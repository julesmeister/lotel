import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/forms/change_date/change_date_widget.dart';
import '/components/forms/new_salary/new_salary_widget.dart';
import '/components/options/salary_options/salary_options_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'new_edit_payroll_model.dart';
export 'new_edit_payroll_model.dart';

class NewEditPayrollWidget extends StatefulWidget {
  const NewEditPayrollWidget({
    super.key,
    this.ref,
  });

  final DocumentReference? ref;

  @override
  State<NewEditPayrollWidget> createState() => _NewEditPayrollWidgetState();
}

class _NewEditPayrollWidgetState extends State<NewEditPayrollWidget> {
  late NewEditPayrollModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NewEditPayrollModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      // Set edit boolean
      _model.edit = widget.ref?.id != null && widget.ref?.id != '';
      safeSetState(() {});
      if (_model.edit) {
        // set ref
        _model.ref = widget.ref;
        safeSetState(() {});
        // old payroll
        _model.existingPayroll =
            await PayrollsRecord.getDocumentOnce(widget.ref!);
        // existing salaries
        _model.existingSalaries = await querySalariesRecordOnce(
          parent: widget.ref,
        );
        // initialize payroll
        _model.date = _model.existingPayroll?.date;
        _model.fortnight = _model.existingPayroll!.fortnight;
        _model.settled = _model.existingPayroll?.status == 'settled';
        _model.salaries =
            _model.existingSalaries!.toList().cast<SalariesRecord>();
        safeSetState(() {});
      } else {
        // new payroll
        _model.date = functions.today();
        _model.fortnight = functions.generateFortnight(functions.today()!);
        _model.settled = false;
        safeSetState(() {});
      }

      _model.staffsOfThisHotel = await queryStaffsRecordOnce(
        queryBuilder: (staffsRecord) => staffsRecord.where(
          'hotel',
          isEqualTo: FFAppState().hotel,
        ),
      );
      _model.staffs = _model.staffsOfThisHotel!.toList().cast<StaffsRecord>();
      safeSetState(() {});
    });

    _model.newRateTextController ??= TextEditingController();
    _model.newRateFocusNode ??= FocusNode();

    _model.newSSSTextController ??= TextEditingController();
    _model.newSSSFocusNode ??= FocusNode();

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
          leading: FlutterFlowIconButton(
            borderColor: FlutterFlowTheme.of(context).info,
            borderRadius: 0.0,
            borderWidth: 1.0,
            buttonSize: 40.0,
            fillColor: FlutterFlowTheme.of(context).info,
            icon: Icon(
              Icons.chevron_left,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 24.0,
            ),
            onPressed: () async {
              context.safePop();
            },
          ),
          title: Text(
            _model.edit ? 'Edit Payroll' : 'New Payroll',
            style: FlutterFlowTheme.of(context).titleLarge.override(
                  fontFamily: 'Outfit',
                  letterSpacing: 0.0,
                ),
          ),
          actions: [
            Visibility(
              visible: (_model.existingPayroll?.status != 'settled') &&
                  (widget.ref != null),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 16.0, 8.0),
                child: FlutterFlowIconButton(
                  borderColor: FlutterFlowTheme.of(context).alternate,
                  borderRadius: 12.0,
                  borderWidth: 2.0,
                  buttonSize: 40.0,
                  fillColor: FlutterFlowTheme.of(context).info,
                  icon: Icon(
                    Icons.person_add_outlined,
                    color: FlutterFlowTheme.of(context).primaryText,
                    size: 24.0,
                  ),
                  onPressed: () async {
                    await showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (context) {
                        return GestureDetector(
                          onTap: () => FocusScope.of(context).unfocus(),
                          child: Padding(
                            padding: MediaQuery.viewInsetsOf(context),
                            child: SizedBox(
                              height: double.infinity,
                              child: NewSalaryWidget(
                                payrollRef: widget.ref!,
                                staffsForSelection: functions.staffsToAddSalary(
                                    _model.staffs.toList(),
                                    _model.salaries.toList()),
                              ),
                            ),
                          ),
                        );
                      },
                    ).then(
                        (value) => safeSetState(() => _model.salary = value));

                    // add salary to list
                    _model.addToSalaries(_model.salary!);
                    safeSetState(() {});

                    safeSetState(() {});
                  },
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
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Total',
                              style: FlutterFlowTheme.of(context)
                                  .labelLarge
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    letterSpacing: 0.0,
                                  ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 4.0, 0.0, 0.0),
                              child: AutoSizeText(
                                formatNumber(
                                  functions
                                      .sumOfSalaries(_model.salaries.toList()),
                                  formatType: FormatType.decimal,
                                  decimalType: DecimalType.automatic,
                                  currency: 'P ',
                                ),
                                maxLines: 1,
                                minFontSize: 22.0,
                                style: FlutterFlowTheme.of(context)
                                    .headlineMedium
                                    .override(
                                      fontFamily: 'Outfit',
                                      letterSpacing: 0.0,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            InkWell(
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
                                      onTap: () =>
                                          FocusScope.of(context).unfocus(),
                                      child: Padding(
                                        padding:
                                            MediaQuery.viewInsetsOf(context),
                                        child: SizedBox(
                                          height: double.infinity,
                                          child: ChangeDateWidget(
                                            date: getCurrentTimestamp,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ).then((value) => safeSetState(
                                    () => _model.adjustedDate = value));

                                if (_model.adjustedDate != null) {
                                  if (_model.settled == true) {
                                    if (dateTimeFormat(
                                            "MMMM", _model.adjustedDate) !=
                                        dateTimeFormat("MMMM", _model.date)) {
                                      // prevStats
                                      _model.prevStats =
                                          await queryStatsRecordOnce(
                                        queryBuilder: (statsRecord) =>
                                            statsRecord
                                                .where(
                                                  'hotel',
                                                  isEqualTo: FFAppState().hotel,
                                                )
                                                .where(
                                                  'year',
                                                  isEqualTo: dateTimeFormat(
                                                      "y", _model.date),
                                                )
                                                .where(
                                                  'month',
                                                  isEqualTo: dateTimeFormat(
                                                      "MMMM", _model.date),
                                                ),
                                        singleRecord: true,
                                      ).then((s) => s.firstOrNull);
                                      // deduct from prev stats

                                      await _model.prevStats!.reference.update({
                                        ...mapToFirestore(
                                          {
                                            'salaries': FieldValue.increment(
                                                -(functions.sumOfSalaries(
                                                    _model.salaries.toList()))),
                                          },
                                        ),
                                      });
                                      // now stats
                                      _model.nowStats =
                                          await queryStatsRecordOnce(
                                        queryBuilder: (statsRecord) =>
                                            statsRecord
                                                .where(
                                                  'hotel',
                                                  isEqualTo: FFAppState().hotel,
                                                )
                                                .where(
                                                  'year',
                                                  isEqualTo: dateTimeFormat(
                                                      "y", _model.adjustedDate),
                                                )
                                                .where(
                                                  'month',
                                                  isEqualTo: dateTimeFormat(
                                                      "MMMM",
                                                      _model.adjustedDate),
                                                ),
                                        singleRecord: true,
                                      ).then((s) => s.firstOrNull);
                                      // increment to now stats

                                      await _model.nowStats!.reference.update({
                                        ...mapToFirestore(
                                          {
                                            'salaries': FieldValue.increment(
                                                functions.sumOfSalaries(
                                                    _model.salaries.toList())),
                                          },
                                        ),
                                      });
                                    }
                                  }
                                  // update date

                                  await _model.ref!
                                      .update(createPayrollsRecordData(
                                    date: _model.adjustedDate,
                                  ));
                                  // update date
                                  _model.date = _model.adjustedDate;
                                  safeSetState(() {});
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Date has been adjusted!',
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
                                }

                                safeSetState(() {});
                              },
                              child: AutoSizeText(
                                dateTimeFormat("EEE M d y h:mm a", _model.date),
                                maxLines: 1,
                                minFontSize: 12.0,
                                style: FlutterFlowTheme.of(context)
                                    .labelLarge
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      letterSpacing: 0.0,
                                    ),
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                if (_model.existingPayroll?.status != 'settled')
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        0.0, 5.0, 1.0, 0.0),
                                    child: FFButtonWidget(
                                      onPressed: () async {
                                        _model.showChangeRate =
                                            !_model.showChangeRate;
                                        safeSetState(() {});
                                      },
                                      text: 'Change Rate',
                                      options: FFButtonOptions(
                                        height: 30.0,
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            24.0, 0.0, 24.0, 0.0),
                                        iconPadding:
                                            const EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 0.0),
                                        color:
                                            FlutterFlowTheme.of(context).info,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              fontFamily: 'Readex Pro',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              fontSize: 10.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.normal,
                                            ),
                                        elevation: 0.0,
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (_model.showChangeRate)
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 8.0, 0.0),
                            child: TextFormField(
                              controller: _model.newRateTextController,
                              focusNode: _model.newRateFocusNode,
                              autofocus: true,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'New Rate',
                                labelStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      letterSpacing: 0.0,
                                    ),
                                hintStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      letterSpacing: 0.0,
                                    ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
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
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    letterSpacing: 0.0,
                                  ),
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      signed: true, decimal: true),
                              validator: _model.newRateTextControllerValidator
                                  .asValidator(context),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 8.0, 0.0),
                            child: TextFormField(
                              controller: _model.newSSSTextController,
                              focusNode: _model.newSSSFocusNode,
                              autofocus: true,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'New SSS Rate',
                                labelStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      letterSpacing: 0.0,
                                    ),
                                hintStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      letterSpacing: 0.0,
                                    ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
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
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    letterSpacing: 0.0,
                                  ),
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      signed: true, decimal: true),
                              validator: _model.newSSSTextControllerValidator
                                  .asValidator(context),
                            ),
                          ),
                        ),
                        FlutterFlowIconButton(
                          borderRadius: 20.0,
                          borderWidth: 1.0,
                          buttonSize: 40.0,
                          icon: Icon(
                            Icons.published_with_changes,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 24.0,
                          ),
                          onPressed: () async {
                            var confirmDialogResponse = await showDialog<bool>(
                                  context: context,
                                  builder: (alertDialogContext) {
                                    return AlertDialog(
                                      title: const Text('Are you sure?'),
                                      content: const Text(
                                          'This will change the fortnight rate of all employees. '),
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
                              // reset loop counter
                              _model.loopSalariesCounter = 0;
                              safeSetState(() {});
                              while (_model.loopSalariesCounter !=
                                  _model.salaries.length) {
                                if (_model.newRateTextController.text != '') {
                                  // update rate every staff

                                  await _model
                                      .salaries[_model.loopSalariesCounter]
                                      .reference
                                      .update(createSalariesRecordData(
                                    rate: double.tryParse(
                                        _model.newRateTextController.text),
                                  ));
                                }
                                if (_model.newSSSTextController.text != '') {
                                  if (_model
                                          .salaries[_model.loopSalariesCounter]
                                          .sss !=
                                      0.0) {
                                    // update rate every staff

                                    await _model
                                        .salaries[_model.loopSalariesCounter]
                                        .reference
                                        .update(createSalariesRecordData(
                                      sss: double.tryParse(
                                          _model.newSSSTextController.text),
                                    ));
                                  }
                                }
                                // update total

                                await _model
                                    .salaries[_model.loopSalariesCounter]
                                    .reference
                                    .update(createSalariesRecordData(
                                  total: functions.updateSalaryTotal(
                                      _model.newRateTextController.text !=
                                              '',
                                      _model.newSSSTextController.text !=
                                              '',
                                      _model
                                          .salaries[_model.loopSalariesCounter]
                                          .rate,
                                      double.tryParse(
                                          _model.newRateTextController.text),
                                      _model
                                          .salaries[_model.loopSalariesCounter]
                                          .sss,
                                      double.tryParse(
                                          _model.newSSSTextController.text),
                                      _model
                                          .salaries[_model.loopSalariesCounter]
                                          .cashAdvance,
                                      _model
                                          .salaries[_model.loopSalariesCounter]
                                          .absences),
                                ));
                                // increment loop
                                _model.loopSalariesCounter =
                                    _model.loopSalariesCounter + 1;
                                safeSetState(() {});
                              }
                              // updated salaries
                              _model.updatedSalaries =
                                  await querySalariesRecordOnce(
                                parent: widget.ref,
                              );
                              // initialize payroll
                              _model.salaries = _model.updatedSalaries!
                                  .toList()
                                  .cast<SalariesRecord>();
                              _model.showChangeRate = false;
                              safeSetState(() {});
                            }
                            // reset form fields
                            safeSetState(() {
                              _model.newRateTextController?.clear();
                              _model.newSSSTextController?.clear();
                            });

                            safeSetState(() {});
                          },
                        ),
                      ],
                    ),
                  if (valueOrDefault(currentUserDocument?.role, '') == 'admin')
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                      child: AuthUserStreamWidget(
                        builder: (context) => Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Fortnight',
                              style: FlutterFlowTheme.of(context)
                                  .headlineMedium
                                  .override(
                                    fontFamily: 'Outfit',
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                FlutterFlowIconButton(
                                  borderColor:
                                      FlutterFlowTheme.of(context).info,
                                  borderRadius: 20.0,
                                  borderWidth: 1.0,
                                  buttonSize: 30.0,
                                  fillColor: FlutterFlowTheme.of(context).info,
                                  icon: FaIcon(
                                    FontAwesomeIcons.angleDown,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 16.0,
                                  ),
                                  onPressed: () async {
                                    _model.fortnight =
                                        functions.downOrdinal(_model.fortnight);
                                    safeSetState(() {});
                                    // update fortnight

                                    await widget.ref!
                                        .update(createPayrollsRecordData(
                                      fortnight: _model.fortnight,
                                    ));
                                  },
                                ),
                                Text(
                                  _model.fortnight,
                                  style: FlutterFlowTheme.of(context)
                                      .headlineMedium
                                      .override(
                                        fontFamily: 'Outfit',
                                        fontSize: 16.0,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    FlutterFlowIconButton(
                                      borderColor:
                                          FlutterFlowTheme.of(context).info,
                                      borderRadius: 20.0,
                                      borderWidth: 1.0,
                                      buttonSize: 30.0,
                                      fillColor:
                                          FlutterFlowTheme.of(context).info,
                                      icon: FaIcon(
                                        FontAwesomeIcons.angleUp,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        size: 16.0,
                                      ),
                                      onPressed: () async {
                                        _model.fortnight = functions
                                            .upOrdinal(_model.fortnight);
                                        safeSetState(() {});
                                        // update fortnight

                                        await widget.ref!
                                            .update(createPayrollsRecordData(
                                          fortnight: _model.fortnight,
                                        ));
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  if ((_model.existingPayroll?.status != 'settled') &&
                      (valueOrDefault(currentUserDocument?.role, '') ==
                          'admin'))
                    Align(
                      alignment: const AlignmentDirectional(0.0, -1.0),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                        child: AuthUserStreamWidget(
                          builder: (context) => Container(
                            width: double.infinity,
                            height: 50.0,
                            constraints: const BoxConstraints(
                              maxWidth: 500.0,
                            ),
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              borderRadius: BorderRadius.circular(12.0),
                              border: Border.all(
                                color: FlutterFlowTheme.of(context).alternate,
                                width: 1.0,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        _model.settled = true;
                                        safeSetState(() {});
                                      },
                                      child: Container(
                                        width: 115.0,
                                        height: 100.0,
                                        decoration: BoxDecoration(
                                          color: _model.settled
                                              ? FlutterFlowTheme.of(context)
                                                  .secondaryBackground
                                              : FlutterFlowTheme.of(context)
                                                  .primaryBackground,
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          border: Border.all(
                                            color: valueOrDefault<Color>(
                                              _model.settled
                                                  ? FlutterFlowTheme.of(context)
                                                      .alternate
                                                  : FlutterFlowTheme.of(context)
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
                                              Icons.receipt_long_sharp,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              size: 16.0,
                                            ),
                                            Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(4.0, 0.0, 0.0, 0.0),
                                              child: Text(
                                                'Settled',
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Readex Pro',
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      letterSpacing: 0.0,
                                                    ),
                                              ),
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
                                        _model.settled = false;
                                        safeSetState(() {});
                                      },
                                      child: Container(
                                        width: 115.0,
                                        height: 100.0,
                                        decoration: BoxDecoration(
                                          color: !_model.settled
                                              ? FlutterFlowTheme.of(context)
                                                  .secondaryBackground
                                              : FlutterFlowTheme.of(context)
                                                  .primaryBackground,
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          border: Border.all(
                                            color: !_model.settled
                                                ? FlutterFlowTheme.of(context)
                                                    .alternate
                                                : FlutterFlowTheme.of(context)
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
                                              Icons.av_timer,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              size: 16.0,
                                            ),
                                            Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(4.0, 0.0, 0.0, 0.0),
                                              child: Text(
                                                'Pending',
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Readex Pro',
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      letterSpacing: 0.0,
                                                    ),
                                              ),
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
                    ),
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
                    child: Builder(
                      builder: (context) {
                        final salariesList =
                            _model.salaries.map((e) => e).toList();

                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          primary: false,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: salariesList.length,
                          itemBuilder: (context, salariesListIndex) {
                            final salariesListItem =
                                salariesList[salariesListIndex];
                            return Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 5.0, 10.0),
                              child: StreamBuilder<StaffsRecord>(
                                stream: StaffsRecord.getDocument(
                                    salariesListItem.staff!),
                                builder: (context, snapshot) {
                                  // Customize what your widget looks like when it's loading.
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: SizedBox(
                                        width: 50.0,
                                        height: 50.0,
                                        child: CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                            FlutterFlowTheme.of(context)
                                                .primary,
                                          ),
                                        ),
                                      ),
                                    );
                                  }

                                  final listContainerStaffsRecord =
                                      snapshot.data!;

                                  return InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      // edit the salary
                                      await showModalBottomSheet(
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                        context: context,
                                        builder: (context) {
                                          return GestureDetector(
                                            onTap: () => FocusScope.of(context)
                                                .unfocus(),
                                            child: Padding(
                                              padding: MediaQuery.viewInsetsOf(
                                                  context),
                                              child: SizedBox(
                                                height: double.infinity,
                                                child: NewSalaryWidget(
                                                  edit: true,
                                                  staffDoc:
                                                      listContainerStaffsRecord,
                                                  salaryDoc: salariesListItem,
                                                  payrollRef: widget.ref!,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ).then((value) => safeSetState(
                                          () => _model.updatedSalary = value));

                                      if (_model.updatedSalary?.reference !=
                                          null) {
                                        // update the salary in list
                                        _model.updateSalariesAtIndex(
                                          salariesListIndex,
                                          (_) => _model.updatedSalary!,
                                        );
                                        safeSetState(() {});
                                      }

                                      safeSetState(() {});
                                    },
                                    onLongPress: () async {
                                      await showModalBottomSheet(
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                        context: context,
                                        builder: (context) {
                                          return GestureDetector(
                                            onTap: () => FocusScope.of(context)
                                                .unfocus(),
                                            child: Padding(
                                              padding: MediaQuery.viewInsetsOf(
                                                  context),
                                              child: SizedBox(
                                                height: 125.0,
                                                child: SalaryOptionsWidget(
                                                  salary: salariesListItem
                                                      .reference,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ).then((value) => safeSetState(() {}));
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      constraints: const BoxConstraints(
                                        maxWidth: 570.0,
                                      ),
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        boxShadow: [
                                          BoxShadow(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            offset: const Offset(
                                              3.0,
                                              3.0,
                                            ),
                                          )
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        border: Border.all(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          width: 2.0,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Expanded(
                                                  flex: 3,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                12.0, 0.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Staff',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .labelMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Readex Pro',
                                                                letterSpacing:
                                                                    0.0,
                                                              ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      10.0),
                                                          child: Text(
                                                            listContainerStaffsRecord
                                                                .name,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .labelMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Readex Pro',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  fontSize:
                                                                      16.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  'Breakdown',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 5.0, 0.0, 0.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Rate',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Readex Pro',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          letterSpacing: 0.0,
                                                        ),
                                                  ),
                                                  Text(
                                                    formatNumber(
                                                      salariesListItem.rate,
                                                      formatType:
                                                          FormatType.decimal,
                                                      decimalType:
                                                          DecimalType.automatic,
                                                      currency: 'P ',
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Readex Pro',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          letterSpacing: 0.0,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 5.0, 0.0, 0.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'SSS',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Readex Pro',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          letterSpacing: 0.0,
                                                        ),
                                                  ),
                                                  Text(
                                                    formatNumber(
                                                      salariesListItem.sss,
                                                      formatType:
                                                          FormatType.decimal,
                                                      decimalType:
                                                          DecimalType.automatic,
                                                      currency: 'P ',
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Readex Pro',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          letterSpacing: 0.0,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 5.0, 0.0, 0.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Cash Advance',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Readex Pro',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          letterSpacing: 0.0,
                                                        ),
                                                  ),
                                                  Text(
                                                    formatNumber(
                                                      salariesListItem
                                                          .cashAdvance,
                                                      formatType:
                                                          FormatType.decimal,
                                                      decimalType:
                                                          DecimalType.automatic,
                                                      currency: 'P ',
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Readex Pro',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          letterSpacing: 0.0,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 5.0, 0.0, 5.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Absences',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Readex Pro',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          letterSpacing: 0.0,
                                                        ),
                                                  ),
                                                  Text(
                                                    formatNumber(
                                                      salariesListItem.absences,
                                                      formatType:
                                                          FormatType.decimal,
                                                      decimalType:
                                                          DecimalType.automatic,
                                                      currency: 'P ',
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Readex Pro',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          letterSpacing: 0.0,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Divider(
                                              thickness: 1.0,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                            ),
                                            Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 5.0, 0.0, 5.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Total',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Readex Pro',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          fontSize: 16.0,
                                                          letterSpacing: 0.0,
                                                        ),
                                                  ),
                                                  Text(
                                                    formatNumber(
                                                      salariesListItem.total,
                                                      formatType:
                                                          FormatType.decimal,
                                                      decimalType:
                                                          DecimalType.automatic,
                                                      currency: 'P ',
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Readex Pro',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          fontSize: 16.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  if (valueOrDefault(currentUserDocument?.role, '') == 'admin')
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                      child: AuthUserStreamWidget(
                        builder: (context) => Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 12.0),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    // Sure delete?
                                    var confirmDialogResponse =
                                        await showDialog<bool>(
                                              context: context,
                                              builder: (alertDialogContext) {
                                                return AlertDialog(
                                                  title: const Text(
                                                      'Delete This Payroll'),
                                                  content:
                                                      const Text('Are you certain?'),
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
                                                      child: const Text('Confirm'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            ) ??
                                            false;
                                    if (confirmDialogResponse) {
                                      // reset salary loop counter
                                      _model.loopSalariesCounter = 0;
                                      safeSetState(() {});
                                      while (_model.loopSalariesCounter !=
                                          _model.salaries.length) {
                                        // reset ca counter loop
                                        _model.loopCACounterUnsettle = 0;
                                        _model.loopAbsencesCounter = 0;
                                        safeSetState(() {});
                                        while (_model.loopCACounterUnsettle !=
                                            _model
                                                .salaries[
                                                    _model.loopSalariesCounter]
                                                .caRefs
                                                .length) {
                                          // unsettle cas again

                                          await _model
                                              .salaries[
                                                  _model.loopSalariesCounter]
                                              .caRefs[
                                                  _model.loopCACounterUnsettle]
                                              .update(createAdvancesRecordData(
                                            settled: false,
                                          ));
                                          // increment loop ca counter
                                          _model.loopCACounterUnsettle =
                                              _model.loopCACounterUnsettle + 1;
                                          safeSetState(() {});
                                        }
                                        while (_model.loopAbsencesCounter !=
                                            _model
                                                .salaries[
                                                    _model.loopSalariesCounter]
                                                .absencesRefs
                                                .length) {
                                          // unsettle absences  again

                                          await _model
                                              .salaries[
                                                  _model.loopSalariesCounter]
                                              .absencesRefs[
                                                  _model.loopAbsencesCounter]
                                              .update(createAbsencesRecordData(
                                            settled: false,
                                          ));
                                          // increment loop absence  counter
                                          _model.loopAbsencesCounter =
                                              _model.loopAbsencesCounter + 1;
                                          safeSetState(() {});
                                        }
                                        // delete each salary
                                        await _model
                                            .salaries[
                                                _model.loopSalariesCounter]
                                            .reference
                                            .delete();
                                        // increment loop salaries
                                        _model.loopSalariesCounter =
                                            _model.loopSalariesCounter + 1;
                                        safeSetState(() {});
                                      }
                                      // deduct from stats

                                      await FFAppState()
                                          .statsReference!
                                          .update({
                                        ...mapToFirestore(
                                          {
                                            'salaries': FieldValue.increment(
                                                -(_model
                                                    .existingPayroll!.total)),
                                          },
                                        ),
                                      });
                                      // delete payroll
                                      await widget.ref!.delete();
                                      // Payroll deleted
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Payroll deleted!',
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
                                      context.safePop();
                                    } else {
                                      return;
                                    }
                                  },
                                  text: 'Delete',
                                  icon: const Icon(
                                    Icons.delete_sweep_outlined,
                                    size: 15.0,
                                  ),
                                  options: FFButtonOptions(
                                    height: 48.0,
                                    padding: const EdgeInsets.all(0.0),
                                    iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color: FlutterFlowTheme.of(context).error,
                                    textStyle: FlutterFlowTheme.of(context)
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
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  if ((_model.existingPayroll?.status == 'settled') &&
                      (valueOrDefault(currentUserDocument?.role, '') ==
                          'admin'))
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 12.0),
                      child: AuthUserStreamWidget(
                        builder: (context) => SizedBox(
                          width: double.infinity,
                          height: 54.0,
                          child: custom_widgets.PrintPayroll(
                            width: double.infinity,
                            height: 54.0,
                            hotel: FFAppState().hotel,
                            salaries: _model.salaries,
                            staffs: _model.staffs,
                            total: functions
                                .sumOfSalaries(_model.salaries.toList()),
                            fortnight: _model.fortnight,
                            date: _model.date!,
                          ),
                        ),
                      ),
                    ),
                  if ((_model.existingPayroll?.status != 'settled') &&
                      (valueOrDefault(currentUserDocument?.role, '') ==
                          'admin'))
                    Align(
                      alignment: const AlignmentDirectional(0.0, 1.0),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 12.0),
                        child: AuthUserStreamWidget(
                          builder: (context) => FFButtonWidget(
                            onPressed: () async {
                              if (_model.edit) {
                                // Save total, status, fortnight

                                await widget.ref!
                                    .update(createPayrollsRecordData(
                                  status:
                                      _model.settled ? 'settled' : 'pending',
                                  total: functions
                                      .sumOfSalaries(_model.salaries.toList()),
                                  fortnight: _model.fortnight,
                                ));
                                // appropriate stats
                                _model.appropriateStats =
                                    await queryStatsRecordOnce(
                                  queryBuilder: (statsRecord) => statsRecord
                                      .where(
                                        'hotel',
                                        isEqualTo: FFAppState().hotel,
                                      )
                                      .where(
                                        'year',
                                        isEqualTo:
                                            dateTimeFormat("y", _model.date),
                                      )
                                      .where(
                                        'month',
                                        isEqualTo:
                                            dateTimeFormat("MMMM", _model.date),
                                      ),
                                  singleRecord: true,
                                ).then((s) => s.firstOrNull);
                                // Update stats

                                await _model.appropriateStats!.reference
                                    .update({
                                  ...mapToFirestore(
                                    {
                                      'salaries': FieldValue.increment(
                                          _model.settled
                                              ? functions.sumOfSalaries(
                                                  _model.salaries.toList())
                                              : 0.0),
                                    },
                                  ),
                                });
                                if (_model.settled) {
                                  // update date payroll

                                  await widget.ref!.update({
                                    ...mapToFirestore(
                                      {
                                        'date': FieldValue.serverTimestamp(),
                                      },
                                    ),
                                  });
                                  // reset loop
                                  _model.loopSalariesCounter = 0;
                                  _model.loopAbsencesCounter = 0;
                                  _model.loopAdvancesCounter = 0;
                                  safeSetState(() {});
                                  while (_model.loopSalariesCounter !=
                                      _model.salaries.length) {
                                    // staff
                                    _model.staff =
                                        await StaffsRecord.getDocumentOnce(
                                            _model
                                                .salaries[
                                                    _model.loopSalariesCounter]
                                                .staff!);
                                    // CAs of staff
                                    _model.unsettledCashAdvance =
                                        await queryAdvancesRecordOnce(
                                      parent: _model.staff?.reference,
                                      queryBuilder: (advancesRecord) =>
                                          advancesRecord
                                              .where(
                                                'settled',
                                                isNotEqualTo: true,
                                              )
                                              .orderBy('settled')
                                              .orderBy('date'),
                                    );
                                    // reset ca loop counter
                                    _model.loopAdvancesCounter = 0;
                                    _model.loopAbsencesCounter = 0;
                                    safeSetState(() {});
                                    while (_model.loopAdvancesCounter !=
                                        _model.unsettledCashAdvance?.length) {
                                      // settle the ca

                                      await _model
                                          .unsettledCashAdvance![
                                              _model.loopAdvancesCounter]
                                          .reference
                                          .update(createAdvancesRecordData(
                                        settled: true,
                                      ));
                                      // increment advances counter
                                      _model.loopAdvancesCounter =
                                          _model.loopAdvancesCounter + 1;
                                      safeSetState(() {});
                                    }
                                    // list of absences
                                    _model.absences =
                                        await queryAbsencesRecordOnce(
                                      parent: _model.staff?.reference,
                                    );
                                    // absences to local
                                    _model.absencesToSettle = _model.absences!
                                        .where((e) => !e.settled)
                                        .toList()
                                        .cast<AbsencesRecord>();
                                    safeSetState(() {});
                                    while (_model.loopAbsencesCounter !=
                                        _model.absencesToSettle.length) {
                                      // settle the absence

                                      await _model
                                          .absencesToSettle[
                                              _model.loopAbsencesCounter]
                                          .reference
                                          .update(createAbsencesRecordData(
                                        settled: true,
                                      ));
                                      // increment loop
                                      _model.loopAbsencesCounter =
                                          _model.loopAbsencesCounter + 1;
                                      safeSetState(() {});
                                    }
                                    // increment loopSalaries
                                    _model.loopSalariesCounter =
                                        _model.loopSalariesCounter + 1;
                                    safeSetState(() {});
                                  }
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'All balances are now settled!',
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
                                  context.safePop();
                                }
                              } else {
                                // new payroll

                                var payrollsRecordReference =
                                    PayrollsRecord.collection.doc();
                                await payrollsRecordReference.set({
                                  ...createPayrollsRecordData(
                                    hotel: FFAppState().hotel,
                                    status:
                                        _model.settled ? 'settled' : 'pending',
                                    fortnight: _model.fortnight,
                                  ),
                                  ...mapToFirestore(
                                    {
                                      'date': FieldValue.serverTimestamp(),
                                    },
                                  ),
                                });
                                _model.newPayroll =
                                    PayrollsRecord.getDocumentFromData({
                                  ...createPayrollsRecordData(
                                    hotel: FFAppState().hotel,
                                    status:
                                        _model.settled ? 'settled' : 'pending',
                                    fortnight: _model.fortnight,
                                  ),
                                  ...mapToFirestore(
                                    {
                                      'date': DateTime.now(),
                                    },
                                  ),
                                }, payrollsRecordReference);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Payroll successfully created!',
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
                                // go to editing this payroll
                                if (Navigator.of(context).canPop()) {
                                  context.pop();
                                }
                                context.pushNamed(
                                  'NewEditPayroll',
                                  queryParameters: {
                                    'ref': serializeParam(
                                      _model.newPayroll?.reference,
                                      ParamType.DocumentReference,
                                    ),
                                  }.withoutNulls,
                                );
                              }

                              safeSetState(() {});
                            },
                            text: _model.edit ? 'Save' : 'Create',
                            icon: const Icon(
                              Icons.save,
                              size: 15.0,
                            ),
                            options: FFButtonOptions(
                              width: MediaQuery.sizeOf(context).width * 1.0,
                              height: 50.0,
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              iconPadding: const EdgeInsets.all(0.0),
                              color: FlutterFlowTheme.of(context).primary,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                              elevation: 2.0,
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  if ((_model.existingPayroll?.status == 'settled') &&
                      (valueOrDefault(currentUserDocument?.role, '') ==
                          'admin'))
                    Align(
                      alignment: const AlignmentDirectional(0.0, 1.0),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 12.0),
                        child: AuthUserStreamWidget(
                          builder: (context) => FFButtonWidget(
                            onPressed: () async {
                              var confirmDialogResponse =
                                  await showDialog<bool>(
                                        context: context,
                                        builder: (alertDialogContext) {
                                          return AlertDialog(
                                            title: const Text('Settle'),
                                            content: const Text(
                                                'All the cash advances will be reset back to zero and marked settled.'),
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
                                // count settled
                                _model.countUnsettled =
                                    await queryAdvancesRecordCount(
                                  queryBuilder: (advancesRecord) =>
                                      advancesRecord.where(
                                    'settled',
                                    isEqualTo: false,
                                  ),
                                );
                                if (_model.countUnsettled! > 0) {
                                  // reset loop
                                  _model.loopSalariesCounter = 0;
                                  _model.loopAbsencesCounter = 0;
                                  _model.loopAdvancesCounter = 0;
                                  safeSetState(() {});
                                  while (_model.loopSalariesCounter !=
                                      _model.salaries.length) {
                                    // staff
                                    _model.staffClear =
                                        await StaffsRecord.getDocumentOnce(
                                            _model
                                                .salaries[
                                                    _model.loopSalariesCounter]
                                                .staff!);
                                    // CAs of staff
                                    _model.unsettledCashAdvanceClear =
                                        await queryAdvancesRecordOnce(
                                      parent: _model.staffClear?.reference,
                                      queryBuilder: (advancesRecord) =>
                                          advancesRecord
                                              .where(
                                                'settled',
                                                isNotEqualTo: true,
                                              )
                                              .orderBy('settled')
                                              .orderBy('date'),
                                    );
                                    // reset ca loop counter
                                    _model.loopAdvancesCounter = 0;
                                    _model.loopAbsencesCounter = 0;
                                    safeSetState(() {});
                                    while (_model.loopAdvancesCounter !=
                                        _model.unsettledCashAdvanceClear
                                            ?.length) {
                                      // settle the ca

                                      await _model
                                          .unsettledCashAdvanceClear![
                                              _model.loopAdvancesCounter]
                                          .reference
                                          .update(createAdvancesRecordData(
                                        settled: true,
                                      ));
                                      // increment advances counter
                                      _model.loopAdvancesCounter =
                                          _model.loopAdvancesCounter + 1;
                                      safeSetState(() {});
                                    }
                                    // list of absences
                                    _model.absencesClear =
                                        await queryAbsencesRecordOnce(
                                      parent: _model.staffClear?.reference,
                                    );
                                    // absences to local
                                    _model.absencesToSettle = _model
                                        .absencesClear!
                                        .where((e) => !e.settled)
                                        .toList()
                                        .cast<AbsencesRecord>();
                                    safeSetState(() {});
                                    while (_model.loopAbsencesCounter !=
                                        _model.absencesToSettle.length) {
                                      // settle the absence

                                      await _model
                                          .absencesToSettle[
                                              _model.loopAbsencesCounter]
                                          .reference
                                          .update(createAbsencesRecordData(
                                        settled: true,
                                      ));
                                      // increment loop
                                      _model.loopAbsencesCounter =
                                          _model.loopAbsencesCounter + 1;
                                      safeSetState(() {});
                                    }
                                    // increment loopSalaries
                                    _model.loopSalariesCounter =
                                        _model.loopSalariesCounter + 1;
                                    safeSetState(() {});
                                  }
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'All balances are now settled!',
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
                                  context.safePop();
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'There are no cash advances to settle!',
                                        style: TextStyle(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                        ),
                                      ),
                                      duration: const Duration(milliseconds: 4000),
                                      backgroundColor:
                                          FlutterFlowTheme.of(context).error,
                                    ),
                                  );
                                }
                              }

                              safeSetState(() {});
                            },
                            text: 'Clear Cash Advances',
                            icon: const Icon(
                              Icons.cleaning_services_outlined,
                              size: 15.0,
                            ),
                            options: FFButtonOptions(
                              width: MediaQuery.sizeOf(context).width * 1.0,
                              height: 50.0,
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              iconPadding: const EdgeInsets.all(0.0),
                              color: FlutterFlowTheme.of(context).primary,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                              elevation: 2.0,
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                ].addToEnd(const SizedBox(height: 20.0)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
