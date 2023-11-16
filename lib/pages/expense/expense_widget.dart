import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'expense_model.dart';
export 'expense_model.dart';

class ExpenseWidget extends StatefulWidget {
  const ExpenseWidget({
    Key? key,
    bool? additional,
    this.remittanceRef,
    double? net,
  })  : this.additional = additional ?? false,
        this.net = net ?? 0.0,
        super(key: key);

  final bool additional;
  final DocumentReference? remittanceRef;
  final double net;

  @override
  _ExpenseWidgetState createState() => _ExpenseWidgetState();
}

class _ExpenseWidgetState extends State<ExpenseWidget>
    with TickerProviderStateMixin {
  late ExpenseModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = {
    'containerOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: Offset(0.0, 110.0),
          end: Offset(0.0, 0.0),
        ),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ExpenseModel());

    _model.amountController ??= TextEditingController();
    _model.amountFocusNode ??= FocusNode();

    _model.descriptionController ??= TextEditingController();
    _model.descriptionFocusNode ??= FocusNode();

    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          automaticallyImplyLeading: false,
          leading: Visibility(
            visible: widget.additional,
            child: FlutterFlowIconButton(
              borderRadius: 20.0,
              borderWidth: 1.0,
              buttonSize: 40.0,
              icon: Icon(
                Icons.chevron_left,
                color: FlutterFlowTheme.of(context).primaryText,
                size: 24.0,
              ),
              onPressed: () async {
                context.safePop();
              },
            ),
          ),
          title: Text(
            'Expense',
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Readex Pro',
                  fontSize: 26.0,
                ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Type a new expense',
                    style: FlutterFlowTheme.of(context).headlineMedium,
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                    child: Text(
                      'Fill out the form below to record a new expense.',
                      style: FlutterFlowTheme.of(context).labelLarge,
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      TextFormField(
                        controller: _model.amountController,
                        focusNode: _model.amountFocusNode,
                        autofocus: true,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'How much?',
                          labelStyle: FlutterFlowTheme.of(context)
                              .headlineSmall
                              .override(
                                fontFamily: 'Outfit',
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                fontWeight: FontWeight.w500,
                              ),
                          hintStyle: FlutterFlowTheme.of(context).labelMedium,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).alternate,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).primary,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                          focusedErrorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                          contentPadding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 12.0, 16.0, 12.0),
                        ),
                        style: FlutterFlowTheme.of(context).headlineSmall,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        cursorColor: FlutterFlowTheme.of(context).primary,
                        validator: _model.amountControllerValidator
                            .asValidator(context),
                      ),
                      TextFormField(
                        controller: _model.descriptionController,
                        focusNode: _model.descriptionFocusNode,
                        autofocus: true,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelStyle: FlutterFlowTheme.of(context).labelMedium,
                          hintText: 'Describe the expense',
                          hintStyle: FlutterFlowTheme.of(context).labelMedium,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).alternate,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).primary,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                          focusedErrorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                          contentPadding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 24.0, 16.0, 12.0),
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium,
                        maxLines: 16,
                        minLines: 6,
                        cursorColor: FlutterFlowTheme.of(context).primary,
                        validator: _model.descriptionControllerValidator
                            .asValidator(context),
                      ),
                    ]
                        .divide(SizedBox(height: 16.0))
                        .addToStart(SizedBox(height: 12.0)),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(
                          color: FlutterFlowTheme.of(context).alternate,
                          width: 2.0,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 15.0, 16.0, 15.0),
                        child: FlutterFlowChoiceChips(
                          options: [
                            ChipData('Food'),
                            ChipData('Pamasahe'),
                            ChipData('Dodong'),
                            ChipData('Cash Advance')
                          ],
                          onChanged: (val) async {
                            setState(() => _model.choicesValue = val?.first);
                            setState(() {
                              _model.descriptionController?.text =
                                  _model.choicesValue!;
                            });
                          },
                          selectedChipStyle: ChipStyle(
                            backgroundColor:
                                FlutterFlowTheme.of(context).primary,
                            textStyle: FlutterFlowTheme.of(context).titleSmall,
                            iconColor: Colors.white,
                            iconSize: 18.0,
                            labelPadding: EdgeInsetsDirectional.fromSTEB(
                                12.0, 4.0, 12.0, 4.0),
                            elevation: 2.0,
                          ),
                          unselectedChipStyle: ChipStyle(
                            backgroundColor:
                                FlutterFlowTheme.of(context).alternate,
                            textStyle: FlutterFlowTheme.of(context).labelMedium,
                            iconColor: FlutterFlowTheme.of(context).primaryText,
                            iconSize: 18.0,
                            labelPadding: EdgeInsetsDirectional.fromSTEB(
                                12.0, 4.0, 12.0, 4.0),
                            elevation: 0.0,
                          ),
                          chipSpacing: 12.0,
                          rowSpacing: 24.0,
                          multiselect: false,
                          alignment: WrapAlignment.start,
                          controller: _model.choicesValueController ??=
                              FormFieldController<List<String>>(
                            [],
                          ),
                          wrapped: true,
                        ),
                      ),
                    ).animateOnPageLoad(
                        animationsMap['containerOnPageLoadAnimation']!),
                  ),
                  if (_model.choicesValue == 'Cash Advance')
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                      child: StreamBuilder<List<StaffsRecord>>(
                        stream: _model.staffsCashAdvance(
                          requestFn: () => queryStaffsRecord(
                            queryBuilder: (staffsRecord) => staffsRecord.where(
                              'hotel',
                              isEqualTo: FFAppState().hotel,
                            ),
                          ),
                        ),
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
                          List<StaffsRecord> selectedNameStaffsRecordList =
                              snapshot.data!;
                          return FlutterFlowDropDown<String>(
                            controller: _model.selectedNameValueController ??=
                                FormFieldController<String>(null),
                            options: selectedNameStaffsRecordList
                                .map((e) => e.name)
                                .toList(),
                            onChanged: (val) async {
                              setState(() => _model.selectedNameValue = val);
                              setState(() {
                                _model.staffSelected =
                                    selectedNameStaffsRecordList
                                        .where((e) =>
                                            e.name == _model.selectedNameValue)
                                        .toList()
                                        .first
                                        .reference;
                              });
                            },
                            height: 60.0,
                            textStyle: FlutterFlowTheme.of(context).bodyMedium,
                            hintText: 'Select Name',
                            icon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 15.0,
                            ),
                            fillColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            elevation: 2.0,
                            borderColor: Color(0xFFE0E3E7),
                            borderWidth: 2.0,
                            borderRadius: 8.0,
                            margin: EdgeInsetsDirectional.fromSTEB(
                                12.0, 4.0, 12.0, 4.0),
                            hidesUnderline: true,
                            isSearchable: false,
                            isMultiSelect: false,
                          );
                        },
                      ),
                    ),
                  if (valueOrDefault(currentUserDocument?.role, '') !=
                      'generic')
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 12.0),
                      child: AuthUserStreamWidget(
                        builder: (context) => FFButtonWidget(
                          onPressed: () async {
                            var _shouldSetState = false;
                            if (_model.choicesValue == 'Cash Advance') {
                              if (_model.staffSelected != null) {
                                // Cash Advance? Sure?
                                var confirmDialogResponse =
                                    await showDialog<bool>(
                                          context: context,
                                          builder: (alertDialogContext) {
                                            return AlertDialog(
                                              title: Text('Cash Advance'),
                                              content: Text(
                                                  'Are you sure you want to cash in advance?'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          alertDialogContext,
                                                          false),
                                                  child: Text('Cancel'),
                                                ),
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          alertDialogContext,
                                                          true),
                                                  child: Text('Confirm'),
                                                ),
                                              ],
                                            );
                                          },
                                        ) ??
                                        false;
                                if (confirmDialogResponse) {
                                  // cash advance

                                  await AdvancesRecord.createDoc(
                                          _model.staffSelected!)
                                      .set({
                                    ...createAdvancesRecordData(
                                      settled: false,
                                      amount: double.tryParse(
                                          _model.amountController.text),
                                      requestedBy: currentUserReference,
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
                                        'You have cashed in advance!',
                                        style: TextStyle(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                        ),
                                      ),
                                      duration: Duration(milliseconds: 4000),
                                      backgroundColor:
                                          FlutterFlowTheme.of(context)
                                              .secondary,
                                    ),
                                  );
                                } else {
                                  if (_shouldSetState) setState(() {});
                                  return;
                                }

                                // Create transaction expense

                                var transactionsRecordReference1 =
                                    TransactionsRecord.collection.doc();
                                await transactionsRecordReference1.set({
                                  ...createTransactionsRecordData(
                                    staff: currentUserReference,
                                    total: double.tryParse(
                                        _model.amountController.text),
                                    type: 'expense',
                                    hotel: FFAppState().hotel,
                                    description:
                                        '${_model.selectedNameValue} claimed ${_model.descriptionController.text}',
                                    remitted: widget.additional ? true : false,
                                    pending: false,
                                  ),
                                  ...mapToFirestore(
                                    {
                                      'date': FieldValue.serverTimestamp(),
                                    },
                                  ),
                                });
                                _model.newCA =
                                    TransactionsRecord.getDocumentFromData({
                                  ...createTransactionsRecordData(
                                    staff: currentUserReference,
                                    total: double.tryParse(
                                        _model.amountController.text),
                                    type: 'expense',
                                    hotel: FFAppState().hotel,
                                    description:
                                        '${_model.selectedNameValue} claimed ${_model.descriptionController.text}',
                                    remitted: widget.additional ? true : false,
                                    pending: false,
                                  ),
                                  ...mapToFirestore(
                                    {
                                      'date': DateTime.now(),
                                    },
                                  ),
                                }, transactionsRecordReference1);
                                _shouldSetState = true;
                                // CA to expenseRef
                                setState(() {
                                  _model.expenseRef = _model.newCA?.reference;
                                });
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'You have not selected a staff yet!',
                                      style: TextStyle(
                                        color:
                                            FlutterFlowTheme.of(context).info,
                                      ),
                                    ),
                                    duration: Duration(milliseconds: 4000),
                                    backgroundColor:
                                        FlutterFlowTheme.of(context).error,
                                  ),
                                );
                                if (_shouldSetState) setState(() {});
                                return;
                              }
                            } else {
                              // Not cash advance
                              var confirmDialogResponse =
                                  await showDialog<bool>(
                                        context: context,
                                        builder: (alertDialogContext) {
                                          return AlertDialog(
                                            title: Text('Are you sure?'),
                                            content: Text(
                                                'You are submitting a new expense.'),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    alertDialogContext, false),
                                                child: Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    alertDialogContext, true),
                                                child: Text('Confirm'),
                                              ),
                                            ],
                                          );
                                        },
                                      ) ??
                                      false;
                              if (confirmDialogResponse) {
                                // Create transaction expense

                                var transactionsRecordReference2 =
                                    TransactionsRecord.collection.doc();
                                await transactionsRecordReference2.set({
                                  ...createTransactionsRecordData(
                                    staff: currentUserReference,
                                    total: double.tryParse(
                                        _model.amountController.text),
                                    type: 'expense',
                                    hotel: FFAppState().hotel,
                                    description: functions.resetFont(
                                        _model.descriptionController.text),
                                    remitted: widget.additional ? true : false,
                                    pending: false,
                                  ),
                                  ...mapToFirestore(
                                    {
                                      'date': FieldValue.serverTimestamp(),
                                    },
                                  ),
                                });
                                _model.newExp =
                                    TransactionsRecord.getDocumentFromData({
                                  ...createTransactionsRecordData(
                                    staff: currentUserReference,
                                    total: double.tryParse(
                                        _model.amountController.text),
                                    type: 'expense',
                                    hotel: FFAppState().hotel,
                                    description: functions.resetFont(
                                        _model.descriptionController.text),
                                    remitted: widget.additional ? true : false,
                                    pending: false,
                                  ),
                                  ...mapToFirestore(
                                    {
                                      'date': DateTime.now(),
                                    },
                                  ),
                                }, transactionsRecordReference2);
                                _shouldSetState = true;
                                // Saved
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Expense saved!',
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
                                // exp to expenseRef
                                setState(() {
                                  _model.expenseRef = _model.newExp?.reference;
                                });
                              } else {
                                if (_shouldSetState) setState(() {});
                                return;
                              }
                            }

                            if (widget.additional) {
                              // add expensRef to remittance

                              await widget.remittanceRef!.update({
                                ...mapToFirestore(
                                  {
                                    'expenses': FieldValue.increment(
                                        double.parse(
                                            _model.amountController.text)),
                                    'transactions': FieldValue.arrayUnion(
                                        [_model.expenseRef]),
                                    'net': FieldValue.increment(-(double.parse(
                                        _model.amountController.text))),
                                  },
                                ),
                              });
                              // update stats

                              await FFAppState().statsReference!.update({
                                ...mapToFirestore(
                                  {
                                    'expenses': FieldValue.increment(
                                        double.parse(
                                            _model.amountController.text)),
                                  },
                                ),
                              });
                            }
                            // Reset choice chips
                            setState(() {
                              _model.choicesValueController?.reset();
                            });
                            // Reset amount/description
                            setState(() {
                              _model.amountController?.clear();
                              _model.descriptionController?.clear();
                            });
                            // Reset selected staff
                            setState(() {
                              _model.selectedNameValueController?.reset();
                            });
                            if (_shouldSetState) setState(() {});
                          },
                          text: 'Submit Expense',
                          icon: Icon(
                            Icons.receipt_long,
                            size: 15.0,
                          ),
                          options: FFButtonOptions(
                            width: double.infinity,
                            height: 54.0,
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
                            elevation: 4.0,
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(12.0),
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
    );
  }
}
