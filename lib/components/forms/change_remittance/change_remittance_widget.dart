import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:collection/collection.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'change_remittance_model.dart';
export 'change_remittance_model.dart';

class ChangeRemittanceWidget extends StatefulWidget {
  const ChangeRemittanceWidget({super.key});

  @override
  State<ChangeRemittanceWidget> createState() => _ChangeRemittanceWidgetState();
}

class _ChangeRemittanceWidgetState extends State<ChangeRemittanceWidget> {
  late ChangeRemittanceModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChangeRemittanceModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      // statsToModify
      _model.initStat =
          await StatsRecord.getDocumentOnce(FFAppState().statsReference!);
      // roomUsage init
      setState(() {
        _model.roomUsage =
            _model.initStat!.roomUsage.toList().cast<RoomUsageStruct>();
      });
      // transactionsToRemit
      _model.toRemit = await queryTransactionsRecordOnce(
        queryBuilder: (transactionsRecord) => transactionsRecord
            .where(
              'hotel',
              isEqualTo: FFAppState().hotel,
            )
            .where(
              'remitted',
              isEqualTo: false,
            )
            .where(
              'pending',
              isNotEqualTo: true,
            ),
      );
      // amount to remit to field
      setState(() {
        _model.amountController?.text =
            functions.netOfTransactions(_model.toRemit!.toList()).toString();
      });
      setState(() {
        _model.toRemitAmount =
            functions.netOfTransactions(_model.toRemit!.toList());
      });
    });

    _model.amountController ??=
        TextEditingController(text: _model.toRemitAmount.toString());
    _model.amountFocusNode ??= FocusNode();

    _model.changeExtraController ??= TextEditingController(text: '0');
    _model.changeExtraFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 6.0,
          sigmaY: 8.0,
        ),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(),
          alignment: const AlignmentDirectional(0.0, 1.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 7.0,
                      color: Color(0x33000000),
                      offset: Offset(
                        0.0,
                        -2.0,
                      ),
                    )
                  ],
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(0.0),
                    bottomRight: Radius.circular(0.0),
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                  child: FutureBuilder<HotelSettingsRecord>(
                    future: HotelSettingsRecord.getDocumentOnce(
                        FFAppState().settingRef!),
                    builder: (context, snapshot) {
                      // Customize what your widget looks like when it's loading.
                      if (!snapshot.hasData) {
                        return Center(
                          child: SizedBox(
                            width: 50.0,
                            height: 50.0,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                FlutterFlowTheme.of(context).primary,
                              ),
                            ),
                          ),
                        );
                      }
                      final columnHotelSettingsRecord = snapshot.data!;
                      return Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 60.0,
                                height: 3.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context).alternate,
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            decoration: const BoxDecoration(),
                            child: Stack(
                              children: [
                                if (!_model.isLoading)
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            16.0, 16.0, 0.0, 0.0),
                                        child: Text(
                                          'Change',
                                          style: FlutterFlowTheme.of(context)
                                              .headlineSmall
                                              .override(
                                                fontFamily: 'Outfit',
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            16.0, 4.0, 0.0, 0.0),
                                        child: Text(
                                          'This amount will carry over to the next remittance.',
                                          textAlign: TextAlign.start,
                                          style: FlutterFlowTheme.of(context)
                                              .labelMedium
                                              .override(
                                                fontFamily: 'Readex Pro',
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                      ),
                                      if (columnHotelSettingsRecord
                                              .failedToRemitTransactions.isNotEmpty)
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  16.0, 16.0, 16.0, 0.0),
                                          child: FFButtonWidget(
                                            onPressed: () async {
                                              while (_model.loopFailedCounter !=
                                                  columnHotelSettingsRecord
                                                      .failedToRemitTransactions
                                                      .length) {
                                                // deremit transactions

                                                await columnHotelSettingsRecord
                                                    .failedToRemitTransactions[
                                                        _model
                                                            .loopFailedCounter]
                                                    .update(
                                                        createTransactionsRecordData(
                                                  remitted: false,
                                                ));
                                                // increment loop
                                                setState(() {
                                                  _model.loopFailedCounter =
                                                      _model.loopFailedCounter +
                                                          1;
                                                });
                                              }
                                              // clear failed transactions and bookings

                                              await FFAppState()
                                                  .settingRef!
                                                  .update({
                                                ...mapToFirestore(
                                                  {
                                                    'failedToRemitTransactions':
                                                        FieldValue.delete(),
                                                  },
                                                ),
                                              });
                                              Navigator.pop(context);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    'Failed Transactions has been deremitted!',
                                                    style: TextStyle(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                    ),
                                                  ),
                                                  duration: const Duration(
                                                      milliseconds: 4000),
                                                  backgroundColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondary,
                                                ),
                                              );
                                            },
                                            text: 'Restore Transactions',
                                            options: FFButtonOptions(
                                              width: double.infinity,
                                              height: 50.0,
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                              iconPadding: const EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .error,
                                              textStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        color: Colors.white,
                                                        letterSpacing: 0.0,
                                                      ),
                                              elevation: 2.0,
                                              borderSide: const BorderSide(
                                                color: Colors.transparent,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                            ),
                                          ),
                                        ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            16.0, 16.0, 16.0, 0.0),
                                        child: TextFormField(
                                          controller: _model.amountController,
                                          focusNode: _model.amountFocusNode,
                                          onChanged: (_) =>
                                              EasyDebounce.debounce(
                                            '_model.amountController',
                                            const Duration(milliseconds: 2000),
                                            () async {
                                              // set change
                                              setState(() {
                                                _model.changeExtraController
                                                    ?.text = ((_model
                                                            .toRemitAmount -
                                                        double.parse(_model
                                                            .amountController
                                                            .text))
                                                    .abs()
                                                    .toString());
                                              });
                                            },
                                          ),
                                          autofocus: true,
                                          textCapitalization:
                                              TextCapitalization.none,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            labelText: 'Remit Amount',
                                            labelStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyLarge
                                                    .override(
                                                      fontFamily: 'Readex Pro',
                                                      fontSize: 36.0,
                                                      letterSpacing: 0.0,
                                                    ),
                                            hintText: 'Remittance',
                                            hintStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelLarge
                                                    .override(
                                                      fontFamily: 'Readex Pro',
                                                      fontSize: 36.0,
                                                      letterSpacing: 0.0,
                                                    ),
                                            enabledBorder: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            focusedErrorBorder:
                                                InputBorder.none,
                                            filled: true,
                                            fillColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondaryBackground,
                                            contentPadding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    24.0, 24.0, 20.0, 24.0),
                                            suffixIcon: _model.amountController!
                                                    .text.isNotEmpty
                                                ? InkWell(
                                                    onTap: () async {
                                                      _model.amountController
                                                          ?.clear(); // set change
                                                      setState(() {
                                                        _model
                                                            .changeExtraController
                                                            ?.text = ((_model
                                                                    .toRemitAmount -
                                                                double.parse(_model
                                                                    .amountController
                                                                    .text))
                                                            .abs()
                                                            .toString());
                                                      });
                                                      setState(() {});
                                                    },
                                                    child: const Icon(
                                                      Icons.clear,
                                                      color: Color(0xFF757575),
                                                      size: 22.0,
                                                    ),
                                                  )
                                                : null,
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Readex Pro',
                                                fontSize: 36.0,
                                                letterSpacing: 0.0,
                                              ),
                                          minLines: null,
                                          keyboardType: const TextInputType
                                              .numberWithOptions(decimal: true),
                                          cursorColor:
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                          validator: _model
                                              .amountControllerValidator
                                              .asValidator(context),
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(
                                                RegExp('[0-9]'))
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            16.0, 16.0, 16.0, 0.0),
                                        child: TextFormField(
                                          controller:
                                              _model.changeExtraController,
                                          focusNode:
                                              _model.changeExtraFocusNode,
                                          onChanged: (_) =>
                                              EasyDebounce.debounce(
                                            '_model.changeExtraController',
                                            const Duration(milliseconds: 2000),
                                            () async {
                                              // set amountEntered
                                              setState(() {
                                                _model.amountController
                                                    ?.text = ((_model
                                                            .toRemitAmount
                                                            .abs() +
                                                        double.parse(_model
                                                                .changeExtraController
                                                                .text)
                                                            .abs())
                                                    .toString());
                                              });
                                            },
                                          ),
                                          autofocus: true,
                                          textCapitalization:
                                              TextCapitalization.none,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            labelText: 'Change',
                                            labelStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyLarge
                                                    .override(
                                                      fontFamily: 'Readex Pro',
                                                      fontSize: 36.0,
                                                      letterSpacing: 0.0,
                                                    ),
                                            hintText: 'Remittance',
                                            hintStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelLarge
                                                    .override(
                                                      fontFamily: 'Readex Pro',
                                                      fontSize: 36.0,
                                                      letterSpacing: 0.0,
                                                    ),
                                            enabledBorder: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            focusedErrorBorder:
                                                InputBorder.none,
                                            filled: true,
                                            fillColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondaryBackground,
                                            contentPadding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    24.0, 24.0, 20.0, 24.0),
                                            suffixIcon: _model
                                                    .changeExtraController!
                                                    .text
                                                    .isNotEmpty
                                                ? InkWell(
                                                    onTap: () async {
                                                      _model
                                                          .changeExtraController
                                                          ?.clear(); // set amountEntered
                                                      setState(() {
                                                        _model.amountController
                                                            ?.text = ((_model
                                                                    .toRemitAmount
                                                                    .abs() +
                                                                double.parse(_model
                                                                        .changeExtraController
                                                                        .text)
                                                                    .abs())
                                                            .toString());
                                                      });
                                                      setState(() {});
                                                    },
                                                    child: const Icon(
                                                      Icons.clear,
                                                      color: Color(0xFF757575),
                                                      size: 22.0,
                                                    ),
                                                  )
                                                : null,
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Readex Pro',
                                                fontSize: 36.0,
                                                letterSpacing: 0.0,
                                              ),
                                          minLines: null,
                                          keyboardType: const TextInputType
                                              .numberWithOptions(decimal: true),
                                          cursorColor:
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                          validator: _model
                                              .changeExtraControllerValidator
                                              .asValidator(context),
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(
                                                RegExp('[0-9]'))
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            16.0, 16.0, 16.0, 20.0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            // is loading
                                            setState(() {
                                              _model.isLoading = true;
                                            });
                                            // unremitted transactions
                                            _model.transactions =
                                                await queryTransactionsRecordOnce(
                                              queryBuilder:
                                                  (transactionsRecord) =>
                                                      transactionsRecord
                                                          .where(
                                                            'remitted',
                                                            isEqualTo: false,
                                                          )
                                                          .where(
                                                            'hotel',
                                                            isEqualTo:
                                                                FFAppState()
                                                                    .hotel,
                                                          )
                                                          .where(
                                                            'pending',
                                                            isEqualTo: false,
                                                          ),
                                            );
                                            // all Unremitted Transactions
                                            setState(() {
                                              _model.allUnremittedTransactions =
                                                  _model.transactions!
                                                      .toList()
                                                      .cast<
                                                          TransactionsRecord>();
                                            });
                                            if (_model.transactions.isNotEmpty) {
                                              // unremitted inventories of this hotel
                                              _model.inventoriesToRemitFirestore =
                                                  await queryInventoriesRecordOnce(
                                                queryBuilder:
                                                    (inventoriesRecord) =>
                                                        inventoriesRecord
                                                            .where(
                                                              'hotel',
                                                              isEqualTo:
                                                                  FFAppState()
                                                                      .hotel,
                                                            )
                                                            .where(
                                                              'remitted',
                                                              isEqualTo: false,
                                                            ),
                                              );
                                              // reset loop variables
                                              setState(() {
                                                _model.loopTransactionsCounter =
                                                    0;
                                                _model.transactionsToRemit = [];
                                                _model.loopInventoryCounter = 0;
                                                _model.inventoriesToRemit = [];
                                                _model.bookingsToRemit = [];
                                              });
                                              while (_model
                                                      .loopTransactionsCounter !=
                                                  _model
                                                      .allUnremittedTransactions
                                                      .length) {
                                                // Add to TransactionToRemit
                                                setState(() {
                                                  _model.addToTransactionsToRemit(
                                                      _model.allUnremittedTransactions[
                                                          _model
                                                              .loopTransactionsCounter]);
                                                });
                                                if (_model
                                                        .allUnremittedTransactions[
                                                            _model
                                                                .loopTransactionsCounter]
                                                        .type ==
                                                    'book') {
                                                  // book to remit add to queue
                                                  setState(() {
                                                    _model.addToBookingsToRemit(_model
                                                        .allUnremittedTransactions[
                                                            _model
                                                                .loopTransactionsCounter]
                                                        .booking!);
                                                  });
                                                  // update use of room local
                                                  setState(() {
                                                    _model
                                                        .updateRoomUsageAtIndex(
                                                      functions.indexOfRoomInRoomUsage(
                                                          _model.roomUsage
                                                              .toList(),
                                                          _model
                                                              .allUnremittedTransactions[
                                                                  _model
                                                                      .loopTransactionsCounter]
                                                              .room),
                                                      (e) => e..incrementUse(1),
                                                    );
                                                  });
                                                  // what's happening
                                                  setState(() {
                                                    _model.happening =
                                                        'Remitting room ${_model.allUnremittedTransactions[_model.loopTransactionsCounter].room.toString()}\'s transaction';
                                                  });
                                                } else {
                                                  // what's happening
                                                  setState(() {
                                                    _model.happening =
                                                        'Remitting ${_model.allUnremittedTransactions[_model.loopTransactionsCounter].type}';
                                                  });
                                                }

                                                if (_model
                                                        .loopTransactionsCounter ==
                                                    0) {
                                                  // create field of failed

                                                  await FFAppState()
                                                      .settingRef!
                                                      .update({
                                                    ...mapToFirestore(
                                                      {
                                                        'failedToRemitTransactions':
                                                            _model
                                                                .failedToRemitTransactions,
                                                      },
                                                    ),
                                                  });
                                                }
                                                // remitted true including change transactions

                                                await _model
                                                    .transactionsToRemit[_model
                                                        .loopTransactionsCounter]
                                                    .reference
                                                    .update(
                                                        createTransactionsRecordData(
                                                  remitted: true,
                                                ));
                                                // append to failed list

                                                await FFAppState()
                                                    .settingRef!
                                                    .update({
                                                  ...mapToFirestore(
                                                    {
                                                      'failedToRemitTransactions':
                                                          FieldValue
                                                              .arrayUnion([
                                                        _model
                                                            .transactionsToRemit[
                                                                _model
                                                                    .loopTransactionsCounter]
                                                            .reference
                                                      ]),
                                                    },
                                                  ),
                                                });
                                                // increment loop
                                                setState(() {
                                                  _model.loopTransactionsCounter =
                                                      _model.loopTransactionsCounter +
                                                          1;
                                                });
                                              }
                                              // update roomUsage firestore

                                              await FFAppState()
                                                  .statsReference!
                                                  .update({
                                                ...mapToFirestore(
                                                  {
                                                    'roomUsage':
                                                        getRoomUsageListFirestoreData(
                                                      _model.roomUsage,
                                                    ),
                                                  },
                                                ),
                                              });
                                              // UnremittedAbsences
                                              _model.unremittedAbsences =
                                                  await queryAbsencesRecordOnce(
                                                queryBuilder:
                                                    (absencesRecord) =>
                                                        absencesRecord
                                                            .where(
                                                              'remitted',
                                                              isEqualTo: false,
                                                            )
                                                            .where(
                                                              'hotel',
                                                              isEqualTo:
                                                                  FFAppState()
                                                                      .hotel,
                                                            ),
                                              );
                                              // what's happening
                                              setState(() {
                                                _model.happening =
                                                    'Remitting absences if any';
                                              });
                                              while (
                                                  _model.loopAbsencesCounter !=
                                                      _model.unremittedAbsences
                                                          ?.length) {
                                                // add to to remit
                                                setState(() {
                                                  _model.addToAbsencesToRemit(_model
                                                          .unremittedAbsences![
                                                      _model
                                                          .loopAbsencesCounter]);
                                                });
                                                // remit absence

                                                await _model
                                                    .unremittedAbsences![_model
                                                        .loopAbsencesCounter]
                                                    .reference
                                                    .update(
                                                        createAbsencesRecordData(
                                                  remitted: true,
                                                ));
                                                // increment loop
                                                setState(() {
                                                  _model.loopAbsencesCounter =
                                                      _model.loopAbsencesCounter +
                                                          1;
                                                });
                                              }
                                              // what's happening
                                              setState(() {
                                                _model.happening =
                                                    'Remitting inventories';
                                              });
                                              while (
                                                  _model.loopInventoryCounter !=
                                                      valueOrDefault<int>(
                                                        _model
                                                            .inventoriesToRemitFirestore
                                                            ?.length,
                                                        0,
                                                      )) {
                                                // remit all inventory

                                                await _model
                                                    .inventoriesToRemitFirestore![
                                                        _model
                                                            .loopInventoryCounter]
                                                    .reference
                                                    .update(
                                                        createInventoriesRecordData(
                                                  remitted: true,
                                                ));
                                                // inventories to list
                                                setState(() {
                                                  _model.addToInventoriesToRemit(_model
                                                      .inventoriesToRemitFirestore![
                                                          _model
                                                              .loopInventoryCounter]
                                                      .reference);
                                                });
                                                // increment counter only
                                                setState(() {
                                                  _model.loopInventoryCounter =
                                                      _model.loopInventoryCounter +
                                                          1;
                                                });
                                              }
                                              // what's happening
                                              setState(() {
                                                _model.happening =
                                                    'Updating grocery values';
                                              });
                                              // count grr
                                              _model.countGrr =
                                                  await queryGoodsRevenueRatioRecordCount(
                                                queryBuilder:
                                                    (goodsRevenueRatioRecord) =>
                                                        goodsRevenueRatioRecord
                                                            .where(
                                                              'hotel',
                                                              isEqualTo:
                                                                  FFAppState()
                                                                      .hotel,
                                                            )
                                                            .orderBy('date',
                                                                descending:
                                                                    true),
                                              );
                                              if (_model.countGrr! > 0) {
                                                // last grr
                                                _model.lastGrr =
                                                    await queryGoodsRevenueRatioRecordOnce(
                                                  queryBuilder:
                                                      (goodsRevenueRatioRecord) =>
                                                          goodsRevenueRatioRecord
                                                              .where(
                                                                'hotel',
                                                                isEqualTo:
                                                                    FFAppState()
                                                                        .hotel,
                                                              )
                                                              .orderBy('date',
                                                                  descending:
                                                                      true),
                                                  singleRecord: true,
                                                ).then((s) => s.firstOrNull);
                                                // increment grr revenue

                                                await _model.lastGrr!.reference
                                                    .update({
                                                  ...mapToFirestore(
                                                    {
                                                      'revenue': FieldValue
                                                          .increment(functions
                                                              .sumOfGoodsIncome(_model
                                                                  .transactionsToRemit
                                                                  .toList())),
                                                    },
                                                  ),
                                                });
                                                if (_model.lastGrr
                                                        ?.daysToBreakEven ==
                                                    0) {
                                                  if (functions.add(
                                                          _model
                                                              .lastGrr!.revenue,
                                                          valueOrDefault<
                                                              double>(
                                                            functions.sumOfGoodsIncome(
                                                                _model
                                                                    .transactionsToRemit
                                                                    .toList()),
                                                            0.0,
                                                          )) >
                                                      _model.lastGrr!.grocery) {
                                                    // set daysToBreakeven

                                                    await _model
                                                        .lastGrr!.reference
                                                        .update(
                                                            createGoodsRevenueRatioRecordData(
                                                      daysToBreakEven: _model
                                                              .lastGrr!
                                                              .daysPassed +
                                                          1,
                                                    ));
                                                  } else {
                                                    // increment daysPassed

                                                    await _model
                                                        .lastGrr!.reference
                                                        .update({
                                                      ...mapToFirestore(
                                                        {
                                                          'daysPassed':
                                                              FieldValue
                                                                  .increment(1),
                                                        },
                                                      ),
                                                    });
                                                  }
                                                }
                                              }
                                              // what's happening
                                              setState(() {
                                                _model.happening =
                                                    'Updating metrics';
                                              });
                                              // update stats and graph

                                              await FFAppState()
                                                  .statsReference!
                                                  .update({
                                                ...createStatsRecordData(
                                                  roomLine:
                                                      updateLineGraphStruct(
                                                    functions.newLineGraph(
                                                        functions.sumOfRoomsIncome(
                                                            _model
                                                                .transactionsToRemit
                                                                .toList()),
                                                        _model.initStat!
                                                            .roomLine),
                                                    clearUnsetFields: false,
                                                  ),
                                                  goodsLine:
                                                      updateLineGraphStruct(
                                                    functions.newLineGraph(
                                                        functions.sumOfGoodsIncome(
                                                            _model
                                                                .transactionsToRemit
                                                                .toList()),
                                                        _model.initStat!
                                                            .goodsLine),
                                                    clearUnsetFields: false,
                                                  ),
                                                ),
                                                ...mapToFirestore(
                                                  {
                                                    'roomsIncome': FieldValue
                                                        .increment(functions
                                                            .sumOfRoomsIncome(_model
                                                                .transactionsToRemit
                                                                .toList())),
                                                    'goodsIncome': FieldValue
                                                        .increment(functions
                                                            .sumOfGoodsIncome(_model
                                                                .transactionsToRemit
                                                                .toList())),
                                                    'expenses': FieldValue
                                                        .increment(functions
                                                            .sumOfExpenses(_model
                                                                .transactionsToRemit
                                                                .toList())),
                                                  },
                                                ),
                                              });
                                              // what's happening
                                              setState(() {
                                                _model.happening =
                                                    'Finishing remittance!';
                                              });
                                              // Create Remittance

                                              var remittancesRecordReference =
                                                  RemittancesRecord.collection
                                                      .doc();
                                              await remittancesRecordReference
                                                  .set({
                                                ...createRemittancesRecordData(
                                                  collected: false,
                                                  preparedBy:
                                                      currentUserReference,
                                                  hotel: FFAppState().hotel,
                                                  gross: functions
                                                      .grossTransactions(_model
                                                          .transactionsToRemit
                                                          .toList()),
                                                  net: functions
                                                      .netOfTransactions(_model
                                                          .transactionsToRemit
                                                          .toList()),
                                                  expenses: functions
                                                      .sumOfExpenses(_model
                                                          .transactionsToRemit
                                                          .toList()),
                                                ),
                                                ...mapToFirestore(
                                                  {
                                                    'date': FieldValue
                                                        .serverTimestamp(),
                                                    'transactions': _model
                                                        .transactionsToRemit
                                                        .map((e) => e.reference)
                                                        .toList(),
                                                    'bookings':
                                                        _model.bookingsToRemit,
                                                    'inventories': _model
                                                        .inventoriesToRemit,
                                                    'absences': _model
                                                        .absencesToRemit
                                                        .map((e) => e.reference)
                                                        .toList(),
                                                  },
                                                ),
                                              });
                                              _model.newRemittanceCopyCopy =
                                                  RemittancesRecord
                                                      .getDocumentFromData({
                                                ...createRemittancesRecordData(
                                                  collected: false,
                                                  preparedBy:
                                                      currentUserReference,
                                                  hotel: FFAppState().hotel,
                                                  gross: functions
                                                      .grossTransactions(_model
                                                          .transactionsToRemit
                                                          .toList()),
                                                  net: functions
                                                      .netOfTransactions(_model
                                                          .transactionsToRemit
                                                          .toList()),
                                                  expenses: functions
                                                      .sumOfExpenses(_model
                                                          .transactionsToRemit
                                                          .toList()),
                                                ),
                                                ...mapToFirestore(
                                                  {
                                                    'date': DateTime.now(),
                                                    'transactions': _model
                                                        .transactionsToRemit
                                                        .map((e) => e.reference)
                                                        .toList(),
                                                    'bookings':
                                                        _model.bookingsToRemit,
                                                    'inventories': _model
                                                        .inventoriesToRemit,
                                                    'absences': _model
                                                        .absencesToRemit
                                                        .map((e) => e.reference)
                                                        .toList(),
                                                  },
                                                ),
                                              }, remittancesRecordReference);
                                              // ready for collection admin

                                              await FFAppState()
                                                  .settingRef!
                                                  .update(
                                                      createHotelSettingsRecordData(
                                                    collectable: true,
                                                    remittable: false,
                                                  ));
                                              // delete all failed transactions incase remittance comes thru

                                              await FFAppState()
                                                  .settingRef!
                                                  .update({
                                                ...mapToFirestore(
                                                  {
                                                    'failedToRemitTransactions':
                                                        FieldValue.delete(),
                                                  },
                                                ),
                                              });
                                              // Clear Lists To Remit
                                              setState(() {
                                                _model.transactionsToRemit = [];
                                                _model.inventoriesToRemit = [];
                                                _model.bookingsToRemit = [];
                                                _model.isLoading = false;
                                              });
                                              // carryover change transaction

                                              await TransactionsRecord
                                                  .collection
                                                  .doc()
                                                  .set({
                                                ...createTransactionsRecordData(
                                                  staff: currentUserReference,
                                                  total: _model.changeExtraController
                                                                  .text !=
                                                              ''
                                                      ? (-double.parse(_model
                                                          .changeExtraController
                                                          .text))
                                                      : 0.0,
                                                  type: 'change',
                                                  description: 'Change',
                                                  hotel: FFAppState().hotel,
                                                  remitted: false,
                                                  pending: false,
                                                ),
                                                ...mapToFirestore(
                                                  {
                                                    'date': FieldValue
                                                        .serverTimestamp(),
                                                  },
                                                ),
                                              });
                                              // update last remit firestore

                                              await FFAppState()
                                                  .settingRef!
                                                  .update({
                                                ...mapToFirestore(
                                                  {
                                                    'lastRemit': FieldValue
                                                        .serverTimestamp(),
                                                  },
                                                ),
                                              });
                                              // last remit update
                                              setState(() {
                                                FFAppState().lastRemit =
                                                    functions.today();
                                              });
                                              Navigator.pop(context);
                                              // Remitted
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    'Remitted. Awaiting for endorsement.',
                                                    style: TextStyle(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                    ),
                                                  ),
                                                  duration: const Duration(
                                                      milliseconds: 4000),
                                                  backgroundColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondary,
                                                ),
                                              );
                                            } else {
                                              // no transactions
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    'There are no transactions to remit!',
                                                    style: TextStyle(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .info,
                                                    ),
                                                  ),
                                                  duration: const Duration(
                                                      milliseconds: 4000),
                                                  backgroundColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .error,
                                                ),
                                              );
                                              // not remittable

                                              await FFAppState()
                                                  .settingRef!
                                                  .update(
                                                      createHotelSettingsRecordData(
                                                    remittable: false,
                                                  ));
                                              Navigator.pop(context);
                                            }

                                            setState(() {});
                                          },
                                          text: 'Continue Remitting',
                                          options: FFButtonOptions(
                                            width: double.infinity,
                                            height: 50.0,
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            iconPadding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily: 'Readex Pro',
                                                      color: Colors.white,
                                                      letterSpacing: 0.0,
                                                    ),
                                            elevation: 2.0,
                                            borderSide: const BorderSide(
                                              color: Colors.transparent,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                if (_model.isLoading)
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            16.0, 20.0, 16.0, 0.0),
                                        child: Text(
                                          'Please don\'t touch anything while remittance is being submitted.',
                                          textAlign: TextAlign.center,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Readex Pro',
                                                fontSize: 24.0,
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 20.0, 0.0, 0.0),
                                        child: Text(
                                          _model.happening,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Readex Pro',
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            const AlignmentDirectional(0.0, -2.13),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: Image.asset(
                                            'assets/images/giphy.gif',
                                            width: double.infinity,
                                            height: 159.0,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
