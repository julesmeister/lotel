import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/forms/transaction_edit/transaction_edit_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'option_to_booking_transaction_model.dart';
export 'option_to_booking_transaction_model.dart';

class OptionToBookingTransactionWidget extends StatefulWidget {
  const OptionToBookingTransactionWidget({
    super.key,
    required this.ref,
    required this.roomNo,
    required this.description,
    required this.price,
    this.booking,
  });

  final DocumentReference? ref;
  final int? roomNo;
  final String? description;
  final double? price;
  final DocumentReference? booking;

  @override
  State<OptionToBookingTransactionWidget> createState() =>
      _OptionToBookingTransactionWidgetState();
}

class _OptionToBookingTransactionWidgetState
    extends State<OptionToBookingTransactionWidget> {
  late OptionToBookingTransactionModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OptionToBookingTransactionModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      // room
      _model.room = await queryRoomsRecordOnce(
        queryBuilder: (roomsRecord) => roomsRecord
            .where(
              'hotel',
              isEqualTo: FFAppState().hotel,
            )
            .where(
              'number',
              isEqualTo: widget!.roomNo,
            ),
        singleRecord: true,
      ).then((s) => s.firstOrNull);
      _model.settings =
          await HotelSettingsRecord.getDocumentOnce(FFAppState().settingRef!);
    });

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

    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Container(
        width: 300.0,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          boxShadow: [
            BoxShadow(
              blurRadius: 4.0,
              color: Color(0x33000000),
              offset: Offset(
                0.0,
                2.0,
              ),
            )
          ],
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 12.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(12.0, 12.0, 0.0, 0.0),
                child: Text(
                  'Options For Room ${widget!.roomNo?.toString()}',
                  textAlign: TextAlign.start,
                  style: FlutterFlowTheme.of(context).labelMedium.override(
                        fontFamily: 'Readex Pro',
                        letterSpacing: 0.0,
                      ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    // edit transaction description
                    await showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: MediaQuery.viewInsetsOf(context),
                          child: Container(
                            height: double.infinity,
                            child: TransactionEditWidget(
                              ref: widget!.ref!,
                              description: widget!.description!,
                              price: widget!.price!,
                              roomRef: _model.room?.reference,
                              bookingRef: widget!.booking,
                            ),
                          ),
                        );
                      },
                    ).then((value) => safeSetState(() {}));

                    // close first
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                12.0, 0.0, 0.0, 0.0),
                            child: Icon(
                              Icons.auto_awesome_motion_outlined,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 20.0,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  12.0, 0.0, 0.0, 0.0),
                              child: Text(
                                'Change Details',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      letterSpacing: 0.0,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    // close
                    Navigator.pop(context);
                    var confirmDialogResponse = await showDialog<bool>(
                          context: context,
                          builder: (alertDialogContext) {
                            return AlertDialog(
                              title: Text('Mark as Pending'),
                              content: Text(
                                  'Guest has decided not to pay balance yet?'),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(alertDialogContext, false),
                                  child: Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(alertDialogContext, true),
                                  child: Text('Confirm'),
                                ),
                              ],
                            );
                          },
                        ) ??
                        false;
                    if (confirmDialogResponse) {
                      // set pending transaction

                      await widget!.ref!.update(createTransactionsRecordData(
                        pending: true,
                        description: (String description) {
                          return description.replaceAll(
                              RegExp(
                                  r'Guest paid the outstanding balance since \d+ hours ago for '),
                              '');
                        }(widget!.description!),
                      ));
                      // add to pending

                      await widget!.booking!.update({
                        ...createBookingsRecordData(
                          status: 'pending',
                        ),
                        ...mapToFirestore(
                          {
                            'pendings': FieldValue.arrayUnion([widget!.ref]),
                          },
                        ),
                      });
                      // bookingRef
                      _model.bookingRef = await BookingsRecord.getDocumentOnce(
                          widget!.booking!);
                      // create history

                      await HistoryRecord.createDoc(_model.bookingRef!.room!)
                          .set({
                        ...createHistoryRecordData(
                          description: 'Transaction worth ${formatNumber(
                            widget!.price,
                            formatType: FormatType.decimal,
                            decimalType: DecimalType.automatic,
                            currency: 'Php ',
                          )} now pending.',
                          staff: currentUserReference,
                          booking: widget!.booking,
                        ),
                        ...mapToFirestore(
                          {
                            'date': FieldValue.serverTimestamp(),
                          },
                        ),
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Transaction is now marked as pending!',
                            style: TextStyle(
                              color: FlutterFlowTheme.of(context).primaryText,
                            ),
                          ),
                          duration: Duration(milliseconds: 4000),
                          backgroundColor:
                              FlutterFlowTheme.of(context).secondary,
                        ),
                      );
                    }

                    setState(() {});
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                12.0, 0.0, 0.0, 0.0),
                            child: Icon(
                              Icons.auto_awesome_motion_outlined,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 20.0,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  12.0, 0.0, 0.0, 0.0),
                              child: Text(
                                'Mark as Pending',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      letterSpacing: 0.0,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    var confirmDialogResponse = await showDialog<bool>(
                          context: context,
                          builder: (alertDialogContext) {
                            return AlertDialog(
                              title: Text('Converting Guest to Senior Citizen'),
                              content: Text('Are you sure about this?'),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(alertDialogContext, false),
                                  child: Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(alertDialogContext, true),
                                  child: Text('Confirm'),
                                ),
                              ],
                            );
                          },
                        ) ??
                        false;
                    if (confirmDialogResponse) {
                      // read booking
                      _model.bookingNorm = await BookingsRecord.getDocumentOnce(
                          widget!.booking!);
                      if (_model.bookingNorm?.ability == 'normal') {
                        // no further discount
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'There\'s nothing to change.',
                              style: TextStyle(
                                color: FlutterFlowTheme.of(context).info,
                              ),
                            ),
                            duration: Duration(milliseconds: 4000),
                            backgroundColor: FlutterFlowTheme.of(context).error,
                          ),
                        );
                      } else {
                        // make senior in booking

                        await widget!.booking!.update(createBookingsRecordData(
                          ability: 'normal',
                          total: (double total, bool promoOn) {
                            return total / (1 - (promoOn ? 0.1 : 0.2));
                          }(_model.bookingNorm!.total,
                              _model.settings!.promoOn),
                        ));
                        // read Transaction again
                        _model.readTransNorm =
                            await TransactionsRecord.getDocumentOnce(
                                widget!.ref!);
                        // create new transaction

                        await TransactionsRecord.collection.doc().set({
                          ...createTransactionsRecordData(
                            description:
                                'Guest from room ${widget!.roomNo?.toString()} is no longer a discounted guest.',
                            staff: currentUserReference,
                            total: (double total, bool promoOn) {
                              return (total -
                                      total / (1 - (promoOn ? 0.1 : 0.2)))
                                  .abs();
                            }(_model.bookingNorm!.total,
                                _model.settings!.promoOn),
                            booking: widget!.booking,
                            type: 'book',
                            pending: _model.readTransNorm?.pending,
                            remitted: false,
                            hotel: FFAppState().hotel,
                            guests: int.tryParse(_model.bookingNorm!.guests),
                            room: widget!.roomNo,
                          ),
                          ...mapToFirestore(
                            {
                              'date': FieldValue.serverTimestamp(),
                            },
                          ),
                        });
                        // create history

                        await HistoryRecord.createDoc(_model.bookingNorm!.room!)
                            .set({
                          ...createHistoryRecordData(
                            description:
                                'Guest from room ${widget!.roomNo?.toString()} no longer discounted.',
                            staff: currentUserReference,
                            booking: widget!.booking,
                          ),
                          ...mapToFirestore(
                            {
                              'date': FieldValue.serverTimestamp(),
                            },
                          ),
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Guest is no longer discounted!',
                              style: TextStyle(
                                color: FlutterFlowTheme.of(context).primaryText,
                              ),
                            ),
                            duration: Duration(milliseconds: 4000),
                            backgroundColor:
                                FlutterFlowTheme.of(context).secondary,
                          ),
                        );
                      }
                    }
                    // close
                    Navigator.pop(context);

                    setState(() {});
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                12.0, 0.0, 0.0, 0.0),
                            child: Icon(
                              Icons.transform,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 20.0,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  12.0, 0.0, 0.0, 0.0),
                              child: Text(
                                'Remove Senior/PWD Discount',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      letterSpacing: 0.0,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    var confirmDialogResponse = await showDialog<bool>(
                          context: context,
                          builder: (alertDialogContext) {
                            return AlertDialog(
                              title: Text('Converting Guest to Senior Citizen'),
                              content: Text('Are you sure about this?'),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(alertDialogContext, false),
                                  child: Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(alertDialogContext, true),
                                  child: Text('Confirm'),
                                ),
                              ],
                            );
                          },
                        ) ??
                        false;
                    if (confirmDialogResponse) {
                      // read booking
                      _model.booking = await BookingsRecord.getDocumentOnce(
                          widget!.booking!);
                      if (_model.booking?.ability == 'normal') {
                        // make senior in booking

                        await widget!.booking!.update(createBookingsRecordData(
                          ability: 'senior',
                          total: (double total, bool promoOn) {
                            return total - (total * (promoOn ? 0.1 : 0.2));
                          }(_model.booking!.total, _model.settings!.promoOn),
                        ));
                        // read Transaction again
                        _model.readTrans =
                            await TransactionsRecord.getDocumentOnce(
                                widget!.ref!);
                        // create new transaction

                        await TransactionsRecord.collection.doc().set({
                          ...createTransactionsRecordData(
                            description:
                                'Guest from room ${widget!.roomNo?.toString()} is now categorized as senior citizen. Hereby granting a discount.',
                            staff: currentUserReference,
                            total: (double total, bool promoOn) {
                              return -(total * (promoOn ? 0.1 : 0.2));
                            }(widget!.price!, _model.settings!.promoOn),
                            booking: widget!.booking,
                            type: 'book',
                            pending: _model.readTrans?.pending,
                            remitted: false,
                            hotel: FFAppState().hotel,
                            guests: int.tryParse(_model.booking!.guests),
                            room: widget!.roomNo,
                          ),
                          ...mapToFirestore(
                            {
                              'date': FieldValue.serverTimestamp(),
                            },
                          ),
                        });
                        // create history

                        await HistoryRecord.createDoc(_model.booking!.room!)
                            .set({
                          ...createHistoryRecordData(
                            description:
                                'Guest from room ${widget!.roomNo?.toString()} now discounted as senior citizen.',
                            staff: currentUserReference,
                            booking: widget!.booking,
                          ),
                          ...mapToFirestore(
                            {
                              'date': FieldValue.serverTimestamp(),
                            },
                          ),
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Guest has been categorized as senior citizen.',
                              style: TextStyle(
                                color: FlutterFlowTheme.of(context).primaryText,
                              ),
                            ),
                            duration: Duration(milliseconds: 4000),
                            backgroundColor:
                                FlutterFlowTheme.of(context).secondary,
                          ),
                        );
                      } else {
                        // no further discount
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'There is no further discount we can provide.',
                              style: TextStyle(
                                color: FlutterFlowTheme.of(context).info,
                              ),
                            ),
                            duration: Duration(milliseconds: 4000),
                            backgroundColor: FlutterFlowTheme.of(context).error,
                          ),
                        );
                      }
                    }
                    // close
                    Navigator.pop(context);

                    setState(() {});
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                12.0, 0.0, 0.0, 0.0),
                            child: Icon(
                              Icons.transform,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 20.0,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  12.0, 0.0, 0.0, 0.0),
                              child: Text(
                                'Categorize as Senior',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      letterSpacing: 0.0,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    var confirmDialogResponse = await showDialog<bool>(
                          context: context,
                          builder: (alertDialogContext) {
                            return AlertDialog(
                              title: Text('Categorizing Guest to PWD'),
                              content: Text('Are you sure about this?'),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(alertDialogContext, false),
                                  child: Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(alertDialogContext, true),
                                  child: Text('Confirm'),
                                ),
                              ],
                            );
                          },
                        ) ??
                        false;
                    if (confirmDialogResponse) {
                      // read booking
                      _model.bookingPWD = await BookingsRecord.getDocumentOnce(
                          widget!.booking!);
                      if (_model.bookingNorm?.ability == 'normal') {
                        // make pwd in booking

                        await _model.bookingPWD!.reference
                            .update(createBookingsRecordData(
                          ability: 'pwd',
                          total: (double total, bool promoOn) {
                            return total - (total * (promoOn ? 0.1 : 0.2));
                          }(_model.bookingPWD!.total, _model.settings!.promoOn),
                        ));
                        // read Transaction again
                        _model.readTransPWD =
                            await TransactionsRecord.getDocumentOnce(
                                widget!.ref!);
                        // create new transaction

                        await TransactionsRecord.collection.doc().set({
                          ...createTransactionsRecordData(
                            description:
                                'Guest from room ${widget!.roomNo?.toString()} is now categorized as PWD. Hereby granting a discount.',
                            staff: currentUserReference,
                            total: (double total, bool promoOn) {
                              return -(total * (promoOn ? 0.1 : 0.2));
                            }(_model.readTransPWD!.total,
                                _model.settings!.promoOn),
                            booking: _model.bookingPWD?.reference,
                            type: 'book',
                            pending: _model.readTransPWD?.pending,
                            remitted: false,
                            hotel: FFAppState().hotel,
                            guests: int.tryParse(_model.bookingPWD!.guests),
                            room: widget!.roomNo,
                          ),
                          ...mapToFirestore(
                            {
                              'date': FieldValue.serverTimestamp(),
                            },
                          ),
                        });
                        // create history

                        await HistoryRecord.createDoc(_model.bookingNorm!.room!)
                            .set({
                          ...createHistoryRecordData(
                            description:
                                'Guest from room ${widget!.roomNo?.toString()} now discounted as PWD.',
                            staff: currentUserReference,
                            booking: widget!.booking,
                          ),
                          ...mapToFirestore(
                            {
                              'date': FieldValue.serverTimestamp(),
                            },
                          ),
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Guest has been categorized as PWD.',
                              style: TextStyle(
                                color: FlutterFlowTheme.of(context).primaryText,
                              ),
                            ),
                            duration: Duration(milliseconds: 4000),
                            backgroundColor:
                                FlutterFlowTheme.of(context).secondary,
                          ),
                        );
                      } else {
                        // no further discount
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'There is no further discount we can provide.',
                              style: TextStyle(
                                color: FlutterFlowTheme.of(context).info,
                              ),
                            ),
                            duration: Duration(milliseconds: 4000),
                            backgroundColor: FlutterFlowTheme.of(context).error,
                          ),
                        );
                      }
                    }
                    // close
                    Navigator.pop(context);

                    setState(() {});
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                12.0, 0.0, 0.0, 0.0),
                            child: Icon(
                              Icons.transform_sharp,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 20.0,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  12.0, 0.0, 0.0, 0.0),
                              child: Text(
                                'Categorize as PWD',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      letterSpacing: 0.0,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    if (valueOrDefault(currentUserDocument?.role, '') ==
                        'admin') {
                      // delete transaction?
                      var confirmDialogResponse = await showDialog<bool>(
                            context: context,
                            builder: (alertDialogContext) {
                              return AlertDialog(
                                title: Text('Are you sure?'),
                                content: Text(
                                    'This transaction will be deleted. If this is a new checkin, the booking will also be deleted.'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(
                                        alertDialogContext, false),
                                    child: Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(alertDialogContext, true),
                                    child: Text('Confirm'),
                                  ),
                                ],
                              );
                            },
                          ) ??
                          false;
                      if (confirmDialogResponse) {
                        // transaction action output
                        _model.trans = await TransactionsRecord.getDocumentOnce(
                            widget!.ref!);
                        if (functions.findTextsInString(
                            widget!.description, 'checkin')) {
                          if (!_model.room!.vacant) {
                            // update room vacancy and guests

                            await _model.room!.reference
                                .update(createRoomsRecordData(
                              vacant: true,
                              guests: 0,
                            ));
                          }
                          // delete booking
                          await _model.trans!.booking!.delete();
                        } else {
                          // decrement booking total

                          await widget!.booking!.update({
                            ...mapToFirestore(
                              {
                                'total':
                                    FieldValue.increment(-(widget!.price!)),
                                'nights': FieldValue.increment(-(1)),
                              },
                            ),
                          });
                        }

                        // history taking

                        await HistoryRecord.createDoc(_model.room!.reference)
                            .set({
                          ...createHistoryRecordData(
                            description:
                                'Removed transaction worth Php ${widget!.price?.toString()}',
                            staff: currentUserReference,
                          ),
                          ...mapToFirestore(
                            {
                              'date': FieldValue.serverTimestamp(),
                            },
                          ),
                        });
                        if (_model.trans!.remitted) {
                          // decrease stats

                          await FFAppState().statsReference!.update({
                            ...mapToFirestore(
                              {
                                'roomsIncome': FieldValue.increment(
                                    -(_model.trans!.total)),
                              },
                            ),
                          });
                        }
                        // delete transactions
                        await widget!.ref!.delete();
                        // transaction deleted
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Transaction is deleted!',
                              style: TextStyle(
                                color: FlutterFlowTheme.of(context).info,
                              ),
                            ),
                            duration: Duration(milliseconds: 4000),
                            backgroundColor: FlutterFlowTheme.of(context).error,
                          ),
                        );
                      }
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Consult Admin First!',
                            style: TextStyle(
                              color: FlutterFlowTheme.of(context).info,
                            ),
                          ),
                          duration: Duration(milliseconds: 4000),
                          backgroundColor: FlutterFlowTheme.of(context).error,
                        ),
                      );
                    }

                    setState(() {});
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                12.0, 0.0, 0.0, 0.0),
                            child: Icon(
                              Icons.delete_outlined,
                              color: FlutterFlowTheme.of(context).error,
                              size: 20.0,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  12.0, 0.0, 0.0, 0.0),
                              child: Text(
                                'Delete Transaction',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      letterSpacing: 0.0,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    if (valueOrDefault(currentUserDocument?.role, '') ==
                        'admin') {
                      // delete transaction?
                      var confirmDialogResponse = await showDialog<bool>(
                            context: context,
                            builder: (alertDialogContext) {
                              return AlertDialog(
                                title: Text('Are you sure?'),
                                content:
                                    Text('This duplicate will be removed.'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(
                                        alertDialogContext, false),
                                    child: Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(alertDialogContext, true),
                                    child: Text('Confirm'),
                                  ),
                                ],
                              );
                            },
                          ) ??
                          false;
                      if (confirmDialogResponse) {
                        // transaction action output
                        _model.duplicateTrans =
                            await TransactionsRecord.getDocumentOnce(
                                widget!.ref!);
                        // history taking

                        await HistoryRecord.createDoc(_model.room!.reference)
                            .set({
                          ...createHistoryRecordData(
                            description:
                                'There was a duplicate that caused admin to remove a transaction worth Php ${widget!.price?.toString()}',
                            staff: currentUserReference,
                          ),
                          ...mapToFirestore(
                            {
                              'date': FieldValue.serverTimestamp(),
                            },
                          ),
                        });
                        if (_model.duplicateTrans!.remitted) {
                          // decrease stats

                          await FFAppState().statsReference!.update({
                            ...mapToFirestore(
                              {
                                'roomsIncome': FieldValue.increment(
                                    -(_model.duplicateTrans!.total)),
                              },
                            ),
                          });
                        }
                        // delete transactions
                        await _model.duplicateTrans!.reference.delete();
                        // decrement book total

                        await widget!.booking!.update(createBookingsRecordData(
                          total: widget!.price,
                        ));
                        // duplicate removed
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Duplicate removed!',
                              style: TextStyle(
                                color: FlutterFlowTheme.of(context).info,
                              ),
                            ),
                            duration: Duration(milliseconds: 4000),
                            backgroundColor: FlutterFlowTheme.of(context).error,
                          ),
                        );
                      }
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Consult Admin First!',
                            style: TextStyle(
                              color: FlutterFlowTheme.of(context).info,
                            ),
                          ),
                          duration: Duration(milliseconds: 4000),
                          backgroundColor: FlutterFlowTheme.of(context).error,
                        ),
                      );
                    }

                    setState(() {});
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                12.0, 0.0, 0.0, 0.0),
                            child: Icon(
                              Icons.remove_outlined,
                              color: FlutterFlowTheme.of(context).error,
                              size: 20.0,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  12.0, 0.0, 0.0, 0.0),
                              child: Text(
                                'Remove duplicate',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      letterSpacing: 0.0,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
