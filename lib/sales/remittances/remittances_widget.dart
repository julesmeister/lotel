import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_calendar.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'remittances_model.dart';
export 'remittances_model.dart';

class RemittancesWidget extends StatefulWidget {
  const RemittancesWidget({Key? key}) : super(key: key);

  @override
  _RemittancesWidgetState createState() => _RemittancesWidgetState();
}

class _RemittancesWidgetState extends State<RemittancesWidget>
    with TickerProviderStateMixin {
  late RemittancesModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = {
    'textOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        VisibilityEffect(duration: 1.ms),
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
          begin: Offset(-40.0, 0.0),
          end: Offset(0.0, 0.0),
        ),
      ],
    ),
    'iconButtonOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        VisibilityEffect(duration: 200.ms),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 200.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
        ScaleEffect(
          curve: Curves.easeInOut,
          delay: 200.ms,
          duration: 600.ms,
          begin: Offset(0.7, 0.7),
          end: Offset(1.0, 1.0),
        ),
      ],
    ),
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
          begin: Offset(0.0, 50.0),
          end: Offset(0.0, 0.0),
        ),
      ],
    ),
    'columnOnPageLoadAnimation': AnimationInfo(
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
          begin: Offset(40.0, 0.0),
          end: Offset(0.0, 0.0),
        ),
      ],
    ),
    'progressBarOnPageLoadAnimation': AnimationInfo(
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
          begin: Offset(-50.0, 0.0),
          end: Offset(0.0, 0.0),
        ),
        ScaleEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: Offset(0.7, 0.7),
          end: Offset(1.0, 1.0),
        ),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RemittancesModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (_model.date == null) {
        // today
        setState(() {
          _model.date = functions.today();
        });
      } else {
        return;
      }
    });

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

    return FutureBuilder<int>(
      future: queryRemittancesRecordCount(
        queryBuilder: (remittancesRecord) => remittancesRecord
            .where(
              'date',
              isGreaterThan: functions.startOfDay(_model.date!),
            )
            .where(
              'hotel',
              isEqualTo: FFAppState().hotel,
            )
            .where(
              'date',
              isLessThan: functions.endOfDay(_model.date!),
            ),
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
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
        int remittancesCount = snapshot.data!;
        return GestureDetector(
          onTap: () => _model.unfocusNode.canRequestFocus
              ? FocusScope.of(context).requestFocus(_model.unfocusNode)
              : FocusScope.of(context).unfocus(),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            appBar: AppBar(
              backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
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
              title: Align(
                alignment: AlignmentDirectional(-1.00, 0.00),
                child: Text(
                  'Remittance',
                  textAlign: TextAlign.start,
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Readex Pro',
                        fontSize: 26.0,
                      ),
                ),
              ),
              actions: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    FlutterFlowIconButton(
                      borderRadius: 20.0,
                      borderWidth: 1.0,
                      buttonSize: 40.0,
                      icon: Icon(
                        Icons.chevron_left,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 24.0,
                      ),
                      onPressed: () async {
                        setState(() {
                          _model.date = functions.prevDate(_model.date!);
                        });
                      },
                    ),
                    FlutterFlowIconButton(
                      borderColor: Colors.transparent,
                      borderRadius: 20.0,
                      borderWidth: 1.0,
                      buttonSize: 40.0,
                      icon: Icon(
                        Icons.navigate_next,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 24.0,
                      ),
                      onPressed: () async {
                        setState(() {
                          _model.date = functions.nextDate(_model.date!);
                        });
                      },
                    ),
                  ],
                ),
              ],
              centerTitle: false,
              elevation: 0.0,
            ),
            body: SafeArea(
              top: true,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 5,
                            child: AutoSizeText(
                              dateTimeFormat('MMMMEEEEd', _model.date),
                              maxLines: 1,
                              style: FlutterFlowTheme.of(context)
                                  .displaySmall
                                  .override(
                                    fontFamily: 'Outfit',
                                    fontSize: 26.0,
                                  ),
                              minFontSize: 22.0,
                            ).animateOnPageLoad(
                                animationsMap['textOnPageLoadAnimation']!),
                          ),
                          if (valueOrDefault(currentUserDocument?.role, '') ==
                              'admin')
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    12.0, 0.0, 0.0, 0.0),
                                child: AuthUserStreamWidget(
                                  builder: (context) => FlutterFlowIconButton(
                                    borderColor:
                                        FlutterFlowTheme.of(context).alternate,
                                    borderRadius: 12.0,
                                    borderWidth: 1.0,
                                    buttonSize: 44.0,
                                    icon: Icon(
                                      Icons.calendar_month,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      size: 24.0,
                                    ),
                                    onPressed: () async {
                                      setState(() {
                                        _model.showDatePicker =
                                            !_model.showDatePicker;
                                      });
                                    },
                                  ).animateOnPageLoad(animationsMap[
                                      'iconButtonOnPageLoadAnimation']!),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    if (_model.showDatePicker)
                      FlutterFlowCalendar(
                        color: FlutterFlowTheme.of(context).primary,
                        iconColor: FlutterFlowTheme.of(context).secondaryText,
                        weekFormat: false,
                        weekStartsMonday: false,
                        rowHeight: 64.0,
                        onChange: (DateTimeRange? newSelectedDate) async {
                          _model.calendarSelectedDay = newSelectedDate;
                          setState(() {
                            _model.date = _model.calendarSelectedDay?.start;
                            _model.showLoadButton = true;
                            _model.showDownloadButton = false;
                            _model.inventories = [];
                            _model.bookings = [];
                            _model.transactions = [];
                          });
                          setState(() {});
                        },
                        titleStyle: FlutterFlowTheme.of(context).headlineSmall,
                        dayOfWeekStyle: FlutterFlowTheme.of(context).labelLarge,
                        dateStyle: FlutterFlowTheme.of(context).bodyMedium,
                        selectedDateStyle:
                            FlutterFlowTheme.of(context).titleSmall,
                        inactiveDateStyle:
                            FlutterFlowTheme.of(context).labelMedium,
                      ),
                    if (remittancesCount > 0)
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 20.0, 16.0, 20.0),
                        child: StreamBuilder<List<RemittancesRecord>>(
                          stream: queryRemittancesRecord(
                            queryBuilder: (remittancesRecord) =>
                                remittancesRecord
                                    .where(
                                      'date',
                                      isGreaterThan:
                                          functions.startOfDay(_model.date!),
                                    )
                                    .where(
                                      'hotel',
                                      isEqualTo: FFAppState().hotel,
                                    )
                                    .where(
                                      'date',
                                      isLessThan:
                                          functions.endOfDay(_model.date!),
                                    ),
                            singleRecord: true,
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
                            List<RemittancesRecord>
                                mainCardRemittancesRecordList = snapshot.data!;
                            // Return an empty Container when the item does not exist.
                            if (snapshot.data!.isEmpty) {
                              return Container();
                            }
                            final mainCardRemittancesRecord =
                                mainCardRemittancesRecordList.isNotEmpty
                                    ? mainCardRemittancesRecordList.first
                                    : null;
                            return Container(
                              width: double.infinity,
                              height: 546.0,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 4.0,
                                    color: Color(0x33000000),
                                    offset: Offset(0.0, 2.0),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          24.0, 24.0, 24.0, 24.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Total',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .headlineSmall
                                                      .override(
                                                        fontFamily: 'Outfit',
                                                        color:
                                                            Color(0xFF14181B),
                                                        fontSize: 24.0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 4.0, 0.0, 0.0),
                                                  child: Text(
                                                    'Less Expenses',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .labelMedium
                                                        .override(
                                                          fontFamily:
                                                              'Readex Pro',
                                                          color:
                                                              Color(0xFF57636C),
                                                          fontSize: 14.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                  ),
                                                ),
                                                if (mainCardRemittancesRecord
                                                        ?.hasNet() ??
                                                    true)
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 8.0,
                                                                0.0, 0.0),
                                                    child: Text(
                                                      valueOrDefault<String>(
                                                        formatNumber(
                                                          mainCardRemittancesRecord
                                                              ?.net,
                                                          formatType: FormatType
                                                              .decimal,
                                                          decimalType:
                                                              DecimalType
                                                                  .automatic,
                                                          currency: 'P ',
                                                        ),
                                                        '0',
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .headlineLarge
                                                          .override(
                                                            fontFamily:
                                                                'Outfit',
                                                            color: Color(
                                                                0xFF14181B),
                                                            fontSize: 32.0,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                    ),
                                                  ),
                                              ],
                                            ).animateOnPageLoad(animationsMap[
                                                'columnOnPageLoadAnimation']!),
                                          ),
                                          CircularPercentIndicator(
                                            percent: functions.netCircleDecimal(
                                                mainCardRemittancesRecord!
                                                    .gross,
                                                mainCardRemittancesRecord!
                                                    .expenses),
                                            radius: 50.0,
                                            lineWidth: 8.0,
                                            animation: true,
                                            animateFromLastPercent: true,
                                            progressColor: Color(0xFF4B39EF),
                                            backgroundColor: Color(0xFFE0E3E7),
                                            center: Text(
                                              functions.netCircle(
                                                  mainCardRemittancesRecord!
                                                      .gross,
                                                  mainCardRemittancesRecord!
                                                      .expenses),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .headlineMedium
                                                  .override(
                                                    fontFamily: 'Outfit',
                                                    color: Color(0xFF14181B),
                                                    fontSize: 22.0,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                            ),
                                          ).animateOnPageLoad(animationsMap[
                                              'progressBarOnPageLoadAnimation']!),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Stack(
                                          children: [
                                            if (!_model.isLoading)
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                24.0,
                                                                25.0,
                                                                24.0,
                                                                25.0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'Expenses',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Readex Pro',
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryText,
                                                                  ),
                                                            ),
                                                            if (mainCardRemittancesRecord
                                                                    ?.hasExpenses() ??
                                                                true)
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            5.0,
                                                                            0.0,
                                                                            0.0),
                                                                child: Text(
                                                                  formatNumber(
                                                                    mainCardRemittancesRecord!
                                                                        .expenses,
                                                                    formatType:
                                                                        FormatType
                                                                            .decimal,
                                                                    decimalType:
                                                                        DecimalType
                                                                            .automatic,
                                                                    currency:
                                                                        'P ',
                                                                  ),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Readex Pro',
                                                                        fontSize:
                                                                            20.0,
                                                                      ),
                                                                ),
                                                              ),
                                                          ],
                                                        ),
                                                        if (valueOrDefault(
                                                                currentUserDocument
                                                                    ?.role,
                                                                '') ==
                                                            'admin')
                                                          AuthUserStreamWidget(
                                                            builder: (context) =>
                                                                FlutterFlowIconButton(
                                                              borderRadius:
                                                                  20.0,
                                                              borderWidth: 1.0,
                                                              buttonSize: 40.0,
                                                              icon: Icon(
                                                                Icons.add,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                size: 24.0,
                                                              ),
                                                              onPressed:
                                                                  () async {
                                                                context
                                                                    .pushNamed(
                                                                  'Expense',
                                                                  queryParameters:
                                                                      {
                                                                    'additional':
                                                                        serializeParam(
                                                                      true,
                                                                      ParamType
                                                                          .bool,
                                                                    ),
                                                                    'remittanceRef':
                                                                        serializeParam(
                                                                      mainCardRemittancesRecord
                                                                          ?.reference,
                                                                      ParamType
                                                                          .DocumentReference,
                                                                    ),
                                                                    'net':
                                                                        serializeParam(
                                                                      mainCardRemittancesRecord
                                                                          ?.net,
                                                                      ParamType
                                                                          .double,
                                                                    ),
                                                                  }.withoutNulls,
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(24.0, 0.0,
                                                                24.0, 25.0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'Sales',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Readex Pro',
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryText,
                                                                  ),
                                                            ),
                                                            if (mainCardRemittancesRecord
                                                                    ?.hasGross() ??
                                                                true)
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            5.0,
                                                                            0.0,
                                                                            0.0),
                                                                child: Text(
                                                                  formatNumber(
                                                                    mainCardRemittancesRecord!
                                                                        .gross,
                                                                    formatType:
                                                                        FormatType
                                                                            .decimal,
                                                                    decimalType:
                                                                        DecimalType
                                                                            .automatic,
                                                                    currency:
                                                                        'P ',
                                                                  ),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Readex Pro',
                                                                        fontSize:
                                                                            20.0,
                                                                      ),
                                                                ),
                                                              ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(24.0, 0.0,
                                                                24.0, 25.0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'Prepared By',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Readex Pro',
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryText,
                                                                  ),
                                                            ),
                                                            if (mainCardRemittancesRecord
                                                                    ?.hasPreparedBy() ??
                                                                true)
                                                              StreamBuilder<
                                                                  UsersRecord>(
                                                                stream: UsersRecord
                                                                    .getDocument(
                                                                        mainCardRemittancesRecord!
                                                                            .preparedBy!),
                                                                builder: (context,
                                                                    snapshot) {
                                                                  // Customize what your widget looks like when it's loading.
                                                                  if (!snapshot
                                                                      .hasData) {
                                                                    return Center(
                                                                      child:
                                                                          SizedBox(
                                                                        width:
                                                                            50.0,
                                                                        height:
                                                                            50.0,
                                                                        child:
                                                                            CircularProgressIndicator(
                                                                          valueColor:
                                                                              AlwaysStoppedAnimation<Color>(
                                                                            FlutterFlowTheme.of(context).primary,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }
                                                                  final textUsersRecord =
                                                                      snapshot
                                                                          .data!;
                                                                  return Text(
                                                                    textUsersRecord
                                                                        .displayName,
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium,
                                                                  );
                                                                },
                                                              ),
                                                          ],
                                                        ),
                                                        Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Text(
                                                              'Collected By',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Readex Pro',
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryText,
                                                                  ),
                                                            ),
                                                            if (mainCardRemittancesRecord
                                                                    ?.hasCollectedBy() ??
                                                                true)
                                                              StreamBuilder<
                                                                  UsersRecord>(
                                                                stream: UsersRecord
                                                                    .getDocument(
                                                                        mainCardRemittancesRecord!
                                                                            .collectedBy!),
                                                                builder: (context,
                                                                    snapshot) {
                                                                  // Customize what your widget looks like when it's loading.
                                                                  if (!snapshot
                                                                      .hasData) {
                                                                    return Center(
                                                                      child:
                                                                          SizedBox(
                                                                        width:
                                                                            50.0,
                                                                        height:
                                                                            50.0,
                                                                        child:
                                                                            CircularProgressIndicator(
                                                                          valueColor:
                                                                              AlwaysStoppedAnimation<Color>(
                                                                            FlutterFlowTheme.of(context).primary,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }
                                                                  final textUsersRecord =
                                                                      snapshot
                                                                          .data!;
                                                                  return Text(
                                                                    valueOrDefault<
                                                                        String>(
                                                                      textUsersRecord
                                                                          .displayName,
                                                                      'Not yet collected',
                                                                    ),
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium,
                                                                  );
                                                                },
                                                              ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            if (_model.isLoading)
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                child: Image.asset(
                                                  'assets/images/giphy.gif',
                                                  width: double.infinity,
                                                  height: 219.0,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16.0, 0.0, 16.0, 15.0),
                                          child: FFButtonWidget(
                                            onPressed: () async {
                                              context.pushNamed(
                                                'remittanceSpecificTransactions',
                                                queryParameters: {
                                                  'transactions':
                                                      serializeParam(
                                                    mainCardRemittancesRecord
                                                        ?.transactions,
                                                    ParamType.DocumentReference,
                                                    true,
                                                  ),
                                                  'remittanceRef':
                                                      serializeParam(
                                                    mainCardRemittancesRecord
                                                        ?.reference,
                                                    ParamType.DocumentReference,
                                                  ),
                                                  'absences': serializeParam(
                                                    mainCardRemittancesRecord
                                                        ?.absences,
                                                    ParamType.DocumentReference,
                                                    true,
                                                  ),
                                                }.withoutNulls,
                                              );
                                            },
                                            text: 'View Transactions',
                                            options: FFButtonOptions(
                                              width: double.infinity,
                                              height: 50.0,
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                              iconPadding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                              color: Color(0xFF39D2C0),
                                              textStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .override(
                                                        fontFamily:
                                                            'Plus Jakarta Sans',
                                                        color: Colors.white,
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                              elevation: 2.0,
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                                width: 1.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        if (_model.showLoadButton)
                                          Align(
                                            alignment: AlignmentDirectional(
                                                0.00, 0.00),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      16.0, 0.0, 16.0, 15.0),
                                              child: FFButtonWidget(
                                                onPressed: () async {
                                                  // reset values
                                                  setState(() {
                                                    _model.showLoadButton =
                                                        true;
                                                    _model.showDownloadButton =
                                                        false;
                                                    _model.inventories = [];
                                                    _model.bookings = [];
                                                    _model.transactions = [];
                                                    _model.rooms = [];
                                                    _model.loopInvetoryCounter =
                                                        0;
                                                    _model.loopBookCounter = 0;
                                                    _model.loopTransactionCounter =
                                                        0;
                                                    _model.isLoading = true;
                                                  });
                                                  // roomList
                                                  _model.roomInThisHotel =
                                                      await queryRoomsRecordOnce(
                                                    queryBuilder:
                                                        (roomsRecord) =>
                                                            roomsRecord.where(
                                                      'hotel',
                                                      isEqualTo:
                                                          FFAppState().hotel,
                                                    ),
                                                  );
                                                  // rooms to list
                                                  setState(() {
                                                    _model.rooms = _model
                                                        .roomInThisHotel!
                                                        .toList()
                                                        .cast<RoomsRecord>();
                                                  });
                                                  while (_model
                                                          .loopInvetoryCounter !=
                                                      mainCardRemittancesRecord
                                                          ?.inventories
                                                          ?.length) {
                                                    // read inventory
                                                    _model.inventoryToList =
                                                        await InventoriesRecord
                                                            .getDocumentOnce(
                                                                mainCardRemittancesRecord!
                                                                        .inventories[
                                                                    _model
                                                                        .loopInvetoryCounter]);
                                                    // increment loop
                                                    setState(() {
                                                      _model.addToInventories(
                                                          _model
                                                              .inventoryToList!);
                                                      _model.loopInvetoryCounter =
                                                          _model.loopInvetoryCounter +
                                                              1;
                                                    });
                                                  }
                                                  while (_model
                                                          .loopBookCounter !=
                                                      mainCardRemittancesRecord
                                                          ?.bookings?.length) {
                                                    // read book
                                                    _model.bookToList =
                                                        await BookingsRecord
                                                            .getDocumentOnce(
                                                                mainCardRemittancesRecord!
                                                                        .bookings[
                                                                    _model
                                                                        .loopBookCounter]);
                                                    // increment loop
                                                    setState(() {
                                                      _model.loopBookCounter =
                                                          _model.loopBookCounter +
                                                              1;
                                                      _model.addToBookings(
                                                          _model.bookToList!);
                                                    });
                                                  }
                                                  while (_model
                                                          .loopTransactionCounter !=
                                                      mainCardRemittancesRecord
                                                          ?.transactions
                                                          ?.length) {
                                                    // read transactions
                                                    _model.transactionToList =
                                                        await TransactionsRecord
                                                            .getDocumentOnce(
                                                                mainCardRemittancesRecord!
                                                                        .transactions[
                                                                    _model
                                                                        .loopTransactionCounter]);
                                                    // increment loop
                                                    setState(() {
                                                      _model.loopTransactionCounter =
                                                          _model.loopTransactionCounter +
                                                              1;
                                                      _model.addToTransactions(
                                                          _model
                                                              .transactionToList!);
                                                    });
                                                  }
                                                  while (_model
                                                          .loopAbsencesCounter !=
                                                      mainCardRemittancesRecord
                                                          ?.absences?.length) {
                                                    // read absence
                                                    _model.absenceToList =
                                                        await AbsencesRecord
                                                            .getDocumentOnce(
                                                                mainCardRemittancesRecord!
                                                                        .absences[
                                                                    _model
                                                                        .loopAbsencesCounter]);
                                                    // increment loop
                                                    setState(() {
                                                      _model.addToAbsences(
                                                          _model
                                                              .absenceToList!);
                                                      _model.loopAbsencesCounter =
                                                          _model.loopAbsencesCounter +
                                                              1;
                                                    });
                                                  }
                                                  // preparedBy
                                                  _model.preparedBy =
                                                      await UsersRecord
                                                          .getDocumentOnce(
                                                              mainCardRemittancesRecord!
                                                                  .preparedBy!);
                                                  if (mainCardRemittancesRecord
                                                          ?.collectedBy !=
                                                      null) {
                                                    // collectedBy
                                                    _model.collectedBy =
                                                        await queryUsersRecordOnce(
                                                      queryBuilder:
                                                          (usersRecord) =>
                                                              usersRecord.where(
                                                        'uid',
                                                        isEqualTo:
                                                            mainCardRemittancesRecord
                                                                ?.collectedBy
                                                                ?.id,
                                                      ),
                                                      singleRecord: true,
                                                    ).then((s) =>
                                                            s.firstOrNull);
                                                  }
                                                  setState(() {
                                                    _model.showDownloadButton =
                                                        true;
                                                    _model.showLoadButton =
                                                        false;
                                                    _model.isLoading = false;
                                                  });

                                                  setState(() {});
                                                },
                                                text: 'Load Shareable PDF',
                                                options: FFButtonOptions(
                                                  width: double.infinity,
                                                  height: 50.0,
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 0.0, 0.0, 0.0),
                                                  iconPadding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(0.0, 0.0,
                                                              0.0, 0.0),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  textStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleSmall
                                                          .override(
                                                            fontFamily:
                                                                'Plus Jakarta Sans',
                                                            color: Colors.white,
                                                            fontSize: 16.0,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                  elevation: 2.0,
                                                  borderSide: BorderSide(
                                                    color: Colors.transparent,
                                                    width: 1.0,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        if (_model.showDownloadButton)
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 0.0, 16.0, 0.0),
                                            child: Container(
                                              width: double.infinity,
                                              height: 50.0,
                                              child: custom_widgets
                                                  .PrintRemittance(
                                                width: double.infinity,
                                                height: 50.0,
                                                remittance:
                                                    mainCardRemittancesRecord!,
                                                transactions:
                                                    _model.transactions,
                                                inventories: _model.inventories,
                                                hotel: FFAppState().hotel,
                                                bookings: _model.bookings,
                                                rooms: _model.rooms,
                                                preparedBy: _model
                                                    .preparedBy?.displayName,
                                                collectedBy:
                                                    mainCardRemittancesRecord
                                                                ?.collectedBy !=
                                                            null
                                                        ? _model.collectedBy
                                                            ?.displayName
                                                        : '',
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ],
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
        );
      },
    );
  }
}
