import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/options/prepared_remittance_user/prepared_remittance_user_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_calendar.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/missing_inventory/missing_inventory_widget.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'remittances_model.dart';
export 'remittances_model.dart';

class RemittancesWidget extends StatefulWidget {
  const RemittancesWidget({super.key});

  @override
  State<RemittancesWidget> createState() => _RemittancesWidgetState();
}

class _RemittancesWidgetState extends State<RemittancesWidget>
    with TickerProviderStateMixin {
  late RemittancesModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RemittancesModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (_model.date == null) {
        // latest remittance
        _model.latestRemittance = await queryRemittancesRecordOnce(
          queryBuilder: (remittancesRecord) => remittancesRecord
              .where(
                'hotel',
                isEqualTo: FFAppState().hotel,
              )
              .orderBy('date', descending: true),
          singleRecord: true,
        ).then((s) => s.firstOrNull);
        // today
        setState(() {
          _model.date = functions.startOfDay(_model.latestRemittance!.date!);
        });
      } else {
        return;
      }
    });

    animationsMap.addAll({
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
      'textOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 1.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
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
      'progressBarOnPageLoadAnimation': AnimationInfo(
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
            begin: const Offset(-50.0, 0.0),
            end: const Offset(0.0, 0.0),
          ),
          ScaleEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: const Offset(0.7, 0.7),
            end: const Offset(1.0, 1.0),
          ),
        ],
      ),
      'textOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: const Offset(0.0, -99.0),
            end: const Offset(0.0, 0.0),
          ),
        ],
      ),
      'iconButtonOnPageLoadAnimation3': AnimationInfo(
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
                borderRadius: 30.0,
                borderWidth: 1.0,
                buttonSize: 60.0,
                icon: Icon(
                  Icons.keyboard_arrow_left_outlined,
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 30.0,
                ),
                onPressed: () async {
                  context.safePop();
                },
              ).animateOnPageLoad(
                  animationsMap['iconButtonOnPageLoadAnimation3']!),
              title: Align(
                alignment: const AlignmentDirectional(-1.0, 0.0),
                child: Text(
                  'Remittance',
                  textAlign: TextAlign.start,
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Readex Pro',
                        fontSize: 26.0,
                        letterSpacing: 0.0,
                      ),
                ).animateOnPageLoad(animationsMap['textOnPageLoadAnimation2']!),
              ),
              actions: const [],
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
                          const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 10.0, 0.0),
                            child: FlutterFlowIconButton(
                              borderRadius: 30.0,
                              borderWidth: 1.0,
                              buttonSize: 60.0,
                              icon: Icon(
                                Icons.keyboard_arrow_left_outlined,
                                color: FlutterFlowTheme.of(context).primaryText,
                                size: 30.0,
                              ),
                              onPressed: () async {
                                setState(() {
                                  _model.date =
                                      functions.prevDate(_model.date!);
                                  _model.showLoadButton = true;
                                  _model.showDownloadButton = false;
                                  _model.inventories = [];
                                  _model.bookings = [];
                                  _model.transactions = [];
                                });
                              },
                            ).animateOnPageLoad(animationsMap[
                                'iconButtonOnPageLoadAnimation1']!),
                          ),
                          Expanded(
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                setState(() {
                                  _model.showDatePicker =
                                      !_model.showDatePicker;
                                });
                              },
                              child: AutoSizeText(
                                dateTimeFormat('MMMMEEEEd', _model.date),
                                maxLines: 1,
                                style: FlutterFlowTheme.of(context)
                                    .displaySmall
                                    .override(
                                      fontFamily: 'Outfit',
                                      fontSize: 26.0,
                                      letterSpacing: 0.0,
                                    ),
                                minFontSize: 22.0,
                              ),
                            ).animateOnPageLoad(
                                animationsMap['textOnPageLoadAnimation1']!),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                10.0, 0.0, 0.0, 0.0),
                            child: FlutterFlowIconButton(
                              borderColor: Colors.transparent,
                              borderRadius: 30.0,
                              borderWidth: 1.0,
                              buttonSize: 60.0,
                              icon: Icon(
                                Icons.keyboard_arrow_right_outlined,
                                color: FlutterFlowTheme.of(context).primaryText,
                                size: 30.0,
                              ),
                              onPressed: () async {
                                setState(() {
                                  _model.date =
                                      functions.nextDate(_model.date!);
                                  _model.showLoadButton = true;
                                  _model.showDownloadButton = false;
                                  _model.inventories = [];
                                  _model.bookings = [];
                                  _model.transactions = [];
                                });
                              },
                            ).animateOnPageLoad(animationsMap[
                                'iconButtonOnPageLoadAnimation2']!),
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
                          if (_model.calendarSelectedDay == newSelectedDate) {
                            return;
                          }
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
                        titleStyle:
                            FlutterFlowTheme.of(context).headlineSmall.override(
                                  fontFamily: 'Outfit',
                                  letterSpacing: 0.0,
                                ),
                        dayOfWeekStyle:
                            FlutterFlowTheme.of(context).labelLarge.override(
                                  fontFamily: 'Readex Pro',
                                  letterSpacing: 0.0,
                                ),
                        dateStyle:
                            FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Readex Pro',
                                  letterSpacing: 0.0,
                                ),
                        selectedDateStyle:
                            FlutterFlowTheme.of(context).titleSmall.override(
                                  fontFamily: 'Readex Pro',
                                  letterSpacing: 0.0,
                                ),
                        inactiveDateStyle:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: 'Readex Pro',
                                  letterSpacing: 0.0,
                                ),
                      ),
                    if (remittancesCount > 0)
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
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
                              height: 589.0,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: const [
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
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          24.0, 24.0, 24.0, 0.0),
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
                                                FFAppState().hotel,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Readex Pro',
                                                          fontSize: 24.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            dateTimeFormat(
                                                'jm',
                                                mainCardRemittancesRecord!
                                                    .date!),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Readex Pro',
                                                  fontSize: 24.0,
                                                  letterSpacing: 0.0,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(24.0),
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
                                                            const Color(0xFF14181B),
                                                        fontSize: 24.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsetsDirectional
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
                                                              const Color(0xFF57636C),
                                                          fontSize: 14.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                  ),
                                                ),
                                                if (mainCardRemittancesRecord
                                                        .hasNet() ??
                                                    true)
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 8.0,
                                                                0.0, 0.0),
                                                    child: Text(
                                                      valueOrDefault<String>(
                                                        formatNumber(
                                                          mainCardRemittancesRecord
                                                              .net,
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
                                                            color: const Color(
                                                                0xFF14181B),
                                                            fontSize: 32.0,
                                                            letterSpacing: 0.0,
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
                                                mainCardRemittancesRecord
                                                    .gross,
                                                mainCardRemittancesRecord
                                                    .expenses),
                                            radius: 50.0,
                                            lineWidth: 8.0,
                                            animation: true,
                                            animateFromLastPercent: true,
                                            progressColor: const Color(0xFF4B39EF),
                                            backgroundColor: const Color(0xFFE0E3E7),
                                            center: Text(
                                              functions.netCircle(
                                                  mainCardRemittancesRecord
                                                      .gross,
                                                  mainCardRemittancesRecord
                                                      .expenses),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .headlineMedium
                                                  .override(
                                                    fontFamily: 'Outfit',
                                                    color: const Color(0xFF14181B),
                                                    fontSize: 22.0,
                                                    letterSpacing: 0.0,
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
                                                        const EdgeInsetsDirectional
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
                                                                    letterSpacing:
                                                                        0.0,
                                                                  ),
                                                            ),
                                                            if (mainCardRemittancesRecord
                                                                    .hasExpenses() ??
                                                                true)
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            5.0,
                                                                            0.0,
                                                                            0.0),
                                                                child: Text(
                                                                  formatNumber(
                                                                    mainCardRemittancesRecord
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
                                                                        letterSpacing:
                                                                            0.0,
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
                                                                          .reference,
                                                                      ParamType
                                                                          .DocumentReference,
                                                                    ),
                                                                    'net':
                                                                        serializeParam(
                                                                      mainCardRemittancesRecord
                                                                          .net,
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
                                                        const EdgeInsetsDirectional
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
                                                                    letterSpacing:
                                                                        0.0,
                                                                  ),
                                                            ),
                                                            if (mainCardRemittancesRecord
                                                                    .hasGross() ??
                                                                true)
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            5.0,
                                                                            0.0,
                                                                            0.0),
                                                                child: Text(
                                                                  formatNumber(
                                                                    mainCardRemittancesRecord
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
                                                                        letterSpacing:
                                                                            0.0,
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
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(24.0, 0.0,
                                                                24.0, 25.0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        InkWell(
                                                          splashColor: Colors
                                                              .transparent,
                                                          focusColor: Colors
                                                              .transparent,
                                                          hoverColor: Colors
                                                              .transparent,
                                                          highlightColor: Colors
                                                              .transparent,
                                                          onTap: () async {
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
                                                                  onTap: () => _model
                                                                          .unfocusNode
                                                                          .canRequestFocus
                                                                      ? FocusScope.of(
                                                                              context)
                                                                          .requestFocus(_model
                                                                              .unfocusNode)
                                                                      : FocusScope.of(
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
                                                                          300.0,
                                                                      child:
                                                                          PreparedRemittanceUserWidget(
                                                                        remittance:
                                                                            mainCardRemittancesRecord.reference,
                                                                        preparedBy:
                                                                            true,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            ).then((value) =>
                                                                safeSetState(
                                                                    () {}));
                                                          },
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                'Prepared By',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Readex Pro',
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryText,
                                                                      letterSpacing:
                                                                          0.0,
                                                                    ),
                                                              ),
                                                              if (mainCardRemittancesRecord
                                                                      .hasPreparedBy() ??
                                                                  true)
                                                                StreamBuilder<
                                                                    UsersRecord>(
                                                                  stream: UsersRecord
                                                                      .getDocument(
                                                                          mainCardRemittancesRecord
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
                                                                          .bodyMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'Readex Pro',
                                                                            letterSpacing:
                                                                                0.0,
                                                                          ),
                                                                    );
                                                                  },
                                                                ),
                                                            ],
                                                          ),
                                                        ),
                                                        InkWell(
                                                          splashColor: Colors
                                                              .transparent,
                                                          focusColor: Colors
                                                              .transparent,
                                                          hoverColor: Colors
                                                              .transparent,
                                                          highlightColor: Colors
                                                              .transparent,
                                                          onTap: () async {
                                                            await showModalBottomSheet(
                                                              isScrollControlled:
                                                                  true,
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent,
                                                              useSafeArea: true,
                                                              context: context,
                                                              builder:
                                                                  (context) {
                                                                return GestureDetector(
                                                                  onTap: () => _model
                                                                          .unfocusNode
                                                                          .canRequestFocus
                                                                      ? FocusScope.of(
                                                                              context)
                                                                          .requestFocus(_model
                                                                              .unfocusNode)
                                                                      : FocusScope.of(
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
                                                                          300.0,
                                                                      child:
                                                                          PreparedRemittanceUserWidget(
                                                                        remittance:
                                                                            mainCardRemittancesRecord.reference,
                                                                        preparedBy:
                                                                            false,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            ).then((value) =>
                                                                safeSetState(
                                                                    () {}));
                                                          },
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .end,
                                                            children: [
                                                              Text(
                                                                'Collected By',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Readex Pro',
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryText,
                                                                      letterSpacing:
                                                                          0.0,
                                                                    ),
                                                              ),
                                                              if (mainCardRemittancesRecord
                                                                      .hasCollectedBy() ??
                                                                  true)
                                                                StreamBuilder<
                                                                    UsersRecord>(
                                                                  stream: UsersRecord
                                                                      .getDocument(
                                                                          mainCardRemittancesRecord
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
                                                                          .bodyMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'Readex Pro',
                                                                            letterSpacing:
                                                                                0.0,
                                                                          ),
                                                                    );
                                                                  },
                                                                ),
                                                            ],
                                                          ),
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
                                                  height: 232.0,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  16.0, 0.0, 16.0, 15.0),
                                          child: FFButtonWidget(
                                            onPressed: () async {
                                              context.pushNamed(
                                                'remittanceSpecificTransactions',
                                                queryParameters: {
                                                  'transactions':
                                                      serializeParam(
                                                    mainCardRemittancesRecord
                                                        .transactions,
                                                    ParamType.DocumentReference,
                                                    true,
                                                  ),
                                                  'remittanceRef':
                                                      serializeParam(
                                                    mainCardRemittancesRecord
                                                        .reference,
                                                    ParamType.DocumentReference,
                                                  ),
                                                  'absences': serializeParam(
                                                    mainCardRemittancesRecord
                                                        .absences,
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
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                              iconPadding: const EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                              color: const Color(0xFF39D2C0),
                                              textStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .override(
                                                        fontFamily:
                                                            'Plus Jakarta Sans',
                                                        color: Colors.white,
                                                        fontSize: 16.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                              elevation: 2.0,
                                              borderSide: const BorderSide(
                                                color: Colors.transparent,
                                                width: 1.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        if (_model.showLoadButton)
                                          Align(
                                            alignment:
                                                const AlignmentDirectional(0.0, 0.0),
                                            child: Padding(
                                              padding: const EdgeInsetsDirectional
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
                                                          .inventories
                                                          .length) {
                                                    // read inventory
                                                    _model.inventoryToList =
                                                        await InventoriesRecord
                                                            .getDocumentOnce(
                                                                mainCardRemittancesRecord
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
                                                          .bookings.length) {
                                                    // read book
                                                    _model.bookToList =
                                                        await BookingsRecord
                                                            .getDocumentOnce(
                                                                mainCardRemittancesRecord
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
                                                          .transactions
                                                          .length) {
                                                    // read transactions
                                                    _model.transactionToList =
                                                        await TransactionsRecord
                                                            .getDocumentOnce(
                                                                mainCardRemittancesRecord
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
                                                  if (functions
                                                      .isInventoryComplete(
                                                          _model.transactions
                                                              .toList(),
                                                          _model.inventories
                                                              .toList())) {
                                                    while (_model
                                                            .loopAbsencesCounter !=
                                                        mainCardRemittancesRecord
                                                            .absences
                                                            .length) {
                                                      // read absence
                                                      _model.absenceToList =
                                                          await AbsencesRecord
                                                              .getDocumentOnce(
                                                                  mainCardRemittancesRecord
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
                                                                mainCardRemittancesRecord
                                                                    .preparedBy!);
                                                    if (mainCardRemittancesRecord
                                                            .collectedBy !=
                                                        null) {
                                                      // collectedBy
                                                      _model.collectedBy =
                                                          await queryUsersRecordOnce(
                                                        queryBuilder:
                                                            (usersRecord) =>
                                                                usersRecord
                                                                    .where(
                                                          'uid',
                                                          isEqualTo:
                                                              mainCardRemittancesRecord
                                                                  .collectedBy
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
                                                  } else {
                                                    // missing
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                          'There\'s a missing inventory!',
                                                          style: TextStyle(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .info,
                                                          ),
                                                        ),
                                                        duration: const Duration(
                                                            milliseconds: 4000),
                                                        backgroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .error,
                                                      ),
                                                    );
                                                    // not loading anymore
                                                    setState(() {
                                                      _model.isLoading = false;
                                                      _model.showLoadButton =
                                                          true;
                                                      _model.showDownloadButton =
                                                          false;
                                                    });
                                                    // reset counter
                                                    setState(() {
                                                      _model.loopTransactionCounter =
                                                          0;
                                                    });
                                                    while (functions
                                                            .transactionWithMissingInventory(
                                                                _model
                                                                    .transactions
                                                                    .toList(),
                                                                _model
                                                                    .inventories
                                                                    .toList())
                                                            ?.goods
                                                            .length !=
                                                        _model
                                                            .loopTransactionCounter) {
                                                      if (functions.goodThatCannotBeFoundInInventory(
                                                          _model.inventories
                                                              .toList(),
                                                          functions
                                                              .transactionWithMissingInventory(
                                                                  _model
                                                                      .transactions
                                                                      .toList(),
                                                                  _model
                                                                      .inventories
                                                                      .toList())!
                                                              .goods[_model.loopTransactionCounter])) {
                                                        await showModalBottomSheet(
                                                          isScrollControlled:
                                                              true,
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          context: context,
                                                          builder: (context) {
                                                            return GestureDetector(
                                                              onTap: () => _model
                                                                      .unfocusNode
                                                                      .canRequestFocus
                                                                  ? FocusScope.of(
                                                                          context)
                                                                      .requestFocus(
                                                                          _model
                                                                              .unfocusNode)
                                                                  : FocusScope.of(
                                                                          context)
                                                                      .unfocus(),
                                                              child: Padding(
                                                                padding: MediaQuery
                                                                    .viewInsetsOf(
                                                                        context),
                                                                child:
                                                                    SizedBox(
                                                                  height: double
                                                                      .infinity,
                                                                  child:
                                                                      MissingInventoryWidget(
                                                                    description: functions
                                                                        .transactionWithMissingInventory(
                                                                            _model.transactions
                                                                                .toList(),
                                                                            _model.inventories
                                                                                .toList())!
                                                                        .goods[_model
                                                                            .loopTransactionCounter]
                                                                        .description,
                                                                    quantity: functions
                                                                        .transactionWithMissingInventory(
                                                                            _model.transactions
                                                                                .toList(),
                                                                            _model.inventories
                                                                                .toList())!
                                                                        .goods[_model
                                                                            .loopTransactionCounter]
                                                                        .quantity,
                                                                    transaction: functions.transactionWithMissingInventory(
                                                                        _model
                                                                            .transactions
                                                                            .toList(),
                                                                        _model
                                                                            .inventories
                                                                            .toList())!,
                                                                    remittanceRef:
                                                                        mainCardRemittancesRecord
                                                                            .reference,
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        ).then((value) =>
                                                            safeSetState(
                                                                () {}));

                                                        break;
                                                      }
                                                      // increment loop
                                                      setState(() {
                                                        _model.loopTransactionCounter =
                                                            _model.loopTransactionCounter +
                                                                1;
                                                      });
                                                    }
                                                  }

                                                  setState(() {});
                                                },
                                                text: 'Load Shareable PDF',
                                                options: FFButtonOptions(
                                                  width: double.infinity,
                                                  height: 50.0,
                                                  padding: const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 0.0, 0.0, 0.0),
                                                  iconPadding:
                                                      const EdgeInsetsDirectional
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
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                  elevation: 2.0,
                                                  borderSide: const BorderSide(
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
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 0.0, 16.0, 0.0),
                                            child: SizedBox(
                                              width: double.infinity,
                                              height: 50.0,
                                              child: custom_widgets
                                                  .PrintRemittance(
                                                width: double.infinity,
                                                height: 50.0,
                                                remittance:
                                                    mainCardRemittancesRecord,
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
                                                                .collectedBy !=
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
