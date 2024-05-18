import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'add_extra_bed_model.dart';
export 'add_extra_bed_model.dart';

class AddExtraBedWidget extends StatefulWidget {
  const AddExtraBedWidget({
    super.key,
    required this.booking,
  });

  final BookingsRecord? booking;

  @override
  State<AddExtraBedWidget> createState() => _AddExtraBedWidgetState();
}

class _AddExtraBedWidgetState extends State<AddExtraBedWidget> {
  late AddExtraBedModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddExtraBedModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      // hotelSetting
      _model.hotelSetting =
          await HotelSettingsRecord.getDocumentOnce(FFAppState().settingRef!);
      // set bed price
      setState(() {
        _model.bedPrice = _model.hotelSetting!.bedPrice;
      });
    });

    _model.numberTextController ??= TextEditingController(text: '0');
    _model.numberFocusNode ??= FocusNode();

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

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(),
      child: Align(
        alignment: const AlignmentDirectional(0.0, 1.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Align(
                alignment: const AlignmentDirectional(1.0, 0.0),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 12.0, 16.0),
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
                shape: const RoundedRectangleBorder(
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
                    borderRadius: const BorderRadius.only(
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
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 12.0, 0.0, 12.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 0.0, 0.0),
                              child: Text(
                                'Add Extra Bed',
                                style: FlutterFlowTheme.of(context)
                                    .headlineSmall
                                    .override(
                                      fontFamily: 'Outfit',
                                      letterSpacing: 0.0,
                                    ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(0.0, -1.0),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 10.0, 0.0),
                                child: Container(
                                  width: 80.0,
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    borderRadius: BorderRadius.circular(12.0),
                                    border: Border.all(
                                      color: FlutterFlowTheme.of(context)
                                          .alternate,
                                      width: 1.0,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              // minus operator
                                              setState(() {
                                                _model.numberTextController
                                                    ?.text = ((int.parse(_model
                                                            .numberTextController
                                                            .text) -
                                                        1)
                                                    .toString());
                                              });
                                              setState(() {
                                                _model.operator = '-';
                                              });
                                            },
                                            child: AnimatedContainer(
                                              duration:
                                                  const Duration(milliseconds: 100),
                                              curve: Curves.linear,
                                              width: 115.0,
                                              height: 100.0,
                                              decoration: BoxDecoration(
                                                color: _model.operator == '-'
                                                    ? FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground
                                                    : FlutterFlowTheme.of(
                                                            context)
                                                        .primaryBackground,
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                border: Border.all(
                                                  color: valueOrDefault<Color>(
                                                    _model.operator == '-'
                                                        ? FlutterFlowTheme.of(
                                                                context)
                                                            .alternate
                                                        : FlutterFlowTheme.of(
                                                                context)
                                                            .primaryBackground,
                                                    FlutterFlowTheme.of(context)
                                                        .alternate,
                                                  ),
                                                  width: 1.0,
                                                ),
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .horizontal_rule_outlined,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    size: 16.0,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              // add operator
                                              setState(() {
                                                _model.numberTextController
                                                    ?.text = ((int.parse(_model
                                                            .numberTextController
                                                            .text) +
                                                        1)
                                                    .toString());
                                              });
                                              setState(() {
                                                _model.operator = '+';
                                              });
                                            },
                                            child: AnimatedContainer(
                                              duration:
                                                  const Duration(milliseconds: 100),
                                              curve: Curves.linear,
                                              width: 115.0,
                                              height: 100.0,
                                              decoration: BoxDecoration(
                                                color: _model.operator == '+'
                                                    ? FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground
                                                    : FlutterFlowTheme.of(
                                                            context)
                                                        .primaryBackground,
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                border: Border.all(
                                                  color: _model.operator == '+'
                                                      ? FlutterFlowTheme.of(
                                                              context)
                                                          .alternate
                                                      : FlutterFlowTheme.of(
                                                              context)
                                                          .primaryBackground,
                                                  width: 1.0,
                                                ),
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.add,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    size: 16.0,
                                                  ),
                                                ],
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
                      const Divider(
                        height: 4.0,
                        thickness: 1.0,
                        color: Color(0xFFE0E3E7),
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: TextFormField(
                          controller: _model.numberTextController,
                          focusNode: _model.numberFocusNode,
                          autofocus: true,
                          textCapitalization: TextCapitalization.sentences,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Additional',
                            labelStyle:
                                FlutterFlowTheme.of(context).bodySmall.override(
                                      fontFamily: 'Readex Pro',
                                      fontSize: 28.0,
                                      letterSpacing: 0.0,
                                    ),
                            hintText: 'Details',
                            hintStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Lexend Deca',
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  fontSize: 28.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.normal,
                                ),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                            filled: true,
                            fillColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            contentPadding: const EdgeInsetsDirectional.fromSTEB(
                                16.0, 24.0, 20.0, 24.0),
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 28.0,
                                    letterSpacing: 0.0,
                                  ),
                          minLines: 1,
                          keyboardType: const TextInputType.numberWithOptions(
                              signed: true, decimal: true),
                          validator: _model.numberTextControllerValidator
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
                            8.0, 4.0, 16.0, 10.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  10.0, 0.0, 0.0, 0.0),
                              child: RichText(
                                textScaler: MediaQuery.of(context).textScaler,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Total: ',
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
                                      text: (int.parse(_model
                                                  .numberTextController.text) +
                                              int.parse(
                                                  widget.booking!.extraBeds))
                                          .toString(),
                                      style: TextStyle(
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    TextSpan(
                                      text: (String additional) {
                                        return (int.parse(additional) ?? 0) <= 1
                                            ? ' extra bed'
                                            : ' extra beds';
                                      }(_model.numberTextController.text),
                                      style: const TextStyle(),
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
                                  if (((String additional) {
                                        return int.tryParse(additional) != null;
                                      }(_model.numberTextController.text)) &&
                                      (_model.numberTextController.text !=
                                          '0')) {
                                    // history

                                    await HistoryRecord.createDoc(
                                            widget.booking!.room!)
                                        .set({
                                      ...createHistoryRecordData(
                                        description: (String additional,
                                                String existing) {
                                          return (int.tryParse(additional) ??
                                                      0) >
                                                  0
                                              ? '$additional beds added'
                                              : '$additional beds removed';
                                        }(_model.numberTextController.text,
                                            widget.booking!.extraBeds),
                                        staff: currentUserReference,
                                        booking: widget.booking?.reference,
                                      ),
                                      ...mapToFirestore(
                                        {
                                          'date': FieldValue.serverTimestamp(),
                                        },
                                      ),
                                    });
                                    // room
                                    _model.room =
                                        await RoomsRecord.getDocumentOnce(
                                            widget.booking!.room!);
                                    // create transaction

                                    var transactionsRecordReference =
                                        TransactionsRecord.collection.doc();
                                    await transactionsRecordReference.set({
                                      ...createTransactionsRecordData(
                                        staff: currentUserReference,
                                        total: _model.hotelSetting!.bedPrice *
                                            double.parse(_model
                                                .numberTextController.text),
                                        hotel: FFAppState().hotel,
                                        type: 'book',
                                        remitted: false,
                                        pending:
                                            widget.booking?.status == 'pending',
                                        room: _model.room?.number,
                                        booking: widget.booking?.reference,
                                        description: (String additional,
                                                String existing, int room) {
                                          return '${(int.tryParse(additional) ??
                                                          0) >
                                                      0
                                                  ? '$additional beds added'
                                                  : '$additional beds removed'} on room $room';
                                        }(
                                            _model.numberTextController.text,
                                            widget.booking!.extraBeds,
                                            _model.room!.number),
                                        guests:
                                            int.parse(widget.booking!.guests),
                                      ),
                                      ...mapToFirestore(
                                        {
                                          'date': FieldValue.serverTimestamp(),
                                        },
                                      ),
                                    });
                                    _model.trans =
                                        TransactionsRecord.getDocumentFromData({
                                      ...createTransactionsRecordData(
                                        staff: currentUserReference,
                                        total: _model.hotelSetting!.bedPrice *
                                            double.parse(_model
                                                .numberTextController.text),
                                        hotel: FFAppState().hotel,
                                        type: 'book',
                                        remitted: false,
                                        pending:
                                            widget.booking?.status == 'pending',
                                        room: _model.room?.number,
                                        booking: widget.booking?.reference,
                                        description: (String additional,
                                                String existing, int room) {
                                          return '${(int.tryParse(additional) ??
                                                          0) >
                                                      0
                                                  ? '$additional beds added'
                                                  : '$additional beds removed'} on room $room';
                                        }(
                                            _model.numberTextController.text,
                                            widget.booking!.extraBeds,
                                            _model.room!.number),
                                        guests:
                                            int.parse(widget.booking!.guests),
                                      ),
                                      ...mapToFirestore(
                                        {
                                          'date': DateTime.now(),
                                        },
                                      ),
                                    }, transactionsRecordReference);
                                    // update booking total + transactions

                                    await widget.booking!.reference.update({
                                      ...createBookingsRecordData(
                                        extraBeds: (int.parse(_model
                                                    .numberTextController
                                                    .text) +
                                                int.parse(
                                                    widget.booking!.extraBeds))
                                            .toString(),
                                      ),
                                      ...mapToFirestore(
                                        {
                                          'transactions': FieldValue.arrayUnion(
                                              [_model.trans?.reference]),
                                          'total': FieldValue.increment(
                                              _model.hotelSetting!.bedPrice *
                                                  double.parse(_model
                                                      .numberTextController
                                                      .text)),
                                        },
                                      ),
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Extra bed has been updated!',
                                          style: TextStyle(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                          ),
                                        ),
                                        duration: const Duration(milliseconds: 4000),
                                        backgroundColor:
                                            FlutterFlowTheme.of(context)
                                                .secondary,
                                      ),
                                    );
                                    Navigator.pop(context);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Enter a correct value!',
                                          style: TextStyle(
                                            color: FlutterFlowTheme.of(context)
                                                .error,
                                          ),
                                        ),
                                        duration: const Duration(milliseconds: 4000),
                                        backgroundColor:
                                            FlutterFlowTheme.of(context).info,
                                      ),
                                    );
                                  }

                                  setState(() {});
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 12.0, 0.0),
                                      child: Text(
                                        'Save',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Readex Pro',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondary,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ),
                                    Icon(
                                      Icons.send_rounded,
                                      color: FlutterFlowTheme.of(context)
                                          .secondary,
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
