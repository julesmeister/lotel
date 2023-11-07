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
                  child: Column(
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
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 16.0, 0.0, 0.0),
                        child: Text(
                          'Change',
                          style: FlutterFlowTheme.of(context).headlineSmall,
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(16.0, 4.0, 0.0, 0.0),
                        child: Text(
                          'This amount will carry over to the next remittance.',
                          style: FlutterFlowTheme.of(context).labelMedium,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 16.0, 16.0, 0.0),
                        child: TextFormField(
                          controller: _model.changeExtraController,
                          focusNode: _model.changeExtraFocusNode,
                          textCapitalization: TextCapitalization.none,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelStyle: FlutterFlowTheme.of(context).bodyLarge,
                            hintText: 'How much?',
                            hintStyle: FlutterFlowTheme.of(context)
                                .labelLarge
                                .override(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 36.0,
                                ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).alternate,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primary,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            filled: true,
                            fillColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            contentPadding: EdgeInsetsDirectional.fromSTEB(
                                24.0, 24.0, 20.0, 24.0),
                          ),
                          style: FlutterFlowTheme.of(context).bodyMedium,
                          maxLines: 4,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          cursorColor: FlutterFlowTheme.of(context).primary,
                          validator: _model.changeExtraControllerValidator
                              .asValidator(context),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 16.0, 16.0, 44.0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            // unremitted transactions
                            _model.transactions =
                                await queryTransactionsRecordOnce(
                              queryBuilder: (transactionsRecord) =>
                                  transactionsRecord
                                      .where(
                                        'remitted',
                                        isEqualTo: false,
                                      )
                                      .where(
                                        'hotel',
                                        isEqualTo: FFAppState().hotel,
                                      ),
                            );
                            // unremitted inventories of this hotel
                            _model.inventoriesToRemitFirestore =
                                await queryInventoriesRecordOnce(
                              queryBuilder: (inventoriesRecord) =>
                                  inventoriesRecord
                                      .where(
                                        'hotel',
                                        isEqualTo: FFAppState().hotel,
                                      )
                                      .where(
                                        'remitted',
                                        isEqualTo: false,
                                      ),
                            );
                            // reset loop variables
                            setState(() {
                              _model.loopTransactionsCounter = 0;
                              _model.transactionsToRemit = [];
                              _model.loopInventoryCounter = 0;
                              _model.inventoriesToRemit = [];
                              _model.bookingsToRemit = [];
                            });
                            while (_model.loopTransactionsCounter !=
                                _model.transactions?.length) {
                              // Add to TransactionToRemit
                              setState(() {
                                _model.addToTransactionsToRemit(
                                    _model.transactions![
                                        _model.loopTransactionsCounter]);
                              });
                              if (_model
                                      .transactions?[
                                          _model.loopTransactionsCounter]
                                      ?.type ==
                                  'book') {
                                // book to remit add to queue
                                setState(() {
                                  _model.addToBookingsToRemit(_model
                                      .transactions![
                                          _model.loopTransactionsCounter]
                                      .booking!);
                                });
                                // booking
                                _model.booking =
                                    await BookingsRecord.getDocumentOnce(_model
                                        .transactions![
                                            _model.loopTransactionsCounter]
                                        .booking!);
                                // update use of room
                                setState(() {
                                  _model.updateRoomUsageAtIndex(
                                    functions.indexOfRoomInRoomUsage(
                                        _model.roomUsage.toList(),
                                        _model
                                            .transactions![
                                                _model.loopTransactionsCounter]
                                            .room),
                                    (e) =>
                                        e..incrementUse(_model.booking!.nights),
                                  );
                                });
                                // remitted book

                                await _model
                                    .transactions![
                                        _model.loopTransactionsCounter]
                                    .booking!
                                    .update(createBookingsRecordData(
                                  remitted: true,
                                ));
                              }
                              // remitted true including change

                              await _model
                                  .transactionsToRemit[
                                      _model.loopTransactionsCounter]
                                  .reference
                                  .update(createTransactionsRecordData(
                                remitted: true,
                              ));
                              // Increment Loop Counter
                              setState(() {
                                _model.loopTransactionsCounter =
                                    _model.loopTransactionsCounter + 1;
                              });
                            }
                            // update roomUsage

                            await FFAppState().statsReference!.update({
                              ...mapToFirestore(
                                {
                                  'roomUsage': getRoomUsageListFirestoreData(
                                    _model.roomUsage,
                                  ),
                                },
                              ),
                            });
                            while (_model.loopInventoryCounter !=
                                valueOrDefault<int>(
                                  _model.inventoriesToRemitFirestore?.length,
                                  0,
                                )) {
                              // remit all inventory

                              await _model
                                  .inventoriesToRemitFirestore![
                                      _model.loopInventoryCounter]
                                  .reference
                                  .update(createInventoriesRecordData(
                                remitted: true,
                              ));
                              // inventories to list
                              setState(() {
                                _model.addToInventoriesToRemit(_model
                                    .inventoriesToRemitFirestore![
                                        _model.loopInventoryCounter]
                                    .reference);
                              });
                              // increment counter only
                              setState(() {
                                _model.loopInventoryCounter =
                                    _model.loopInventoryCounter + 1;
                              });
                            }
                            // update stats and graph

                            await FFAppState().statsReference!.update({
                              ...createStatsRecordData(
                                roomLine: updateLineGraphStruct(
                                  functions.newLineGraph(
                                      functions.sumOfRoomsIncome(
                                          _model.transactionsToRemit.toList()),
                                      _model.initStat!.roomLine),
                                  clearUnsetFields: false,
                                ),
                                goodsLine: updateLineGraphStruct(
                                  functions.newLineGraph(
                                      functions.sumOfGoodsIncome(
                                          _model.transactionsToRemit.toList()),
                                      _model.initStat!.goodsLine),
                                  clearUnsetFields: false,
                                ),
                              ),
                              ...mapToFirestore(
                                {
                                  'roomsIncome': FieldValue.increment(
                                      functions.sumOfRoomsIncome(
                                          _model.transactionsToRemit.toList())),
                                  'goodsIncome': FieldValue.increment(
                                      functions.sumOfGoodsIncome(
                                          _model.transactionsToRemit.toList())),
                                  'expenses': FieldValue.increment(
                                      functions.sumOfExpenses(
                                          _model.transactionsToRemit.toList())),
                                },
                              ),
                            });
                            // Create Remittance

                            var remittancesRecordReference =
                                RemittancesRecord.collection.doc();
                            await remittancesRecordReference.set({
                              ...createRemittancesRecordData(
                                collected: false,
                                preparedBy: currentUserReference,
                                hotel: FFAppState().hotel,
                                gross: functions.grossTransactions(
                                    _model.transactionsToRemit.toList()),
                                net: functions.netOfTransactions(
                                    _model.transactionsToRemit.toList()),
                                expenses: functions.sumOfExpenses(
                                    _model.transactionsToRemit.toList()),
                              ),
                              ...mapToFirestore(
                                {
                                  'date': FieldValue.serverTimestamp(),
                                  'transactions': _model.transactionsToRemit
                                      .map((e) => e.reference)
                                      .toList(),
                                  'bookings': _model.bookingsToRemit,
                                  'inventories': _model.inventoriesToRemit,
                                },
                              ),
                            });
                            _model.newRemittanceCopyCopy =
                                RemittancesRecord.getDocumentFromData({
                              ...createRemittancesRecordData(
                                collected: false,
                                preparedBy: currentUserReference,
                                hotel: FFAppState().hotel,
                                gross: functions.grossTransactions(
                                    _model.transactionsToRemit.toList()),
                                net: functions.netOfTransactions(
                                    _model.transactionsToRemit.toList()),
                                expenses: functions.sumOfExpenses(
                                    _model.transactionsToRemit.toList()),
                              ),
                              ...mapToFirestore(
                                {
                                  'date': DateTime.now(),
                                  'transactions': _model.transactionsToRemit
                                      .map((e) => e.reference)
                                      .toList(),
                                  'bookings': _model.bookingsToRemit,
                                  'inventories': _model.inventoriesToRemit,
                                },
                              ),
                            }, remittancesRecordReference);
                            // Clear Lists To Remit
                            setState(() {
                              _model.transactionsToRemit = [];
                              _model.inventoriesToRemit = [];
                              _model.bookingsToRemit = [];
                            });
                            // carryover change transaction

                            await TransactionsRecord.collection.doc().set({
                              ...createTransactionsRecordData(
                                staff: currentUserReference,
                                total: _model.changeExtraController.text !=
                                            null &&
                                        _model.changeExtraController.text != ''
                                    ? (-double.parse(
                                        _model.changeExtraController.text))
                                    : 0.0,
                                type: 'change',
                                description: 'Change',
                                hotel: FFAppState().hotel,
                                remitted: false,
                              ),
                              ...mapToFirestore(
                                {
                                  'date': FieldValue.serverTimestamp(),
                                },
                              ),
                            });
                            // last remit update
                            setState(() {
                              FFAppState().lastRemit = functions.today();
                            });
                            Navigator.pop(context);
                            // Remitted
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Remitted. Awaiting for endorsement.',
                                  style: TextStyle(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                  ),
                                ),
                                duration: Duration(milliseconds: 4000),
                                backgroundColor:
                                    FlutterFlowTheme.of(context).secondary,
                              ),
                            );

                            setState(() {});
                          },
                          text: 'Continue Remitting',
                          options: FFButtonOptions(
                            width: double.infinity,
                            height: 50.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context).primary,
                            textStyle: FlutterFlowTheme.of(context)
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
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                      ),
                    ],
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
