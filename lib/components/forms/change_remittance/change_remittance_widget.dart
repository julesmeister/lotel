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
      _model.roomUsage =
          _model.initStat!.roomUsage.toList().cast<RoomUsageStruct>();
      safeSetState(() {});
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
      safeSetState(() {
        _model.amountTextController?.text =
            functions.netOfTransactions(_model.toRemit!.toList()).toString();
        _model.amountFocusNode?.requestFocus();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _model.amountTextController?.selection = TextSelection.collapsed(
            offset: _model.amountTextController!.text.length,
          );
        });
      });
      _model.toRemitAmount =
          functions.netOfTransactions(_model.toRemit!.toList());
      safeSetState(() {});
    });

    _model.amountTextController ??=
        TextEditingController(text: _model.toRemitAmount.toString());
    _model.amountFocusNode ??= FocusNode();

    _model.changeExtraTextController ??= TextEditingController(text: '0');
    _model.changeExtraFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
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
          sigmaX: 0.0,
          sigmaY: 0.0,
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
                                                _model.loopFailedCounter =
                                                    _model.loopFailedCounter +
                                                        1;
                                                safeSetState(() {});
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
                                          controller:
                                              _model.amountTextController,
                                          focusNode: _model.amountFocusNode,
                                          onChanged: (_) =>
                                              EasyDebounce.debounce(
                                            '_model.amountTextController',
                                            const Duration(milliseconds: 2000),
                                            () async {
                                              // set change
                                              safeSetState(() {
                                                _model.changeExtraTextController
                                                    ?.text = ((_model
                                                            .toRemitAmount -
                                                        double.parse(_model
                                                            .amountTextController
                                                            .text))
                                                    .abs()
                                                    .toString());
                                                _model.changeExtraFocusNode
                                                    ?.requestFocus();
                                                WidgetsBinding.instance
                                                    .addPostFrameCallback((_) {
                                                  _model.changeExtraTextController
                                                          ?.selection =
                                                      TextSelection.collapsed(
                                                    offset: _model
                                                        .changeExtraTextController!
                                                        .text
                                                        .length,
                                                  );
                                                });
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
                                            suffixIcon: _model
                                                    .amountTextController!
                                                    .text
                                                    .isNotEmpty
                                                ? InkWell(
                                                    onTap: () async {
                                                      _model
                                                          .amountTextController
                                                          ?.clear(); // set change
                                                      safeSetState(() {
                                                        _model
                                                            .changeExtraTextController
                                                            ?.text = ((_model
                                                                    .toRemitAmount -
                                                                double.parse(_model
                                                                    .amountTextController
                                                                    .text))
                                                            .abs()
                                                            .toString());
                                                        _model
                                                            .changeExtraFocusNode
                                                            ?.requestFocus();
                                                        WidgetsBinding.instance
                                                            .addPostFrameCallback(
                                                                (_) {
                                                          _model.changeExtraTextController
                                                                  ?.selection =
                                                              TextSelection
                                                                  .collapsed(
                                                            offset: _model
                                                                .changeExtraTextController!
                                                                .text
                                                                .length,
                                                          );
                                                        });
                                                      });
                                                      safeSetState(() {});
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
                                          keyboardType: const TextInputType
                                              .numberWithOptions(
                                              signed: true, decimal: true),
                                          cursorColor:
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                          validator: _model
                                              .amountTextControllerValidator
                                              .asValidator(context),
                                        ),
                                      ),
                                      const Divider(
                                        height: 4.0,
                                        thickness: 1.0,
                                        color: Color(0xFFE0E3E7),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            16.0, 16.0, 16.0, 0.0),
                                        child: TextFormField(
                                          controller:
                                              _model.changeExtraTextController,
                                          focusNode:
                                              _model.changeExtraFocusNode,
                                          onChanged: (_) =>
                                              EasyDebounce.debounce(
                                            '_model.changeExtraTextController',
                                            const Duration(milliseconds: 2000),
                                            () async {
                                              // set amountEntered
                                              safeSetState(() {
                                                _model.amountTextController
                                                    ?.text = ((_model
                                                            .toRemitAmount
                                                            .abs() +
                                                        double.parse(_model
                                                                .changeExtraTextController
                                                                .text)
                                                            .abs())
                                                    .toString());
                                                _model.amountFocusNode
                                                    ?.requestFocus();
                                                WidgetsBinding.instance
                                                    .addPostFrameCallback((_) {
                                                  _model.amountTextController
                                                          ?.selection =
                                                      TextSelection.collapsed(
                                                    offset: _model
                                                        .amountTextController!
                                                        .text
                                                        .length,
                                                  );
                                                });
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
                                                    .changeExtraTextController!
                                                    .text
                                                    .isNotEmpty
                                                ? InkWell(
                                                    onTap: () async {
                                                      _model
                                                          .changeExtraTextController
                                                          ?.clear(); // set amountEntered
                                                      safeSetState(() {
                                                        _model
                                                            .amountTextController
                                                            ?.text = ((_model
                                                                    .toRemitAmount
                                                                    .abs() +
                                                                double.parse(_model
                                                                        .changeExtraTextController
                                                                        .text)
                                                                    .abs())
                                                            .toString());
                                                        _model.amountFocusNode
                                                            ?.requestFocus();
                                                        WidgetsBinding.instance
                                                            .addPostFrameCallback(
                                                                (_) {
                                                          _model.amountTextController
                                                                  ?.selection =
                                                              TextSelection
                                                                  .collapsed(
                                                            offset: _model
                                                                .amountTextController!
                                                                .text
                                                                .length,
                                                          );
                                                        });
                                                      });
                                                      safeSetState(() {});
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
                                          keyboardType: const TextInputType
                                              .numberWithOptions(
                                              signed: true, decimal: true),
                                          cursorColor:
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                          validator: _model
                                              .changeExtraTextControllerValidator
                                              .asValidator(context),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            16.0, 16.0, 16.0, 20.0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            var shouldSetState = false;
                                            var confirmDialogResponse =
                                                await showDialog<bool>(
                                                      context: context,
                                                      builder:
                                                          (alertDialogContext) {
                                                        return AlertDialog(
                                                          title: const Text(
                                                              'No Excess Amount?'),
                                                          content: const Text(
                                                              'Are you certain remittance doesn\'t exceed the specified amount?'),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () =>
                                                                  Navigator.pop(
                                                                      alertDialogContext,
                                                                      false),
                                                              child: const Text(
                                                                  'Cancel'),
                                                            ),
                                                            TextButton(
                                                              onPressed: () =>
                                                                  Navigator.pop(
                                                                      alertDialogContext,
                                                                      true),
                                                              child: const Text(
                                                                  'Confirm'),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    ) ??
                                                    false;
                                            if (confirmDialogResponse) {
                                              // is loading
                                              _model.isLoading = true;
                                              safeSetState(() {});
                                              if ((_model.toRemitAmount !=
                                                      (double.parse(_model
                                                          .amountTextController
                                                          .text))) &&
                                                  (_model.changeExtraTextController
                                                          .text ==
                                                      '0')) {
                                                // Wait for change
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      'Wait for change to reflect!',
                                                      style: TextStyle(
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
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
                                                if (shouldSetState) {
                                                  safeSetState(() {});
                                                }
                                                return;
                                              } else {
                                                // unremitted transactions
                                                _model.transactions =
                                                    await queryTransactionsRecordOnce(
                                                  queryBuilder:
                                                      (transactionsRecord) =>
                                                          transactionsRecord
                                                              .where(
                                                                'remitted',
                                                                isEqualTo:
                                                                    false,
                                                              )
                                                              .where(
                                                                'hotel',
                                                                isEqualTo:
                                                                    FFAppState()
                                                                        .hotel,
                                                              )
                                                              .where(
                                                                'pending',
                                                                isEqualTo:
                                                                    false,
                                                              ),
                                                );
                                                shouldSetState = true;
                                                // all Unremitted Transactions
                                                _model.allUnremittedTransactions =
                                                    _model.transactions!
                                                        .toList()
                                                        .cast<
                                                            TransactionsRecord>();
                                                safeSetState(() {});
                                                if (_model
                                                        .transactions?.length !=
                                                    0) {
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
                                                                  isEqualTo:
                                                                      false,
                                                                ),
                                                  );
                                                  shouldSetState = true;
                                                  // reset loop variables
                                                  _model.loopTransactionsCounter =
                                                      0;
                                                  _model.transactionsToRemit =
                                                      [];
                                                  _model.loopInventoryCounter =
                                                      0;
                                                  _model.inventoriesToRemit =
                                                      [];
                                                  _model.bookingsToRemit = [];
                                                  safeSetState(() {});
                                                  while (_model
                                                          .loopTransactionsCounter !=
                                                      _model
                                                          .allUnremittedTransactions
                                                          .length) {
                                                    // Add to TransactionToRemit
                                                    _model.addToTransactionsToRemit(
                                                        _model.allUnremittedTransactions[
                                                            _model
                                                                .loopTransactionsCounter]);
                                                    safeSetState(() {});
                                                    if (_model
                                                            .allUnremittedTransactions[
                                                                _model
                                                                    .loopTransactionsCounter]
                                                            .type ==
                                                        'book') {
                                                      // book to remit add to queue
                                                      _model.addToBookingsToRemit(_model
                                                          .allUnremittedTransactions[
                                                              _model
                                                                  .loopTransactionsCounter]
                                                          .booking!);
                                                      safeSetState(() {});
                                                      // update use of room local
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
                                                        (e) =>
                                                            e..incrementUse(1),
                                                      );
                                                      safeSetState(() {});
                                                      // what's happening
                                                      _model.happening =
                                                          'Remitting room ${_model.allUnremittedTransactions[_model.loopTransactionsCounter].room.toString()}\'s transaction';
                                                      safeSetState(() {});
                                                    } else {
                                                      // what's happening
                                                      _model.happening =
                                                          'Remitting ${_model.allUnremittedTransactions[_model.loopTransactionsCounter].type}';
                                                      safeSetState(() {});
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
                                                    _model.loopTransactionsCounter =
                                                        _model.loopTransactionsCounter +
                                                            1;
                                                    safeSetState(() {});
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
                                                                  isEqualTo:
                                                                      false,
                                                                )
                                                                .where(
                                                                  'hotel',
                                                                  isEqualTo:
                                                                      FFAppState()
                                                                          .hotel,
                                                                ),
                                                  );
                                                  shouldSetState = true;
                                                  // what's happening
                                                  _model.happening =
                                                      'Remitting absences if any';
                                                  safeSetState(() {});
                                                  while (_model
                                                          .loopAbsencesCounter !=
                                                      _model.unremittedAbsences
                                                          ?.length) {
                                                    // add to to remit
                                                    _model.addToAbsencesToRemit(
                                                        _model.unremittedAbsences![
                                                            _model
                                                                .loopAbsencesCounter]);
                                                    safeSetState(() {});
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
                                                    _model.loopAbsencesCounter =
                                                        _model.loopAbsencesCounter +
                                                            1;
                                                    safeSetState(() {});
                                                  }
                                                  // what's happening
                                                  _model.happening =
                                                      'Remitting inventories';
                                                  safeSetState(() {});
                                                  while (_model
                                                          .loopInventoryCounter !=
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
                                                    _model.addToInventoriesToRemit(_model
                                                        .inventoriesToRemitFirestore![
                                                            _model
                                                                .loopInventoryCounter]
                                                        .reference);
                                                    safeSetState(() {});
                                                    // increment counter only
                                                    _model.loopInventoryCounter =
                                                        _model.loopInventoryCounter +
                                                            1;
                                                    safeSetState(() {});
                                                  }
                                                  // what's happening
                                                  _model.happening =
                                                      'Updating grocery values';
                                                  safeSetState(() {});
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
                                                  shouldSetState = true;
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
                                                                  .orderBy(
                                                                      'date',
                                                                      descending:
                                                                          true),
                                                      singleRecord: true,
                                                    ).then((s) =>
                                                            s.firstOrNull);
                                                    shouldSetState = true;
                                                    // increment grr revenue

                                                    await _model
                                                        .lastGrr!.reference
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
                                                              _model.lastGrr!
                                                                  .revenue,
                                                              valueOrDefault<
                                                                  double>(
                                                                functions.sumOfGoodsIncome(_model
                                                                    .transactionsToRemit
                                                                    .toList()),
                                                                0.0,
                                                              )) >
                                                          _model.lastGrr!
                                                              .grocery) {
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
                                                                      .increment(
                                                                          1),
                                                            },
                                                          ),
                                                        });
                                                      }
                                                    }
                                                  }
                                                  // what's happening
                                                  _model.happening =
                                                      'Updating metrics';
                                                  safeSetState(() {});
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
                                                  _model.happening =
                                                      'Finishing remittance!';
                                                  safeSetState(() {});
                                                  // Create Remittance

                                                  var remittancesRecordReference =
                                                      RemittancesRecord
                                                          .collection
                                                          .doc();
                                                  await remittancesRecordReference
                                                      .set({
                                                    ...createRemittancesRecordData(
                                                      collected: false,
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
                                                      preparedByName:
                                                          currentUserDisplayName,
                                                    ),
                                                    ...mapToFirestore(
                                                      {
                                                        'date': FieldValue
                                                            .serverTimestamp(),
                                                        'transactions': _model
                                                            .transactionsToRemit
                                                            .map((e) =>
                                                                e.reference)
                                                            .toList(),
                                                        'bookings': _model
                                                            .bookingsToRemit,
                                                        'inventories': _model
                                                            .inventoriesToRemit,
                                                        'absences': _model
                                                            .absencesToRemit
                                                            .map((e) =>
                                                                e.reference)
                                                            .toList(),
                                                      },
                                                    ),
                                                  });
                                                  _model.newRemittanceCopyCopy =
                                                      RemittancesRecord
                                                          .getDocumentFromData({
                                                    ...createRemittancesRecordData(
                                                      collected: false,
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
                                                      preparedByName:
                                                          currentUserDisplayName,
                                                    ),
                                                    ...mapToFirestore(
                                                      {
                                                        'date': DateTime.now(),
                                                        'transactions': _model
                                                            .transactionsToRemit
                                                            .map((e) =>
                                                                e.reference)
                                                            .toList(),
                                                        'bookings': _model
                                                            .bookingsToRemit,
                                                        'inventories': _model
                                                            .inventoriesToRemit,
                                                        'absences': _model
                                                            .absencesToRemit
                                                            .map((e) =>
                                                                e.reference)
                                                            .toList(),
                                                      },
                                                    ),
                                                  }, remittancesRecordReference);
                                                  shouldSetState = true;
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
                                                  _model.transactionsToRemit =
                                                      [];
                                                  _model.inventoriesToRemit =
                                                      [];
                                                  _model.bookingsToRemit = [];
                                                  _model.isLoading = false;
                                                  safeSetState(() {});
                                                  // carryover change transaction

                                                  await TransactionsRecord
                                                      .collection
                                                      .doc()
                                                      .set({
                                                    ...createTransactionsRecordData(
                                                      staff:
                                                          currentUserReference,
                                                      total: _model.changeExtraTextController
                                                                      .text !=
                                                                  ''
                                                          ? (-double.parse(_model
                                                              .changeExtraTextController
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
                                                  FFAppState().lastRemit =
                                                      functions.today();
                                                  safeSetState(() {});
                                                  Navigator.pop(context);
                                                  // Remitted
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'Remitted. Awaiting for endorsement.',
                                                        style: TextStyle(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
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
                                                          color: FlutterFlowTheme
                                                                  .of(context)
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
                                              }
                                            }
                                            if (shouldSetState) {
                                              safeSetState(() {});
                                            }
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
