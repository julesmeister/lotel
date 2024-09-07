import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:collection/collection.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'expense_model.dart';
export 'expense_model.dart';

class ExpenseWidget extends StatefulWidget {
  const ExpenseWidget({
    super.key,
    bool? additional,
    this.remittanceRef,
    double? net,
    this.issue,
  })  : additional = additional ?? false,
        net = net ?? 0.0;

  final bool additional;
  final DocumentReference? remittanceRef;
  final double net;
  final String? issue;

  @override
  State<ExpenseWidget> createState() => _ExpenseWidgetState();
}

class _ExpenseWidgetState extends State<ExpenseWidget>
    with TickerProviderStateMixin {
  late ExpenseModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ExpenseModel());

    _model.amountTextController ??= TextEditingController();
    _model.amountFocusNode ??= FocusNode();

    _model.descriptionTextController ??= TextEditingController(
        text:
            widget.issue != null && widget.issue != '' ? widget.issue : '');
    _model.descriptionFocusNode ??= FocusNode();

    animationsMap.addAll({
      'textOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          MoveEffect(
            curve: Curves.bounceOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: const Offset(0.0, -100.0),
            end: const Offset(0.0, 0.0),
          ),
        ],
      ),
      'textFieldOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          MoveEffect(
            curve: Curves.bounceOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: const Offset(-100.0, 0.0),
            end: const Offset(0.0, 0.0),
          ),
        ],
      ),
      'textFieldOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          MoveEffect(
            curve: Curves.bounceOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: const Offset(100.0, 0.0),
            end: const Offset(0.0, 0.0),
          ),
        ],
      ),
      'containerOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: const Offset(0.0, 110.0),
            end: const Offset(0.0, 0.0),
          ),
        ],
      ),
      'dropDownOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          MoveEffect(
            curve: Curves.bounceOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: const Offset(0.0, 100.0),
            end: const Offset(0.0, 0.0),
          ),
        ],
      ),
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          automaticallyImplyLeading: false,
          title: Text(
            'Expense',
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Readex Pro',
                  fontSize: 26.0,
                  letterSpacing: 0.0,
                ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 15.0, 0.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      if (valueOrDefault(currentUserDocument?.role, '') !=
                          'generic')
                        AuthUserStreamWidget(
                          builder: (context) => FlutterFlowIconButton(
                            borderRadius: 20.0,
                            borderWidth: 1.0,
                            buttonSize: 40.0,
                            disabledIconColor: const Color(0xFFDADBDC),
                            icon: Icon(
                              Icons.check,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 24.0,
                            ),
                            onPressed: _model.disableSubmit
                                ? null
                                : () async {
                                    var shouldSetState = false;
                                    if (_model.choicesValue == 'Cash Advance') {
                                      if (_model.staffSelected != null) {
                                        // Cash Advance? Sure?
                                        var confirmDialogResponse =
                                            await showDialog<bool>(
                                                  context: context,
                                                  builder:
                                                      (alertDialogContext) {
                                                    return AlertDialog(
                                                      title:
                                                          const Text('Cash Advance'),
                                                      content: const Text(
                                                          'Are you sure you want to cash in advance?'),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  alertDialogContext,
                                                                  false),
                                                          child: const Text('Cancel'),
                                                        ),
                                                        TextButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  alertDialogContext,
                                                                  true),
                                                          child:
                                                              const Text('Confirm'),
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
                                              amount: double.tryParse(_model
                                                  .amountTextController.text),
                                              requestedBy: currentUserReference,
                                            ),
                                            ...mapToFirestore(
                                              {
                                                'date': FieldValue
                                                    .serverTimestamp(),
                                              },
                                            ),
                                          });
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'You have cashed in advance!',
                                                style: TextStyle(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                ),
                                              ),
                                              duration:
                                                  const Duration(milliseconds: 4000),
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondary,
                                            ),
                                          );
                                        } else {
                                          if (shouldSetState) {
                                            safeSetState(() {});
                                          }
                                          return;
                                        }

                                        // Create transaction expense

                                        var transactionsRecordReference1 =
                                            TransactionsRecord.collection.doc();
                                        await transactionsRecordReference1.set({
                                          ...createTransactionsRecordData(
                                            staff: currentUserReference,
                                            total: double.tryParse(_model
                                                .amountTextController.text),
                                            type: 'expense',
                                            hotel: FFAppState().hotel,
                                            description:
                                                '${_model.selectedNameValue} claimed ${_model.descriptionTextController.text}',
                                            remitted: widget.additional
                                                ? true
                                                : false,
                                            pending: false,
                                          ),
                                          ...mapToFirestore(
                                            {
                                              'date':
                                                  FieldValue.serverTimestamp(),
                                            },
                                          ),
                                        });
                                        _model.newCACopy = TransactionsRecord
                                            .getDocumentFromData({
                                          ...createTransactionsRecordData(
                                            staff: currentUserReference,
                                            total: double.tryParse(_model
                                                .amountTextController.text),
                                            type: 'expense',
                                            hotel: FFAppState().hotel,
                                            description:
                                                '${_model.selectedNameValue} claimed ${_model.descriptionTextController.text}',
                                            remitted: widget.additional
                                                ? true
                                                : false,
                                            pending: false,
                                          ),
                                          ...mapToFirestore(
                                            {
                                              'date': DateTime.now(),
                                            },
                                          ),
                                        }, transactionsRecordReference1);
                                        shouldSetState = true;
                                        // CA to expenseRef
                                        _model.expenseRef =
                                            _model.newCACopy?.reference;
                                        safeSetState(() {});
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'You have not selected a staff yet!',
                                              style: TextStyle(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .info,
                                              ),
                                            ),
                                            duration:
                                                const Duration(milliseconds: 4000),
                                            backgroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .error,
                                          ),
                                        );
                                        if (shouldSetState) {
                                          safeSetState(() {});
                                        }
                                        return;
                                      }
                                    } else {
                                      if (functions.findTextsInString(
                                          _model.choicesValue, 'Absent')) {
                                        if (_model.staffSelected != null) {
                                          // Absent? Sure?
                                          var confirmDialogResponse =
                                              await showDialog<bool>(
                                                    context: context,
                                                    builder:
                                                        (alertDialogContext) {
                                                      return AlertDialog(
                                                        title: const Text('Absent'),
                                                        content: const Text(
                                                            'Are you sure you want to someone was absent?'),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                    alertDialogContext,
                                                                    false),
                                                            child:
                                                                const Text('Cancel'),
                                                          ),
                                                          TextButton(
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                    alertDialogContext,
                                                                    true),
                                                            child:
                                                                const Text('Confirm'),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  ) ??
                                                  false;
                                          if (confirmDialogResponse) {
                                            // create absent

                                            await AbsencesRecord.createDoc(
                                                    _model.staffSelected!)
                                                .set({
                                              ...createAbsencesRecordData(
                                                settled: false,
                                                amount: double.tryParse(_model
                                                    .amountTextController.text),
                                                encodedBy: currentUserReference,
                                                remitted: false,
                                                hotel: FFAppState().hotel,
                                              ),
                                              ...mapToFirestore(
                                                {
                                                  'date': FieldValue
                                                      .serverTimestamp(),
                                                },
                                              ),
                                            });
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'You have marked ${_model.selectedNameValue} absent!',
                                                  style: TextStyle(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                  ),
                                                ),
                                                duration: const Duration(
                                                    milliseconds: 4000),
                                                backgroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                              ),
                                            );
                                          } else {
                                            if (shouldSetState) {
                                              safeSetState(() {});
                                            }
                                            return;
                                          }
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'You have not selected a staff yet!',
                                                style: TextStyle(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .info,
                                                ),
                                              ),
                                              duration:
                                                  const Duration(milliseconds: 4000),
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .error,
                                            ),
                                          );
                                          if (shouldSetState) {
                                            safeSetState(() {});
                                          }
                                          return;
                                        }
                                      } else {
                                        if (_model.descriptionTextController
                                                    .text !=
                                                '') {
                                          // is there a duplicate within the last hour
                                          _model.duplicatewithin1hour =
                                              await queryTransactionsRecordCount(
                                            queryBuilder:
                                                (transactionsRecord) =>
                                                    transactionsRecord
                                                        .where(
                                                          'description',
                                                          isEqualTo: functions
                                                              .resetFont(functions
                                                                  .startBigLetter(_model
                                                                      .descriptionTextController
                                                                      .text)),
                                                        )
                                                        .where(
                                                          'hotel',
                                                          isEqualTo:
                                                              FFAppState()
                                                                  .hotel,
                                                        )
                                                        .where(
                                                          'type',
                                                          isEqualTo: 'expense',
                                                        )
                                                        .where(
                                                          'total',
                                                          isEqualTo: double
                                                              .parse(_model
                                                                  .amountTextController
                                                                  .text),
                                                        )
                                                        .where(
                                                          'remitted',
                                                          isEqualTo: false,
                                                        ),
                                          );
                                          shouldSetState = true;
                                          if (_model.duplicatewithin1hour ==
                                              0) {
                                            // Not cash advance
                                            var confirmDialogResponse =
                                                await showDialog<bool>(
                                                      context: context,
                                                      builder:
                                                          (alertDialogContext) {
                                                        return AlertDialog(
                                                          title: const Text(
                                                              'Are you sure?'),
                                                          content: const Text(
                                                              'You are submitting a new expense.'),
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
                                              // Create transaction expense

                                              var transactionsRecordReference2 =
                                                  TransactionsRecord.collection
                                                      .doc();
                                              await transactionsRecordReference2
                                                  .set({
                                                ...createTransactionsRecordData(
                                                  staff: currentUserReference,
                                                  total: double.tryParse(_model
                                                      .amountTextController
                                                      .text),
                                                  type: 'expense',
                                                  hotel: FFAppState().hotel,
                                                  description: functions
                                                      .resetFont(functions
                                                          .startBigLetter(_model
                                                              .descriptionTextController
                                                              .text)),
                                                  remitted: widget.additional
                                                      ? true
                                                      : false,
                                                  pending: false,
                                                ),
                                                ...mapToFirestore(
                                                  {
                                                    'date': FieldValue
                                                        .serverTimestamp(),
                                                  },
                                                ),
                                              });
                                              _model.newExpCopy =
                                                  TransactionsRecord
                                                      .getDocumentFromData({
                                                ...createTransactionsRecordData(
                                                  staff: currentUserReference,
                                                  total: double.tryParse(_model
                                                      .amountTextController
                                                      .text),
                                                  type: 'expense',
                                                  hotel: FFAppState().hotel,
                                                  description: functions
                                                      .resetFont(functions
                                                          .startBigLetter(_model
                                                              .descriptionTextController
                                                              .text)),
                                                  remitted: widget.additional
                                                      ? true
                                                      : false,
                                                  pending: false,
                                                ),
                                                ...mapToFirestore(
                                                  {
                                                    'date': DateTime.now(),
                                                  },
                                                ),
                                              }, transactionsRecordReference2);
                                              shouldSetState = true;
                                              // Saved
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    'Expense saved!',
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
                                              // exp to expenseRef
                                              _model.expenseRef =
                                                  _model.newExpCopy?.reference;
                                              safeSetState(() {});
                                              if (functions.findTextsInString(
                                                  _model.choicesValue,
                                                  'Softdrinks')) {
                                                // also creating grocery
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      'Also creating grocery!',
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
                                                // create grocery

                                                await GroceriesRecord.collection
                                                    .doc()
                                                    .set({
                                                  ...createGroceriesRecordData(
                                                    hotel: FFAppState().hotel,
                                                    recordedBy:
                                                        currentUserReference,
                                                    amount: double.tryParse(
                                                        _model
                                                            .amountTextController
                                                            .text),
                                                    remark: _model
                                                        .descriptionTextController
                                                        .text,
                                                  ),
                                                  ...mapToFirestore(
                                                    {
                                                      'date': FieldValue
                                                          .serverTimestamp(),
                                                    },
                                                  ),
                                                });
                                                // increment stats grocery

                                                await FFAppState()
                                                    .statsReference!
                                                    .update({
                                                  ...mapToFirestore(
                                                    {
                                                      'groceryExpenses':
                                                          FieldValue.increment(
                                                              double.parse(_model
                                                                  .amountTextController
                                                                  .text)),
                                                    },
                                                  ),
                                                });
                                                // count grr
                                                _model.countGrrCopy =
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
                                                if (_model.countGrrCopy! > 0) {
                                                  // last grr
                                                  _model.lastGrrCopy =
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
                                                  shouldSetState = true;
                                                  // increment grocery

                                                  await _model
                                                      .lastGrrCopy!.reference
                                                      .update({
                                                    ...mapToFirestore(
                                                      {
                                                        'grocery': FieldValue
                                                            .increment(double
                                                                .parse(_model
                                                                    .amountTextController
                                                                    .text)),
                                                      },
                                                    ),
                                                  });
                                                }
                                              }
                                            } else {
                                              if (shouldSetState) {
                                                safeSetState(() {});
                                              }
                                              return;
                                            }
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'You have submitted another duplicate expense!',
                                                  style: TextStyle(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .info,
                                                  ),
                                                ),
                                                duration: const Duration(
                                                    milliseconds: 4000),
                                                backgroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .error,
                                              ),
                                            );
                                          }
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Kindly provide a description!',
                                                style: TextStyle(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .info,
                                                ),
                                              ),
                                              duration:
                                                  const Duration(milliseconds: 4000),
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .error,
                                            ),
                                          );
                                        }
                                      }
                                    }

                                    if (widget.additional) {
                                      // add expensRef to remittance

                                      await widget.remittanceRef!.update({
                                        ...mapToFirestore(
                                          {
                                            'expenses': FieldValue.increment(
                                                double.parse(_model
                                                    .amountTextController
                                                    .text)),
                                            'transactions':
                                                FieldValue.arrayUnion(
                                                    [_model.expenseRef]),
                                            'net': FieldValue.increment(
                                                -(double.parse(_model
                                                    .amountTextController
                                                    .text))),
                                          },
                                        ),
                                      });
                                      // update stats

                                      await FFAppState()
                                          .statsReference!
                                          .update({
                                        ...mapToFirestore(
                                          {
                                            'expenses': FieldValue.increment(
                                                double.parse(_model
                                                    .amountTextController
                                                    .text)),
                                          },
                                        ),
                                      });
                                    }
                                    // Reset choice chips
                                    safeSetState(() {
                                      _model.choicesValueController?.reset();
                                    });
                                    // Reset amount/description
                                    safeSetState(() {
                                      _model.amountTextController?.clear();
                                      _model.descriptionTextController?.text =
                                          widget.issue != null &&
                                                  widget.issue != ''
                                              ? widget.issue!
                                              : '';
                                    });
                                    // Reset selected staff
                                    safeSetState(() {
                                      _model.selectedNameValueController
                                          ?.reset();
                                    });
                                    if (shouldSetState) safeSetState(() {});
                                  },
                          ),
                        ),
                      if (widget.additional)
                        FlutterFlowIconButton(
                          borderRadius: 20.0,
                          borderWidth: 1.0,
                          buttonSize: 40.0,
                          icon: Icon(
                            Icons.keyboard_arrow_down_sharp,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 24.0,
                          ),
                          onPressed: () async {
                            context.safePop();
                          },
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Type a new expense',
                    style: FlutterFlowTheme.of(context).headlineMedium.override(
                          fontFamily: 'Outfit',
                          letterSpacing: 0.0,
                        ),
                  ).animateOnPageLoad(
                      animationsMap['textOnPageLoadAnimation']!),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                    child: Text(
                      'Fill out the form below to record a new expense.',
                      style: FlutterFlowTheme.of(context).labelLarge.override(
                            fontFamily: 'Readex Pro',
                            letterSpacing: 0.0,
                          ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      TextFormField(
                        controller: _model.amountTextController,
                        focusNode: _model.amountFocusNode,
                        onChanged: (_) => EasyDebounce.debounce(
                          '_model.amountTextController',
                          const Duration(milliseconds: 2000),
                          () async {
                            if (_model.amountTextController.text == '') {
                              // disable
                              _model.disableSubmit = true;
                              safeSetState(() {});
                            } else {
                              // enable
                              _model.disableSubmit = false;
                              safeSetState(() {});
                            }
                          },
                        ),
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
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w500,
                              ),
                          hintStyle:
                              FlutterFlowTheme.of(context).labelMedium.override(
                                    fontFamily: 'Readex Pro',
                                    letterSpacing: 0.0,
                                  ),
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
                          contentPadding: const EdgeInsetsDirectional.fromSTEB(
                              16.0, 12.0, 16.0, 12.0),
                        ),
                        style:
                            FlutterFlowTheme.of(context).headlineSmall.override(
                                  fontFamily: 'Outfit',
                                  letterSpacing: 0.0,
                                ),
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        cursorColor: FlutterFlowTheme.of(context).primary,
                        validator: _model.amountTextControllerValidator
                            .asValidator(context),
                      ).animateOnPageLoad(
                          animationsMap['textFieldOnPageLoadAnimation1']!),
                      TextFormField(
                        controller: _model.descriptionTextController,
                        focusNode: _model.descriptionFocusNode,
                        autofocus: false,
                        textCapitalization: TextCapitalization.words,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelStyle:
                              FlutterFlowTheme.of(context).labelMedium.override(
                                    fontFamily: 'Readex Pro',
                                    letterSpacing: 0.0,
                                  ),
                          hintText: 'Describe the expense',
                          hintStyle:
                              FlutterFlowTheme.of(context).labelMedium.override(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 24.0,
                                    letterSpacing: 0.0,
                                  ),
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
                          contentPadding: const EdgeInsetsDirectional.fromSTEB(
                              16.0, 24.0, 16.0, 12.0),
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Readex Pro',
                              fontSize: 24.0,
                              letterSpacing: 0.0,
                            ),
                        maxLines: 16,
                        minLines: 6,
                        cursorColor: FlutterFlowTheme.of(context).primary,
                        validator: _model.descriptionTextControllerValidator
                            .asValidator(context),
                      ).animateOnPageLoad(
                          animationsMap['textFieldOnPageLoadAnimation2']!),
                    ]
                        .divide(const SizedBox(height: 16.0))
                        .addToStart(const SizedBox(height: 12.0)),
                  ),
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 16.0),
                    child: StreamBuilder<List<OptionsRecord>>(
                      stream: queryOptionsRecord(
                        queryBuilder: (optionsRecord) => optionsRecord.where(
                          'type',
                          isEqualTo: 'expense',
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
                        List<OptionsRecord> containerOptionsRecordList =
                            snapshot.data!;

                        return Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(
                              color: FlutterFlowTheme.of(context).alternate,
                              width: 2.0,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                16.0, 15.0, 16.0, 15.0),
                            child: FlutterFlowChoiceChips(
                              options: containerOptionsRecordList
                                  .map((e) => e.choice)
                                  .toList()
                                  .map((label) => ChipData(label))
                                  .toList(),
                              onChanged: (val) async {
                                safeSetState(() =>
                                    _model.choicesValue = val?.firstOrNull);
                                if (_model.choicesValue == 'Food') {
                                  // Food Allowance
                                  safeSetState(() {
                                    _model.descriptionTextController?.text =
                                        'Food Allowance for Staff';
                                    _model.descriptionTextController
                                            ?.selection =
                                        TextSelection.collapsed(
                                            offset: _model
                                                .descriptionTextController!
                                                .text
                                                .length);
                                  });
                                  // 150 amount
                                  safeSetState(() {
                                    _model.amountTextController?.text = '150';
                                    _model.amountTextController?.selection =
                                        TextSelection.collapsed(
                                            offset: _model.amountTextController!
                                                .text.length);
                                  });
                                  // enable submit
                                  _model.disableSubmit = false;
                                  safeSetState(() {});
                                } else {
                                  // choice
                                  safeSetState(() {
                                    _model.descriptionTextController?.text =
                                        _model.choicesValue!;
                                    _model.descriptionTextController
                                            ?.selection =
                                        TextSelection.collapsed(
                                            offset: _model
                                                .descriptionTextController!
                                                .text
                                                .length);
                                  });
                                  if (_model.choicesValue == 'Pamasahe') {
                                    // 100 pamasahe
                                    safeSetState(() {
                                      _model.amountTextController?.text = '100';
                                      _model.amountTextController?.selection =
                                          TextSelection.collapsed(
                                              offset: _model
                                                  .amountTextController!
                                                  .text
                                                  .length);
                                    });
                                    // enable submit
                                    _model.disableSubmit = false;
                                    safeSetState(() {});
                                  } else {
                                    if (_model.choicesValue == 'Sako') {
                                      // 10 sako
                                      safeSetState(() {
                                        _model.amountTextController?.text =
                                            '10';
                                        _model.amountTextController?.selection =
                                            TextSelection.collapsed(
                                                offset: _model
                                                    .amountTextController!
                                                    .text
                                                    .length);
                                      });
                                      // enable submit
                                      _model.disableSubmit = false;
                                      safeSetState(() {});
                                    }
                                  }
                                }
                              },
                              selectedChipStyle: ChipStyle(
                                backgroundColor:
                                    FlutterFlowTheme.of(context).primary,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      letterSpacing: 0.0,
                                    ),
                                iconColor: Colors.white,
                                iconSize: 18.0,
                                labelPadding: const EdgeInsetsDirectional.fromSTEB(
                                    12.0, 4.0, 12.0, 4.0),
                                elevation: 2.0,
                              ),
                              unselectedChipStyle: ChipStyle(
                                backgroundColor:
                                    FlutterFlowTheme.of(context).alternate,
                                textStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      letterSpacing: 0.0,
                                    ),
                                iconColor:
                                    FlutterFlowTheme.of(context).primaryText,
                                iconSize: 18.0,
                                labelPadding: const EdgeInsetsDirectional.fromSTEB(
                                    12.0, 4.0, 12.0, 4.0),
                                elevation: 0.0,
                              ),
                              chipSpacing: 12.0,
                              rowSpacing: 10.0,
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
                            animationsMap['containerOnPageLoadAnimation']!);
                      },
                    ),
                  ),
                  if (functions.findTextsInString(
                      _model.choicesValue, 'Cash Advance,Absent'))
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                      child: StreamBuilder<List<StaffsRecord>>(
                        stream: _model.staffsCashAdvance(
                          requestFn: () => queryStaffsRecord(
                            queryBuilder: (staffsRecord) => staffsRecord
                                .where(
                                  'hotel',
                                  isEqualTo: FFAppState().hotel,
                                )
                                .where(
                                  'fired',
                                  isNotEqualTo: true,
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
                              safeSetState(
                                  () => _model.selectedNameValue = val);
                              _model.staffSelected =
                                  selectedNameStaffsRecordList
                                      .where((e) =>
                                          e.name == _model.selectedNameValue)
                                      .toList()
                                      .first
                                      .reference;
                              safeSetState(() {});
                            },
                            height: 60.0,
                            textStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  letterSpacing: 0.0,
                                ),
                            hintText: 'Select Name',
                            icon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 15.0,
                            ),
                            fillColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            elevation: 2.0,
                            borderColor: const Color(0xFFE0E3E7),
                            borderWidth: 2.0,
                            borderRadius: 8.0,
                            margin: const EdgeInsetsDirectional.fromSTEB(
                                12.0, 4.0, 12.0, 4.0),
                            hidesUnderline: true,
                            isSearchable: false,
                            isMultiSelect: false,
                          ).animateOnPageLoad(
                              animationsMap['dropDownOnPageLoadAnimation']!);
                        },
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
