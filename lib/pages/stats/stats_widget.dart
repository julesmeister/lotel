import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_charts.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
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
import 'stats_model.dart';
export 'stats_model.dart';

class StatsWidget extends StatefulWidget {
  const StatsWidget({Key? key}) : super(key: key);

  @override
  _StatsWidgetState createState() => _StatsWidgetState();
}

class _StatsWidgetState extends State<StatsWidget>
    with TickerProviderStateMixin {
  late StatsModel _model;

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
          begin: Offset(30.0, 0.0),
          end: Offset(0.0, 0.0),
        ),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => StatsModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      // count
      _model.initCount = await queryStatsRecordCount(
        queryBuilder: (statsRecord) => statsRecord
            .where(
              'month',
              isEqualTo: functions.currentMonth(),
            )
            .where(
              'year',
              isEqualTo: functions.currentYear(),
            ),
      );
      if (_model.initCount! > 0) {
        // get stats
        _model.currentStats = await queryStatsRecordOnce(
          queryBuilder: (statsRecord) => statsRecord
              .where(
                'month',
                isEqualTo: functions.currentMonth(),
              )
              .where(
                'year',
                isEqualTo: functions.currentYear(),
              ),
        );
        // initialize all stats
        setState(() {
          _model.stats = _model.currentStats!.toList().cast<StatsRecord>();
        });
        // initialize all page vars
        setState(() {
          _model.month = functions.currentMonth();
          _model.year = functions.currentYear();
          _model.expenses = _model.stats
                  .where((e) => e.hotel == 'Serenity')
                  .toList()
                  .first
                  .expenses +
              _model.stats
                  .where((e) => e.hotel == 'My Lifestyle')
                  .toList()
                  .first
                  .expenses;
          _model.salaries = _model.stats
                  .where((e) => e.hotel == 'Serenity')
                  .toList()
                  .first
                  .salaries +
              _model.stats
                  .where((e) => e.hotel == 'My Lifestyle')
                  .toList()
                  .first
                  .salaries;
          _model.goodsLine = functions.mergedLine(
              _model.stats
                  .where((e) => e.hotel == 'Serenity')
                  .toList()
                  .first
                  .goodsLine,
              _model.stats
                  .where((e) => e.hotel == 'My Lifestyle')
                  .toList()
                  .first
                  .goodsLine);
          _model.roomLine = functions.mergedLine(
              _model.stats
                  .where((e) => e.hotel == 'Serenity')
                  .toList()
                  .first
                  .roomLine,
              _model.stats
                  .where((e) => e.hotel == 'My Lifestyle')
                  .toList()
                  .first
                  .roomLine);
          _model.rooms = _model.stats
                  .where((e) => e.hotel == 'Serenity')
                  .toList()
                  .first
                  .roomsIncome +
              _model.stats
                  .where((e) => e.hotel == 'My Lifestyle')
                  .toList()
                  .first
                  .roomsIncome;
          _model.goods = _model.stats
                  .where((e) => e.hotel == 'Serenity')
                  .toList()
                  .first
                  .goodsIncome +
              _model.stats
                  .where((e) => e.hotel == 'My Lifestyle')
                  .toList()
                  .first
                  .goodsIncome;
          _model.groceryExpenses = _model.stats
                  .where((e) => e.hotel == 'Serenity')
                  .toList()
                  .first
                  .groceryExpenses +
              _model.stats
                  .where((e) => e.hotel == 'My Lifestyle')
                  .toList()
                  .first
                  .groceryExpenses;
          _model.bills = _model.stats
                  .where((e) => e.hotel == 'Serenity')
                  .toList()
                  .first
                  .bills +
              _model.stats
                  .where((e) => e.hotel == 'My Lifestyle')
                  .toList()
                  .first
                  .bills;
        });
      } else {
        // no data yet
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'No data yet!',
              style: TextStyle(
                color: FlutterFlowTheme.of(context).info,
              ),
            ),
            duration: Duration(milliseconds: 4000),
            backgroundColor: FlutterFlowTheme.of(context).error,
          ),
        );
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
            Icons.arrow_back_rounded,
            color: FlutterFlowTheme.of(context).primaryText,
            size: 30.0,
          ),
          onPressed: () async {
            context.pop();
          },
        ),
        title: Text(
          'Stats',
          style: FlutterFlowTheme.of(context).headlineMedium.override(
                fontFamily: 'Outfit',
                color: FlutterFlowTheme.of(context).primaryText,
                fontSize: 22.0,
              ),
        ),
        actions: [
          Visibility(
            visible: _model.hotel != 'All',
            child: Align(
              alignment: AlignmentDirectional(0.00, 0.00),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 16.0, 0.0),
                child: Container(
                  width: 30.0,
                  height: 30.0,
                  child: custom_widgets.ShareStats(
                    width: 30.0,
                    height: 30.0,
                    stats: _model.stats
                        .where((e) => e.hotel == _model.hotel)
                        .toList()
                        .first,
                  ),
                ),
              ),
            ),
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
                    alignment: AlignmentDirectional(0.00, -1.00),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 16.0),
                      child: Container(
                        width: double.infinity,
                        height: 50.0,
                        constraints: BoxConstraints(
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
                                    // initialize all page vars
                                    setState(() {
                                      _model.month = functions.currentMonth();
                                      _model.year = functions.currentYear();
                                      _model.expenses = _model.stats
                                              .where(
                                                  (e) => e.hotel == 'Serenity')
                                              .toList()
                                              .first
                                              .expenses +
                                          _model.stats
                                              .where((e) =>
                                                  e.hotel == 'My Lifestyle')
                                              .toList()
                                              .first
                                              .expenses;
                                      _model.salaries = _model.stats
                                              .where(
                                                  (e) => e.hotel == 'Serenity')
                                              .toList()
                                              .first
                                              .salaries +
                                          _model.stats
                                              .where((e) =>
                                                  e.hotel == 'My Lifestyle')
                                              .toList()
                                              .first
                                              .salaries;
                                      _model.goodsLine = functions.mergedLine(
                                          _model.stats
                                              .where(
                                                  (e) => e.hotel == 'Serenity')
                                              .toList()
                                              .first
                                              .goodsLine,
                                          _model.stats
                                              .where((e) =>
                                                  e.hotel == 'My Lifestyle')
                                              .toList()
                                              .first
                                              .goodsLine);
                                      _model.roomLine = functions.mergedLine(
                                          _model.stats
                                              .where(
                                                  (e) => e.hotel == 'Serenity')
                                              .toList()
                                              .first
                                              .roomLine,
                                          _model.stats
                                              .where((e) =>
                                                  e.hotel == 'My Lifestyle')
                                              .toList()
                                              .first
                                              .roomLine);
                                      _model.rooms = _model.stats
                                              .where(
                                                  (e) => e.hotel == 'Serenity')
                                              .toList()
                                              .first
                                              .roomsIncome +
                                          _model.stats
                                              .where((e) =>
                                                  e.hotel == 'My Lifestyle')
                                              .toList()
                                              .first
                                              .roomsIncome;
                                      _model.goods = _model.stats
                                              .where(
                                                  (e) => e.hotel == 'Serenity')
                                              .toList()
                                              .first
                                              .goodsIncome +
                                          _model.stats
                                              .where((e) =>
                                                  e.hotel == 'My Lifestyle')
                                              .toList()
                                              .first
                                              .goodsIncome;
                                      _model.hotel = 'All';
                                      _model.groceryExpenses = _model.stats
                                              .where(
                                                  (e) => e.hotel == 'Serenity')
                                              .toList()
                                              .first
                                              .groceryExpenses +
                                          _model.stats
                                              .where((e) =>
                                                  e.hotel == 'My Lifestyle')
                                              .toList()
                                              .first
                                              .groceryExpenses;
                                      _model.bills = _model.stats
                                              .where(
                                                  (e) => e.hotel == 'Serenity')
                                              .toList()
                                              .first
                                              .bills +
                                          _model.stats
                                              .where((e) =>
                                                  e.hotel == 'My Lifestyle')
                                              .toList()
                                              .first
                                              .bills;
                                    });
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
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  4.0, 0.0, 0.0, 0.0),
                                          child: Text(
                                            'All',
                                            style: FlutterFlowTheme.of(context)
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
                                    // initialize all page vars
                                    setState(() {
                                      _model.month = functions.currentMonth();
                                      _model.year = functions.currentYear();
                                      _model.expenses = _model.stats
                                          .where((e) => e.hotel == 'Serenity')
                                          .toList()
                                          .first
                                          .expenses;
                                      _model.salaries = _model.stats
                                          .where((e) => e.hotel == 'Serenity')
                                          .toList()
                                          .first
                                          .salaries;
                                      _model.roomUsage = functions
                                          .extractRoomUsage(_model.stats
                                              .where(
                                                  (e) => e.hotel == 'Serenity')
                                              .toList()
                                              .first)
                                          .toList()
                                          .cast<RoomUsageStruct>();
                                      _model.goodsLine = _model.stats
                                          .where((e) => e.hotel == 'Serenity')
                                          .toList()
                                          .first
                                          .goodsLine;
                                      _model.roomLine = _model.stats
                                          .where((e) => e.hotel == 'Serenity')
                                          .toList()
                                          .first
                                          .roomLine;
                                      _model.rooms = _model.stats
                                          .where((e) => e.hotel == 'Serenity')
                                          .toList()
                                          .first
                                          .roomsIncome;
                                      _model.goods = _model.stats
                                          .where((e) => e.hotel == 'Serenity')
                                          .toList()
                                          .first
                                          .goodsIncome;
                                      _model.statsRef = _model.stats
                                          .where((e) => e.hotel == 'Serenity')
                                          .toList()
                                          .first
                                          .reference;
                                      _model.hotel = 'Serenity';
                                      _model.net = _model.stats
                                              .where(
                                                  (e) => e.hotel == 'Serenity')
                                              .toList()
                                              .first
                                              .roomsIncome +
                                          _model.stats
                                              .where(
                                                  (e) => e.hotel == 'Serenity')
                                              .toList()
                                              .first
                                              .goodsIncome -
                                          _model.stats
                                              .where(
                                                  (e) => e.hotel == 'Serenity')
                                              .toList()
                                              .first
                                              .salaries -
                                          _model.stats
                                              .where(
                                                  (e) => e.hotel == 'Serenity')
                                              .toList()
                                              .first
                                              .expenses;
                                      _model.groceryExpenses = _model.stats
                                          .where((e) => e.hotel == 'Serenity')
                                          .toList()
                                          .first
                                          .groceryExpenses;
                                      _model.bills = _model.stats
                                          .where((e) => e.hotel == 'Serenity')
                                          .toList()
                                          .first
                                          .bills;
                                    });
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
                                              EdgeInsetsDirectional.fromSTEB(
                                                  4.0, 0.0, 0.0, 0.0),
                                          child: Text(
                                            'Serenity',
                                            style: FlutterFlowTheme.of(context)
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
                                    // initialize all page vars
                                    setState(() {
                                      _model.month = functions.currentMonth();
                                      _model.year = functions.currentYear();
                                      _model.expenses = _model.stats
                                          .where(
                                              (e) => e.hotel == 'My Lifestyle')
                                          .toList()
                                          .first
                                          .expenses;
                                      _model.salaries = _model.stats
                                          .where(
                                              (e) => e.hotel == 'My Lifestyle')
                                          .toList()
                                          .first
                                          .salaries;
                                      _model.roomUsage = functions
                                          .extractRoomUsage(_model.stats
                                              .where((e) =>
                                                  e.hotel == 'My Lifestyle')
                                              .toList()
                                              .first)
                                          .toList()
                                          .cast<RoomUsageStruct>();
                                      _model.goodsLine = _model.stats
                                          .where(
                                              (e) => e.hotel == 'My Lifestyle')
                                          .toList()
                                          .first
                                          .goodsLine;
                                      _model.roomLine = _model.stats
                                          .where(
                                              (e) => e.hotel == 'My Lifestyle')
                                          .toList()
                                          .first
                                          .roomLine;
                                      _model.rooms = _model.stats
                                          .where(
                                              (e) => e.hotel == 'My Lifestyle')
                                          .toList()
                                          .first
                                          .roomsIncome;
                                      _model.goods = _model.stats
                                          .where(
                                              (e) => e.hotel == 'My Lifestyle')
                                          .toList()
                                          .first
                                          .goodsIncome;
                                      _model.statsRef = _model.stats
                                          .where(
                                              (e) => e.hotel == 'My Lifestyle')
                                          .toList()
                                          .first
                                          .reference;
                                      _model.net = _model.stats
                                              .where((e) =>
                                                  e.hotel == 'My Lifestyle')
                                              .toList()
                                              .first
                                              .roomsIncome +
                                          _model.stats
                                              .where((e) =>
                                                  e.hotel == 'My Lifestyle')
                                              .toList()
                                              .first
                                              .goodsIncome -
                                          _model.stats
                                              .where((e) =>
                                                  e.hotel == 'My Lifestyle')
                                              .toList()
                                              .first
                                              .salaries -
                                          _model.stats
                                              .where((e) =>
                                                  e.hotel == 'My Lifestyle')
                                              .toList()
                                              .first
                                              .expenses;
                                      _model.hotel = 'My Lifestyle';
                                      _model.groceryExpenses = _model.stats
                                          .where(
                                              (e) => e.hotel == 'My Lifestyle')
                                          .toList()
                                          .first
                                          .groceryExpenses;
                                      _model.bills = _model.stats
                                          .where(
                                              (e) => e.hotel == 'My Lifestyle')
                                          .toList()
                                          .first
                                          .bills;
                                    });
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
                                              EdgeInsetsDirectional.fromSTEB(
                                                  4.0, 0.0, 0.0, 0.0),
                                          child: Text(
                                            'My Lifestyle',
                                            style: FlutterFlowTheme.of(context)
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
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                if (functions.listOfMonths().length > 0)
                  FlutterFlowDropDown<String>(
                    controller: _model.monthValueController ??=
                        FormFieldController<String>(
                      _model.monthValue ??= functions.currentMonth(),
                    ),
                    options: functions.listOfMonths(),
                    onChanged: (val) async {
                      setState(() => _model.monthValue = val); // count
                      _model.initStatsCountCopy = await queryStatsRecordCount(
                        queryBuilder: (statsRecord) => statsRecord
                            .where(
                              'month',
                              isEqualTo: _model.monthValue,
                            )
                            .where(
                              'year',
                              isEqualTo: _model.yearValue,
                            )
                            .where(
                              'hotel',
                              isEqualTo: FFAppState().hotel,
                            ),
                      );
                      if (_model.initStatsCountCopy! > 0) {
                        // get stats
                        _model.foundMonthDoc = await queryStatsRecordOnce(
                          queryBuilder: (statsRecord) => statsRecord
                              .where(
                                'month',
                                isEqualTo: _model.monthValue,
                              )
                              .where(
                                'year',
                                isEqualTo: _model.yearValue,
                              ),
                        );
                        // initialize all stats
                        setState(() {
                          _model.stats = _model.foundMonthDoc!
                              .toList()
                              .cast<StatsRecord>();
                        });
                        // initialize all page vars
                        setState(() {
                          _model.month = functions.currentMonth();
                          _model.year = functions.currentYear();
                          _model.expenses = _model.stats
                                  .where((e) => e.hotel == 'Serenity')
                                  .toList()
                                  .first
                                  .expenses +
                              _model.stats
                                  .where((e) => e.hotel == 'My Lifestyle')
                                  .toList()
                                  .first
                                  .expenses;
                          _model.salaries = _model.stats
                                  .where((e) => e.hotel == 'Serenity')
                                  .toList()
                                  .first
                                  .salaries +
                              _model.stats
                                  .where((e) => e.hotel == 'My Lifestyle')
                                  .toList()
                                  .first
                                  .salaries;
                          _model.goodsLine = functions.mergedLine(
                              _model.stats
                                  .where((e) => e.hotel == 'Serenity')
                                  .toList()
                                  .first
                                  .goodsLine,
                              _model.stats
                                  .where((e) => e.hotel == 'My Lifestyle')
                                  .toList()
                                  .first
                                  .goodsLine);
                          _model.roomLine = functions.mergedLine(
                              _model.stats
                                  .where((e) => e.hotel == 'Serenity')
                                  .toList()
                                  .first
                                  .roomLine,
                              _model.stats
                                  .where((e) => e.hotel == 'My Lifestyle')
                                  .toList()
                                  .first
                                  .roomLine);
                          _model.rooms = _model.stats
                                  .where((e) => e.hotel == 'Serenity')
                                  .toList()
                                  .first
                                  .roomsIncome +
                              _model.stats
                                  .where((e) => e.hotel == 'My Lifestyle')
                                  .toList()
                                  .first
                                  .roomsIncome;
                          _model.goods = _model.stats
                                  .where((e) => e.hotel == 'Serenity')
                                  .toList()
                                  .first
                                  .goodsIncome +
                              _model.stats
                                  .where((e) => e.hotel == 'My Lifestyle')
                                  .toList()
                                  .first
                                  .goodsIncome;
                          _model.hotel = 'All';
                          _model.groceryExpenses = _model.stats
                                  .where((e) => e.hotel == 'Serenity')
                                  .toList()
                                  .first
                                  .groceryExpenses +
                              _model.stats
                                  .where((e) => e.hotel == 'My Lifestyle')
                                  .toList()
                                  .first
                                  .groceryExpenses;
                          _model.bills = _model.stats
                                  .where((e) => e.hotel == 'Serenity')
                                  .toList()
                                  .first
                                  .bills +
                              _model.stats
                                  .where((e) => e.hotel == 'My Lifestyle')
                                  .toList()
                                  .first
                                  .bills;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Showing stats of ${_model.monthValue} ${_model.yearValue}',
                              style: TextStyle(
                                color: FlutterFlowTheme.of(context).primaryText,
                              ),
                            ),
                            duration: Duration(milliseconds: 4000),
                            backgroundColor:
                                FlutterFlowTheme.of(context).secondary,
                          ),
                        );
                      } else {
                        // no data yet
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'No data yet!',
                              style: TextStyle(
                                color: FlutterFlowTheme.of(context).info,
                              ),
                            ),
                            duration: Duration(milliseconds: 4000),
                            backgroundColor: FlutterFlowTheme.of(context).error,
                          ),
                        );
                      }

                      setState(() {});
                    },
                    width: 200.0,
                    height: 50.0,
                    textStyle: FlutterFlowTheme.of(context).bodyMedium,
                    hintText: 'Month',
                    icon: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: FlutterFlowTheme.of(context).secondaryText,
                      size: 24.0,
                    ),
                    fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                    elevation: 2.0,
                    borderColor: FlutterFlowTheme.of(context).alternate,
                    borderWidth: 2.0,
                    borderRadius: 8.0,
                    margin:
                        EdgeInsetsDirectional.fromSTEB(16.0, 4.0, 16.0, 4.0),
                    hidesUnderline: true,
                    isSearchable: false,
                    isMultiSelect: false,
                  ),
                if (functions.listOfYears().length > 0)
                  FlutterFlowDropDown<String>(
                    controller: _model.yearValueController ??=
                        FormFieldController<String>(
                      _model.yearValue ??= functions.currentYear(),
                    ),
                    options: functions.listOfYears(),
                    onChanged: (val) async {
                      setState(() => _model.yearValue = val); // count
                      _model.initStatsCountCopyCopy =
                          await queryStatsRecordCount(
                        queryBuilder: (statsRecord) => statsRecord
                            .where(
                              'month',
                              isEqualTo: _model.monthValue,
                            )
                            .where(
                              'year',
                              isEqualTo: _model.yearValue,
                            )
                            .where(
                              'hotel',
                              isEqualTo: FFAppState().hotel,
                            ),
                      );
                      if (_model.initStatsCountCopyCopy! > 0) {
                        // get stats
                        _model.foundYearDoc = await queryStatsRecordOnce(
                          queryBuilder: (statsRecord) => statsRecord
                              .where(
                                'month',
                                isEqualTo: _model.monthValue,
                              )
                              .where(
                                'year',
                                isEqualTo: _model.yearValue,
                              ),
                        );
                        // initialize all stats
                        setState(() {
                          _model.stats =
                              _model.foundYearDoc!.toList().cast<StatsRecord>();
                        });
                        // initialize all page vars
                        setState(() {
                          _model.month = functions.currentMonth();
                          _model.year = functions.currentYear();
                          _model.expenses = _model.stats
                                  .where((e) => e.hotel == 'Serenity')
                                  .toList()
                                  .first
                                  .expenses +
                              _model.stats
                                  .where((e) => e.hotel == 'My Lifestyle')
                                  .toList()
                                  .first
                                  .expenses;
                          _model.salaries = _model.stats
                                  .where((e) => e.hotel == 'Serenity')
                                  .toList()
                                  .first
                                  .salaries +
                              _model.stats
                                  .where((e) => e.hotel == 'My Lifestyle')
                                  .toList()
                                  .first
                                  .salaries;
                          _model.goodsLine = functions.mergedLine(
                              _model.stats
                                  .where((e) => e.hotel == 'Serenity')
                                  .toList()
                                  .first
                                  .goodsLine,
                              _model.stats
                                  .where((e) => e.hotel == 'My Lifestyle')
                                  .toList()
                                  .first
                                  .goodsLine);
                          _model.roomLine = functions.mergedLine(
                              _model.stats
                                  .where((e) => e.hotel == 'Serenity')
                                  .toList()
                                  .first
                                  .roomLine,
                              _model.stats
                                  .where((e) => e.hotel == 'My Lifestyle')
                                  .toList()
                                  .first
                                  .roomLine);
                          _model.rooms = _model.stats
                                  .where((e) => e.hotel == 'Serenity')
                                  .toList()
                                  .first
                                  .roomsIncome +
                              _model.stats
                                  .where((e) => e.hotel == 'My Lifestyle')
                                  .toList()
                                  .first
                                  .roomsIncome;
                          _model.goods = _model.stats
                                  .where((e) => e.hotel == 'Serenity')
                                  .toList()
                                  .first
                                  .goodsIncome +
                              _model.stats
                                  .where((e) => e.hotel == 'My Lifestyle')
                                  .toList()
                                  .first
                                  .goodsIncome;
                          _model.hotel = 'All';
                          _model.groceryExpenses = _model.stats
                                  .where((e) => e.hotel == 'Serenity')
                                  .toList()
                                  .first
                                  .groceryExpenses +
                              _model.stats
                                  .where((e) => e.hotel == 'My Lifestyle')
                                  .toList()
                                  .first
                                  .groceryExpenses;
                          _model.bills = _model.stats
                                  .where((e) => e.hotel == 'Serenity')
                                  .toList()
                                  .first
                                  .bills +
                              _model.stats
                                  .where((e) => e.hotel == 'My Lifestyle')
                                  .toList()
                                  .first
                                  .bills;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Showing stats of ${_model.month} ${_model.year}',
                              style: TextStyle(
                                color: FlutterFlowTheme.of(context).primaryText,
                              ),
                            ),
                            duration: Duration(milliseconds: 4000),
                            backgroundColor:
                                FlutterFlowTheme.of(context).secondary,
                          ),
                        );
                      } else {
                        // no data yet
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'No data yet!',
                              style: TextStyle(
                                color: FlutterFlowTheme.of(context).info,
                              ),
                            ),
                            duration: Duration(milliseconds: 4000),
                            backgroundColor: FlutterFlowTheme.of(context).error,
                          ),
                        );
                      }

                      setState(() {});
                    },
                    width: 130.0,
                    height: 50.0,
                    textStyle: FlutterFlowTheme.of(context).bodyMedium,
                    hintText: 'Year',
                    icon: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: FlutterFlowTheme.of(context).secondaryText,
                      size: 24.0,
                    ),
                    fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                    elevation: 2.0,
                    borderColor: FlutterFlowTheme.of(context).alternate,
                    borderWidth: 2.0,
                    borderRadius: 8.0,
                    margin:
                        EdgeInsetsDirectional.fromSTEB(16.0, 4.0, 16.0, 4.0),
                    hidesUnderline: true,
                    isSearchable: false,
                    isMultiSelect: false,
                  ),
              ],
            ),
            Align(
              alignment: AlignmentDirectional(-1.00, 0.00),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 4.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0.0, 12.0, 0.0, 12.0),
                        child: Container(
                          height: 120.0,
                          constraints: BoxConstraints(
                            maxWidth: 270.0,
                          ),
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(
                              color: FlutterFlowTheme.of(context).alternate,
                              width: 1.0,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 16.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 16.0, 0.0),
                                  child: Icon(
                                    Icons.trending_up_rounded,
                                    color:
                                        FlutterFlowTheme.of(context).secondary,
                                    size: 32.0,
                                  ),
                                ),
                                Flexible(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Rooms Income',
                                        style: FlutterFlowTheme.of(context)
                                            .labelMedium,
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 4.0, 4.0, 0.0),
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onDoubleTap: () async {
                                                  var _shouldSetState = false;
                                                  if (_model.hotel != 'All') {
                                                    var confirmDialogResponse =
                                                        await showDialog<bool>(
                                                              context: context,
                                                              builder:
                                                                  (alertDialogContext) {
                                                                return AlertDialog(
                                                                  title: Text(
                                                                      'Update Stats'),
                                                                  content: Text(
                                                                      'This will recalculate all transactions under room bookings.'),
                                                                  actions: [
                                                                    TextButton(
                                                                      onPressed: () => Navigator.pop(
                                                                          alertDialogContext,
                                                                          false),
                                                                      child: Text(
                                                                          'Cancel'),
                                                                    ),
                                                                    TextButton(
                                                                      onPressed: () => Navigator.pop(
                                                                          alertDialogContext,
                                                                          true),
                                                                      child: Text(
                                                                          'Confirm'),
                                                                    ),
                                                                  ],
                                                                );
                                                              },
                                                            ) ??
                                                            false;
                                                    if (confirmDialogResponse) {
                                                      _model.bookingTransactionsOnly =
                                                          await queryTransactionsRecordOnce(
                                                        queryBuilder:
                                                            (transactionsRecord) =>
                                                                transactionsRecord
                                                                    .where(
                                                                      'hotel',
                                                                      isEqualTo:
                                                                          _model
                                                                              .hotel,
                                                                    )
                                                                    .where(
                                                                      'date',
                                                                      isGreaterThan:
                                                                          functions
                                                                              .startOfMonth(_model.month),
                                                                    )
                                                                    .where(
                                                                      'type',
                                                                      isEqualTo:
                                                                          'book',
                                                                    )
                                                                    .where(
                                                                      'pending',
                                                                      isEqualTo:
                                                                          false,
                                                                    )
                                                                    .where(
                                                                      'remitted',
                                                                      isEqualTo:
                                                                          true,
                                                                    ),
                                                      );
                                                      _shouldSetState = true;
                                                      // upate rooms income var
                                                      setState(() {
                                                        _model.rooms = functions
                                                            .sumOfRoomsIncome(_model
                                                                .bookingTransactionsOnly!
                                                                .toList());
                                                      });
                                                      // update stats room income

                                                      await _model.statsRef!.update(
                                                          createStatsRecordData(
                                                        roomsIncome:
                                                            _model.rooms,
                                                      ));
                                                    }
                                                  } else {
                                                    if (_shouldSetState)
                                                      setState(() {});
                                                    return;
                                                  }

                                                  if (_shouldSetState)
                                                    setState(() {});
                                                },
                                                child: AutoSizeText(
                                                  formatNumber(
                                                    _model.rooms,
                                                    formatType:
                                                        FormatType.decimal,
                                                    decimalType:
                                                        DecimalType.automatic,
                                                    currency: 'P ',
                                                  ),
                                                  maxLines: 1,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .displaySmall
                                                      .override(
                                                        fontFamily: 'Outfit',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .warning,
                                                      ),
                                                  minFontSize: 30.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 5.0, 0.0, 0.0),
                                        child: AutoSizeText(
                                          'Daily Average: Php ${formatNumber(
                                            functions.avgYData(_model
                                                .roomLine!.yData
                                                .toList()),
                                            formatType: FormatType.decimal,
                                            decimalType: DecimalType.automatic,
                                          )}',
                                          maxLines: 1,
                                          style: FlutterFlowTheme.of(context)
                                              .labelMedium,
                                          minFontSize: 10.0,
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
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0.0, 12.0, 0.0, 12.0),
                        child: Container(
                          height: 120.0,
                          constraints: BoxConstraints(
                            maxWidth: 270.0,
                          ),
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(
                              color: FlutterFlowTheme.of(context).alternate,
                              width: 1.0,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 16.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 16.0, 0.0),
                                  child: Icon(
                                    Icons.trending_up_rounded,
                                    color:
                                        FlutterFlowTheme.of(context).secondary,
                                    size: 32.0,
                                  ),
                                ),
                                Flexible(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Goods Income',
                                        style: FlutterFlowTheme.of(context)
                                            .labelMedium,
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 4.0, 4.0, 0.0),
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onDoubleTap: () async {
                                                  var _shouldSetState = false;
                                                  if (_model.hotel != 'All') {
                                                    var confirmDialogResponse =
                                                        await showDialog<bool>(
                                                              context: context,
                                                              builder:
                                                                  (alertDialogContext) {
                                                                return AlertDialog(
                                                                  title: Text(
                                                                      'Update Stats'),
                                                                  content: Text(
                                                                      'This will recalculate all transactions under goods sold.'),
                                                                  actions: [
                                                                    TextButton(
                                                                      onPressed: () => Navigator.pop(
                                                                          alertDialogContext,
                                                                          false),
                                                                      child: Text(
                                                                          'Cancel'),
                                                                    ),
                                                                    TextButton(
                                                                      onPressed: () => Navigator.pop(
                                                                          alertDialogContext,
                                                                          true),
                                                                      child: Text(
                                                                          'Confirm'),
                                                                    ),
                                                                  ],
                                                                );
                                                              },
                                                            ) ??
                                                            false;
                                                    if (confirmDialogResponse) {
                                                      _model.goodsTransactionsOnly =
                                                          await queryTransactionsRecordOnce(
                                                        queryBuilder:
                                                            (transactionsRecord) =>
                                                                transactionsRecord
                                                                    .where(
                                                                      'hotel',
                                                                      isEqualTo:
                                                                          _model
                                                                              .hotel,
                                                                    )
                                                                    .where(
                                                                      'date',
                                                                      isGreaterThan:
                                                                          functions
                                                                              .startOfMonth(_model.month),
                                                                    )
                                                                    .where(
                                                                      'type',
                                                                      isEqualTo:
                                                                          'goods',
                                                                    ),
                                                      );
                                                      _shouldSetState = true;
                                                      // upate goods income var
                                                      setState(() {
                                                        _model.goods = functions
                                                            .sumOfGoodsIncome(_model
                                                                .goodsTransactionsOnly!
                                                                .toList());
                                                      });
                                                      // update stats room income

                                                      await _model.statsRef!.update(
                                                          createStatsRecordData(
                                                        goodsIncome:
                                                            _model.goods,
                                                      ));
                                                    }
                                                  } else {
                                                    if (_shouldSetState)
                                                      setState(() {});
                                                    return;
                                                  }

                                                  if (_shouldSetState)
                                                    setState(() {});
                                                },
                                                child: AutoSizeText(
                                                  formatNumber(
                                                    _model.goods,
                                                    formatType:
                                                        FormatType.decimal,
                                                    decimalType:
                                                        DecimalType.automatic,
                                                    currency: 'P ',
                                                  ),
                                                  maxLines: 1,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .displaySmall
                                                      .override(
                                                        fontFamily: 'Outfit',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondary,
                                                      ),
                                                  minFontSize: 30.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 5.0, 0.0, 0.0),
                                        child: Text(
                                          'Daily Average: Php ${formatNumber(
                                            functions.avgYData(_model
                                                .goodsLine!.yData
                                                .toList()),
                                            formatType: FormatType.decimal,
                                            decimalType: DecimalType.automatic,
                                          )}',
                                          style: FlutterFlowTheme.of(context)
                                              .labelMedium,
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
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0.0, 12.0, 0.0, 12.0),
                        child: Container(
                          height: 120.0,
                          constraints: BoxConstraints(
                            maxWidth: 270.0,
                          ),
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(
                              color: FlutterFlowTheme.of(context).alternate,
                              width: 1.0,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 16.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 16.0, 0.0),
                                  child: Icon(
                                    Icons.trending_up_rounded,
                                    color:
                                        FlutterFlowTheme.of(context).secondary,
                                    size: 32.0,
                                  ),
                                ),
                                Flexible(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Expenses',
                                        style: FlutterFlowTheme.of(context)
                                            .labelMedium,
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 4.0, 4.0, 0.0),
                                            child: InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onDoubleTap: () async {
                                                var _shouldSetState = false;
                                                if (_model.hotel != 'All') {
                                                  var confirmDialogResponse =
                                                      await showDialog<bool>(
                                                            context: context,
                                                            builder:
                                                                (alertDialogContext) {
                                                              return AlertDialog(
                                                                title: Text(
                                                                    'Update Stats'),
                                                                content: Text(
                                                                    'This will recalculate all transactions under expenses.'),
                                                                actions: [
                                                                  TextButton(
                                                                    onPressed: () =>
                                                                        Navigator.pop(
                                                                            alertDialogContext,
                                                                            false),
                                                                    child: Text(
                                                                        'Cancel'),
                                                                  ),
                                                                  TextButton(
                                                                    onPressed: () =>
                                                                        Navigator.pop(
                                                                            alertDialogContext,
                                                                            true),
                                                                    child: Text(
                                                                        'Confirm'),
                                                                  ),
                                                                ],
                                                              );
                                                            },
                                                          ) ??
                                                          false;
                                                  if (confirmDialogResponse) {
                                                    _model.expenseTransactionsOnly =
                                                        await queryTransactionsRecordOnce(
                                                      queryBuilder:
                                                          (transactionsRecord) =>
                                                              transactionsRecord
                                                                  .where(
                                                                    'hotel',
                                                                    isEqualTo:
                                                                        _model
                                                                            .hotel,
                                                                  )
                                                                  .where(
                                                                    'date',
                                                                    isGreaterThan:
                                                                        functions
                                                                            .startOfMonth(_model.month),
                                                                  )
                                                                  .where(
                                                                    'type',
                                                                    isEqualTo:
                                                                        'expense',
                                                                  ),
                                                    );
                                                    _shouldSetState = true;
                                                    // upate expense var
                                                    setState(() {
                                                      _model.expenses = functions
                                                          .sumOfExpenses(_model
                                                              .expenseTransactionsOnly!
                                                              .toList());
                                                    });
                                                    // update stats expense

                                                    await _model.statsRef!.update(
                                                        createStatsRecordData(
                                                      expenses: functions
                                                          .sumOfExpenses(_model
                                                              .expenseTransactionsOnly!
                                                              .toList()),
                                                    ));
                                                  }
                                                } else {
                                                  if (_shouldSetState)
                                                    setState(() {});
                                                  return;
                                                }

                                                if (_shouldSetState)
                                                  setState(() {});
                                              },
                                              child: AutoSizeText(
                                                formatNumber(
                                                  _model.expenses,
                                                  formatType:
                                                      FormatType.decimal,
                                                  decimalType:
                                                      DecimalType.automatic,
                                                  currency: 'P ',
                                                ),
                                                maxLines: 1,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .displaySmall,
                                                minFontSize: 30.0,
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
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0.0, 12.0, 0.0, 12.0),
                        child: Container(
                          height: 120.0,
                          constraints: BoxConstraints(
                            maxWidth: 270.0,
                          ),
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(
                              color: FlutterFlowTheme.of(context).alternate,
                              width: 1.0,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 16.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 16.0, 0.0),
                                  child: Icon(
                                    Icons.trending_up_rounded,
                                    color:
                                        FlutterFlowTheme.of(context).secondary,
                                    size: 32.0,
                                  ),
                                ),
                                Flexible(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Salaries',
                                        style: FlutterFlowTheme.of(context)
                                            .labelMedium,
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 4.0, 4.0, 0.0),
                                            child: Text(
                                              formatNumber(
                                                _model.salaries,
                                                formatType: FormatType.decimal,
                                                decimalType:
                                                    DecimalType.automatic,
                                                currency: 'P ',
                                              ).maybeHandleOverflow(
                                                  maxChars: 30),
                                              maxLines: 1,
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .displaySmall,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0.0, 12.0, 0.0, 12.0),
                        child: Container(
                          height: 120.0,
                          constraints: BoxConstraints(
                            maxWidth: 270.0,
                          ),
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(
                              color: FlutterFlowTheme.of(context).alternate,
                              width: 1.0,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 16.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 16.0, 0.0),
                                  child: Icon(
                                    Icons.trending_up_rounded,
                                    color:
                                        FlutterFlowTheme.of(context).secondary,
                                    size: 32.0,
                                  ),
                                ),
                                Flexible(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Bills',
                                        style: FlutterFlowTheme.of(context)
                                            .labelMedium,
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 4.0, 4.0, 0.0),
                                            child: Text(
                                              formatNumber(
                                                _model.salaries,
                                                formatType: FormatType.decimal,
                                                decimalType:
                                                    DecimalType.automatic,
                                                currency: 'P ',
                                              ).maybeHandleOverflow(
                                                  maxChars: 30),
                                              maxLines: 1,
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .displaySmall,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0.0, 12.0, 0.0, 12.0),
                        child: Container(
                          height: 120.0,
                          constraints: BoxConstraints(
                            maxWidth: 290.0,
                          ),
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(
                              color: FlutterFlowTheme.of(context).alternate,
                              width: 1.0,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 16.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 16.0, 0.0),
                                  child: Icon(
                                    Icons.trending_up_rounded,
                                    color:
                                        FlutterFlowTheme.of(context).secondary,
                                    size: 32.0,
                                  ),
                                ),
                                Flexible(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Net',
                                        style: FlutterFlowTheme.of(context)
                                            .labelMedium,
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 4.0, 4.0, 0.0),
                                            child: AutoSizeText(
                                              formatNumber(
                                                _model.rooms +
                                                    _model.goods -
                                                    _model.expenses -
                                                    _model.salaries -
                                                    _model.bills,
                                                formatType: FormatType.decimal,
                                                decimalType:
                                                    DecimalType.automatic,
                                                currency: 'P ',
                                              ),
                                              maxLines: 1,
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .displaySmall,
                                              minFontSize: 30.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ]
                        .divide(SizedBox(width: 16.0))
                        .addToStart(SizedBox(width: 16.0))
                        .addToEnd(SizedBox(width: 16.0)),
                  ),
                ),
              ),
            ),
            if (_model.roomLine!.hasXData() && _model.roomLine!.hasYData())
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
                child: Container(
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
                          dotData: FlDotData(show: false),
                          belowBarData: BarAreaData(
                            show: true,
                            color: Color(0xFFFCF3D5),
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
                          dotData: FlDotData(show: false),
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
                    axisBounds: AxisBounds(),
                    xAxisLabelInfo: AxisLabelInfo(
                      title: 'Last 30 Days',
                      titleTextStyle: FlutterFlowTheme.of(context).bodyMedium,
                    ),
                    yAxisLabelInfo: AxisLabelInfo(
                      title: 'Check Ins',
                      titleTextStyle: FlutterFlowTheme.of(context).bodyMedium,
                    ),
                  ),
                ),
              ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 12.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 12.0, 0.0),
                        child: Icon(
                          Icons.radio_button_checked,
                          color: FlutterFlowTheme.of(context).warning,
                          size: 16.0,
                        ),
                      ),
                      Text(
                        'Rooms',
                        style: FlutterFlowTheme.of(context).bodyMedium,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 12.0, 0.0),
                        child: Icon(
                          Icons.radio_button_checked,
                          color: FlutterFlowTheme.of(context).secondary,
                          size: 16.0,
                        ),
                      ),
                      Text(
                        'Goods',
                        style: FlutterFlowTheme.of(context).bodyMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(4.0, 4.0, 4.0, 4.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                        child: Text(
                          'Grocery Profitability',
                          style:
                              FlutterFlowTheme.of(context).titleLarge.override(
                                    fontFamily: 'Outfit',
                                    color: Color(0xFF14181B),
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0.00, 0.00),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 10.0),
                          child: Container(
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
                  ),
                ),
              ),
            ),
            if (_model.hotel != 'All')
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 0.0),
                        child: Text(
                          'Room Usage',
                          textAlign: TextAlign.start,
                          style: FlutterFlowTheme.of(context).headlineMedium,
                        ),
                      ),
                    ],
                  ),
                  if (_model.roomUsage.length > 0)
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
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 12.0, 12.0, 12.0),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 4.0,
                                      color: Color(0x34090F13),
                                      offset: Offset(0.0, 2.0),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
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
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(0.0),
                                            bottomRight: Radius.circular(0.0),
                                            topLeft: Radius.circular(12.0),
                                            topRight: Radius.circular(12.0),
                                          ),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  12.0, 12.0, 12.0, 12.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: 36.0,
                                                height: 36.0,
                                                decoration: BoxDecoration(
                                                  color: Color(0x98FFFFFF),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                ),
                                                alignment: AlignmentDirectional(
                                                    0.00, 0.00),
                                                child: Icon(
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
                                          decoration: BoxDecoration(),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
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
                                              barRadius: Radius.circular(10.0),
                                              padding: EdgeInsets.zero,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ).animateOnPageLoad(animationsMap[
                                  'containerOnPageLoadAnimation']!),
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
