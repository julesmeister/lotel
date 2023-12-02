import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'change_remittance_model.dart';
export 'change_remittance_model.dart';

class ChangeRemittanceWidget extends StatefulWidget {
  const ChangeRemittanceWidget({Key? key}) : super(key: key);

  @override
  _ChangeRemittanceWidgetState createState() => _ChangeRemittanceWidgetState();
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
    });

    _model.changeExtraController ??= TextEditingController();
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
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).accent4,
          ),
          alignment: AlignmentDirectional(0.00, 1.00),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 7.0,
                      color: Color(0x33000000),
                      offset: Offset(0.0, -2.0),
                    )
                  ],
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0.0),
                    bottomRight: Radius.circular(0.0),
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
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
                            decoration: BoxDecoration(),
                            child: Stack(
                              children: [
                                if (!_model.isLoading)
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16.0, 16.0, 0.0, 0.0),
                                        child: Text(
                                          'Change',
                                          style: FlutterFlowTheme.of(context)
                                              .headlineSmall,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16.0, 4.0, 0.0, 0.0),
                                        child: Text(
                                          'This amount will carry over to the next remittance.',
                                          textAlign: TextAlign.start,
                                          style: FlutterFlowTheme.of(context)
                                              .labelMedium,
                                        ),
                                      ),
                                      if (columnHotelSettingsRecord
                                              .failedToRemitTransactions
                                              .length >
                                          0)
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
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
                                                  duration: Duration(
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
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                              iconPadding: EdgeInsetsDirectional
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
                                                      ),
                                              elevation: 2.0,
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                            ),
                                          ),
                                        ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16.0, 16.0, 16.0, 0.0),
                                        child: TextFormField(
                                          controller:
                                              _model.changeExtraController,
                                          focusNode:
                                              _model.changeExtraFocusNode,
                                          textCapitalization:
                                              TextCapitalization.none,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            labelStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyLarge
                                                    .override(
                                                      fontFamily: 'Readex Pro',
                                                      fontSize: 36.0,
                                                    ),
                                            hintText: 'How much?',
                                            hintStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelLarge
                                                    .override(
                                                      fontFamily: 'Readex Pro',
                                                      fontSize: 36.0,
                                                    ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .alternate,
                                                width: 2.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                width: 2.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .error,
                                                width: 2.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .error,
                                                width: 2.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            filled: true,
                                            fillColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondaryBackground,
                                            contentPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    24.0, 24.0, 20.0, 24.0),
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Readex Pro',
                                                fontSize: 36.0,
                                              ),
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
                                        padding: EdgeInsetsDirectional.fromSTEB(
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
                                                          ),
                                            );
                                            if (_model.transactions?.length !=
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
                                                  _model.transactions?.length) {
                                                if (!_model
                                                    .transactions![_model
                                                        .loopTransactionsCounter]
                                                    .pending) {
                                                  // Add to TransactionToRemit
                                                  setState(() {
                                                    _model.addToTransactionsToRemit(
                                                        _model.transactions![_model
                                                            .loopTransactionsCounter]);
                                                  });
                                                  if (_model
                                                          .transactions?[_model
                                                              .loopTransactionsCounter]
                                                          ?.type ==
                                                      'book') {
                                                    // book to remit add to queue
                                                    setState(() {
                                                      _model.addToBookingsToRemit(_model
                                                          .transactions![_model
                                                              .loopTransactionsCounter]
                                                          .booking!);
                                                    });
                                                    // booking
                                                    _model.booking = await BookingsRecord
                                                        .getDocumentOnce(_model
                                                            .transactions![_model
                                                                .loopTransactionsCounter]
                                                            .booking!);
                                                    // update use of room local
                                                    setState(() {
                                                      _model
                                                          .updateRoomUsageAtIndex(
                                                        functions.indexOfRoomInRoomUsage(
                                                            _model.roomUsage
                                                                .toList(),
                                                            _model
                                                                .transactions![
                                                                    _model
                                                                        .loopTransactionsCounter]
                                                                .room),
                                                        (e) => e
                                                          ..incrementUse(_model
                                                              .booking!.nights),
                                                      );
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
                                                } else {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'Just be aware that are still pending transactions.',
                                                        style: TextStyle(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                        ),
                                                      ),
                                                      duration: Duration(
                                                          milliseconds: 4000),
                                                      backgroundColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondary,
                                                    ),
                                                  );
                                                }

                                                // Increment Loop Counter
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
                                                              null &&
                                                          _model.changeExtraController
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
                                                  duration: Duration(
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
                                                  duration: Duration(
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
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily: 'Readex Pro',
                                                      color: Colors.white,
                                                    ),
                                            elevation: 2.0,
                                            borderSide: BorderSide(
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
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16.0, 20.0, 16.0, 0.0),
                                        child: Text(
                                          'Please don\'t touch anything while remittance is being submitted.',
                                          textAlign: TextAlign.center,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Readex Pro',
                                                fontSize: 24.0,
                                              ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(0.00, -2.13),
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
