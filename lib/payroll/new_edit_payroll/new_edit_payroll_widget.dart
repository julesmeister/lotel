import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/new_salary/new_salary_widget.dart';
import '/components/salary_options/salary_options_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'new_edit_payroll_model.dart';
export 'new_edit_payroll_model.dart';

class NewEditPayrollWidget extends StatefulWidget {
  const NewEditPayrollWidget({
    Key? key,
    this.ref,
  }) : super(key: key);

  final DocumentReference? ref;

  @override
  _NewEditPayrollWidgetState createState() => _NewEditPayrollWidgetState();
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
      setState(() {
        _model.edit = widget.ref?.id != null && widget.ref?.id != '';
      });
      if (_model.edit) {
        // set ref
        setState(() {
          _model.ref = widget.ref;
        });
        // old payroll
        _model.existingPayroll =
            await PayrollsRecord.getDocumentOnce(widget.ref!);
        // existing salaries
        _model.existingSalaries = await querySalariesRecordOnce(
          parent: widget.ref,
        );
        setState(() {
          _model.date = _model.existingPayroll?.date;
          _model.fortnight = _model.existingPayroll!.fortnight;
          _model.settled = _model.existingPayroll?.status == 'settled';
          _model.salaries =
              _model.existingSalaries!.toList().cast<SalariesRecord>();
          _model.approved = _model.existingPayroll?.approvedBy != null;
        });
      } else {
        // new payroll
        setState(() {
          _model.date = functions.today();
          _model.fortnight = functions.generateFortnight(functions.today()!);
          _model.settled = false;
        });
      }
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
            style: FlutterFlowTheme.of(context).titleLarge,
          ),
          actions: [
            Visibility(
              visible: (_model.existingPayroll?.status != 'settled') &&
                  (widget.ref != null),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 16.0, 8.0),
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
                    _model.staffsForSelection = await queryStaffsRecordOnce(
                      queryBuilder: (staffsRecord) => staffsRecord.where(
                        'hotel',
                        isEqualTo: FFAppState().hotel,
                      ),
                    );
                    await showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (context) {
                        return GestureDetector(
                          onTap: () => _model.unfocusNode.canRequestFocus
                              ? FocusScope.of(context)
                                  .requestFocus(_model.unfocusNode)
                              : FocusScope.of(context).unfocus(),
                          child: Padding(
                            padding: MediaQuery.viewInsetsOf(context),
                            child: Container(
                              height: double.infinity,
                              child: NewSalaryWidget(
                                payrollRef: widget.ref!,
                                staffsForSelection: _model.staffsForSelection!,
                              ),
                            ),
                          ),
                        );
                      },
                    ).then(
                        (value) => safeSetState(() => _model.salary = value));

                    // add salary to list
                    setState(() {
                      _model.addToSalaries(_model.salary!);
                    });

                    setState(() {});
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
            padding: EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: FlutterFlowTheme.of(context).labelLarge,
                      ),
                      Text(
                        dateTimeFormat('EEEE MMM d y h:mm a', _model.date),
                        style: FlutterFlowTheme.of(context).labelLarge.override(
                              fontFamily: 'Readex Pro',
                              color: FlutterFlowTheme.of(context).primaryText,
                            ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                    child: Text(
                      formatNumber(
                        functions.sumOfSalaries(_model.salaries.toList()),
                        formatType: FormatType.decimal,
                        decimalType: DecimalType.automatic,
                        currency: '₱ ',
                      ),
                      style: FlutterFlowTheme.of(context).headlineMedium,
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Fortnight',
                          style: FlutterFlowTheme.of(context)
                              .headlineMedium
                              .override(
                                fontFamily: 'Outfit',
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                fontSize: 16.0,
                              ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            FlutterFlowIconButton(
                              borderColor: FlutterFlowTheme.of(context).info,
                              borderRadius: 20.0,
                              borderWidth: 1.0,
                              buttonSize: 30.0,
                              fillColor: FlutterFlowTheme.of(context).info,
                              icon: FaIcon(
                                FontAwesomeIcons.angleDown,
                                color: FlutterFlowTheme.of(context).primaryText,
                                size: 16.0,
                              ),
                              onPressed: () async {
                                setState(() {
                                  _model.fortnight =
                                      functions.downOrdinal(_model.fortnight);
                                });
                              },
                            ),
                            Text(
                              _model.fortnight,
                              style: FlutterFlowTheme.of(context)
                                  .headlineMedium
                                  .override(
                                    fontFamily: 'Outfit',
                                    fontSize: 16.0,
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
                                    FontAwesomeIcons.angleUp,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 16.0,
                                  ),
                                  onPressed: () async {
                                    setState(() {
                                      _model.fortnight =
                                          functions.upOrdinal(_model.fortnight);
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (_model.existingPayroll?.status != 'settled')
                    Align(
                      alignment: AlignmentDirectional(0.00, -1.00),
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                        child: Container(
                          width: double.infinity,
                          height: 50.0,
                          constraints: BoxConstraints(
                            maxWidth: 500.0,
                          ),
                          decoration: BoxDecoration(
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(
                              color: FlutterFlowTheme.of(context).alternate,
                              width: 1.0,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                4.0, 4.0, 4.0, 4.0),
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
                                      setState(() {
                                        _model.settled = true;
                                      });
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
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            size: 16.0,
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    4.0, 0.0, 0.0, 0.0),
                                            child: Text(
                                              'Settled',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Readex Pro',
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
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
                                      setState(() {
                                        _model.settled = false;
                                      });
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
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            size: 16.0,
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    4.0, 0.0, 0.0, 0.0),
                                            child: Text(
                                              'Pending',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Readex Pro',
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
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
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
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
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 10.0),
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
                                    onLongPress: () async {
                                      await showModalBottomSheet(
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                        context: context,
                                        builder: (context) {
                                          return GestureDetector(
                                            onTap: () => _model
                                                    .unfocusNode.canRequestFocus
                                                ? FocusScope.of(context)
                                                    .requestFocus(
                                                        _model.unfocusNode)
                                                : FocusScope.of(context)
                                                    .unfocus(),
                                            child: Padding(
                                              padding: MediaQuery.viewInsetsOf(
                                                  context),
                                              child: Container(
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
                                      constraints: BoxConstraints(
                                        maxWidth: 570.0,
                                      ),
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        border: Border.all(
                                          color: FlutterFlowTheme.of(context)
                                              .alternate,
                                          width: 2.0,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10.0, 10.0, 10.0, 10.0),
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
                                                        EdgeInsetsDirectional
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
                                                              .labelMedium,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
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
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
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
                                                        ),
                                                  ),
                                                  Text(
                                                    formatNumber(
                                                      salariesListItem.rate,
                                                      formatType:
                                                          FormatType.decimal,
                                                      decimalType:
                                                          DecimalType.automatic,
                                                      currency: '₱ ',
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
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
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
                                                        ),
                                                  ),
                                                  Text(
                                                    formatNumber(
                                                      salariesListItem.sss,
                                                      formatType:
                                                          FormatType.decimal,
                                                      decimalType:
                                                          DecimalType.automatic,
                                                      currency: '₱ ',
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
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
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
                                                      currency: '₱ ',
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
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 5.0, 0.0, 0.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Cash Advance Balance',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Readex Pro',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                        ),
                                                  ),
                                                  Text(
                                                    formatNumber(
                                                      salariesListItem
                                                          .pendingCA,
                                                      formatType:
                                                          FormatType.decimal,
                                                      decimalType:
                                                          DecimalType.automatic,
                                                      currency: '₱ ',
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
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 5.0, 0.0, 0.0),
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
                                                              .primary,
                                                          fontSize: 16.0,
                                                        ),
                                                  ),
                                                  Text(
                                                    formatNumber(
                                                      salariesListItem.total,
                                                      formatType:
                                                          FormatType.decimal,
                                                      decimalType:
                                                          DecimalType.automatic,
                                                      currency: '₱ ',
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
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 12.0),
                            child: FFButtonWidget(
                              onPressed: () async {
                                // Sure delete?
                                var confirmDialogResponse = await showDialog<
                                        bool>(
                                      context: context,
                                      builder: (alertDialogContext) {
                                        return AlertDialog(
                                          title: Text('Delete This Payroll'),
                                          content: Text('Are you certain?'),
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
                                  // reset salary loop counter
                                  setState(() {
                                    _model.loopSalariesCounter = 0;
                                  });
                                  while (_model.loopSalariesCounter !=
                                      _model.salaries.length) {
                                    // reset ca counter loop
                                    setState(() {
                                      _model.loopCACounterUnsettle = 0;
                                    });
                                    while (_model.loopCACounterUnsettle !=
                                        _model
                                            .salaries[
                                                _model.loopSalariesCounter]
                                            .caRefs
                                            .length) {
                                      // unsettle cas again

                                      await _model
                                          .salaries[_model.loopSalariesCounter]
                                          .caRefs[_model.loopCACounterUnsettle]
                                          .update(createAdvancesRecordData(
                                        settled: false,
                                      ));
                                      // increment loop ca counter
                                      setState(() {
                                        _model.loopCACounterUnsettle =
                                            _model.loopCACounterUnsettle + 1;
                                      });
                                    }
                                    // delete each salary
                                    await _model
                                        .salaries[_model.loopSalariesCounter]
                                        .reference
                                        .delete();
                                    // increment loop salaries
                                    setState(() {
                                      _model.loopSalariesCounter =
                                          _model.loopSalariesCounter + 1;
                                    });
                                  }
                                  // deduct from stats

                                  await FFAppState().statsReference!.update({
                                    ...mapToFirestore(
                                      {
                                        'salaries': FieldValue.increment(
                                            -(_model.existingPayroll!.total)),
                                      },
                                    ),
                                  });
                                  // delete payroll
                                  await widget.ref!.delete();
                                  // Payroll deleted
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Payroll deleted!',
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
                                  context.safePop();
                                } else {
                                  return;
                                }
                              },
                              text: 'Delete',
                              icon: Icon(
                                Icons.delete_sweep_outlined,
                                size: 15.0,
                              ),
                              options: FFButtonOptions(
                                height: 48.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: FlutterFlowTheme.of(context).error,
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
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (_model.existingPayroll?.status != 'settled')
                    Align(
                      alignment: AlignmentDirectional(0.00, 1.00),
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 20.0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            if (_model.edit) {
                              // Save total, status, fortnight

                              await widget.ref!.update(createPayrollsRecordData(
                                status: _model.settled ? 'settled' : 'pending',
                                total: functions
                                    .sumOfSalaries(_model.salaries.toList()),
                                fortnight: _model.fortnight,
                              ));
                              // Update stats

                              await FFAppState().statsReference!.update({
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
                                while (_model.loopSalariesCounter !=
                                    _model.salaries.length) {
                                  // staff
                                  _model.staff =
                                      await StaffsRecord.getDocumentOnce(_model
                                          .salaries[_model.loopSalariesCounter]
                                          .staff!);
                                  // CAs of staff
                                  _model.unsettledCashAdvance =
                                      await queryAdvancesRecordOnce(
                                    parent: _model.staff?.reference,
                                    queryBuilder: (advancesRecord) =>
                                        advancesRecord.where(
                                      'settled',
                                      isEqualTo: false,
                                    ),
                                  );
                                  // reset ca loop counter
                                  setState(() {
                                    _model.loopAdvancesCounter = 0;
                                  });
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
                                    setState(() {
                                      _model.loopAdvancesCounter =
                                          _model.loopAdvancesCounter + 1;
                                    });
                                  }
                                  // increment loopSalaries
                                  setState(() {
                                    _model.loopSalariesCounter =
                                        _model.loopSalariesCounter + 1;
                                  });
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
                                    duration: Duration(milliseconds: 4000),
                                    backgroundColor:
                                        FlutterFlowTheme.of(context).secondary,
                                  ),
                                );
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
                                  duration: Duration(milliseconds: 4000),
                                  backgroundColor:
                                      FlutterFlowTheme.of(context).secondary,
                                ),
                              );
                            }

                            setState(() {});
                          },
                          text: _model.edit ? 'Save' : 'Create',
                          icon: Icon(
                            Icons.save,
                            size: 15.0,
                          ),
                          options: FFButtonOptions(
                            width: MediaQuery.sizeOf(context).width * 1.0,
                            height: 50.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context).primary,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  color: Colors.white,
                                ),
                            elevation: 2.0,
                            borderSide: BorderSide(
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
        ),
      ),
    );
  }
}
