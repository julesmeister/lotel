import '/backend/backend.dart';
import '/components/forms/salary_edit/salary_edit_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_charts.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'metrics_model.dart';
export 'metrics_model.dart';

class MetricsWidget extends StatefulWidget {
  const MetricsWidget({super.key});

  @override
  State<MetricsWidget> createState() => _MetricsWidgetState();
}

class _MetricsWidgetState extends State<MetricsWidget>
    with TickerProviderStateMixin {
  late MetricsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MetricsModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (FFAppState().statsReference != null) {
        // if this stat is correct
        _model.alreadyStats =
            await StatsRecord.getDocumentOnce(FFAppState().statsReference!);
        if (_model.alreadyStats?.month != functions.currentMonth()) {
          // latest Stats
          _model.latestStats = await queryStatsRecordOnce(
            queryBuilder: (statsRecord) => statsRecord
                .where(
                  'month',
                  isEqualTo: functions.currentMonth(),
                )
                .where(
                  'year',
                  isEqualTo: functions.currentYear(),
                )
                .where(
                  'hotel',
                  isEqualTo: FFAppState().hotel,
                ),
            singleRecord: true,
          ).then((s) => s.firstOrNull);
          if (_model.latestStats != null) {
            // set latest stat reference app state
            FFAppState().statsReference = _model.latestStats?.reference;
            setState(() {});
          } else {
            // clear stats reference
            FFAppState().statsReference = null;
            setState(() {});
            // create a new blank stat
            await action_blocks.createNewStats(context);
            setState(() {});
          }
        }
      }
      // hide month picker
      _model.showMonthPicker = false;
      _model.month = functions.currentMonth();
      _model.year = functions.currentYear();
      setState(() {});
      await _model.updateStatsByDate(
        context,
        year: functions.currentYear(),
        month: functions.currentMonth(),
        hotel: FFAppState().hotel,
      );
      setState(() {});
      // show month picker
      _model.showMonthPicker = true;
      setState(() {});
    });

    animationsMap.addAll({
      'containerOnPageLoadAnimation1': AnimationInfo(
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
      'containerOnPageLoadAnimation2': AnimationInfo(
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
      'columnOnPageLoadAnimation1': AnimationInfo(
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
      'containerOnPageLoadAnimation3': AnimationInfo(
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
            begin: const Offset(30.0, 0.0),
            end: const Offset(0.0, 0.0),
          ),
        ],
      ),
      'containerOnPageLoadAnimation4': AnimationInfo(
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
            begin: const Offset(30.0, 0.0),
            end: const Offset(0.0, 0.0),
          ),
        ],
      ),
      'containerOnPageLoadAnimation5': AnimationInfo(
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
            begin: const Offset(30.0, 0.0),
            end: const Offset(0.0, 0.0),
          ),
        ],
      ),
      'columnOnPageLoadAnimation2': AnimationInfo(
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
      'containerOnPageLoadAnimation6': AnimationInfo(
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
            begin: const Offset(30.0, 0.0),
            end: const Offset(0.0, 0.0),
          ),
        ],
      ),
      'containerOnPageLoadAnimation7': AnimationInfo(
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
            begin: const Offset(30.0, 0.0),
            end: const Offset(0.0, 0.0),
          ),
        ],
      ),
      'containerOnPageLoadAnimation8': AnimationInfo(
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
            begin: const Offset(30.0, 0.0),
            end: const Offset(0.0, 0.0),
          ),
        ],
      ),
      'chartOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          BlurEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: const Offset(4.0, 4.0),
            end: const Offset(0.0, 0.0),
          ),
        ],
      ),
      'rowOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FlipEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 1.0,
            end: 2.0,
          ),
        ],
      ),
      'columnOnPageLoadAnimation3': AnimationInfo(
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
      'containerOnPageLoadAnimation9': AnimationInfo(
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
            begin: const Offset(30.0, 0.0),
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

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).info,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).info,
        automaticallyImplyLeading: false,
        leading: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30.0,
          borderWidth: 1.0,
          buttonSize: 60.0,
          icon: Icon(
            Icons.chevron_left,
            color: FlutterFlowTheme.of(context).primaryText,
            size: 30.0,
          ),
          onPressed: () async {
            context.pop();
          },
        ),
        title: Text(
          'Metrics',
          style: FlutterFlowTheme.of(context).headlineMedium.override(
                fontFamily: 'Outfit',
                color: FlutterFlowTheme.of(context).primaryText,
                fontSize: 22.0,
                letterSpacing: 0.0,
              ),
        ),
        actions: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                child: FlutterFlowIconButton(
                  borderRadius: 20.0,
                  borderWidth: 1.0,
                  buttonSize: 40.0,
                  icon: Icon(
                    Icons.stacked_line_chart,
                    color: FlutterFlowTheme.of(context).primaryText,
                    size: 24.0,
                  ),
                  onPressed: () async {
                    context.pushNamed(
                      'MetricsYearly',
                      extra: <String, dynamic>{
                        kTransitionInfoKey: const TransitionInfo(
                          hasTransition: true,
                          transitionType: PageTransitionType.rightToLeft,
                        ),
                      },
                    );
                  },
                ),
              ),
              if (_model.hotel != 'All')
                Align(
                  alignment: const AlignmentDirectional(0.0, 0.0),
                  child: Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 16.0, 0.0),
                    child: SizedBox(
                      width: 30.0,
                      height: 30.0,
                      child: custom_widgets.ShareStats(
                        width: 30.0,
                        height: 30.0,
                        stats: _model.stats[_model.hotel == 'All'
                            ? 0
                            : functions.indexOfStatsFromHotel(
                                _model.stats.toList(), _model.hotel)],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
        centerTitle: false,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Align(
                    alignment: const AlignmentDirectional(0.0, -1.0),
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 10.0),
                      child: Container(
                        width: double.infinity,
                        height: 50.0,
                        constraints: const BoxConstraints(
                          maxWidth: 500.0,
                        ),
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primaryBackground,
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
                              InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  _model.hotelName =
                                      await _model.updateStatsByHotel(
                                    context,
                                    hotel: 'All',
                                  );
                                  _model.hotel = _model.hotelName!;
                                  setState(() {});

                                  setState(() {});
                                },
                                child: Container(
                                  width: 50.0,
                                  height: 100.0,
                                  decoration: BoxDecoration(
                                    color: _model.hotel == 'All'
                                        ? FlutterFlowTheme.of(context)
                                            .secondaryBackground
                                        : FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(
                                      color: valueOrDefault<Color>(
                                        _model.hotel == 'All'
                                            ? FlutterFlowTheme.of(context)
                                                .alternate
                                            : FlutterFlowTheme.of(context)
                                                .primaryBackground,
                                        FlutterFlowTheme.of(context).alternate,
                                      ),
                                      width: 1.0,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            4.0, 0.0, 4.0, 0.0),
                                        child: Text(
                                          'All',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Readex Pro',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                      ),
                                    ],
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
                                    if (_model.stats.isNotEmpty) {
                                      _model.hotelName1 =
                                          await _model.updateStatsByHotel(
                                        context,
                                        hotel: 'Serenity',
                                      );
                                      // set hotel name
                                      _model.hotel = _model.hotelName1!;
                                      setState(() {});
                                    } else {
                                      // No data
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'No data to show!',
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
                                    }

                                    setState(() {});
                                  },
                                  child: Container(
                                    width: 115.0,
                                    height: 100.0,
                                    decoration: BoxDecoration(
                                      color: _model.hotel == 'Serenity'
                                          ? FlutterFlowTheme.of(context)
                                              .secondaryBackground
                                          : FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                      borderRadius: BorderRadius.circular(10.0),
                                      border: Border.all(
                                        color: _model.hotel == 'Serenity'
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
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  4.0, 0.0, 0.0, 0.0),
                                          child: AutoSizeText(
                                            'Serenity',
                                            maxLines: 1,
                                            minFontSize: 10.0,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Readex Pro',
                                                  color: FlutterFlowTheme.of(
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
                                    if (_model.stats.isNotEmpty) {
                                      _model.hotelName2 =
                                          await _model.updateStatsByHotel(
                                        context,
                                        hotel: 'My Lifestyle',
                                      );
                                      // set hotel
                                      _model.hotel = _model.hotelName2!;
                                      setState(() {});
                                    } else {
                                      // No data
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'No data to show!',
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
                                    }

                                    setState(() {});
                                  },
                                  child: Container(
                                    width: 115.0,
                                    height: 100.0,
                                    decoration: BoxDecoration(
                                      color: _model.hotel == 'My Lifestyle'
                                          ? FlutterFlowTheme.of(context)
                                              .secondaryBackground
                                          : FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                      borderRadius: BorderRadius.circular(10.0),
                                      border: Border.all(
                                        color: _model.hotel == 'My Lifestyle'
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
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  4.0, 0.0, 0.0, 0.0),
                                          child: AutoSizeText(
                                            'My Lifestyle',
                                            maxLines: 1,
                                            minFontSize: 10.0,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Readex Pro',
                                                  color: FlutterFlowTheme.of(
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
                      ).animateOnPageLoad(
                          animationsMap['containerOnPageLoadAnimation1']!),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FlutterFlowIconButton(
                  borderRadius: 20.0,
                  buttonSize: 60.0,
                  icon: Icon(
                    Icons.keyboard_arrow_left_outlined,
                    color: FlutterFlowTheme.of(context).primaryText,
                    size: 30.0,
                  ),
                  onPressed: () async {
                    // hide month picker
                    _model.showMonthPicker = false;
                    setState(() {});
                    // set previous year
                    _model.year =
                        functions.previousYear(_model.month, _model.year);
                    setState(() {});
                    // set previous month
                    _model.month = functions.previousMonth(_model.month);
                    setState(() {});
                    await _model.updateStatsByDate(
                      context,
                      year: _model.year,
                      month: _model.month,
                      hotel: FFAppState().hotel,
                    );
                    setState(() {});
                    // set hotel to all
                    _model.hotel = 'All';
                    setState(() {});
                    // show month picker
                    _model.showMonthPicker = true;
                    setState(() {});
                  },
                ),
                if (_model.showMonthPicker)
                  custom_widgets.MonthPicker(
                    width: MediaQuery.sizeOf(context).width * 0.6,
                    height: 60.0,
                    initialMonth: ((String month) {
                      return {
                        'January': 1,
                        'February': 2,
                        'March': 3,
                        'April': 4,
                        'May': 5,
                        'June': 6,
                        'July': 7,
                        'August': 8,
                        'September': 9,
                        'October': 10,
                        'November': 11,
                        'December': 12,
                      }[month];
                    }(_model.month))!,
                    initialYear: int.parse(_model.year),
                    changeMonthYear: (month, year) async {
                      // hide month picker
                      _model.showMonthPicker = false;
                      _model.month = ((int month) {
                        return {
                          1: 'January',
                          2: 'February',
                          3: 'March',
                          4: 'April',
                          5: 'May',
                          6: 'June',
                          7: 'July',
                          8: 'August',
                          9: 'September',
                          10: 'October',
                          11: 'November',
                          12: 'December',
                        }[month];
                      }(month))!;
                      _model.year = year.toString();
                      setState(() {});
                      // get stats from this month
                      await _model.updateStatsByDate(
                        context,
                        year: year.toString(),
                        month: (int month) {
                          return {
                            1: 'January',
                            2: 'February',
                            3: 'March',
                            4: 'April',
                            5: 'May',
                            6: 'June',
                            7: 'July',
                            8: 'August',
                            9: 'September',
                            10: 'October',
                            11: 'November',
                            12: 'December',
                          }[month];
                        }(month),
                        hotel: FFAppState().hotel,
                      );
                      setState(() {});
                      // show month picker
                      _model.showMonthPicker = true;
                      setState(() {});
                      // set hotel to all
                      _model.hotel = 'All';
                      setState(() {});
                    },
                  ).animateOnPageLoad(
                      animationsMap['containerOnPageLoadAnimation2']!),
                FlutterFlowIconButton(
                  borderColor: Colors.transparent,
                  borderRadius: 20.0,
                  buttonSize: 60.0,
                  icon: Icon(
                    Icons.keyboard_arrow_right_outlined,
                    color: FlutterFlowTheme.of(context).primaryText,
                    size: 30.0,
                  ),
                  onPressed: () async {
                    // hide month picker
                    _model.showMonthPicker = false;
                    setState(() {});
                    // next Year
                    _model.year = functions.nextYear(_model.year, _model.month);
                    setState(() {});
                    // next month
                    _model.month = functions.nextMonth(_model.month);
                    setState(() {});
                    await _model.updateStatsByDate(
                      context,
                      year: _model.year,
                      month: _model.month,
                      hotel: FFAppState().hotel,
                    );
                    setState(() {});
                    // set hotel to all
                    _model.hotel = 'All';
                    setState(() {});
                    // show month picker
                    _model.showMonthPicker = true;
                    setState(() {});
                  },
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 6,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 12.0, 12.0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onDoubleTap: () async {
                              if (_model.hotel != 'All') {
                                var confirmDialogResponse =
                                    await showDialog<bool>(
                                          context: context,
                                          builder: (alertDialogContext) {
                                            return AlertDialog(
                                              title: const Text('Recalibrate'),
                                              content: const Text(
                                                  'This will recalculate all room sales of this month from this establishment.'),
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
                                  // reset loop and temp
                                  _model.loopCounter = 0;
                                  _model.transactionsTemp = [];
                                  setState(() {});
                                  // remittance first day of month
                                  _model.remittanceForRooms =
                                      await queryRemittancesRecordOnce(
                                    queryBuilder: (remittancesRecord) =>
                                        remittancesRecord
                                            .where(
                                              'hotel',
                                              isEqualTo: _model.hotel,
                                            )
                                            .where(
                                              'date',
                                              isGreaterThanOrEqualTo:
                                                  functions.startOfDay(
                                                      functions.startOfMonth(
                                                          _model.month,
                                                          _model.year)),
                                            )
                                            .where(
                                              'date',
                                              isLessThanOrEqualTo:
                                                  functions.endOfDay(
                                                      functions.startOfMonth(
                                                          _model.month,
                                                          _model.year)),
                                            ),
                                    singleRecord: true,
                                  ).then((s) => s.firstOrNull);
                                  while (_model.loopCounter !=
                                      _model.remittanceForRooms?.transactions
                                          .length) {
                                    // transactionFromRemittanceGoods
                                    _model.transactionFromRemittanceRooms =
                                        await TransactionsRecord
                                            .getDocumentOnce(_model
                                                    .remittanceForRooms!
                                                    .transactions[
                                                _model.loopCounter]);
                                    if (_model.transactionFromRemittanceRooms
                                            ?.type ==
                                        'book') {
                                      // add to temp
                                      _model.addToTransactionsTemp(_model
                                          .transactionFromRemittanceRooms!);
                                      setState(() {});
                                    }
                                    // + loop
                                    _model.loopCounter = _model.loopCounter + 1;
                                    setState(() {});
                                  }
                                  // room  sales
                                  _model.roomSales =
                                      await queryTransactionsRecordOnce(
                                    queryBuilder: (transactionsRecord) =>
                                        transactionsRecord
                                            .where(
                                              'hotel',
                                              isEqualTo: _model.hotel,
                                            )
                                            .where(
                                              'type',
                                              isEqualTo: 'book',
                                            )
                                            .where(
                                              'remitted',
                                              isEqualTo: true,
                                            )
                                            .where(
                                              'date',
                                              isGreaterThanOrEqualTo:
                                                  functions.startOfMonth(
                                                      _model.month,
                                                      _model.year),
                                            )
                                            .where(
                                              'date',
                                              isLessThanOrEqualTo:
                                                  functions.endOfMonth(
                                                      _model.month,
                                                      _model.year),
                                            ),
                                  );
                                  // set room income of this stats ref

                                  await _model.statsRef!
                                      .update(createStatsRecordData(
                                    roomsIncome: functions.sumOfRoomsIncome(
                                        functions
                                            .mergeTransactions(
                                                _model.roomSales!.toList(),
                                                _model.transactionsTemp
                                                    .toList())
                                            .toList()),
                                  ));
                                  await _model.updateStatsByDate(
                                    context,
                                    year: _model.year,
                                    month: _model.month,
                                    hotel: FFAppState().hotel,
                                  );
                                  setState(() {});
                                  // set hotel to all
                                  _model.hotel = 'All';
                                  setState(() {});
                                }
                              }

                              setState(() {});
                            },
                            child: Container(
                              width: 230.0,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 4.0,
                                    color: Color(0x34090F13),
                                    offset: Offset(
                                      0.0,
                                      1.0,
                                    ),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 4.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: (String change) {
                                          return change.contains("-");
                                        }(functions.metricChange(
                                                _model.rooms,
                                                'rooms',
                                                _model.prevMetrics.toList(),
                                                _model.hotel))
                                            ? FlutterFlowTheme.of(context).error
                                            : FlutterFlowTheme.of(context)
                                                .secondary,
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(0.0),
                                          bottomRight: Radius.circular(0.0),
                                          topLeft: Radius.circular(12.0),
                                          topRight: Radius.circular(12.0),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            AutoSizeText(
                                              formatNumber(
                                                _model.rooms,
                                                formatType: FormatType.decimal,
                                                decimalType:
                                                    DecimalType.automatic,
                                                currency: 'P ',
                                              ),
                                              maxLines: 1,
                                              minFontSize: 14.0,
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .titleMedium
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        color: Colors.white,
                                                        fontSize: 20.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                            ),
                                            AutoSizeText(
                                              'Rooms Income',
                                              maxLines: 1,
                                              minFontSize: 10.0,
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .titleSmall
                                                  .override(
                                                    fontFamily: 'Readex Pro',
                                                    color: Colors.white,
                                                    fontSize: 14.0,
                                                    letterSpacing: 1.0,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 10.0, 0.0, 0.0),
                                              child: AutoSizeText(
                                                formatNumber(
                                                  functions.avgYData(_model
                                                      .roomLine!.yData
                                                      .toList()),
                                                  formatType:
                                                      FormatType.decimal,
                                                  decimalType:
                                                      DecimalType.automatic,
                                                  currency: 'P ',
                                                ),
                                                maxLines: 1,
                                                minFontSize: 14.0,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .titleMedium
                                                        .override(
                                                          fontFamily:
                                                              'Readex Pro',
                                                          color: Colors.white,
                                                          fontSize: 20.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                              ),
                                            ),
                                            AutoSizeText(
                                              'Daily Average',
                                              maxLines: 1,
                                              minFontSize: 10.0,
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .labelMedium
                                                  .override(
                                                    fontFamily: 'Readex Pro',
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    fontSize: 14.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 36.0,
                                            height: 36.0,
                                            decoration: BoxDecoration(
                                              color: (String change) {
                                                return change.contains("-");
                                              }(functions.metricChange(
                                                      _model.rooms,
                                                      'rooms',
                                                      _model.prevMetrics
                                                          .toList(),
                                                      _model.hotel))
                                                  ? FlutterFlowTheme.of(context)
                                                      .error
                                                  : FlutterFlowTheme.of(context)
                                                      .secondary,
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                            ),
                                            alignment:
                                                const AlignmentDirectional(0.0, 0.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                if ((String change) {
                                                  return change.contains("-");
                                                }(functions.metricChange(
                                                    _model.rooms,
                                                    'rooms',
                                                    _model.prevMetrics.toList(),
                                                    _model.hotel)))
                                                  const FaIcon(
                                                    FontAwesomeIcons.caretDown,
                                                    color: Colors.white,
                                                    size: 20.0,
                                                  ),
                                                if (!((String change) {
                                                  return change.contains("-");
                                                }(functions.metricChange(
                                                    _model.rooms,
                                                    'rooms',
                                                    _model.prevMetrics.toList(),
                                                    _model.hotel))))
                                                  const FaIcon(
                                                    FontAwesomeIcons.caretUp,
                                                    color: Colors.white,
                                                    size: 20.0,
                                                  ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 8.0, 0.0),
                                            child: Text(
                                              functions.metricChange(
                                                  _model.rooms,
                                                  'rooms',
                                                  _model.prevMetrics.toList(),
                                                  _model.hotel),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Readex Pro',
                                                    color: const Color(0xFF14181B),
                                                    fontSize: 14.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
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
                          ).animateOnPageLoad(
                              animationsMap['containerOnPageLoadAnimation3']!),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 12.0, 12.0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onDoubleTap: () async {
                              if (_model.hotel != 'All') {
                                var confirmDialogResponse =
                                    await showDialog<bool>(
                                          context: context,
                                          builder: (alertDialogContext) {
                                            return AlertDialog(
                                              title: const Text('Recalibrate'),
                                              content: const Text(
                                                  'This will recalculate all expenses of this month from this establishment.'),
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
                                  // reset loop and temp
                                  _model.loopCounter = 0;
                                  _model.transactionsTemp = [];
                                  setState(() {});
                                  // remittance first day of month
                                  _model.remittanceForExpenses =
                                      await queryRemittancesRecordOnce(
                                    queryBuilder: (remittancesRecord) =>
                                        remittancesRecord
                                            .where(
                                              'hotel',
                                              isEqualTo: _model.hotel,
                                            )
                                            .where(
                                              'date',
                                              isGreaterThanOrEqualTo:
                                                  functions.startOfDay(
                                                      functions.startOfMonth(
                                                          _model.month,
                                                          _model.year)),
                                            )
                                            .where(
                                              'date',
                                              isLessThanOrEqualTo:
                                                  functions.endOfDay(
                                                      functions.startOfMonth(
                                                          _model.month,
                                                          _model.year)),
                                            ),
                                    singleRecord: true,
                                  ).then((s) => s.firstOrNull);
                                  while (_model.loopCounter !=
                                      _model.remittanceForExpenses?.transactions
                                          .length) {
                                    // transactionFromRemittanceGoods
                                    _model.transactionFromRemittanceExpenses =
                                        await TransactionsRecord
                                            .getDocumentOnce(_model
                                                    .remittanceForExpenses!
                                                    .transactions[
                                                _model.loopCounter]);
                                    if (_model.transactionFromRemittanceExpenses
                                            ?.type ==
                                        'expense') {
                                      // add to temp
                                      _model.addToTransactionsTemp(_model
                                          .transactionFromRemittanceExpenses!);
                                      setState(() {});
                                    }
                                    // + loop
                                    _model.loopCounter = _model.loopCounter + 1;
                                    setState(() {});
                                  }
                                  // expenses recalculate
                                  _model.expensesRecalculate =
                                      await queryTransactionsRecordOnce(
                                    queryBuilder: (transactionsRecord) =>
                                        transactionsRecord
                                            .where(
                                              'hotel',
                                              isEqualTo: _model.hotel,
                                            )
                                            .where(
                                              'type',
                                              isEqualTo: 'expense',
                                            )
                                            .where(
                                              'remitted',
                                              isEqualTo: true,
                                            )
                                            .where(
                                              'date',
                                              isGreaterThanOrEqualTo:
                                                  functions.startOfMonth(
                                                      _model.month,
                                                      _model.year),
                                            )
                                            .where(
                                              'date',
                                              isLessThanOrEqualTo:
                                                  functions.endOfMonth(
                                                      _model.month,
                                                      _model.year),
                                            ),
                                  );
                                  // set expenses of this stats ref

                                  await _model.statsRef!
                                      .update(createStatsRecordData(
                                    expenses: functions.sumOfExpenses(functions
                                        .mergeTransactions(
                                            _model.expensesRecalculate!
                                                .toList(),
                                            _model.transactionsTemp.toList())
                                        .toList()),
                                  ));
                                  await _model.updateStatsByDate(
                                    context,
                                    year: _model.year,
                                    month: _model.month,
                                    hotel: FFAppState().hotel,
                                  );
                                  setState(() {});
                                  // set hotel to all
                                  _model.hotel = 'All';
                                  setState(() {});
                                }
                              }

                              setState(() {});
                            },
                            child: Container(
                              width: 230.0,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 4.0,
                                    color: Color(0x34090F13),
                                    offset: Offset(
                                      0.0,
                                      1.0,
                                    ),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 4.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: (String change) {
                                          return change.contains("-");
                                        }(functions.metricChange(
                                                _model.expenses,
                                                'expenses',
                                                _model.prevMetrics.toList(),
                                                _model.hotel))
                                            ? FlutterFlowTheme.of(context).error
                                            : FlutterFlowTheme.of(context)
                                                .secondary,
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(0.0),
                                          bottomRight: Radius.circular(0.0),
                                          topLeft: Radius.circular(12.0),
                                          topRight: Radius.circular(12.0),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            AutoSizeText(
                                              formatNumber(
                                                _model.expenses,
                                                formatType: FormatType.decimal,
                                                decimalType:
                                                    DecimalType.automatic,
                                                currency: 'P ',
                                              ),
                                              maxLines: 1,
                                              minFontSize: 14.0,
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .titleMedium
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        color: Colors.white,
                                                        fontSize: 20.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                            ),
                                            Text(
                                              'Expenses',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .titleSmall
                                                  .override(
                                                    fontFamily: 'Readex Pro',
                                                    color: Colors.white,
                                                    fontSize: 14.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 36.0,
                                            height: 36.0,
                                            decoration: BoxDecoration(
                                              color: (String change) {
                                                return change.contains("-");
                                              }(functions.metricChange(
                                                      _model.expenses,
                                                      'expenses',
                                                      _model.prevMetrics
                                                          .toList(),
                                                      _model.hotel))
                                                  ? FlutterFlowTheme.of(context)
                                                      .error
                                                  : FlutterFlowTheme.of(context)
                                                      .secondary,
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                            ),
                                            alignment:
                                                const AlignmentDirectional(0.0, 0.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                if ((String change) {
                                                  return change.contains("-");
                                                }(functions.metricChange(
                                                    _model.expenses,
                                                    'expenses',
                                                    _model.prevMetrics.toList(),
                                                    _model.hotel)))
                                                  const FaIcon(
                                                    FontAwesomeIcons.caretDown,
                                                    color: Colors.white,
                                                    size: 20.0,
                                                  ),
                                                if (!((String change) {
                                                  return change.contains("-");
                                                }(functions.metricChange(
                                                    _model.expenses,
                                                    'expenses',
                                                    _model.prevMetrics.toList(),
                                                    _model.hotel))))
                                                  const FaIcon(
                                                    FontAwesomeIcons.caretUp,
                                                    color: Colors.white,
                                                    size: 20.0,
                                                  ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 8.0, 0.0),
                                            child: Text(
                                              functions.metricChange(
                                                  _model.expenses,
                                                  'expenses',
                                                  _model.prevMetrics.toList(),
                                                  _model.hotel),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Readex Pro',
                                                    color: const Color(0xFF14181B),
                                                    fontSize: 14.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
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
                          ).animateOnPageLoad(
                              animationsMap['containerOnPageLoadAnimation4']!),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 12.0, 12.0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onDoubleTap: () async {
                              if (_model.hotel != 'All') {
                                var confirmDialogResponse =
                                    await showDialog<bool>(
                                          context: context,
                                          builder: (alertDialogContext) {
                                            return AlertDialog(
                                              title: const Text('Recalculate Bills'),
                                              content: const Text(
                                                  'This will redo the calculation of the bills for this month.'),
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
                                  // bills this month
                                  _model.billsThisMonth =
                                      await queryBillsRecordOnce(
                                    queryBuilder: (billsRecord) => billsRecord
                                        .where(
                                          'hotel',
                                          isEqualTo: _model.hotel,
                                        )
                                        .where(
                                          'date',
                                          isGreaterThanOrEqualTo:
                                              functions.startOfMonth(
                                                  _model.month, _model.year),
                                        )
                                        .where(
                                          'date',
                                          isLessThanOrEqualTo:
                                              functions.endOfMonth(
                                                  _model.month, _model.year),
                                        ),
                                  );
                                  // update bills

                                  await _model.statsRef!
                                      .update(createStatsRecordData(
                                    bills: valueOrDefault<double>(
                                      functions.sumOfBills(
                                          _model.billsThisMonth!.toList()),
                                      0.0,
                                    ),
                                  ));
                                  await _model.updateStatsByDate(
                                    context,
                                    year: _model.year,
                                    month: _model.month,
                                    hotel: FFAppState().hotel,
                                  );
                                  setState(() {});
                                  // set hotel to all
                                  _model.hotel = 'All';
                                  setState(() {});
                                  // recalculated
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Bills for this month have been recalculated for this month\'s metric total.',
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
                              }

                              setState(() {});
                            },
                            child: Container(
                              width: 230.0,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 4.0,
                                    color: Color(0x34090F13),
                                    offset: Offset(
                                      0.0,
                                      1.0,
                                    ),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 4.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: (String change) {
                                          return change.contains("-");
                                        }(functions.metricChange(
                                                _model.bills,
                                                'bills',
                                                _model.prevMetrics.toList(),
                                                _model.hotel))
                                            ? FlutterFlowTheme.of(context).error
                                            : FlutterFlowTheme.of(context)
                                                .secondary,
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(0.0),
                                          bottomRight: Radius.circular(0.0),
                                          topLeft: Radius.circular(12.0),
                                          topRight: Radius.circular(12.0),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            AutoSizeText(
                                              formatNumber(
                                                _model.bills,
                                                formatType: FormatType.decimal,
                                                decimalType:
                                                    DecimalType.automatic,
                                                currency: 'P ',
                                              ),
                                              maxLines: 1,
                                              minFontSize: 14.0,
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .titleMedium
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        color: Colors.white,
                                                        fontSize: 20.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                            ),
                                            Text(
                                              'Bills',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .titleSmall
                                                  .override(
                                                    fontFamily: 'Readex Pro',
                                                    color: Colors.white,
                                                    fontSize: 14.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 36.0,
                                            height: 36.0,
                                            decoration: BoxDecoration(
                                              color: (String change) {
                                                return change.contains("-");
                                              }(functions.metricChange(
                                                      _model.bills,
                                                      'bills',
                                                      _model.prevMetrics
                                                          .toList(),
                                                      _model.hotel))
                                                  ? FlutterFlowTheme.of(context)
                                                      .error
                                                  : FlutterFlowTheme.of(context)
                                                      .secondary,
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                            ),
                                            alignment:
                                                const AlignmentDirectional(0.0, 0.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                if ((String change) {
                                                  return change.contains("-");
                                                }(functions.metricChange(
                                                    _model.bills,
                                                    'bills',
                                                    _model.prevMetrics.toList(),
                                                    _model.hotel)))
                                                  const FaIcon(
                                                    FontAwesomeIcons.caretDown,
                                                    color: Colors.white,
                                                    size: 20.0,
                                                  ),
                                                if (!((String change) {
                                                  return change.contains("-");
                                                }(functions.metricChange(
                                                    _model.bills,
                                                    'bills',
                                                    _model.prevMetrics.toList(),
                                                    _model.hotel))))
                                                  const FaIcon(
                                                    FontAwesomeIcons.caretUp,
                                                    color: Colors.white,
                                                    size: 20.0,
                                                  ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 8.0, 0.0),
                                            child: Text(
                                              functions.metricChange(
                                                  _model.bills,
                                                  'bills',
                                                  _model.prevMetrics.toList(),
                                                  _model.hotel),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Readex Pro',
                                                    color: const Color(0xFF14181B),
                                                    fontSize: 14.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
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
                          ).animateOnPageLoad(
                              animationsMap['containerOnPageLoadAnimation5']!),
                        ),
                      ],
                    ).animateOnPageLoad(
                        animationsMap['columnOnPageLoadAnimation1']!),
                  ),
                  Expanded(
                    flex: 6,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 16.0, 12.0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onDoubleTap: () async {
                              if (_model.hotel != 'All') {
                                var confirmDialogResponse =
                                    await showDialog<bool>(
                                          context: context,
                                          builder: (alertDialogContext) {
                                            return AlertDialog(
                                              title: const Text('Recalibrate'),
                                              content: const Text(
                                                  'This will recalculate all goods sales of this month from this establishment.'),
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
                                  // reset loop and temp
                                  _model.loopCounter = 0;
                                  _model.transactionsTemp = [];
                                  setState(() {});
                                  // remittance first day of month
                                  _model.remittanceForGoods =
                                      await queryRemittancesRecordOnce(
                                    queryBuilder: (remittancesRecord) =>
                                        remittancesRecord
                                            .where(
                                              'hotel',
                                              isEqualTo: _model.hotel,
                                            )
                                            .where(
                                              'date',
                                              isGreaterThanOrEqualTo:
                                                  functions.startOfDay(
                                                      functions.startOfMonth(
                                                          _model.month,
                                                          _model.year)),
                                            )
                                            .where(
                                              'date',
                                              isLessThanOrEqualTo:
                                                  functions.endOfDay(
                                                      functions.startOfMonth(
                                                          _model.month,
                                                          _model.year)),
                                            ),
                                    singleRecord: true,
                                  ).then((s) => s.firstOrNull);
                                  while (_model.loopCounter !=
                                      _model.remittanceForGoods?.transactions
                                          .length) {
                                    // transactionFromRemittanceGoods
                                    _model.transactionFromRemittanceGoods =
                                        await TransactionsRecord
                                            .getDocumentOnce(_model
                                                    .remittanceForGoods!
                                                    .transactions[
                                                _model.loopCounter]);
                                    if (_model.transactionFromRemittanceGoods
                                            ?.type ==
                                        'goods') {
                                      // add to temp
                                      _model.addToTransactionsTemp(_model
                                          .transactionFromRemittanceGoods!);
                                      setState(() {});
                                    }
                                    // + loop
                                    _model.loopCounter = _model.loopCounter + 1;
                                    setState(() {});
                                  }
                                  // goods sales
                                  _model.goodSales =
                                      await queryTransactionsRecordOnce(
                                    queryBuilder: (transactionsRecord) =>
                                        transactionsRecord
                                            .where(
                                              'hotel',
                                              isEqualTo: _model.hotel,
                                            )
                                            .where(
                                              'type',
                                              isEqualTo: 'goods',
                                            )
                                            .where(
                                              'remitted',
                                              isEqualTo: true,
                                            )
                                            .where(
                                              'date',
                                              isGreaterThanOrEqualTo:
                                                  functions.startOfMonth(
                                                      _model.month,
                                                      _model.year),
                                            )
                                            .where(
                                              'date',
                                              isLessThanOrEqualTo:
                                                  functions.endOfMonth(
                                                      _model.month,
                                                      _model.year),
                                            ),
                                  );
                                  // set goods income of this stats ref

                                  await _model.statsRef!
                                      .update(createStatsRecordData(
                                    goodsIncome: functions.sumOfGoodsIncome(
                                        functions
                                            .mergeTransactions(
                                                _model.goodSales!.toList(),
                                                _model.transactionsTemp
                                                    .toList())
                                            .toList()),
                                  ));
                                  await _model.updateStatsByDate(
                                    context,
                                    year: _model.year,
                                    month: _model.month,
                                    hotel: FFAppState().hotel,
                                  );
                                  setState(() {});
                                  // set hotel to all
                                  _model.hotel = 'All';
                                  setState(() {});
                                }
                              }

                              setState(() {});
                            },
                            child: Container(
                              width: 230.0,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 4.0,
                                    color: Color(0x34090F13),
                                    offset: Offset(
                                      0.0,
                                      1.0,
                                    ),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 4.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: (String change) {
                                          return change.contains("-");
                                        }(functions.metricChange(
                                                _model.goods,
                                                'goods',
                                                _model.prevMetrics.toList(),
                                                _model.hotel))
                                            ? FlutterFlowTheme.of(context).error
                                            : FlutterFlowTheme.of(context)
                                                .secondary,
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(0.0),
                                          bottomRight: Radius.circular(0.0),
                                          topLeft: Radius.circular(12.0),
                                          topRight: Radius.circular(12.0),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            AutoSizeText(
                                              formatNumber(
                                                _model.goods,
                                                formatType: FormatType.decimal,
                                                decimalType:
                                                    DecimalType.automatic,
                                                currency: 'P ',
                                              ),
                                              maxLines: 1,
                                              minFontSize: 14.0,
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .titleMedium
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        color: Colors.white,
                                                        fontSize: 20.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                            ),
                                            AutoSizeText(
                                              'Goods Income',
                                              maxLines: 1,
                                              minFontSize: 10.0,
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .titleSmall
                                                  .override(
                                                    fontFamily: 'Readex Pro',
                                                    color: Colors.white,
                                                    fontSize: 14.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 10.0, 0.0, 0.0),
                                              child: AutoSizeText(
                                                formatNumber(
                                                  functions.avgYData(_model
                                                      .goodsLine!.yData
                                                      .toList()),
                                                  formatType:
                                                      FormatType.decimal,
                                                  decimalType:
                                                      DecimalType.automatic,
                                                  currency: 'P ',
                                                ),
                                                maxLines: 1,
                                                minFontSize: 14.0,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .titleMedium
                                                        .override(
                                                          fontFamily:
                                                              'Readex Pro',
                                                          color: Colors.white,
                                                          fontSize: 20.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                              ),
                                            ),
                                            AutoSizeText(
                                              'Daily Average',
                                              maxLines: 1,
                                              minFontSize: 10.0,
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .labelMedium
                                                  .override(
                                                    fontFamily: 'Readex Pro',
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    fontSize: 14.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 36.0,
                                            height: 36.0,
                                            decoration: BoxDecoration(
                                              color: (String change) {
                                                return change.contains("-");
                                              }(functions.metricChange(
                                                      _model.goods,
                                                      'goods',
                                                      _model.prevMetrics
                                                          .toList(),
                                                      _model.hotel))
                                                  ? FlutterFlowTheme.of(context)
                                                      .error
                                                  : FlutterFlowTheme.of(context)
                                                      .secondary,
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                            ),
                                            alignment:
                                                const AlignmentDirectional(0.0, 0.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                if ((String change) {
                                                  return change.contains("-");
                                                }(functions.metricChange(
                                                    _model.goods,
                                                    'goods',
                                                    _model.prevMetrics.toList(),
                                                    _model.hotel)))
                                                  const FaIcon(
                                                    FontAwesomeIcons.caretDown,
                                                    color: Colors.white,
                                                    size: 20.0,
                                                  ),
                                                if (!((String change) {
                                                  return change.contains("-");
                                                }(functions.metricChange(
                                                    _model.goods,
                                                    'goods',
                                                    _model.prevMetrics.toList(),
                                                    _model.hotel))))
                                                  const FaIcon(
                                                    FontAwesomeIcons.caretUp,
                                                    color: Colors.white,
                                                    size: 20.0,
                                                  ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 8.0, 0.0),
                                            child: Text(
                                              functions.metricChange(
                                                  _model.goods,
                                                  'goods',
                                                  _model.prevMetrics.toList(),
                                                  _model.hotel),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Readex Pro',
                                                    color: const Color(0xFF14181B),
                                                    fontSize: 14.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
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
                          ).animateOnPageLoad(
                              animationsMap['containerOnPageLoadAnimation6']!),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 16.0, 12.0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              if (_model.hotel != 'All') {
                                await showModalBottomSheet(
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  enableDrag: false,
                                  useSafeArea: true,
                                  context: context,
                                  builder: (context) {
                                    return Padding(
                                      padding: MediaQuery.viewInsetsOf(context),
                                      child: SizedBox(
                                        height: double.infinity,
                                        child: SalaryEditWidget(
                                          stats: _model.stat,
                                        ),
                                      ),
                                    );
                                  },
                                ).then((value) => safeSetState(
                                    () => _model.salaryEdited = value));

                                if (_model.salaryEdited != null) {
                                  await _model.updateStatsByDate(
                                    context,
                                    year: _model.year,
                                    month: _model.month,
                                    hotel: FFAppState().hotel,
                                  );
                                  setState(() {});
                                  // set hotel to all
                                  _model.hotel = 'All';
                                  setState(() {});
                                }
                              }

                              setState(() {});
                            },
                            child: Container(
                              width: 230.0,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 4.0,
                                    color: Color(0x34090F13),
                                    offset: Offset(
                                      0.0,
                                      1.0,
                                    ),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 4.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: (String change) {
                                          return change.contains("-");
                                        }(functions.metricChange(
                                                _model.salaries,
                                                'salaries',
                                                _model.prevMetrics.toList(),
                                                _model.hotel))
                                            ? FlutterFlowTheme.of(context).error
                                            : FlutterFlowTheme.of(context)
                                                .secondary,
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(0.0),
                                          bottomRight: Radius.circular(0.0),
                                          topLeft: Radius.circular(12.0),
                                          topRight: Radius.circular(12.0),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            AutoSizeText(
                                              formatNumber(
                                                _model.salaries,
                                                formatType: FormatType.decimal,
                                                decimalType:
                                                    DecimalType.automatic,
                                                currency: 'P ',
                                              ),
                                              maxLines: 1,
                                              minFontSize: 14.0,
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .titleMedium
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        color: Colors.white,
                                                        fontSize: 20.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                            ),
                                            Text(
                                              'Salaries',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .titleSmall
                                                  .override(
                                                    fontFamily: 'Readex Pro',
                                                    color: Colors.white,
                                                    fontSize: 14.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 36.0,
                                            height: 36.0,
                                            decoration: BoxDecoration(
                                              color: (String change) {
                                                return change.contains("-");
                                              }(functions.metricChange(
                                                      _model.salaries,
                                                      'salaries',
                                                      _model.prevMetrics
                                                          .toList(),
                                                      _model.hotel))
                                                  ? FlutterFlowTheme.of(context)
                                                      .error
                                                  : FlutterFlowTheme.of(context)
                                                      .secondary,
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                            ),
                                            alignment:
                                                const AlignmentDirectional(0.0, 0.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                if ((String change) {
                                                  return change.contains("-");
                                                }(functions.metricChange(
                                                    _model.salaries,
                                                    'salaries',
                                                    _model.prevMetrics.toList(),
                                                    _model.hotel)))
                                                  const FaIcon(
                                                    FontAwesomeIcons.caretDown,
                                                    color: Colors.white,
                                                    size: 20.0,
                                                  ),
                                                if (!((String change) {
                                                  return change.contains("-");
                                                }(functions.metricChange(
                                                    _model.salaries,
                                                    'salaries',
                                                    _model.prevMetrics.toList(),
                                                    _model.hotel))))
                                                  const FaIcon(
                                                    FontAwesomeIcons.caretUp,
                                                    color: Colors.white,
                                                    size: 20.0,
                                                  ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 8.0, 0.0),
                                            child: Text(
                                              functions.metricChange(
                                                  _model.salaries,
                                                  'salaries',
                                                  _model.prevMetrics.toList(),
                                                  _model.hotel),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Readex Pro',
                                                    color: const Color(0xFF14181B),
                                                    fontSize: 14.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
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
                          ).animateOnPageLoad(
                              animationsMap['containerOnPageLoadAnimation7']!),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 16.0, 12.0),
                          child: Container(
                            width: 230.0,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 4.0,
                                  color: Color(0x34090F13),
                                  offset: Offset(
                                    0.0,
                                    1.0,
                                  ),
                                )
                              ],
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 4.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: (String change) {
                                        return change.contains("-");
                                      }(functions.metricChange(
                                              _model.net,
                                              'net',
                                              _model.prevMetrics.toList(),
                                              _model.hotel))
                                          ? FlutterFlowTheme.of(context).error
                                          : FlutterFlowTheme.of(context)
                                              .secondary,
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(0.0),
                                        bottomRight: Radius.circular(0.0),
                                        topLeft: Radius.circular(12.0),
                                        topRight: Radius.circular(12.0),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AutoSizeText(
                                            formatNumber(
                                              _model.net,
                                              formatType: FormatType.decimal,
                                              decimalType:
                                                  DecimalType.automatic,
                                              currency: 'P ',
                                            ),
                                            maxLines: 1,
                                            minFontSize: 14.0,
                                            style: FlutterFlowTheme.of(context)
                                                .titleMedium
                                                .override(
                                                  fontFamily: 'Readex Pro',
                                                  color: Colors.white,
                                                  fontSize: 20.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                          ),
                                          Text(
                                            'Net',
                                            style: FlutterFlowTheme.of(context)
                                                .titleSmall
                                                .override(
                                                  fontFamily: 'Readex Pro',
                                                  color: Colors.white,
                                                  fontSize: 14.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 36.0,
                                          height: 36.0,
                                          decoration: BoxDecoration(
                                            color: (String change) {
                                              return change.contains("-");
                                            }(functions.metricChange(
                                                    _model.net,
                                                    'net',
                                                    _model.prevMetrics.toList(),
                                                    _model.hotel))
                                                ? FlutterFlowTheme.of(context)
                                                    .error
                                                : FlutterFlowTheme.of(context)
                                                    .secondary,
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                          alignment:
                                              const AlignmentDirectional(0.0, 0.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              if ((String change) {
                                                return change.contains("-");
                                              }(functions.metricChange(
                                                  _model.net,
                                                  'net',
                                                  _model.prevMetrics.toList(),
                                                  _model.hotel)))
                                                const FaIcon(
                                                  FontAwesomeIcons.caretDown,
                                                  color: Colors.white,
                                                  size: 20.0,
                                                ),
                                              if (!((String change) {
                                                return change.contains("-");
                                              }(functions.metricChange(
                                                  _model.net,
                                                  'net',
                                                  _model.prevMetrics.toList(),
                                                  _model.hotel))))
                                                const FaIcon(
                                                  FontAwesomeIcons.caretUp,
                                                  color: Colors.white,
                                                  size: 20.0,
                                                ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 8.0, 0.0),
                                          child: Text(
                                            functions.metricChange(
                                                _model.net,
                                                'net',
                                                _model.prevMetrics.toList(),
                                                _model.hotel),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Readex Pro',
                                                  color: const Color(0xFF14181B),
                                                  fontSize: 14.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ).animateOnPageLoad(
                              animationsMap['containerOnPageLoadAnimation8']!),
                        ),
                      ],
                    ).animateOnPageLoad(
                        animationsMap['columnOnPageLoadAnimation2']!),
                  ),
                ],
              ),
            ),
            if (_model.roomLine!.hasXData() &&
                _model.roomLine!.hasYData() &&
                (_model.stats.isNotEmpty))
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 200.0,
                  child: FlutterFlowLineChart(
                    data: [
                      FFLineChartData(
                        xData: _model.roomLine!.xData,
                        yData: _model.roomLine!.yData,
                        settings: LineChartBarData(
                          color: FlutterFlowTheme.of(context).warning,
                          barWidth: 2.0,
                          isCurved: true,
                          preventCurveOverShooting: true,
                          dotData: const FlDotData(show: false),
                          belowBarData: BarAreaData(
                            show: true,
                            color: const Color(0xFFFCF3D5),
                          ),
                        ),
                      ),
                      FFLineChartData(
                        xData: _model.goodsLine!.xData,
                        yData: _model.goodsLine!.yData,
                        settings: LineChartBarData(
                          color: FlutterFlowTheme.of(context).secondary,
                          barWidth: 2.0,
                          isCurved: true,
                          dotData: const FlDotData(show: false),
                          belowBarData: BarAreaData(
                            show: true,
                            color: FlutterFlowTheme.of(context).accent2,
                          ),
                        ),
                      )
                    ],
                    chartStylingInfo: ChartStylingInfo(
                      enableTooltip: true,
                      backgroundColor:
                          FlutterFlowTheme.of(context).secondaryBackground,
                      showBorder: false,
                    ),
                    axisBounds: const AxisBounds(),
                    xAxisLabelInfo: AxisLabelInfo(
                      title: 'Last 30 Days',
                      titleTextStyle:
                          FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Outfit',
                                fontSize: 14.0,
                                letterSpacing: 0.0,
                              ),
                      showLabels: true,
                      labelTextStyle: const TextStyle(
                        fontSize: 8.0,
                      ),
                      labelInterval: 1.0,
                      labelFormatter: LabelFormatter(
                        numberFormat: (val) => formatNumber(
                          val,
                          formatType: FormatType.custom,
                          format: '#',
                          locale: '',
                        ),
                      ),
                    ),
                    yAxisLabelInfo: AxisLabelInfo(
                      title: 'Check Ins',
                      titleTextStyle:
                          FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Outfit',
                                fontSize: 14.0,
                                letterSpacing: 0.0,
                              ),
                    ),
                  ),
                ).animateOnPageLoad(animationsMap['chartOnPageLoadAnimation']!),
              ),
            if (_model.stats.isNotEmpty)
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 12.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 12.0, 0.0),
                          child: Icon(
                            Icons.radio_button_checked,
                            color: FlutterFlowTheme.of(context).warning,
                            size: 16.0,
                          ),
                        ),
                        Text(
                          'Rooms',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Readex Pro',
                                    letterSpacing: 0.0,
                                  ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 12.0, 0.0),
                          child: Icon(
                            Icons.radio_button_checked,
                            color: FlutterFlowTheme.of(context).secondary,
                            size: 16.0,
                          ),
                        ),
                        Text(
                          'Goods',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Readex Pro',
                                    letterSpacing: 0.0,
                                  ),
                        ),
                      ],
                    ),
                  ],
                ).animateOnPageLoad(animationsMap['rowOnPageLoadAnimation']!),
              ),
            if ((_model.groceryExpenses != 0.0) && (_model.stats.isNotEmpty))
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 10.0),
                          child: Text(
                            'Grocery Profitability',
                            style: FlutterFlowTheme.of(context)
                                .titleLarge
                                .override(
                                  fontFamily: 'Outfit',
                                  color: const Color(0xFF14181B),
                                  fontSize: 22.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                        if (_model.stats.isNotEmpty)
                          Align(
                            alignment: const AlignmentDirectional(0.0, 0.0),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 10.0),
                              child: SizedBox(
                                width: double.infinity,
                                height: 400.0,
                                child: custom_widgets.GroceryProfitability(
                                  width: double.infinity,
                                  height: 400.0,
                                  grocery: _model.groceryExpenses,
                                  revenue: _model.goods,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ).animateOnPageLoad(
                        animationsMap['columnOnPageLoadAnimation3']!),
                  ),
                ),
              ),
            if (_model.hotel != 'All')
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 0.0),
                        child: Text(
                          'Room Usage',
                          textAlign: TextAlign.start,
                          style: FlutterFlowTheme.of(context)
                              .headlineMedium
                              .override(
                                fontFamily: 'Outfit',
                                letterSpacing: 0.0,
                              ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 20.0, 0.0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            // add missing
                            var confirmDialogResponse = await showDialog<bool>(
                                  context: context,
                                  builder: (alertDialogContext) {
                                    return AlertDialog(
                                      title: const Text('Check For Missing Rooms'),
                                      content: const Text(
                                          'This will go over all the rooms again, and it will add any if missing.'),
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
                              // stat to be refreshed
                              _model.statO = await queryStatsRecordOnce(
                                queryBuilder: (statsRecord) => statsRecord
                                    .where(
                                      'hotel',
                                      isEqualTo: _model.hotel,
                                    )
                                    .where(
                                      'month',
                                      isEqualTo: _model.month,
                                    )
                                    .where(
                                      'year',
                                      isEqualTo: _model.year,
                                    ),
                                singleRecord: true,
                              ).then((s) => s.firstOrNull);
                              // all rooms
                              _model.roomsCheck = await queryRoomsRecordOnce(
                                queryBuilder: (roomsRecord) =>
                                    roomsRecord.where(
                                  'hotel',
                                  isEqualTo: _model.hotel,
                                ),
                              );
                              if (_model.roomUsage.length !=
                                  _model.roomsCheck?.length) {
                                // update rooms

                                await _model.statO!.reference.update({
                                  ...mapToFirestore(
                                    {
                                      'roomUsage':
                                          getRoomUsageListFirestoreData(
                                        functions.refreshRoomsInStats(
                                            _model.roomUsage.toList(),
                                            _model.roomsCheck!.toList()),
                                      ),
                                    },
                                  ),
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'An amendment was successful!',
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
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'There\'s nothing to add!',
                                      style: TextStyle(
                                        color:
                                            FlutterFlowTheme.of(context).info,
                                      ),
                                    ),
                                    duration: const Duration(milliseconds: 4000),
                                    backgroundColor:
                                        FlutterFlowTheme.of(context).error,
                                  ),
                                );
                              }
                            }

                            setState(() {});
                          },
                          child: Icon(
                            Icons.refresh,
                            color: FlutterFlowTheme.of(context).secondary,
                            size: 24.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (_model.roomUsage.isNotEmpty)
                    Builder(
                      builder: (context) {
                        final roomUsages = functions
                            .highestRoomUtilityOrderUsage(
                                _model.roomUsage.toList())
                            .toList();

                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          primary: false,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: roomUsages.length,
                          itemBuilder: (context, roomUsagesIndex) {
                            final roomUsagesItem = roomUsages[roomUsagesIndex];
                            return Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  16.0, 12.0, 12.0, 12.0),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                      blurRadius: 4.0,
                                      color: Color(0x34090F13),
                                      offset: Offset(
                                        0.0,
                                        2.0,
                                      ),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 4.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        height: 50.0,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(0.0),
                                            bottomRight: Radius.circular(0.0),
                                            topLeft: Radius.circular(12.0),
                                            topRight: Radius.circular(12.0),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: 36.0,
                                                height: 36.0,
                                                decoration: BoxDecoration(
                                                  color: const Color(0x98FFFFFF),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                ),
                                                alignment: const AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: const Icon(
                                                  Icons.meeting_room_rounded,
                                                  color: Colors.white,
                                                  size: 20.0,
                                                ),
                                              ),
                                              Text(
                                                roomUsagesItem.number
                                                    .toString(),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .titleMedium
                                                        .override(
                                                          fontFamily:
                                                              'Readex Pro',
                                                          color: Colors.white,
                                                          fontSize: 18.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      ClipRRect(
                                        child: Container(
                                          width: double.infinity,
                                          height: 30.0,
                                          decoration: const BoxDecoration(),
                                          child: Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    12.0, 0.0, 12.0, 0.0),
                                            child: LinearPercentIndicator(
                                              percent: valueOrDefault<double>(
                                                functions.progressRoomUsage(
                                                    _model.roomUsage.toList(),
                                                    roomUsagesItem),
                                                0.0,
                                              ),
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.8,
                                              lineHeight: 12.0,
                                              animation: true,
                                              animateFromLastPercent: true,
                                              progressColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .accent4,
                                              barRadius: const Radius.circular(10.0),
                                              padding: EdgeInsets.zero,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ).animateOnPageLoad(animationsMap[
                                  'containerOnPageLoadAnimation9']!),
                            );
                          },
                        );
                      },
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
