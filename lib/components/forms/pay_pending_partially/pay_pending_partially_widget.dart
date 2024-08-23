import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/forms/change_amount/change_amount_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'pay_pending_partially_model.dart';
export 'pay_pending_partially_model.dart';

class PayPendingPartiallyWidget extends StatefulWidget {
  const PayPendingPartiallyWidget({
    super.key,
    required this.transactions,
    required this.booking,
  });

  final List<TransactionsRecord>? transactions;
  final DocumentReference? booking;

  @override
  State<PayPendingPartiallyWidget> createState() =>
      _PayPendingPartiallyWidgetState();
}

class _PayPendingPartiallyWidgetState extends State<PayPendingPartiallyWidget> {
  late PayPendingPartiallyModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PayPendingPartiallyModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      // reset
      _model.loop = 0;
      setState(() {});
      while (widget!.transactions?.length != _model.loop) {
        // add transaction to list
        _model.addToPendings(PayPendingStruct(
          amount: widget!.transactions?[_model.loop]?.total,
          pending: false,
          ref: widget!.transactions?[_model.loop]?.reference,
        ));
        setState(() {});
        // + loop
        _model.loop = _model.loop + 1;
        setState(() {});
      }
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
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(),
      child: Align(
        alignment: AlignmentDirectional(0.0, 1.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Align(
                alignment: AlignmentDirectional(1.0, 0.0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 12.0, 16.0),
                  child: FlutterFlowIconButton(
                    borderColor: Colors.transparent,
                    borderRadius: 30.0,
                    borderWidth: 1.0,
                    buttonSize: 44.0,
                    fillColor: FlutterFlowTheme.of(context).primaryBackground,
                    icon: Icon(
                      Icons.close_rounded,
                      color: FlutterFlowTheme.of(context).secondaryText,
                      size: 24.0,
                    ),
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              Material(
                color: Colors.transparent,
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0.0),
                    bottomRight: Radius.circular(0.0),
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                ),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0.0),
                      bottomRight: Radius.circular(0.0),
                      topLeft: Radius.circular(16.0),
                      topRight: Radius.circular(16.0),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0.0, 12.0, 0.0, 12.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 6,
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 0.0, 0.0),
                                child: Text(
                                  'Pay',
                                  style: FlutterFlowTheme.of(context)
                                      .headlineSmall
                                      .override(
                                        fontFamily: 'Outfit',
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 16.0, 0.0),
                              child: Text(
                                formatNumber(
                                  _model.pendings
                                      .where((e) => !e.pending)
                                      .toList()
                                      .length,
                                  formatType: FormatType.custom,
                                  format: '# selected',
                                  locale: '',
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      letterSpacing: 0.0,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 4.0,
                        thickness: 1.0,
                        color: Color(0xFFE0E3E7),
                      ),
                      Builder(
                        builder: (context) {
                          final pendingTransactions = _model.pendings.toList();

                          return ListView.builder(
                            padding: EdgeInsets.zero,
                            primary: false,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: pendingTransactions.length,
                            itemBuilder: (context, pendingTransactionsIndex) {
                              final pendingTransactionsItem =
                                  pendingTransactions[pendingTransactionsIndex];
                              return Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20.0, 5.0, 16.0, 5.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    await showModalBottomSheet(
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      context: context,
                                      builder: (context) {
                                        return Padding(
                                          padding:
                                              MediaQuery.viewInsetsOf(context),
                                          child: Container(
                                            height: double.infinity,
                                            child: ChangeAmountWidget(
                                              amount: pendingTransactionsItem
                                                  .amount,
                                            ),
                                          ),
                                        );
                                      },
                                    ).then((value) => safeSetState(
                                        () => _model.amount = value));

                                    if (_model.amount != null) {
                                      // update amount
                                      _model.updatePendingsAtIndex(
                                        pendingTransactionsIndex,
                                        (e) => e..amount = _model.amount,
                                      );
                                      setState(() {});
                                    }

                                    setState(() {});
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            formatNumber(
                                              pendingTransactionsItem.amount,
                                              formatType: FormatType.decimal,
                                              decimalType:
                                                  DecimalType.automatic,
                                              currency: 'Php ',
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Readex Pro',
                                                  fontSize: 22.0,
                                                  letterSpacing: 0.0,
                                                ),
                                          ),
                                          Text(
                                            dateTimeFormat(
                                                "EEEE MMMM d y h:mm a",
                                                widget!.transactions!
                                                    .where((e) =>
                                                        e.reference ==
                                                        pendingTransactionsItem
                                                            .ref)
                                                    .toList()
                                                    .first
                                                    .date!),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Readex Pro',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  letterSpacing: 0.0,
                                                ),
                                          ),
                                        ],
                                      ),
                                      Theme(
                                        data: ThemeData(
                                          checkboxTheme: CheckboxThemeData(
                                            visualDensity:
                                                VisualDensity.compact,
                                            materialTapTargetSize:
                                                MaterialTapTargetSize
                                                    .shrinkWrap,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4.0),
                                            ),
                                          ),
                                          unselectedWidgetColor:
                                              FlutterFlowTheme.of(context)
                                                  .secondaryText,
                                        ),
                                        child: Checkbox(
                                          value: _model.checkboxValueMap[
                                                  pendingTransactionsItem] ??=
                                              !pendingTransactionsItem.pending,
                                          onChanged: (newValue) async {
                                            setState(() => _model
                                                        .checkboxValueMap[
                                                    pendingTransactionsItem] =
                                                newValue!);
                                            if (newValue!) {
                                              // paid
                                              _model.updatePendingsAtIndex(
                                                pendingTransactionsIndex,
                                                (e) => e..pending = false,
                                              );
                                              setState(() {});
                                            } else {
                                              // pending
                                              _model.updatePendingsAtIndex(
                                                pendingTransactionsIndex,
                                                (e) => e..pending = true,
                                              );
                                              setState(() {});
                                            }
                                          },
                                          side: BorderSide(
                                            width: 2,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                          ),
                                          activeColor:
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                          checkColor:
                                              FlutterFlowTheme.of(context).info,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                      Divider(
                        height: 4.0,
                        thickness: 1.0,
                        color: Color(0xFFE0E3E7),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            8.0, 4.0, 16.0, 16.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  10.0, 0.0, 0.0, 0.0),
                              child: RichText(
                                textScaler: MediaQuery.of(context).textScaler,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Total Paid: ',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Readex Pro',
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.normal,
                                          ),
                                    ),
                                    TextSpan(
                                      text: formatNumber(
                                        (List<double> amounts) {
                                          return amounts.fold<double>(
                                              0,
                                              (previousValue, element) =>
                                                  previousValue +
                                                  (element ?? 0));
                                        }(_model.pendings
                                            .where((e) => !e.pending)
                                            .toList()
                                            .map((e) => e.amount)
                                            .toList()),
                                        formatType: FormatType.decimal,
                                        decimalType: DecimalType.automatic,
                                        currency: 'Php ',
                                      ),
                                      style: TextStyle(
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    )
                                  ],
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ),
                            ),
                            Container(
                              width: 150.0,
                              height: 44.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  // get booking
                                  _model.booking =
                                      await BookingsRecord.getDocumentOnce(
                                          widget!.booking!);
                                  // room
                                  _model.room =
                                      await RoomsRecord.getDocumentOnce(
                                          _model.booking!.room!);
                                  // reset
                                  _model.loop = 0;
                                  setState(() {});
                                  while (
                                      _model.pendings.length != _model.loop) {
                                    if (_model.pendings[_model.loop].pending) {
                                      // update total only

                                      await _model.pendings[_model.loop].ref!
                                          .update(createTransactionsRecordData(
                                        total:
                                            _model.pendings[_model.loop].amount,
                                        pending: true,
                                      ));
                                    } else {
                                      // update transaction

                                      await _model.pendings[_model.loop].ref!
                                          .update({
                                        ...createTransactionsRecordData(
                                          description:
                                              'Guest paid the outstanding balance since ${functions.hoursAgo(widget!.transactions!.where((e) => e.reference == _model.pendings[_model.loop].ref).toList().first.date!)} for ${widget!.transactions?.where((e) => e.reference == _model.pendings[_model.loop].ref).toList()?.first?.description}',
                                          total: _model
                                              .pendings[_model.loop].amount,
                                          staff: currentUserReference,
                                          pending: false,
                                        ),
                                        ...mapToFirestore(
                                          {
                                            'date':
                                                FieldValue.serverTimestamp(),
                                          },
                                        ),
                                      });
                                      // remove pending from booking

                                      await widget!.booking!.update({
                                        ...mapToFirestore(
                                          {
                                            'pendings': FieldValue.arrayRemove([
                                              _model.pendings[_model.loop].ref
                                            ]),
                                            'transactions':
                                                FieldValue.arrayUnion([
                                              _model.pendings[_model.loop].ref
                                            ]),
                                          },
                                        ),
                                      });
                                    }

                                    // + loop
                                    _model.loop = _model.loop + 1;
                                    setState(() {});
                                  }
                                  // set history

                                  await HistoryRecord.createDoc(
                                          _model.room!.reference)
                                      .set({
                                    ...createHistoryRecordData(
                                      description:
                                          'Guest settled balance for ${formatNumber(
                                        _model.pendings
                                            .where((e) => !e.pending)
                                            .toList()
                                            .length,
                                        formatType: FormatType.custom,
                                        format: '# transactions',
                                        locale: '',
                                      )}.',
                                      staff: currentUserReference,
                                      booking: widget!.booking,
                                    ),
                                    ...mapToFirestore(
                                      {
                                        'date': FieldValue.serverTimestamp(),
                                      },
                                    ),
                                  });
                                  // update book status

                                  await widget!.booking!
                                      .update(createBookingsRecordData(
                                    status: widget!.transactions?.length !=
                                            _model.pendings
                                                .where(
                                                    (e) => e.pending == false)
                                                .toList()
                                                .length
                                        ? 'pending'
                                        : 'paid',
                                  ));
                                  // success
                                  Navigator.pop(context, true);

                                  setState(() {});
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 12.0, 0.0),
                                      child: Text(
                                        'Paid',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Readex Pro',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ),
                                    Icon(
                                      Icons.send_rounded,
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      size: 28.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
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
