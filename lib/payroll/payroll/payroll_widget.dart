import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/forms/staff_add_edit/staff_add_edit_widget.dart';
import '/components/options/option_to_payroll/option_to_payroll_widget.dart';
import '/components/options/option_to_staff/option_to_staff_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'payroll_model.dart';
export 'payroll_model.dart';

class PayrollWidget extends StatefulWidget {
  const PayrollWidget({super.key});

  @override
  State<PayrollWidget> createState() => _PayrollWidgetState();
}

class _PayrollWidgetState extends State<PayrollWidget>
    with TickerProviderStateMixin {
  late PayrollModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PayrollModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.year = functions.currentYear();
      safeSetState(() {});
    });

    animationsMap.addAll({
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
            begin: const Offset(0.0, 50.0),
            end: const Offset(0.0, 0.0),
          ),
        ],
      ),
      'columnOnPageLoadAnimation': AnimationInfo(
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
            begin: const Offset(40.0, 0.0),
            end: const Offset(0.0, 0.0),
          ),
        ],
      ),
      'iconButtonOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: const Offset(-100.0, 0.0),
            end: const Offset(0.0, 0.0),
          ),
        ],
      ),
      'iconButtonOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: const Offset(100.0, 0.0),
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

    return FutureBuilder<int>(
      future: queryPayrollsRecordCount(
        queryBuilder: (payrollsRecord) => payrollsRecord.where(
          'hotel',
          isEqualTo: FFAppState().hotel,
        ),
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          );
        }
        int payrollCount = snapshot.data!;

        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            appBar: AppBar(
              backgroundColor: FlutterFlowTheme.of(context).info,
              automaticallyImplyLeading: false,
              leading: FlutterFlowIconButton(
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
              title: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Payroll',
                    style: FlutterFlowTheme.of(context).headlineMedium.override(
                          fontFamily: 'Outfit',
                          color: FlutterFlowTheme.of(context).primaryText,
                          fontSize: 22.0,
                          letterSpacing: 0.0,
                        ),
                  ),
                  Text(
                    FFAppState().hotel,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Readex Pro',
                          letterSpacing: 0.0,
                        ),
                  ),
                ],
              ),
              actions: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    if (valueOrDefault(currentUserDocument?.role, '') ==
                        'admin')
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 16.0, 8.0),
                        child: AuthUserStreamWidget(
                          builder: (context) => FlutterFlowIconButton(
                            borderColor:
                                FlutterFlowTheme.of(context).primaryText,
                            borderRadius: 12.0,
                            borderWidth: 1.0,
                            buttonSize: 40.0,
                            fillColor: FlutterFlowTheme.of(context).info,
                            icon: Icon(
                              Icons.add,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 24.0,
                            ),
                            onPressed: () async {
                              // create payroll
                              var confirmDialogResponse =
                                  await showDialog<bool>(
                                        context: context,
                                        builder: (alertDialogContext) {
                                          return AlertDialog(
                                            title: const Text('Create Payroll'),
                                            content: const Text(
                                                'This action will replicate the latest payroll data, although you may need to make adjustments as required.'),
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
                                // count payrolls
                                _model.countPayrolls =
                                    await queryPayrollsRecordCount(
                                  queryBuilder: (payrollsRecord) =>
                                      payrollsRecord.where(
                                    'hotel',
                                    isEqualTo: FFAppState().hotel,
                                  ),
                                );
                                if (payrollCount > 0) {
                                  // isLoading
                                  _model.isLoading = true;
                                  safeSetState(() {});
                                  // get sample payroll
                                  _model.firstExistingPayroll =
                                      await queryPayrollsRecordOnce(
                                    queryBuilder: (payrollsRecord) =>
                                        payrollsRecord
                                            .where(
                                              'hotel',
                                              isEqualTo: FFAppState().hotel,
                                            )
                                            .orderBy('date', descending: true),
                                    singleRecord: true,
                                  ).then((s) => s.firstOrNull);
                                  // previous salaries
                                  _model.sampleSalaries =
                                      await querySalariesRecordOnce(
                                    parent:
                                        _model.firstExistingPayroll?.reference,
                                  );
                                  // reset loop counter
                                  _model.loopSalariesCounter = 0;
                                  _model.loopAdvancesCounter = 0;
                                  safeSetState(() {});
                                  // create new payroll

                                  var payrollsRecordReference =
                                      PayrollsRecord.collection.doc();
                                  await payrollsRecordReference.set({
                                    ...createPayrollsRecordData(
                                      status: 'pending',
                                      hotel: FFAppState().hotel,
                                      fortnight: functions.upOrdinal(_model
                                          .firstExistingPayroll!.fortnight),
                                      total: 0.0,
                                    ),
                                    ...mapToFirestore(
                                      {
                                        'date': FieldValue.serverTimestamp(),
                                      },
                                    ),
                                  });
                                  _model.newPayrollCreated =
                                      PayrollsRecord.getDocumentFromData({
                                    ...createPayrollsRecordData(
                                      status: 'pending',
                                      hotel: FFAppState().hotel,
                                      fortnight: functions.upOrdinal(_model
                                          .firstExistingPayroll!.fortnight),
                                      total: 0.0,
                                    ),
                                    ...mapToFirestore(
                                      {
                                        'date': DateTime.now(),
                                      },
                                    ),
                                  }, payrollsRecordReference);
                                  while (_model.loopSalariesCounter !=
                                      _model.sampleSalaries?.length) {
                                    // staff
                                    _model.staffToCheckFired =
                                        await StaffsRecord.getDocumentOnce(
                                            _model
                                                .sampleSalaries![
                                                    _model.loopSalariesCounter!]
                                                .staff!);
                                    if (_model.staffToCheckFired?.fired ==
                                        false) {
                                      // creating salaries

                                      var salariesRecordReference =
                                          SalariesRecord.createDoc(_model
                                              .newPayrollCreated!.reference);
                                      await salariesRecordReference.set({
                                        ...createSalariesRecordData(
                                          sss: _model
                                              .sampleSalaries?[
                                                  _model.loopSalariesCounter!]
                                              .sss,
                                          cashAdvance: 0.0,
                                          pendingCA: _model
                                              .sampleSalaries?[
                                                  _model.loopSalariesCounter!]
                                              .pendingCA,
                                          staff: _model
                                              .sampleSalaries?[
                                                  _model.loopSalariesCounter!]
                                              .staff,
                                          rate: _model
                                              .sampleSalaries?[
                                                  _model.loopSalariesCounter!]
                                              .rate,
                                        ),
                                        ...mapToFirestore(
                                          {
                                            'date':
                                                FieldValue.serverTimestamp(),
                                          },
                                        ),
                                      });
                                      _model.newSalary =
                                          SalariesRecord.getDocumentFromData({
                                        ...createSalariesRecordData(
                                          sss: _model
                                              .sampleSalaries?[
                                                  _model.loopSalariesCounter!]
                                              .sss,
                                          cashAdvance: 0.0,
                                          pendingCA: _model
                                              .sampleSalaries?[
                                                  _model.loopSalariesCounter!]
                                              .pendingCA,
                                          staff: _model
                                              .sampleSalaries?[
                                                  _model.loopSalariesCounter!]
                                              .staff,
                                          rate: _model
                                              .sampleSalaries?[
                                                  _model.loopSalariesCounter!]
                                              .rate,
                                        ),
                                        ...mapToFirestore(
                                          {
                                            'date': DateTime.now(),
                                          },
                                        ),
                                      }, salariesRecordReference);
                                      // Unsettled Cash Advances
                                      _model.unSettledCashAdvances =
                                          await queryAdvancesRecordOnce(
                                        parent: _model
                                            .sampleSalaries?[
                                                _model.loopSalariesCounter!]
                                            .staff,
                                        queryBuilder: (advancesRecord) =>
                                            advancesRecord
                                                .where(
                                                  'settled',
                                                  isNotEqualTo: true,
                                                )
                                                .orderBy('settled')
                                                .orderBy('date'),
                                      );
                                      // Unsettled absences
                                      _model.absencesRaw =
                                          await queryAbsencesRecordOnce(
                                        parent: _model
                                            .sampleSalaries?[
                                                _model.loopSalariesCounter!]
                                            .staff,
                                      );
                                      // save salary w/ cash advances

                                      await _model.newSalary!.reference.update({
                                        ...createSalariesRecordData(
                                          cashAdvance: valueOrDefault<double>(
                                            functions
                                                .calculateUnsettledCashAdvances(
                                                    _model
                                                        .unSettledCashAdvances!
                                                        .toList()),
                                            0.0,
                                          ),
                                          total: valueOrDefault<double>(
                                                _model
                                                    .sampleSalaries?[_model
                                                        .loopSalariesCounter!]
                                                    .rate,
                                                0.0,
                                              ) -
                                              _model
                                                  .sampleSalaries![_model
                                                      .loopSalariesCounter!]
                                                  .sss -
                                              valueOrDefault<double>(
                                                functions
                                                    .calculateUnsettledCashAdvances(
                                                        _model
                                                            .unSettledCashAdvances!
                                                            .toList()),
                                                0.0,
                                              ) -
                                              functions.calculateAbsencesTotal(
                                                  _model.absencesRaw!.toList()),
                                          absences:
                                              functions.calculateAbsencesTotal(
                                                  _model.absencesRaw!.toList()),
                                        ),
                                        ...mapToFirestore(
                                          {
                                            'caRefs': _model
                                                .unSettledCashAdvances
                                                ?.map((e) => e.reference)
                                                .toList(),
                                            'absencesRefs': _model.absencesRaw
                                                ?.where((e) => !e.settled)
                                                .toList()
                                                .map((e) => e.reference)
                                                .toList(),
                                          },
                                        ),
                                      });
                                    }
                                    // increment salaries counter
                                    _model.loopSalariesCounter =
                                        _model.loopSalariesCounter! + 1;
                                    safeSetState(() {});
                                  }
                                  // is not Loading
                                  _model.isLoading = false;
                                  safeSetState(() {});

                                  context.pushNamed(
                                    'NewEditPayroll',
                                    queryParameters: {
                                      'ref': serializeParam(
                                        _model.newPayrollCreated?.reference,
                                        ParamType.DocumentReference,
                                      ),
                                    }.withoutNulls,
                                  );
                                } else {
                                  context.pushNamed('NewEditPayroll');
                                }
                              }

                              safeSetState(() {});
                            },
                          ),
                        ),
                      ),
                  ],
                ),
              ],
              centerTitle: false,
              elevation: 0.0,
            ),
            body: SafeArea(
              top: true,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Align(
                      alignment: const AlignmentDirectional(0.0, -1.0),
                      child: Container(
                        width: double.infinity,
                        constraints: const BoxConstraints(
                          maxWidth: 1170.0,
                        ),
                        decoration: const BoxDecoration(),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 10.0, 0.0, 0.0),
                                child: Container(
                                  height: 120.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 16.0, 0.0),
                                          child: PagedListView<
                                              DocumentSnapshot<Object?>?,
                                              StaffsRecord>(
                                            pagingController:
                                                _model.setListViewController1(
                                              StaffsRecord.collection
                                                  .where(
                                                    'hotel',
                                                    isEqualTo:
                                                        FFAppState().hotel,
                                                  )
                                                  .where(
                                                    'fired',
                                                    isEqualTo: false,
                                                  ),
                                            ),
                                            padding: const EdgeInsets.fromLTRB(
                                              16.0,
                                              0,
                                              0,
                                              0,
                                            ),
                                            reverse: false,
                                            scrollDirection: Axis.horizontal,
                                            builderDelegate:
                                                PagedChildBuilderDelegate<
                                                    StaffsRecord>(
                                              // Customize what your widget looks like when it's loading the first page.
                                              firstPageProgressIndicatorBuilder:
                                                  (_) => Center(
                                                child: SizedBox(
                                                  width: 50.0,
                                                  height: 50.0,
                                                  child:
                                                      CircularProgressIndicator(
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                            Color>(
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primary,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              // Customize what your widget looks like when it's loading another page.
                                              newPageProgressIndicatorBuilder:
                                                  (_) => Center(
                                                child: SizedBox(
                                                  width: 50.0,
                                                  height: 50.0,
                                                  child:
                                                      CircularProgressIndicator(
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                            Color>(
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primary,
                                                    ),
                                                  ),
                                                ),
                                              ),

                                              itemBuilder:
                                                  (context, _, listViewIndex) {
                                                final listViewStaffsRecord = _model
                                                    .listViewPagingController1!
                                                    .itemList![listViewIndex];
                                                return Padding(
                                                  padding: const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 0.0, 10.0, 5.0),
                                                  child: FutureBuilder<
                                                      List<AdvancesRecord>>(
                                                    future:
                                                        queryAdvancesRecordOnce(
                                                      parent:
                                                          listViewStaffsRecord
                                                              .reference,
                                                      queryBuilder:
                                                          (advancesRecord) =>
                                                              advancesRecord
                                                                  .where(
                                                                    'settled',
                                                                    isEqualTo:
                                                                        false,
                                                                  )
                                                                  .orderBy(
                                                                      'date',
                                                                      descending:
                                                                          true),
                                                      limit: 5,
                                                    ),
                                                    builder:
                                                        (context, snapshot) {
                                                      // Customize what your widget looks like when it's loading.
                                                      if (!snapshot.hasData) {
                                                        return Center(
                                                          child: SizedBox(
                                                            width: 50.0,
                                                            height: 50.0,
                                                            child:
                                                                CircularProgressIndicator(
                                                              valueColor:
                                                                  AlwaysStoppedAnimation<
                                                                      Color>(
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                      List<AdvancesRecord>
                                                          staffsCAsAdvancesRecordList =
                                                          snapshot.data!;

                                                      return InkWell(
                                                        splashColor:
                                                            Colors.transparent,
                                                        focusColor:
                                                            Colors.transparent,
                                                        hoverColor:
                                                            Colors.transparent,
                                                        highlightColor:
                                                            Colors.transparent,
                                                        onTap: () async {
                                                          context.pushNamed(
                                                            'IndividualHistory',
                                                            queryParameters: {
                                                              'staff':
                                                                  serializeParam(
                                                                listViewStaffsRecord,
                                                                ParamType
                                                                    .Document,
                                                              ),
                                                            }.withoutNulls,
                                                            extra: <String,
                                                                dynamic>{
                                                              'staff':
                                                                  listViewStaffsRecord,
                                                            },
                                                          );
                                                        },
                                                        onLongPress: () async {
                                                          if (valueOrDefault(
                                                                  currentUserDocument
                                                                      ?.role,
                                                                  '') ==
                                                              'admin') {
                                                            await showModalBottomSheet(
                                                              isScrollControlled:
                                                                  true,
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent,
                                                              context: context,
                                                              builder:
                                                                  (context) {
                                                                return GestureDetector(
                                                                  onTap: () =>
                                                                      FocusScope.of(
                                                                              context)
                                                                          .unfocus(),
                                                                  child:
                                                                      Padding(
                                                                    padding: MediaQuery
                                                                        .viewInsetsOf(
                                                                            context),
                                                                    child:
                                                                        SizedBox(
                                                                      height:
                                                                          180.0,
                                                                      child:
                                                                          OptionToStaffWidget(
                                                                        staffRef:
                                                                            listViewStaffsRecord.reference,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            ).then((value) =>
                                                                safeSetState(
                                                                    () {}));
                                                          }
                                                        },
                                                        child: Container(
                                                          width: 160.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: valueOrDefault<
                                                                            String>(
                                                                          formatNumber(
                                                                            functions.totalOfCAs(staffsCAsAdvancesRecordList.where((e) => e.settled == false).toList()),
                                                                            formatType:
                                                                                FormatType.decimal,
                                                                            decimalType:
                                                                                DecimalType.automatic,
                                                                            currency:
                                                                                'P ',
                                                                          ),
                                                                          '0',
                                                                        ) ==
                                                                        'P 0'
                                                                    ? FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryText
                                                                    : FlutterFlowTheme.of(
                                                                            context)
                                                                        .primary,
                                                                offset: const Offset(
                                                                  3.0,
                                                                  3.0,
                                                                ),
                                                              )
                                                            ],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0),
                                                            border: Border.all(
                                                              color: valueOrDefault<
                                                                          String>(
                                                                        formatNumber(
                                                                          functions.totalOfCAs(staffsCAsAdvancesRecordList
                                                                              .where((e) => e.settled == false)
                                                                              .toList()),
                                                                          formatType:
                                                                              FormatType.decimal,
                                                                          decimalType:
                                                                              DecimalType.automatic,
                                                                          currency:
                                                                              'P ',
                                                                        ),
                                                                        '0',
                                                                      ) ==
                                                                      'P 0'
                                                                  ? FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText
                                                                  : FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary,
                                                              width: 2.0,
                                                            ),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets.all(
                                                                    10.0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Expanded(
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      AutoSizeText(
                                                                        listViewStaffsRecord
                                                                            .name
                                                                            .maybeHandleOverflow(
                                                                          maxChars:
                                                                              15,
                                                                        ),
                                                                        maxLines:
                                                                            1,
                                                                        minFontSize:
                                                                            10.0,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .headlineSmall
                                                                            .override(
                                                                              fontFamily: 'Outfit',
                                                                              color: valueOrDefault<Color>(
                                                                                valueOrDefault<String>(
                                                                                          formatNumber(
                                                                                            functions.totalOfCAs(staffsCAsAdvancesRecordList.where((e) => e.settled == false).toList()),
                                                                                            formatType: FormatType.decimal,
                                                                                            decimalType: DecimalType.automatic,
                                                                                            currency: 'P ',
                                                                                          ),
                                                                                          '0',
                                                                                        ) ==
                                                                                        'P 0'
                                                                                    ? FlutterFlowTheme.of(context).primaryText
                                                                                    : FlutterFlowTheme.of(context).primary,
                                                                                FlutterFlowTheme.of(context).primaryText,
                                                                              ),
                                                                              fontSize: 24.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.w500,
                                                                            ),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            4.0,
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            Text(
                                                                          'Unpaid CAs',
                                                                          maxLines:
                                                                              1,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .titleSmall
                                                                              .override(
                                                                                fontFamily: 'Plus Jakarta Sans',
                                                                                color: valueOrDefault<Color>(
                                                                                  valueOrDefault<String>(
                                                                                            formatNumber(
                                                                                              functions.totalOfCAs(staffsCAsAdvancesRecordList.where((e) => e.settled == false).toList()),
                                                                                              formatType: FormatType.decimal,
                                                                                              decimalType: DecimalType.automatic,
                                                                                              currency: 'P ',
                                                                                            ),
                                                                                            '0',
                                                                                          ) ==
                                                                                          'P 0'
                                                                                      ? FlutterFlowTheme.of(context).primaryText
                                                                                      : FlutterFlowTheme.of(context).primary,
                                                                                  FlutterFlowTheme.of(context).primaryText,
                                                                                ),
                                                                                fontSize: 12.0,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.w500,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            3.0,
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            Text(
                                                                          valueOrDefault<
                                                                              String>(
                                                                            formatNumber(
                                                                              functions.totalOfCAs(staffsCAsAdvancesRecordList.where((e) => e.settled == false).toList()),
                                                                              formatType: FormatType.decimal,
                                                                              decimalType: DecimalType.automatic,
                                                                              currency: 'P ',
                                                                            ),
                                                                            '0',
                                                                          ),
                                                                          maxLines:
                                                                              1,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .displaySmall
                                                                              .override(
                                                                                fontFamily: 'Outfit',
                                                                                color: valueOrDefault<Color>(
                                                                                  valueOrDefault<String>(
                                                                                            formatNumber(
                                                                                              functions.totalOfCAs(staffsCAsAdvancesRecordList.where((e) => e.settled == false).toList()),
                                                                                              formatType: FormatType.decimal,
                                                                                              decimalType: DecimalType.automatic,
                                                                                              currency: 'P ',
                                                                                            ),
                                                                                            '0',
                                                                                          ) ==
                                                                                          'P 0'
                                                                                      ? FlutterFlowTheme.of(context).primaryText
                                                                                      : FlutterFlowTheme.of(context).primary,
                                                                                  FlutterFlowTheme.of(context).primaryText,
                                                                                ),
                                                                                fontSize: 16.0,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.w600,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ).animateOnPageLoad(
                                                                      animationsMap[
                                                                          'columnOnPageLoadAnimation']!),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ).animateOnPageLoad(
                                                          animationsMap[
                                                              'containerOnPageLoadAnimation']!);
                                                    },
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      if (valueOrDefault(
                                              currentUserDocument?.role, '') ==
                                          'admin')
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 8.0, 10.0, 8.0),
                                          child: AuthUserStreamWidget(
                                            builder: (context) =>
                                                FlutterFlowIconButton(
                                              borderColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              borderRadius: 12.0,
                                              borderWidth: 1.0,
                                              buttonSize: 40.0,
                                              fillColor:
                                                  FlutterFlowTheme.of(context)
                                                      .info,
                                              icon: Icon(
                                                Icons.person_add_outlined,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                size: 24.0,
                                              ),
                                              onPressed: () async {
                                                await showModalBottomSheet(
                                                  isScrollControlled: true,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  context: context,
                                                  builder: (context) {
                                                    return GestureDetector(
                                                      onTap: () =>
                                                          FocusScope.of(context)
                                                              .unfocus(),
                                                      child: Padding(
                                                        padding: MediaQuery
                                                            .viewInsetsOf(
                                                                context),
                                                        child: const SizedBox(
                                                          height:
                                                              double.infinity,
                                                          child:
                                                              StaffAddEditWidget(),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ).then((value) =>
                                                    safeSetState(() {}));
                                              },
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16.0, 10.0, 16.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    FlutterFlowIconButton(
                                      borderRadius: 20.0,
                                      buttonSize: 60.0,
                                      icon: Icon(
                                        Icons.keyboard_arrow_left_outlined,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        size: 30.0,
                                      ),
                                      onPressed: () async {
                                        // set previous year
                                        _model.year = functions.previousYear(
                                            'January', _model.year);
                                        safeSetState(() {});
                                      },
                                    ).animateOnPageLoad(animationsMap[
                                        'iconButtonOnPageLoadAnimation1']!),
                                    Text(
                                      _model.year,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Readex Pro',
                                            fontSize: 24.0,
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                    FlutterFlowIconButton(
                                      borderColor: Colors.transparent,
                                      borderRadius: 20.0,
                                      buttonSize: 60.0,
                                      icon: Icon(
                                        Icons.keyboard_arrow_right_outlined,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        size: 30.0,
                                      ),
                                      onPressed: () async {
                                        // set next year
                                        _model.year = functions.nextYear(
                                            _model.year, 'December');
                                        safeSetState(() {});
                                      },
                                    ).animateOnPageLoad(animationsMap[
                                        'iconButtonOnPageLoadAnimation2']!),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16.0, 8.0, 16.0, 0.0),
                                child: Container(
                                  width: double.infinity,
                                  constraints: const BoxConstraints(
                                    maxWidth: double.infinity,
                                  ),
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    borderRadius: BorderRadius.circular(8.0),
                                    border: Border.all(
                                      color: FlutterFlowTheme.of(context)
                                          .alternate,
                                      width: 1.0,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        16.0, 12.0, 16.0, 12.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 4,
                                          child: Text(
                                            'Date',
                                            style: FlutterFlowTheme.of(context)
                                                .labelMedium
                                                .override(
                                                  fontFamily: 'Readex Pro',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  fontSize: 14.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            'Amount',
                                            textAlign: TextAlign.end,
                                            style: FlutterFlowTheme.of(context)
                                                .labelMedium
                                                .override(
                                                  fontFamily: 'Readex Pro',
                                                  letterSpacing: 0.0,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Stack(
                                children: [
                                  if ((payrollCount > 0) && !_model.isLoading)
                                    PagedListView<DocumentSnapshot<Object?>?,
                                        PayrollsRecord>.separated(
                                      pagingController:
                                          _model.setListViewController2(
                                        PayrollsRecord.collection
                                            .where(
                                              'hotel',
                                              isEqualTo: FFAppState().hotel,
                                            )
                                            .where(
                                              'date',
                                              isGreaterThanOrEqualTo: functions
                                                  .startOfYear(_model.year),
                                            )
                                            .where(
                                              'date',
                                              isLessThanOrEqualTo: functions
                                                  .endOfYear(_model.year),
                                            )
                                            .orderBy('date', descending: true),
                                      ),
                                      padding: const EdgeInsets.fromLTRB(
                                        0,
                                        12.0,
                                        0,
                                        44.0,
                                      ),
                                      primary: false,
                                      shrinkWrap: true,
                                      reverse: false,
                                      scrollDirection: Axis.vertical,
                                      separatorBuilder: (_, __) =>
                                          const SizedBox(height: 12.0),
                                      builderDelegate:
                                          PagedChildBuilderDelegate<
                                              PayrollsRecord>(
                                        // Customize what your widget looks like when it's loading the first page.
                                        firstPageProgressIndicatorBuilder:
                                            (_) => Center(
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
                                        ),
                                        // Customize what your widget looks like when it's loading another page.
                                        newPageProgressIndicatorBuilder: (_) =>
                                            Center(
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
                                        ),

                                        itemBuilder:
                                            (context, _, listViewIndex) {
                                          final listViewPayrollsRecord = _model
                                              .listViewPagingController2!
                                              .itemList![listViewIndex];
                                          return Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 0.0, 16.0, 0.0),
                                            child: InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                context.pushNamed(
                                                  'NewEditPayroll',
                                                  queryParameters: {
                                                    'ref': serializeParam(
                                                      listViewPayrollsRecord
                                                          .reference,
                                                      ParamType
                                                          .DocumentReference,
                                                    ),
                                                  }.withoutNulls,
                                                );
                                              },
                                              onLongPress: () async {
                                                await showModalBottomSheet(
                                                  isScrollControlled: true,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  context: context,
                                                  builder: (context) {
                                                    return GestureDetector(
                                                      onTap: () =>
                                                          FocusScope.of(context)
                                                              .unfocus(),
                                                      child: Padding(
                                                        padding: MediaQuery
                                                            .viewInsetsOf(
                                                                context),
                                                        child: SizedBox(
                                                          height: 125.0,
                                                          child:
                                                              OptionToPayrollWidget(
                                                            payroll:
                                                                listViewPayrollsRecord,
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ).then((value) =>
                                                    safeSetState(() {}));
                                              },
                                              child: Container(
                                                width: double.infinity,
                                                constraints: const BoxConstraints(
                                                  maxWidth: 570.0,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      offset: const Offset(
                                                        3.0,
                                                        3.0,
                                                      ),
                                                    )
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  border: Border.all(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    width: 2.0,
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsetsDirectional
                                                      .fromSTEB(16.0, 12.0,
                                                          16.0, 12.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Expanded(
                                                        flex: 3,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      12.0,
                                                                      0.0),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              RichText(
                                                                textScaler: MediaQuery.of(
                                                                        context)
                                                                    .textScaler,
                                                                text: TextSpan(
                                                                  children: [
                                                                    TextSpan(
                                                                      text: listViewPayrollsRecord
                                                                          .fortnight,
                                                                      style:
                                                                          TextStyle(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primary,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                    ),
                                                                    const TextSpan(
                                                                      text:
                                                                          ' fortnight',
                                                                      style:
                                                                          TextStyle(),
                                                                    )
                                                                  ],
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyLarge
                                                                      .override(
                                                                        fontFamily:
                                                                            'Readex Pro',
                                                                        letterSpacing:
                                                                            0.0,
                                                                      ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            4.0,
                                                                            0.0,
                                                                            0.0),
                                                                child:
                                                                    AutoSizeText(
                                                                  dateTimeFormat(
                                                                      "EEE MMM d y h:mm a",
                                                                      listViewPayrollsRecord
                                                                          .date!),
                                                                  maxLines: 1,
                                                                  minFontSize:
                                                                      12.0,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Readex Pro',
                                                                        letterSpacing:
                                                                            0.0,
                                                                      ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 2,
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Text(
                                                              formatNumber(
                                                                listViewPayrollsRecord
                                                                    .total,
                                                                formatType:
                                                                    FormatType
                                                                        .decimal,
                                                                decimalType:
                                                                    DecimalType
                                                                        .automatic,
                                                                currency: 'P ',
                                                              ),
                                                              textAlign:
                                                                  TextAlign.end,
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .headlineSmall
                                                                  .override(
                                                                    fontFamily:
                                                                        'Outfit',
                                                                    letterSpacing:
                                                                        0.0,
                                                                  ),
                                                            ),
                                                            Align(
                                                              alignment:
                                                                  const AlignmentDirectional(
                                                                      1.0, 0.0),
                                                              child: Text(
                                                                listViewPayrollsRecord
                                                                    .status,
                                                                textAlign:
                                                                    TextAlign
                                                                        .end,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Readex Pro',
                                                                      color: listViewPayrollsRecord.status ==
                                                                              'pending'
                                                                          ? FlutterFlowTheme.of(context)
                                                                              .error
                                                                          : FlutterFlowTheme.of(context)
                                                                              .success,
                                                                      letterSpacing:
                                                                          0.0,
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
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  if (_model.isLoading)
                                    Container(
                                      width: double.infinity,
                                      height: 330.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Image.asset(
                                          'assets/images/giphy.gif',
                                          width: 300.0,
                                          height: 270.0,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                ],
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
      },
    );
  }
}
