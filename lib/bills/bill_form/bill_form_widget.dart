import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/forms/change_date/change_date_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:collection/collection.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'bill_form_model.dart';
export 'bill_form_model.dart';

class BillFormWidget extends StatefulWidget {
  const BillFormWidget({
    super.key,
    bool? additional,
    this.remittanceRef,
    double? net,
  })  : additional = additional ?? false,
        net = net ?? 0.0;

  final bool additional;
  final DocumentReference? remittanceRef;
  final double net;

  @override
  State<BillFormWidget> createState() => _BillFormWidgetState();
}

class _BillFormWidgetState extends State<BillFormWidget>
    with TickerProviderStateMixin {
  late BillFormModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BillFormModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        _model.date = getCurrentTimestamp;
        _model.stats = FFAppState().statsReference;
      });
    });

    _model.amountTextController ??= TextEditingController();
    _model.amountFocusNode ??= FocusNode();

    _model.afterdueTextController ??= TextEditingController();
    _model.afterdueFocusNode ??= FocusNode();

    _model.descriptionTextController ??= TextEditingController();
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
      'textFieldOnPageLoadAnimation3': AnimationInfo(
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
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
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
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          automaticallyImplyLeading: false,
          leading: InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
              context.safePop();
            },
            child: Icon(
              Icons.chevron_left,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 24.0,
            ),
          ),
          title: Text(
            'Bill',
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Readex Pro',
                  fontSize: 26.0,
                  letterSpacing: 0.0,
                ),
          ),
          actions: [
            Visibility(
              visible:
                  valueOrDefault(currentUserDocument?.role, '') != 'generic',
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 15.0, 0.0),
                child: AuthUserStreamWidget(
                  builder: (context) => FlutterFlowIconButton(
                    borderRadius: 20.0,
                    borderWidth: 1.0,
                    disabledIconColor: FlutterFlowTheme.of(context).alternate,
                    icon: Icon(
                      Icons.check,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 24.0,
                    ),
                    onPressed: _model.disableSubmit
                        ? null
                        : () async {
                            if ((_model.amountTextController.text != '') &&
                                (_model.descriptionTextController.text !=
                                        '') &&
                                (functions.stringToDouble(
                                        _model.amountTextController.text) >
                                    0.0)) {
                              var confirmDialogResponse =
                                  await showDialog<bool>(
                                        context: context,
                                        builder: (alertDialogContext) {
                                          return AlertDialog(
                                            title: const Text('Are you sure?'),
                                            content: const Text(
                                                'This bill will be recorded for future reference.'),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    alertDialogContext, false),
                                                child: const Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    alertDialogContext, true),
                                                child: const Text('Confirm'),
                                              ),
                                            ],
                                          );
                                        },
                                      ) ??
                                      false;
                              if (confirmDialogResponse) {
                                // bill creation

                                await BillsRecord.collection
                                    .doc()
                                    .set(createBillsRecordData(
                                      description: functions.startBigLetter(
                                          _model
                                              .descriptionTextController.text),
                                      amount: double.tryParse(
                                          _model.amountTextController.text),
                                      date: _model.date,
                                      hotel: FFAppState().hotel,
                                      staff: currentUserReference,
                                      afterDue: valueOrDefault<double>(
                                        double.tryParse(
                                            _model.afterdueTextController.text),
                                        0.0,
                                      ),
                                    ));
                                if (!functions.isThisMonth(_model.date!)) {
                                  // which stats belong
                                  _model.statsBillBelong =
                                      await queryStatsRecordOnce(
                                    queryBuilder: (statsRecord) => statsRecord
                                        .where(
                                          'hotel',
                                          isEqualTo: FFAppState().hotel,
                                        )
                                        .where(
                                          'month',
                                          isEqualTo: dateTimeFormat(
                                              'MMMM', _model.date),
                                        )
                                        .where(
                                          'year',
                                          isEqualTo:
                                              dateTimeFormat('y', _model.date),
                                        ),
                                    singleRecord: true,
                                  ).then((s) => s.firstOrNull);
                                  // set stats ref
                                  setState(() {
                                    _model.stats =
                                        _model.statsBillBelong?.reference;
                                  });
                                }
                                // increment bills stats

                                await _model.stats!.update({
                                  ...mapToFirestore(
                                    {
                                      'bills': FieldValue.increment(
                                          double.parse(_model
                                              .amountTextController.text)),
                                    },
                                  ),
                                });
                                // bill recorded
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      '${_model.descriptionTextController.text} bill with an amount of ${_model.amountTextController.text} has been recorded!',
                                      style: TextStyle(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                      ),
                                    ),
                                    duration: const Duration(milliseconds: 4000),
                                    backgroundColor:
                                        FlutterFlowTheme.of(context).secondary,
                                  ),
                                );
                                // Reset choice chips
                                setState(() {
                                  _model.choicesValueController?.reset();
                                });
                                // Reset amount/description
                                setState(() {
                                  _model.amountTextController?.clear();
                                  _model.descriptionTextController?.clear();
                                });
                                // reset date
                                setState(() {
                                  _model.date = getCurrentTimestamp;
                                });
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'There are some missing fields and/or amount cannot be just zero!',
                                    style: TextStyle(
                                      color: FlutterFlowTheme.of(context).info,
                                    ),
                                  ),
                                  duration: const Duration(milliseconds: 4000),
                                  backgroundColor:
                                      FlutterFlowTheme.of(context).error,
                                ),
                              );
                            }

                            setState(() {});
                          },
                  ),
                ),
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
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        await showModalBottomSheet(
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          enableDrag: false,
                          useSafeArea: true,
                          context: context,
                          builder: (context) {
                            return GestureDetector(
                              onTap: () => _model.unfocusNode.canRequestFocus
                                  ? FocusScope.of(context)
                                      .requestFocus(_model.unfocusNode)
                                  : FocusScope.of(context).unfocus(),
                              child: Padding(
                                padding: MediaQuery.viewInsetsOf(context),
                                child: SizedBox(
                                  height: double.infinity,
                                  child: ChangeDateWidget(
                                    date: _model.date!,
                                  ),
                                ),
                              ),
                            );
                          },
                        ).then((value) =>
                            safeSetState(() => _model.adjustedDate = value));

                        if (_model.adjustedDate != null) {
                          setState(() {
                            _model.date = _model.adjustedDate;
                          });
                        }

                        setState(() {});
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(
                            Icons.calendar_month,
                            color: Color(0xFF04B9F9),
                            size: 35.0,
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 0.0, 0.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Select Date',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                                Text(
                                  dateTimeFormat('MMMM d, y', _model.date),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        fontSize: 18.0,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    'Type a new bill',
                    style: FlutterFlowTheme.of(context).headlineMedium.override(
                          fontFamily: 'Outfit',
                          letterSpacing: 0.0,
                        ),
                  ).animateOnPageLoad(
                      animationsMap['textOnPageLoadAnimation']!),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                    child: Text(
                      'Fill out the form below to record a bill. Leave after due blank if not applicable.',
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
                              setState(() {
                                _model.disableSubmit = true;
                              });
                            } else {
                              // enable
                              setState(() {
                                _model.disableSubmit = false;
                              });
                            }
                          },
                        ),
                        autofocus: false,
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
                        controller: _model.afterdueTextController,
                        focusNode: _model.afterdueFocusNode,
                        autofocus: false,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'After Due Amount?',
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
                        validator: _model.afterdueTextControllerValidator
                            .asValidator(context),
                      ).animateOnPageLoad(
                          animationsMap['textFieldOnPageLoadAnimation2']!),
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
                          hintText: 'Describe the bill',
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
                          animationsMap['textFieldOnPageLoadAnimation3']!),
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
                          isEqualTo: 'bill',
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
                                setState(() =>
                                    _model.choicesValue = val?.firstOrNull);
                                setState(() {
                                  _model.descriptionTextController?.text =
                                      _model.choicesValue!;
                                });
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
