import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/forms/change_date/change_date_widget.dart';
import '/components/forms/change_remittance/change_remittance_widget.dart';
import '/components/forms/extra_remittance/extra_remittance_widget.dart';
import '/components/forms/new_grocery/new_grocery_widget.dart';
import '/components/forms/new_issue/new_issue_widget.dart';
import '/components/forms/promo/promo_widget.dart';
import '/components/options/list_of_names/list_of_names_widget.dart';
import '/components/options/option_to_issue/option_to_issue_widget.dart';
import '/components/options/option_to_reasses/option_to_reasses_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/room/occupied/occupied_widget.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:badges/badges.dart' as badges;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'home_page_model.dart';
export 'home_page_model.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget>
    with TickerProviderStateMixin {
  late HomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  var hasTextTriggered1 = false;
  var hasTextTriggered2 = false;
  var hasTextTriggered3 = false;
  var hasTextTriggered4 = false;
  var hasTextTriggered5 = false;
  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      Function() navigate = () {};
      // last login of user
      _model.log = await queryLastLoginRecordOnce(
        parent: currentUserReference,
        queryBuilder: (lastLoginRecord) =>
            lastLoginRecord.orderBy('datetime', descending: true),
        singleRecord: true,
      ).then((s) => s.firstOrNull);
      // new date for last login

      await _model.log!.reference.update({
        ...mapToFirestore(
          {
            'datetime': FieldValue.serverTimestamp(),
          },
        ),
      });
      if (FFAppState().extPricePerHr == 0.0) {
        // hotel Settings
        _model.hotelSettingForLates = await queryHotelSettingsRecordOnce(
          queryBuilder: (hotelSettingsRecord) => hotelSettingsRecord.where(
            'hotel',
            isEqualTo: FFAppState().hotel,
          ),
          singleRecord: true,
        ).then((s) => s.firstOrNull);
        // set extPricePerHr
        FFAppState().extPricePerHr =
            _model.hotelSettingForLates!.lateCheckoutFee;
        safeSetState(() {});
      }
    
      if (!(FFAppState().settingRef != null)) {
        // hotel Settings
        _model.hotelSettingsHome = await queryHotelSettingsRecordOnce(
          queryBuilder: (hotelSettingsRecord) => hotelSettingsRecord.where(
            'hotel',
            isEqualTo: FFAppState().hotel,
          ),
          singleRecord: true,
        ).then((s) => s.firstOrNull);
        // set settingsRef
        FFAppState().settingRef = _model.hotelSettingsHome?.reference;
        safeSetState(() {});
      }
      if (FFAppState().lastRemit == null) {
        // update last remit
        FFAppState().lastRemit = functions.yesterdayDate();
        safeSetState(() {});
      } else {
        // check if last remit changed
        _model.settings =
            await HotelSettingsRecord.getDocumentOnce(FFAppState().settingRef!);
        if (_model.settings?.lastRemit != FFAppState().lastRemit) {
          // update last remit
          FFAppState().lastRemit = _model.settings?.lastRemit;
          safeSetState(() {});
        }
      }

      if (valueOrDefault(currentUserDocument?.role, '') != 'admin') {
        if (valueOrDefault<bool>(currentUserDocument?.expired, false)) {
          GoRouter.of(context).prepareAuthEvent();
          await authManager.signOut();
          GoRouter.of(context).clearRedirectLocation();

          navigate = () => context.goNamedAuth('Login', context.mounted);

          navigate();
          return;
        }
      }
      if (FFAppState().statsReference != null) {
        // if this stat is correct
        _model.alreadyStats =
            await StatsRecord.getDocumentOnce(FFAppState().statsReference!);
        if (_model.alreadyStats?.month == functions.currentMonth()) {
          return;
        }

        // clear stats reference
        FFAppState().statsReference = null;
        safeSetState(() {});
        // proceed new month
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Proceeding to new month!',
              style: TextStyle(
                color: FlutterFlowTheme.of(context).primaryText,
              ),
            ),
            duration: const Duration(milliseconds: 4000),
            backgroundColor: FlutterFlowTheme.of(context).secondary,
          ),
        );
      }
      // stat exist firestore not local
      _model.fireStat = await queryStatsRecordOnce(
        queryBuilder: (statsRecord) => statsRecord
            .where(
              'hotel',
              isEqualTo: FFAppState().hotel,
            )
            .where(
              'year',
              isEqualTo: functions.currentYear(),
            )
            .where(
              'month',
              isEqualTo: functions.currentMonth(),
            ),
      );
      if (_model.fireStat!.isNotEmpty) {
        // save new ref stat
        FFAppState().statsReference = _model.fireStat?.first.reference;
        FFAppState().currentStats = functions.currentMonthYear()!;
        safeSetState(() {});
        return;
      } else {
        // create a new stat
        await action_blocks.createNewStats(context);
        safeSetState(() {});
      }

      navigate();
    });

    animationsMap.addAll({
      'columnOnPageLoadAnimation1': AnimationInfo(
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
      'textOnActionTriggerAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: false,
        effectsBuilder: () => [
          FlipEffect(
            curve: Curves.easeIn,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 1.0,
            end: 2.0,
          ),
        ],
      ),
      'columnOnPageLoadAnimation2': AnimationInfo(
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
      'textOnActionTriggerAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: false,
        effectsBuilder: () => [
          FlipEffect(
            curve: Curves.easeIn,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 1.0,
            end: 2.0,
          ),
        ],
      ),
      'textOnActionTriggerAnimation3': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: false,
        effectsBuilder: () => [
          FlipEffect(
            curve: Curves.easeIn,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 1.0,
            end: 2.0,
          ),
        ],
      ),
      'textOnActionTriggerAnimation4': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: false,
        effectsBuilder: () => [
          FlipEffect(
            curve: Curves.easeIn,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 1.0,
            end: 2.0,
          ),
        ],
      ),
      'badgeOnPageLoadAnimation': AnimationInfo(
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
      'textOnActionTriggerAnimation5': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: false,
        effectsBuilder: () => [
          FlipEffect(
            curve: Curves.easeIn,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 1.0,
            end: 2.0,
          ),
        ],
      ),
    });
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );

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

    return StreamBuilder<List<HotelSettingsRecord>>(
      stream: FFAppState().hoteSettings(
        uniqueQueryKey: FFAppState().hotel,
        requestFn: () => queryHotelSettingsRecord(
          queryBuilder: (hotelSettingsRecord) => hotelSettingsRecord.where(
            'hotel',
            isEqualTo: FFAppState().hotel,
          ),
          singleRecord: true,
        ),
      )..listen((snapshot) {
          List<HotelSettingsRecord> homePageHotelSettingsRecordList = snapshot;
          final homePageHotelSettingsRecord =
              homePageHotelSettingsRecordList.isNotEmpty
                  ? homePageHotelSettingsRecordList.first
                  : null;
          if (_model.homePagePreviousSnapshot != null &&
              !const ListEquality(HotelSettingsRecordDocumentEquality()).equals(
                  homePageHotelSettingsRecordList,
                  _model.homePagePreviousSnapshot)) {
            () async {
              // Get Hotel
              _model.hotel = await HotelSettingsRecord.getDocumentOnce(
                  homePageHotelSettingsRecord!.reference);
              FFAppState().lastRemit = _model.hotel?.lastRemit;
              safeSetState(() {});

              safeSetState(() {});
            }();
          }
          _model.homePagePreviousSnapshot = snapshot;
        }),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
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
        List<HotelSettingsRecord> homePageHotelSettingsRecordList =
            snapshot.data!;
        final homePageHotelSettingsRecord =
            homePageHotelSettingsRecordList.isNotEmpty
                ? homePageHotelSettingsRecordList.first
                : null;

        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            key: scaffoldKey,
            body: SafeArea(
              top: true,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 3.0,
                      color: Color(0x32000000),
                      offset: Offset(
                        0.0,
                        1.0,
                      ),
                    )
                  ],
                ),
                child: FutureBuilder<int>(
                  future: FFAppState().pendingsCount(
                    uniqueQueryKey: FFAppState().hotel,
                    requestFn: () => queryTransactionsRecordCount(
                      queryBuilder: (transactionsRecord) => transactionsRecord
                          .where(
                            'hotel',
                            isEqualTo: FFAppState().hotel,
                          )
                          .where(
                            'pending',
                            isEqualTo: true,
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
                    int pendingCountCount = snapshot.data!;

                    return SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          if ((valueOrDefault(currentUserDocument?.role, '') ==
                                  'admin') ||
                              (FFAppState().role == 'demo'))
                            Align(
                              alignment: const AlignmentDirectional(0.0, -1.0),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16.0, 16.0, 16.0, 0.0),
                                child: AuthUserStreamWidget(
                                  builder: (context) =>
                                      StreamBuilder<List<HotelSettingsRecord>>(
                                    stream: _model.hotelSettings(
                                      requestFn: () =>
                                          queryHotelSettingsRecord(),
                                    ),
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
                                      List<HotelSettingsRecord>
                                          statusToggleHotelSettingsRecordList =
                                          snapshot.data!;

                                      return Container(
                                        width: double.infinity,
                                        height: 50.0,
                                        constraints: const BoxConstraints(
                                          maxWidth: 500.0,
                                        ),
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          border: Border.all(
                                            color: FlutterFlowTheme.of(context)
                                                .alternate,
                                            width: 1.0,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    // stat exist firestore not local
                                                    _model.serenityStat =
                                                        await queryStatsRecordOnce(
                                                      queryBuilder:
                                                          (statsRecord) =>
                                                              statsRecord
                                                                  .where(
                                                                    'hotel',
                                                                    isEqualTo:
                                                                        'Serenity',
                                                                  )
                                                                  .where(
                                                                    'year',
                                                                    isEqualTo:
                                                                        functions
                                                                            .currentYear(),
                                                                  )
                                                                  .where(
                                                                    'month',
                                                                    isEqualTo:
                                                                        functions
                                                                            .currentMonth(),
                                                                  ),
                                                      singleRecord: true,
                                                    ).then((s) =>
                                                            s.firstOrNull);
                                                    await _model.changeHotel(
                                                      context,
                                                      bedPrice:
                                                          statusToggleHotelSettingsRecordList
                                                              .where((e) =>
                                                                  statusToggleHotelSettingsRecordList
                                                                      .first
                                                                      .hotel ==
                                                                  'Serenity')
                                                              .toList()
                                                              .first
                                                              .bedPrice,
                                                      lastRemit:
                                                          statusToggleHotelSettingsRecordList
                                                              .where((e) =>
                                                                  statusToggleHotelSettingsRecordList
                                                                      .first
                                                                      .hotel ==
                                                                  'Serenity')
                                                              .toList()
                                                              .first
                                                              .lastRemit,
                                                      hotel: 'Serenity',
                                                      statsReference: _model
                                                          .serenityStat
                                                          ?.reference,
                                                      settingsRef:
                                                          statusToggleHotelSettingsRecordList
                                                              .where((e) =>
                                                                  statusToggleHotelSettingsRecordList
                                                                      .first
                                                                      .hotel ==
                                                                  'Serenity')
                                                              .toList()
                                                              .first
                                                              .reference,
                                                      extPricePerHr:
                                                          statusToggleHotelSettingsRecordList
                                                              .where((e) =>
                                                                  statusToggleHotelSettingsRecordList
                                                                      .first
                                                                      .hotel ==
                                                                  'Serenity')
                                                              .toList()
                                                              .first
                                                              .lateCheckoutFee,
                                                    );
                                                    safeSetState(() {});
                                                    // hotelSetting
                                                    _model.hotelSettingSerenity =
                                                        await HotelSettingsRecord.getDocumentOnce(
                                                            statusToggleHotelSettingsRecordList
                                                                .where((e) =>
                                                                    statusToggleHotelSettingsRecordList
                                                                        .first
                                                                        .hotel ==
                                                                    'Serenity')
                                                                .toList()
                                                                .first
                                                                .reference);
                                                    safeSetState(() {
                                                      _model.allowRemittanceToBeSeenValue =
                                                          _model
                                                              .hotelSettingSerenity!
                                                              .remittable;
                                                    });
                                                    // sales
                                                    if (animationsMap[
                                                            'textOnActionTriggerAnimation1'] !=
                                                        null) {
                                                      safeSetState(() =>
                                                          hasTextTriggered1 =
                                                              true);
                                                      SchedulerBinding.instance
                                                          .addPostFrameCallback((_) async =>
                                                              await animationsMap[
                                                                      'textOnActionTriggerAnimation1']!
                                                                  .controller
                                                                  .forward(
                                                                      from:
                                                                          0.0));
                                                    }
                                                    // last remit
                                                    if (animationsMap[
                                                            'textOnActionTriggerAnimation2'] !=
                                                        null) {
                                                      safeSetState(() =>
                                                          hasTextTriggered2 =
                                                              true);
                                                      SchedulerBinding.instance
                                                          .addPostFrameCallback((_) async =>
                                                              await animationsMap[
                                                                      'textOnActionTriggerAnimation2']!
                                                                  .controller
                                                                  .forward(
                                                                      from:
                                                                          0.0));
                                                    }
                                                    // check in
                                                    if (animationsMap[
                                                            'textOnActionTriggerAnimation3'] !=
                                                        null) {
                                                      safeSetState(() =>
                                                          hasTextTriggered3 =
                                                              true);
                                                      SchedulerBinding.instance
                                                          .addPostFrameCallback((_) async =>
                                                              await animationsMap[
                                                                      'textOnActionTriggerAnimation3']!
                                                                  .controller
                                                                  .forward(
                                                                      from:
                                                                          0.0));
                                                    }
                                                    // transaction
                                                    if (animationsMap[
                                                            'textOnActionTriggerAnimation4'] !=
                                                        null) {
                                                      safeSetState(() =>
                                                          hasTextTriggered4 =
                                                              true);
                                                      SchedulerBinding.instance
                                                          .addPostFrameCallback((_) async =>
                                                              await animationsMap[
                                                                      'textOnActionTriggerAnimation4']!
                                                                  .controller
                                                                  .forward(
                                                                      from:
                                                                          0.0));
                                                    }
                                                    // pending
                                                    if (animationsMap[
                                                            'textOnActionTriggerAnimation5'] !=
                                                        null) {
                                                      safeSetState(() =>
                                                          hasTextTriggered5 =
                                                              true);
                                                      SchedulerBinding.instance
                                                          .addPostFrameCallback((_) async =>
                                                              await animationsMap[
                                                                      'textOnActionTriggerAnimation5']!
                                                                  .controller
                                                                  .forward(
                                                                      from:
                                                                          0.0));
                                                    }

                                                    safeSetState(() {});
                                                  },
                                                  child: AnimatedContainer(
                                                    duration: const Duration(
                                                        milliseconds: 100),
                                                    curve: Curves.linear,
                                                    width: 115.0,
                                                    height: 100.0,
                                                    decoration: BoxDecoration(
                                                      color: FFAppState()
                                                                  .hotel ==
                                                              'Serenity'
                                                          ? FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryBackground
                                                          : FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryBackground,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      border: Border.all(
                                                        color: valueOrDefault<
                                                            Color>(
                                                          FFAppState()
                                                                      .hotel ==
                                                                  'Serenity'
                                                              ? FlutterFlowTheme
                                                                      .of(
                                                                          context)
                                                                  .alternate
                                                              : FlutterFlowTheme
                                                                      .of(context)
                                                                  .primaryBackground,
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .alternate,
                                                        ),
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      10.0,
                                                                      0.0),
                                                          child: Icon(
                                                            Icons
                                                                .local_hotel_outlined,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryText,
                                                            size: 16.0,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      4.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: Text(
                                                            'Serenity',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Readex Pro',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  letterSpacing:
                                                                      0.0,
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
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    // stat exist firestore not local
                                                    _model.lifestyleStat =
                                                        await queryStatsRecordOnce(
                                                      queryBuilder:
                                                          (statsRecord) =>
                                                              statsRecord
                                                                  .where(
                                                                    'hotel',
                                                                    isEqualTo:
                                                                        'My Lifestyle',
                                                                  )
                                                                  .where(
                                                                    'year',
                                                                    isEqualTo:
                                                                        functions
                                                                            .currentYear(),
                                                                  )
                                                                  .where(
                                                                    'month',
                                                                    isEqualTo:
                                                                        functions
                                                                            .currentMonth(),
                                                                  ),
                                                      singleRecord: true,
                                                    ).then((s) =>
                                                            s.firstOrNull);
                                                    await _model.changeHotel(
                                                      context,
                                                      bedPrice:
                                                          statusToggleHotelSettingsRecordList
                                                              .where((e) =>
                                                                  e.hotel ==
                                                                  'My Lifestyle')
                                                              .toList()
                                                              .first
                                                              .bedPrice,
                                                      lastRemit:
                                                          statusToggleHotelSettingsRecordList
                                                              .where((e) =>
                                                                  e.hotel ==
                                                                  'My Lifestyle')
                                                              .toList()
                                                              .first
                                                              .lastRemit,
                                                      hotel: 'My Lifestyle',
                                                      statsReference: _model
                                                          .lifestyleStat
                                                          ?.reference,
                                                      settingsRef:
                                                          statusToggleHotelSettingsRecordList
                                                              .where((e) =>
                                                                  e.hotel ==
                                                                  'My Lifestyle')
                                                              .toList()
                                                              .first
                                                              .reference,
                                                      extPricePerHr:
                                                          statusToggleHotelSettingsRecordList
                                                              .where((e) =>
                                                                  e.hotel ==
                                                                  'My Lifestyle')
                                                              .toList()
                                                              .first
                                                              .lateCheckoutFee,
                                                    );
                                                    safeSetState(() {});
                                                    // hotelSettingLifestyle
                                                    _model.hotelSettingLifestyle =
                                                        await HotelSettingsRecord
                                                            .getDocumentOnce(
                                                                statusToggleHotelSettingsRecordList
                                                                    .where((e) =>
                                                                        e.hotel ==
                                                                        'My Lifestyle')
                                                                    .toList()
                                                                    .first
                                                                    .reference);
                                                    safeSetState(() {
                                                      _model.allowRemittanceToBeSeenValue =
                                                          _model
                                                              .hotelSettingLifestyle!
                                                              .remittable;
                                                    });
                                                    // sales
                                                    if (animationsMap[
                                                            'textOnActionTriggerAnimation1'] !=
                                                        null) {
                                                      safeSetState(() =>
                                                          hasTextTriggered1 =
                                                              true);
                                                      SchedulerBinding.instance
                                                          .addPostFrameCallback((_) async =>
                                                              await animationsMap[
                                                                      'textOnActionTriggerAnimation1']!
                                                                  .controller
                                                                  .forward(
                                                                      from:
                                                                          0.0));
                                                    }
                                                    // last remit
                                                    if (animationsMap[
                                                            'textOnActionTriggerAnimation2'] !=
                                                        null) {
                                                      safeSetState(() =>
                                                          hasTextTriggered2 =
                                                              true);
                                                      SchedulerBinding.instance
                                                          .addPostFrameCallback((_) async =>
                                                              await animationsMap[
                                                                      'textOnActionTriggerAnimation2']!
                                                                  .controller
                                                                  .forward(
                                                                      from:
                                                                          0.0));
                                                    }
                                                    // check in
                                                    if (animationsMap[
                                                            'textOnActionTriggerAnimation3'] !=
                                                        null) {
                                                      safeSetState(() =>
                                                          hasTextTriggered3 =
                                                              true);
                                                      SchedulerBinding.instance
                                                          .addPostFrameCallback((_) async =>
                                                              await animationsMap[
                                                                      'textOnActionTriggerAnimation3']!
                                                                  .controller
                                                                  .forward(
                                                                      from:
                                                                          0.0));
                                                    }
                                                    // transaction
                                                    if (animationsMap[
                                                            'textOnActionTriggerAnimation4'] !=
                                                        null) {
                                                      safeSetState(() =>
                                                          hasTextTriggered4 =
                                                              true);
                                                      SchedulerBinding.instance
                                                          .addPostFrameCallback((_) async =>
                                                              await animationsMap[
                                                                      'textOnActionTriggerAnimation4']!
                                                                  .controller
                                                                  .forward(
                                                                      from:
                                                                          0.0));
                                                    }
                                                    // pending
                                                    if (animationsMap[
                                                            'textOnActionTriggerAnimation5'] !=
                                                        null) {
                                                      safeSetState(() =>
                                                          hasTextTriggered5 =
                                                              true);
                                                      SchedulerBinding.instance
                                                          .addPostFrameCallback((_) async =>
                                                              await animationsMap[
                                                                      'textOnActionTriggerAnimation5']!
                                                                  .controller
                                                                  .forward(
                                                                      from:
                                                                          0.0));
                                                    }

                                                    safeSetState(() {});
                                                  },
                                                  child: AnimatedContainer(
                                                    duration: const Duration(
                                                        milliseconds: 100),
                                                    curve: Curves.linear,
                                                    width: 115.0,
                                                    height: 100.0,
                                                    decoration: BoxDecoration(
                                                      color: FFAppState()
                                                                  .hotel ==
                                                              'My Lifestyle'
                                                          ? FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryBackground
                                                          : FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryBackground,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      border: Border.all(
                                                        color: FFAppState()
                                                                    .hotel ==
                                                                'My Lifestyle'
                                                            ? FlutterFlowTheme
                                                                    .of(context)
                                                                .alternate
                                                            : FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryBackground,
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      10.0,
                                                                      0.0),
                                                          child: Icon(
                                                            Icons
                                                                .local_hotel_outlined,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryText,
                                                            size: 16.0,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      4.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: Text(
                                                            'My Lifestyle',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Readex Pro',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  letterSpacing:
                                                                      0.0,
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
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          if ((valueOrDefault(currentUserDocument?.role, '') ==
                                  'admin') ||
                              (valueOrDefault(currentUserDocument?.role, '') ==
                                  'demo'))
                            Align(
                              alignment: const AlignmentDirectional(0.0, -1.0),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16.0, 10.0, 16.0, 0.0),
                                child: AuthUserStreamWidget(
                                  builder: (context) =>
                                      StreamBuilder<List<HotelSettingsRecord>>(
                                    stream: queryHotelSettingsRecord(
                                      queryBuilder: (hotelSettingsRecord) =>
                                          hotelSettingsRecord.where(
                                        'hotel',
                                        isEqualTo: FFAppState().hotel,
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
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                      List<HotelSettingsRecord>
                                          remitbuttoncontrolHotelSettingsRecordList =
                                          snapshot.data!;
                                      // Return an empty Container when the item does not exist.
                                      if (snapshot.data!.isEmpty) {
                                        return Container();
                                      }
                                      final remitbuttoncontrolHotelSettingsRecord =
                                          remitbuttoncontrolHotelSettingsRecordList
                                                  .isNotEmpty
                                              ? remitbuttoncontrolHotelSettingsRecordList
                                                  .first
                                              : null;

                                      return AnimatedContainer(
                                        duration: const Duration(milliseconds: 600),
                                        curve: Curves.elasticOut,
                                        width: double.infinity,
                                        constraints: const BoxConstraints(
                                          maxWidth: 500.0,
                                        ),
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          border: Border.all(
                                            color: FlutterFlowTheme.of(context)
                                                .alternate,
                                            width: 1.0,
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 5.0, 0.0, 5.0),
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  _model.showRemitController =
                                                      !_model
                                                          .showRemitController;
                                                  safeSetState(() {});
                                                },
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  10.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                      child: Text(
                                                        'Front Desk Remit Button',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Readex Pro',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryText,
                                                                  fontSize:
                                                                      10.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                      ),
                                                    ),
                                                    if (_model
                                                        .showRemitController)
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    5.0,
                                                                    0.0),
                                                        child: Icon(
                                                          Icons
                                                              .keyboard_arrow_down_outlined,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          size: 14.0,
                                                        ),
                                                      ),
                                                    if (!_model
                                                        .showRemitController)
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    5.0,
                                                                    0.0),
                                                        child: Icon(
                                                          Icons.chevron_left,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          size: 14.0,
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            if (_model.showRemitController)
                                              Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 0.0, 5.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      flex: 5,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    10.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: Text(
                                                          'Allow Front Desk To See Remit Button',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Readex Pro',
                                                                letterSpacing:
                                                                    0.0,
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 5,
                                                      child: Align(
                                                        alignment:
                                                            const AlignmentDirectional(
                                                                1.0, 0.0),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      10.0,
                                                                      0.0),
                                                          child:
                                                              Switch.adaptive(
                                                            value: _model
                                                                    .allowRemittanceToBeSeenValue ??=
                                                                remitbuttoncontrolHotelSettingsRecord!
                                                                    .remittable,
                                                            onChanged: (valueOrDefault(
                                                                        currentUserDocument
                                                                            ?.role,
                                                                        '') ==
                                                                    'demo')
                                                                ? null
                                                                : (newValue) async {
                                                                    safeSetState(() =>
                                                                        _model.allowRemittanceToBeSeenValue =
                                                                            newValue);
                                                                    if (newValue) {
                                                                      // remittable

                                                                      await homePageHotelSettingsRecord!
                                                                          .reference
                                                                          .update(
                                                                              createHotelSettingsRecordData(
                                                                        remittable:
                                                                            true,
                                                                      ));
                                                                    } else {
                                                                      // unremittable

                                                                      await homePageHotelSettingsRecord!
                                                                          .reference
                                                                          .update(
                                                                              createHotelSettingsRecordData(
                                                                        remittable:
                                                                            false,
                                                                      ));
                                                                    }
                                                                  },
                                                            activeColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                            activeTrackColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryText,
                                                            inactiveTrackColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .error,
                                                            inactiveThumbColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryText,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                16.0, 24.0, 16.0, 16.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      FutureBuilder<int>(
                                        future: FFAppState().pendingsCount(
                                          uniqueQueryKey: FFAppState().hotel,
                                          requestFn: () =>
                                              queryTransactionsRecordCount(
                                            queryBuilder:
                                                (transactionsRecord) =>
                                                    transactionsRecord
                                                        .where(
                                                          'hotel',
                                                          isEqualTo:
                                                              FFAppState()
                                                                  .hotel,
                                                        )
                                                        .where(
                                                          'pending',
                                                          isEqualTo: true,
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
                                                child:
                                                    CircularProgressIndicator(
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                          Color>(
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                          int textCount = snapshot.data!;

                                          return Text(
                                            'Sales',
                                            maxLines: 1,
                                            style: FlutterFlowTheme.of(context)
                                                .labelMedium
                                                .override(
                                                  fontFamily:
                                                      'Plus Jakarta Sans',
                                                  color: const Color(0xFF57636C),
                                                  fontSize: 14.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                          );
                                        },
                                      ),
                                      if (valueOrDefault(
                                              currentUserDocument?.role, '') !=
                                          'generic')
                                        AuthUserStreamWidget(
                                          builder: (context) => StreamBuilder<
                                              List<TransactionsRecord>>(
                                            stream: _model.salesTotal(
                                              uniqueQueryKey:
                                                  FFAppState().hotel,
                                              requestFn: () =>
                                                  queryTransactionsRecord(
                                                queryBuilder:
                                                    (transactionsRecord) =>
                                                        transactionsRecord
                                                            .where(
                                                              'hotel',
                                                              isEqualTo:
                                                                  FFAppState()
                                                                      .hotel,
                                                            )
                                                            .where(
                                                              'remitted',
                                                              isEqualTo: false,
                                                            )
                                                            .where(
                                                              'pending',
                                                              isNotEqualTo:
                                                                  true,
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
                                              List<TransactionsRecord>
                                                  salesTodayTransactionsRecordList =
                                                  snapshot.data!;

                                              return InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onDoubleTap: () async {
                                                  if (valueOrDefault(
                                                          currentUserDocument
                                                              ?.role,
                                                          '') ==
                                                      'admin') {
                                                    await showModalBottomSheet(
                                                      isScrollControlled: true,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      enableDrag: false,
                                                      useSafeArea: true,
                                                      context: context,
                                                      builder: (context) {
                                                        return GestureDetector(
                                                          onTap: () =>
                                                              FocusScope.of(
                                                                      context)
                                                                  .unfocus(),
                                                          child: Padding(
                                                            padding: MediaQuery
                                                                .viewInsetsOf(
                                                                    context),
                                                            child:
                                                                const ExtraRemittanceWidget(),
                                                          ),
                                                        );
                                                      },
                                                    ).then((value) =>
                                                        safeSetState(() {}));
                                                  }
                                                },
                                                onLongPress: () async {
                                                  if (valueOrDefault(
                                                          currentUserDocument
                                                              ?.role,
                                                          '') ==
                                                      'admin') {
                                                    await showModalBottomSheet(
                                                      isScrollControlled: true,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      enableDrag: false,
                                                      useSafeArea: true,
                                                      context: context,
                                                      builder: (context) {
                                                        return GestureDetector(
                                                          onTap: () =>
                                                              FocusScope.of(
                                                                      context)
                                                                  .unfocus(),
                                                          child: Padding(
                                                            padding: MediaQuery
                                                                .viewInsetsOf(
                                                                    context),
                                                            child:
                                                                const ExtraRemittanceWidget(),
                                                          ),
                                                        );
                                                      },
                                                    ).then((value) =>
                                                        safeSetState(() {}));
                                                  }
                                                },
                                                child: AutoSizeText(
                                                  formatNumber(
                                                    functions.totalToRemit(
                                                        salesTodayTransactionsRecordList
                                                            .toList()),
                                                    formatType:
                                                        FormatType.decimal,
                                                    decimalType:
                                                        DecimalType.automatic,
                                                    currency: 'P ',
                                                  ),
                                                  maxLines: 1,
                                                  minFontSize: 24.0,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .displaySmall
                                                      .override(
                                                        fontFamily: 'Outfit',
                                                        color:
                                                            const Color(0xFF14181B),
                                                        fontSize: 36.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                ),
                                              ).animateOnActionTrigger(
                                                  animationsMap[
                                                      'textOnActionTriggerAnimation1']!,
                                                  hasBeenTriggered:
                                                      hasTextTriggered1);
                                            },
                                          ),
                                        ),
                                      if (pendingCountCount > 0)
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 4.0, 0.0, 4.0),
                                          child: FutureBuilder<
                                              List<TransactionsRecord>>(
                                            future: queryTransactionsRecordOnce(
                                              queryBuilder:
                                                  (transactionsRecord) =>
                                                      transactionsRecord
                                                          .where(
                                                            'hotel',
                                                            isEqualTo:
                                                                FFAppState()
                                                                    .hotel,
                                                          )
                                                          .where(
                                                            'pending',
                                                            isEqualTo: true,
                                                          ),
                                            ),
                                            builder: (context, snapshot) {
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
                                              List<TransactionsRecord>
                                                  textTransactionsRecordList =
                                                  snapshot.data!;

                                              return Text(
                                                '+ ${formatNumber(
                                                  functions.pendingsTotal(
                                                      textTransactionsRecordList
                                                          .toList()),
                                                  formatType:
                                                      FormatType.decimal,
                                                  decimalType:
                                                      DecimalType.automatic,
                                                  currency: 'Php ',
                                                )} in pending',
                                                textAlign: TextAlign.start,
                                                maxLines: 1,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .labelSmall
                                                        .override(
                                                          fontFamily:
                                                              'Plus Jakarta Sans',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          fontSize: 12.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                              );
                                            },
                                          ),
                                        ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 4.0, 0.0, 0.0),
                                        child: Text(
                                          dateTimeFormat(
                                              "yMMMd", getCurrentTimestamp),
                                          textAlign: TextAlign.start,
                                          maxLines: 1,
                                          style: FlutterFlowTheme.of(context)
                                              .labelSmall
                                              .override(
                                                fontFamily: 'Plus Jakarta Sans',
                                                color: const Color(0xFF57636C),
                                                fontSize: 12.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ).animateOnPageLoad(animationsMap[
                                      'columnOnPageLoadAnimation1']!),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 15.0),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onLongPress: () async {
                                          if (valueOrDefault(
                                                  currentUserDocument?.role,
                                                  '') ==
                                              'admin') {
                                            // show last remit editor
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
                                                    padding:
                                                        MediaQuery.viewInsetsOf(
                                                            context),
                                                    child: SizedBox(
                                                      height: double.infinity,
                                                      child: ChangeDateWidget(
                                                        date: FFAppState()
                                                            .lastRemit!,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ).then((value) => safeSetState(() =>
                                                _model.adjustedLastRemit =
                                                    value));

                                            if (_model.adjustedLastRemit !=
                                                null) {
                                              // set local date

                                              safeSetState(() {});
                                              // update hotel setting

                                              await FFAppState()
                                                  .settingRef!
                                                  .update(
                                                      createHotelSettingsRecordData(
                                                    lastRemit: _model
                                                        .adjustedLastRemit,
                                                  ));
                                              // set appstate date
                                              FFAppState().lastRemit =
                                                  _model.adjustedLastRemit;
                                              safeSetState(() {});
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    'Last remit date has been changed!',
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
                                            }
                                          }

                                          safeSetState(() {});
                                        },
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            RichText(
                                              textScaler: MediaQuery.of(context)
                                                  .textScaler,
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: 'Last Remit: ',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Plus Jakarta Sans',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          fontSize: 12.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                  ),
                                                  TextSpan(
                                                    text: dateTimeFormat(
                                                        "yMMMd",
                                                        FFAppState().lastRemit),
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  )
                                                ],
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Plus Jakarta Sans',
                                                          fontSize: 12.0,
                                                          letterSpacing: 0.0,
                                                        ),
                                              ),
                                              maxLines: 1,
                                            ),
                                            Text(
                                              dateTimeFormat(
                                                  "jm", FFAppState().lastRemit),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Plus Jakarta Sans',
                                                        fontSize: 12.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                            ).animateOnActionTrigger(
                                                animationsMap[
                                                    'textOnActionTriggerAnimation2']!,
                                                hasBeenTriggered:
                                                    hasTextTriggered2),
                                          ],
                                        ),
                                      ),
                                    ),
                                    if ((valueOrDefault(
                                                    currentUserDocument?.role,
                                                    '') ==
                                                'admin'
                                            ? homePageHotelSettingsRecord
                                                ?.collectable
                                            : homePageHotelSettingsRecord
                                                ?.remittable) ??
                                        true)
                                      AuthUserStreamWidget(
                                        builder: (context) => InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onLongPress: () async {
                                            // latest remit
                                            _model.latestRemittance =
                                                await queryRemittancesRecordOnce(
                                              queryBuilder:
                                                  (remittancesRecord) =>
                                                      remittancesRecord
                                                          .where(
                                                            'hotel',
                                                            isEqualTo:
                                                                FFAppState()
                                                                    .hotel,
                                                          )
                                                          .orderBy('date',
                                                              descending: true),
                                              singleRecord: true,
                                            ).then((s) => s.firstOrNull);
                                            await showModalBottomSheet(
                                              isScrollControlled: true,
                                              backgroundColor:
                                                  Colors.transparent,
                                              useSafeArea: true,
                                              context: context,
                                              builder: (context) {
                                                return GestureDetector(
                                                  onTap: () =>
                                                      FocusScope.of(context)
                                                          .unfocus(),
                                                  child: Padding(
                                                    padding:
                                                        MediaQuery.viewInsetsOf(
                                                            context),
                                                    child: ListOfNamesWidget(
                                                      remittance: _model
                                                          .latestRemittance
                                                          ?.reference,
                                                      preparedBy: false,
                                                    ),
                                                  ),
                                                );
                                              },
                                            ).then(
                                                (value) => safeSetState(() {}));

                                            safeSetState(() {});
                                          },
                                          child: FFButtonWidget(
                                            onPressed: (valueOrDefault(
                                                        currentUserDocument
                                                            ?.role,
                                                        '') ==
                                                    'demo')
                                                ? null
                                                : () async {
                                                    var shouldSetState = false;
                                                    if (FFAppState().role ==
                                                        'admin') {
                                                      // Accept Remittance
                                                      var confirmDialogResponse =
                                                          await showDialog<
                                                                  bool>(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (alertDialogContext) {
                                                                  return AlertDialog(
                                                                    title: const Text(
                                                                        'Accept Remittance'),
                                                                    content: const Text(
                                                                        'Are you sure you want to accept this remittance?'),
                                                                    actions: [
                                                                      TextButton(
                                                                        onPressed: () => Navigator.pop(
                                                                            alertDialogContext,
                                                                            false),
                                                                        child: const Text(
                                                                            'Cancel'),
                                                                      ),
                                                                      TextButton(
                                                                        onPressed: () => Navigator.pop(
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
                                                        // unremitted
                                                        _model.unRemitted =
                                                            await queryRemittancesRecordOnce(
                                                          queryBuilder:
                                                              (remittancesRecord) =>
                                                                  remittancesRecord
                                                                      .where(
                                                                        'hotel',
                                                                        isEqualTo:
                                                                            FFAppState().hotel,
                                                                      )
                                                                      .where(
                                                                        'collected',
                                                                        isEqualTo:
                                                                            false,
                                                                      ),
                                                          singleRecord: true,
                                                        ).then((s) =>
                                                                s.firstOrNull);
                                                        shouldSetState = true;
                                                        // update collected by

                                                        await _model.unRemitted!
                                                            .reference
                                                            .update(
                                                                createRemittancesRecordData(
                                                          collected: true,
                                                          collectedByName:
                                                              currentUserDisplayName,
                                                        ));
                                                        // not collectable anymore

                                                        await FFAppState()
                                                            .settingRef!
                                                            .update(
                                                                createHotelSettingsRecordData(
                                                              collectable:
                                                                  false,
                                                              remittable: false,
                                                            ));
                                                        // hide remit controller
                                                        _model.showRemitController =
                                                            false;
                                                        safeSetState(() {});
                                                        // toggle off remit controller
                                                        safeSetState(() {
                                                          _model.allowRemittanceToBeSeenValue =
                                                              false;
                                                        });
                                                      } else {
                                                        if (shouldSetState) {
                                                          safeSetState(() {});
                                                        }
                                                        return;
                                                      }

                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                            'Remittance Collected',
                                                            style: TextStyle(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primaryText,
                                                            ),
                                                          ),
                                                          duration: const Duration(
                                                              milliseconds:
                                                                  4000),
                                                          backgroundColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .secondary,
                                                        ),
                                                      );
                                                    } else {
                                                      await showModalBottomSheet(
                                                        isScrollControlled:
                                                            true,
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        useSafeArea: true,
                                                        context: context,
                                                        builder: (context) {
                                                          return GestureDetector(
                                                            onTap: () =>
                                                                FocusScope.of(
                                                                        context)
                                                                    .unfocus(),
                                                            child: Padding(
                                                              padding: MediaQuery
                                                                  .viewInsetsOf(
                                                                      context),
                                                              child: const SizedBox(
                                                                height: 504.0,
                                                                child:
                                                                    ChangeRemittanceWidget(),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ).then((value) =>
                                                          safeSetState(() {}));
                                                    }

                                                    await _model
                                                        .clearCache(context);
                                                    if (shouldSetState) {
                                                      safeSetState(() {});
                                                    }
                                                  },
                                            text: valueOrDefault(
                                                        currentUserDocument
                                                            ?.role,
                                                        '') ==
                                                    'admin'
                                                ? 'Collect'
                                                : 'Remit',
                                            options: FFButtonOptions(
                                              width: 110.0,
                                              height: 40.0,
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                              iconPadding: const EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                              color: const Color(0xFF4B39EF),
                                              textStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Plus Jakarta Sans',
                                                        color: Colors.white,
                                                        fontSize: 14.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                              borderSide: const BorderSide(
                                                color: Colors.transparent,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              disabledColor:
                                                  FlutterFlowTheme.of(context)
                                                      .alternate,
                                              disabledTextColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ).animateOnPageLoad(animationsMap[
                                    'columnOnPageLoadAnimation2']!),
                              ],
                            ),
                          ),
                          if ((valueOrDefault(currentUserDocument?.role, '') ==
                                  'admin') &&
                              (FFAppState().lockDown == false))
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  24.0, 0.0, 24.0, 0.0),
                              child: AuthUserStreamWidget(
                                builder: (context) => Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: const AlignmentDirectional(0.0, 0.0),
                                      child: Text(
                                        'Metrics',
                                        style: FlutterFlowTheme.of(context)
                                            .headlineSmall
                                            .override(
                                              fontFamily: 'Plus Jakarta Sans',
                                              fontSize: 18.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ),
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        context.pushNamed(
                                          'Metrics',
                                          extra: <String, dynamic>{
                                            kTransitionInfoKey: const TransitionInfo(
                                              hasTransition: true,
                                              transitionType: PageTransitionType
                                                  .rightToLeft,
                                            ),
                                          },
                                        );
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            'View More',
                                            maxLines: 1,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Readex Pro',
                                                  letterSpacing: 0.0,
                                                ),
                                          ),
                                          Align(
                                            alignment:
                                                const AlignmentDirectional(0.0, 0.0),
                                            child: Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 2.0, 0.0, 0.0),
                                              child: Icon(
                                                Icons.chevron_right,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                size: 24.0,
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
                          Container(
                            width: double.infinity,
                            height: 120.0,
                            constraints: const BoxConstraints(
                              maxHeight: 160.0,
                            ),
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        0.0, 8.0, 0.0, 0.0),
                                    child: ListView(
                                      padding: const EdgeInsets.fromLTRB(
                                        16.0,
                                        0,
                                        0,
                                        0,
                                      ),
                                      primary: false,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      children: [
                                        Builder(
                                          builder: (context) => Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 8.0, 8.0),
                                            child: FutureBuilder<
                                                List<RoomsRecord>>(
                                              future: FFAppState().checkInCount(
                                                requestFn: () =>
                                                    queryRoomsRecordOnce(
                                                  queryBuilder: (roomsRecord) =>
                                                      roomsRecord
                                                          .where(
                                                            'hotel',
                                                            isEqualTo:
                                                                FFAppState()
                                                                    .hotel,
                                                          )
                                                          .where(
                                                            'vacant',
                                                            isEqualTo: false,
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
                                                List<RoomsRecord>
                                                    checkinStatsRoomsRecordList =
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
                                                    _model.vacantRooms =
                                                        await queryRoomsRecordOnce(
                                                      queryBuilder:
                                                          (roomsRecord) =>
                                                              roomsRecord
                                                                  .where(
                                                                    'hotel',
                                                                    isEqualTo:
                                                                        FFAppState()
                                                                            .hotel,
                                                                  )
                                                                  .where(
                                                                    'vacant',
                                                                    isEqualTo:
                                                                        true,
                                                                  ),
                                                    );
                                                    await showDialog(
                                                      context: context,
                                                      builder: (dialogContext) {
                                                        return Dialog(
                                                          elevation: 0,
                                                          insetPadding:
                                                              EdgeInsets.zero,
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          alignment: const AlignmentDirectional(
                                                                  0.0, 0.0)
                                                              .resolve(
                                                                  Directionality.of(
                                                                      context)),
                                                          child:
                                                              GestureDetector(
                                                            onTap: () =>
                                                                FocusScope.of(
                                                                        dialogContext)
                                                                    .unfocus(),
                                                            child: SizedBox(
                                                              height: 660.0,
                                                              child:
                                                                  OccupiedWidget(
                                                                occupiedRooms:
                                                                    checkinStatsRoomsRecordList,
                                                                vacantRooms: _model
                                                                    .vacantRooms!,
                                                                hotelSetting:
                                                                    homePageHotelSettingsRecord!,
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    );

                                                    safeSetState(() {});
                                                  },
                                                  child: Container(
                                                    width: 130.0,
                                                    decoration: BoxDecoration(
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
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
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        width: 2.0,
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(12.0),
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
                                                          AutoSizeText(
                                                            checkinStatsRoomsRecordList
                                                                .length
                                                                .toString(),
                                                            maxLines: 1,
                                                            minFontSize: 10.0,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .displaySmall
                                                                .override(
                                                                  fontFamily:
                                                                      'Outfit',
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                          ).animateOnActionTrigger(
                                                              animationsMap[
                                                                  'textOnActionTriggerAnimation3']!,
                                                              hasBeenTriggered:
                                                                  hasTextTriggered3),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        4.0,
                                                                        0.0,
                                                                        0.0),
                                                            child: AutoSizeText(
                                                              'Occupancy',
                                                              maxLines: 1,
                                                              minFontSize: 10.0,
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
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 8.0, 8.0),
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              context.goNamed(
                                                'transactions',
                                                extra: <String, dynamic>{
                                                  kTransitionInfoKey:
                                                      const TransitionInfo(
                                                    hasTransition: true,
                                                    transitionType:
                                                        PageTransitionType
                                                            .rightToLeft,
                                                  ),
                                                },
                                              );
                                            },
                                            child: Container(
                                              width: 130.0,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: FlutterFlowTheme.of(
                                                            context)
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
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  width: 2.0,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(12.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    FutureBuilder<int>(
                                                      future: _model
                                                          .totalTransactions(
                                                        uniqueQueryKey:
                                                            FFAppState().hotel,
                                                        requestFn: () =>
                                                            queryTransactionsRecordCount(
                                                          queryBuilder:
                                                              (transactionsRecord) =>
                                                                  transactionsRecord
                                                                      .where(
                                                                        'remitted',
                                                                        isEqualTo:
                                                                            false,
                                                                      )
                                                                      .where(
                                                                        'hotel',
                                                                        isEqualTo:
                                                                            FFAppState().hotel,
                                                                      )
                                                                      .where(
                                                                        'pending',
                                                                        isNotEqualTo:
                                                                            true,
                                                                      ),
                                                        ),
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
                                                        int transactionsCountCount =
                                                            snapshot.data!;

                                                        return AutoSizeText(
                                                          transactionsCountCount
                                                              .toString(),
                                                          maxLines: 1,
                                                          minFontSize: 10.0,
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .displaySmall
                                                              .override(
                                                                fontFamily:
                                                                    'Outfit',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
                                                                letterSpacing:
                                                                    0.0,
                                                              ),
                                                        ).animateOnActionTrigger(
                                                            animationsMap[
                                                                'textOnActionTriggerAnimation4']!,
                                                            hasBeenTriggered:
                                                                hasTextTriggered4);
                                                      },
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  4.0,
                                                                  0.0,
                                                                  0.0),
                                                      child: AutoSizeText(
                                                        'Transactions',
                                                        maxLines: 1,
                                                        minFontSize: 10.0,
                                                        style:
                                                            FlutterFlowTheme.of(
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
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 8.0, 8.0),
                                          child: StreamBuilder<
                                              List<TransactionsRecord>>(
                                            stream: FFAppState().pendingBadge(
                                              uniqueQueryKey:
                                                  FFAppState().hotel,
                                              requestFn: () =>
                                                  queryTransactionsRecord(
                                                queryBuilder:
                                                    (transactionsRecord) =>
                                                        transactionsRecord
                                                            .where(
                                                              'hotel',
                                                              isEqualTo:
                                                                  FFAppState()
                                                                      .hotel,
                                                            )
                                                            .where(
                                                              'pending',
                                                              isEqualTo: true,
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
                                              List<TransactionsRecord>
                                                  pendingsStatsTransactionsRecordList =
                                                  snapshot.data!;

                                              return InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  context.pushNamed('Pendings');
                                                },
                                                onDoubleTap: () async {
                                                  FFAppState()
                                                      .clearPendingBadgeCacheKey(
                                                          FFAppState().hotel);
                                                  FFAppState()
                                                      .clearPendingsCountCacheKey(
                                                          FFAppState().hotel);
                                                },
                                                child: Container(
                                                  width: 130.0,
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
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      width: 2.0,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(12.0),
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
                                                        Align(
                                                          alignment:
                                                              const AlignmentDirectional(
                                                                  -1.0, 0.0),
                                                          child: badges.Badge(
                                                            badgeContent: Text(
                                                              functions
                                                                  .pendingsLastTwentyFourHours(
                                                                      pendingsStatsTransactionsRecordList
                                                                          .toList())
                                                                  .toString(),
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .titleSmall
                                                                  .override(
                                                                    fontFamily:
                                                                        'Readex Pro',
                                                                    color: Colors
                                                                        .white,
                                                                    letterSpacing:
                                                                        0.0,
                                                                  ),
                                                            ),
                                                            showBadge: functions
                                                                    .pendingsLastTwentyFourHours(
                                                                        pendingsStatsTransactionsRecordList
                                                                            .toList()) >
                                                                0,
                                                            shape: badges
                                                                .BadgeShape
                                                                .circle,
                                                            badgeColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .error,
                                                            elevation: 4.0,
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        8.0,
                                                                        8.0,
                                                                        8.0,
                                                                        8.0),
                                                            position: badges
                                                                    .BadgePosition
                                                                .topEnd(),
                                                            animationType: badges
                                                                .BadgeAnimationType
                                                                .scale,
                                                            toAnimate: false,
                                                            child: AutoSizeText(
                                                              '${pendingCountCount.toString()}  '
                                                                  .maybeHandleOverflow(
                                                                maxChars: 3,
                                                              ),
                                                              maxLines: 1,
                                                              minFontSize: 10.0,
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .displaySmall
                                                                  .override(
                                                                    fontFamily:
                                                                        'Outfit',
                                                                    color: const Color(
                                                                        0xFFFD949C),
                                                                    letterSpacing:
                                                                        0.0,
                                                                  ),
                                                            ).animateOnActionTrigger(
                                                                animationsMap[
                                                                    'textOnActionTriggerAnimation5']!,
                                                                hasBeenTriggered:
                                                                    hasTextTriggered5),
                                                          ).animateOnPageLoad(
                                                              animationsMap[
                                                                  'badgeOnPageLoadAnimation']!),
                                                        ),
                                                        Align(
                                                          alignment:
                                                              const AlignmentDirectional(
                                                                  -1.0, -1.0),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        4.0,
                                                                        0.0,
                                                                        0.0),
                                                            child: Text(
                                                              'Pendings',
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
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 8.0, 8.0),
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              context.pushNamed('Replenish');
                                            },
                                            child: Container(
                                              width: 130.0,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: FlutterFlowTheme.of(
                                                            context)
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
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  width: 2.0,
                                                ),
                                              ),
                                              child: Align(
                                                alignment: const AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(12.0),
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
                                                      FutureBuilder<int>(
                                                        future: FFAppState()
                                                            .replenishCount(
                                                          requestFn: () =>
                                                              queryGoodsRecordCount(
                                                            queryBuilder:
                                                                (goodsRecord) =>
                                                                    goodsRecord
                                                                        .where(
                                                                          'replenish',
                                                                          isEqualTo:
                                                                              true,
                                                                        )
                                                                        .where(
                                                                          'hotel',
                                                                          isEqualTo:
                                                                              FFAppState().hotel,
                                                                        ),
                                                          ),
                                                        ),
                                                        builder: (context,
                                                            snapshot) {
                                                          // Customize what your widget looks like when it's loading.
                                                          if (!snapshot
                                                              .hasData) {
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
                                                          int textCount =
                                                              snapshot.data!;

                                                          return AutoSizeText(
                                                            textCount
                                                                .toString(),
                                                            maxLines: 1,
                                                            minFontSize: 10.0,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .displaySmall
                                                                .override(
                                                                  fontFamily:
                                                                      'Outfit',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .tertiary,
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                          );
                                                        },
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    4.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: AutoSizeText(
                                                          'To Replenish',
                                                          maxLines: 1,
                                                          minFontSize: 10.0,
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
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 16.0, 8.0),
                                          child: Container(
                                            constraints: const BoxConstraints(
                                              minWidth: 90.0,
                                            ),
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: FlutterFlowTheme.of(
                                                          context)
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
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                width: 2.0,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(12.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  FutureBuilder<int>(
                                                    future: FFAppState().staffs(
                                                      uniqueQueryKey:
                                                          FFAppState().hotel,
                                                      requestFn: () =>
                                                          queryStaffsRecordCount(
                                                        queryBuilder:
                                                            (staffsRecord) =>
                                                                staffsRecord
                                                                    .where(
                                                                      'hotel',
                                                                      isEqualTo:
                                                                          FFAppState()
                                                                              .hotel,
                                                                    )
                                                                    .where(
                                                                      'fired',
                                                                      isEqualTo:
                                                                          false,
                                                                    ),
                                                      ),
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
                                                      int textCount =
                                                          snapshot.data!;

                                                      return AutoSizeText(
                                                        textCount
                                                            .toString()
                                                            .maybeHandleOverflow(
                                                              maxChars: 3,
                                                            ),
                                                        maxLines: 1,
                                                        minFontSize: 10.0,
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .displaySmall
                                                                .override(
                                                                  fontFamily:
                                                                      'Outfit',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondary,
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                      );
                                                    },
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 4.0,
                                                                0.0, 0.0),
                                                    child: Text(
                                                      'Staffs',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .labelMedium
                                                          .override(
                                                            fontFamily:
                                                                'Readex Pro',
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
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 4.0, 0.0, 12.0),
                            child: StreamBuilder<List<RoomsRecord>>(
                              stream: FFAppState().rooms(
                                uniqueQueryKey: FFAppState().hotel,
                                requestFn: () => queryRoomsRecord(
                                  queryBuilder: (roomsRecord) => roomsRecord
                                      .where(
                                        'hotel',
                                        isEqualTo: FFAppState().hotel,
                                      )
                                      .orderBy('number'),
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
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          FlutterFlowTheme.of(context).primary,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                List<RoomsRecord> roomContainerRoomsRecordList =
                                    snapshot.data!;

                                return Container(
                                  width: double.infinity,
                                  constraints: const BoxConstraints(
                                    minHeight: 230.0,
                                    maxHeight: 260.0,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(0.0),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            24.0, 0.0, 24.0, 0.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 12.0, 0.0, 0.0),
                                              child: Text(
                                                'Rooms',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .headlineMedium
                                                        .override(
                                                          fontFamily:
                                                              'Plus Jakarta Sans',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          fontSize: 18.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                              ),
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 12.0, 10.0, 0.0),
                                                  child: FlutterFlowIconButton(
                                                    borderColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primaryText,
                                                    borderRadius: 10.0,
                                                    borderWidth: 1.0,
                                                    buttonSize: 40.0,
                                                    icon: Icon(
                                                      Icons.list_alt_outlined,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      size: 24.0,
                                                    ),
                                                    onPressed: () async {
                                                      context.pushNamed(
                                                        'HistoryInRooms',
                                                        queryParameters: {
                                                          'room':
                                                              serializeParam(
                                                            roomContainerRoomsRecordList,
                                                            ParamType.Document,
                                                            isList: true,
                                                          ),
                                                        }.withoutNulls,
                                                        extra: <String,
                                                            dynamic>{
                                                          'room':
                                                              roomContainerRoomsRecordList,
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 12.0, 10.0, 0.0),
                                                  child: FlutterFlowIconButton(
                                                    borderColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primaryText,
                                                    borderRadius: 10.0,
                                                    borderWidth: 1.0,
                                                    buttonSize: 40.0,
                                                    icon: Icon(
                                                      Icons.discount_outlined,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      size: 24.0,
                                                    ),
                                                    onPressed: () async {
                                                      await showModalBottomSheet(
                                                        isScrollControlled:
                                                            true,
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        context: context,
                                                        builder: (context) {
                                                          return GestureDetector(
                                                            onTap: () =>
                                                                FocusScope.of(
                                                                        context)
                                                                    .unfocus(),
                                                            child: Padding(
                                                              padding: MediaQuery
                                                                  .viewInsetsOf(
                                                                      context),
                                                              child: const SizedBox(
                                                                height: double
                                                                    .infinity,
                                                                child:
                                                                    PromoWidget(),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ).then((value) =>
                                                          safeSetState(() {}));
                                                    },
                                                  ),
                                                ),
                                                if (valueOrDefault(
                                                        currentUserDocument
                                                            ?.role,
                                                        '') ==
                                                    'admin')
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 12.0,
                                                                0.0, 0.0),
                                                    child: AuthUserStreamWidget(
                                                      builder: (context) =>
                                                          FlutterFlowIconButton(
                                                        borderColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        borderRadius: 10.0,
                                                        borderWidth: 1.0,
                                                        buttonSize: 40.0,
                                                        icon: Icon(
                                                          Icons
                                                              .edit_note_rounded,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          size: 24.0,
                                                        ),
                                                        onPressed: () async {
                                                          context.pushNamed(
                                                              'RoomList');
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Flexible(
                                        child: Builder(
                                          builder: (context) {
                                            final rooms =
                                                roomContainerRoomsRecordList
                                                    .map((e) => e)
                                                    .toList();

                                            return ListView.builder(
                                              padding: const EdgeInsets.fromLTRB(
                                                4.0,
                                                0,
                                                20.0,
                                                0,
                                              ),
                                              primary: false,
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              itemCount: rooms.length,
                                              itemBuilder:
                                                  (context, roomsIndex) {
                                                final roomsItem =
                                                    rooms[roomsIndex];
                                                return Padding(
                                                  padding: const EdgeInsetsDirectional
                                                      .fromSTEB(12.0, 12.0, 0.0,
                                                          12.0),
                                                  child: InkWell(
                                                    splashColor:
                                                        Colors.transparent,
                                                    focusColor:
                                                        Colors.transparent,
                                                    hoverColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                    onTap: () async {
                                                      // history count
                                                      _model.historyCount =
                                                          await queryHistoryRecordCount(
                                                        parent:
                                                            roomsItem.reference,
                                                      );
                                                      if (_model.historyCount! >
                                                          0) {
                                                        context.pushNamed(
                                                          'HistoryInRoom',
                                                          queryParameters: {
                                                            'room':
                                                                serializeParam(
                                                              roomsItem,
                                                              ParamType
                                                                  .Document,
                                                            ),
                                                          }.withoutNulls,
                                                          extra: <String,
                                                              dynamic>{
                                                            'room': roomsItem,
                                                          },
                                                        );
                                                      } else {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                            content: Text(
                                                              'There is no history in this room!',
                                                              style: TextStyle(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .info,
                                                              ),
                                                            ),
                                                            duration: const Duration(
                                                                milliseconds:
                                                                    4000),
                                                            backgroundColor:
                                                                const Color(
                                                                    0xFFFF5963),
                                                          ),
                                                        );
                                                      }

                                                      safeSetState(() {});
                                                    },
                                                    onLongPress: () async {
                                                      await showModalBottomSheet(
                                                        isScrollControlled:
                                                            true,
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        enableDrag: false,
                                                        context: context,
                                                        builder: (context) {
                                                          return GestureDetector(
                                                            onTap: () =>
                                                                FocusScope.of(
                                                                        context)
                                                                    .unfocus(),
                                                            child: Padding(
                                                              padding: MediaQuery
                                                                  .viewInsetsOf(
                                                                      context),
                                                              child:
                                                                  OptionToReassesWidget(
                                                                room: roomsItem,
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ).then((value) =>
                                                          safeSetState(() {}));
                                                    },
                                                    child: Container(
                                                      width: 210.0,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: roomsItem
                                                                        .vacant ==
                                                                    true
                                                                ? FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondary
                                                                : const Color(
                                                                    0xFFFF5963),
                                                            offset: const Offset(
                                                              3.0,
                                                              3.0,
                                                            ),
                                                          )
                                                        ],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12.0),
                                                        border: Border.all(
                                                          color: roomsItem
                                                                      .vacant ==
                                                                  true
                                                              ? FlutterFlowTheme
                                                                      .of(
                                                                          context)
                                                                  .secondary
                                                              : const Color(
                                                                  0xFFFF5963),
                                                          width: 2.0,
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(
                                                            12.0),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Expanded(
                                                                  flex: 5,
                                                                  child: Text(
                                                                    'Room  ${roomsItem.number.toString()}',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyLarge
                                                                        .override(
                                                                          fontFamily:
                                                                              'Plus Jakarta Sans',
                                                                          color:
                                                                              const Color(0xFF14181B),
                                                                          fontSize:
                                                                              16.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 5,
                                                                  child: Text(
                                                                    valueOrDefault<
                                                                        String>(
                                                                      functions.numOfGuests(roomsItem
                                                                          .guests
                                                                          .toString()),
                                                                      '0',
                                                                    ),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .end,
                                                                    maxLines: 1,
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              'Plus Jakarta Sans',
                                                                          color:
                                                                              const Color(0xFF14181B),
                                                                          fontSize:
                                                                              14.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Expanded(
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Expanded(
                                                                    flex: 8,
                                                                    child:
                                                                        AutoSizeText(
                                                                      homePageHotelSettingsRecord!
                                                                              .promoOn
                                                                          ? formatNumber(
                                                                              (roomsItem.price - (roomsItem.price * homePageHotelSettingsRecord.promoPercent / 100)).toInt().toDouble(),
                                                                              formatType: FormatType.decimal,
                                                                              decimalType: DecimalType.automatic,
                                                                              currency: 'P ',
                                                                            )
                                                                          : formatNumber(
                                                                              roomsItem.price,
                                                                              formatType: FormatType.decimal,
                                                                              decimalType: DecimalType.automatic,
                                                                              currency: 'P ',
                                                                            ),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                      maxLines:
                                                                          1,
                                                                      minFontSize:
                                                                          24.0,
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .displaySmall
                                                                          .override(
                                                                            fontFamily:
                                                                                'Outfit',
                                                                            color:
                                                                                const Color(0xFF14181B),
                                                                            fontSize:
                                                                                36.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Expanded(
                                                                  flex: 1,
                                                                  child: Icon(
                                                                    Icons
                                                                        .meeting_room_outlined,
                                                                    color: roomsItem.vacant ==
                                                                            true
                                                                        ? FlutterFlowTheme.of(context)
                                                                            .secondary
                                                                        : const Color(
                                                                            0xFFFF5963),
                                                                    size: 24.0,
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 6,
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            10.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                    child:
                                                                        AutoSizeText(
                                                                      roomsItem.vacant ==
                                                                              true
                                                                          ? 'Vacant'
                                                                          : (functions.moreThan24hr(roomsItem.last)
                                                                              ? 'Overstaying'
                                                                              : 'Occupied'),
                                                                      maxLines:
                                                                          1,
                                                                      minFontSize:
                                                                          10.0,
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'Plus Jakarta Sans',
                                                                            color:
                                                                                const Color(0xFF14181B),
                                                                            fontSize:
                                                                                14.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 3,
                                                                  child:
                                                                      FlutterFlowIconButton(
                                                                    borderColor:
                                                                        FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                    borderRadius:
                                                                        15.0,
                                                                    borderWidth:
                                                                        2.0,
                                                                    buttonSize:
                                                                        44.0,
                                                                    icon: Icon(
                                                                      Icons
                                                                          .arrow_forward_rounded,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryText,
                                                                      size:
                                                                          24.0,
                                                                    ),
                                                                    onPressed:
                                                                        () async {
                                                                      if (roomsItem
                                                                              .vacant ==
                                                                          true) {
                                                                        context
                                                                            .pushNamed(
                                                                          'CheckIn',
                                                                          queryParameters:
                                                                              {
                                                                            'ref': serializeParam(
                                                                              roomsItem.reference,
                                                                              ParamType.DocumentReference,
                                                                            ),
                                                                            'price': serializeParam(
                                                                              homePageHotelSettingsRecord.promoOn ? ((roomsItem.price - (roomsItem.price * homePageHotelSettingsRecord.promoPercent / 100)).toInt().toDouble()) : roomsItem.price,
                                                                              ParamType.double,
                                                                            ),
                                                                            'roomNo': serializeParam(
                                                                              roomsItem.number,
                                                                              ParamType.int,
                                                                            ),
                                                                            'extend': serializeParam(
                                                                              false,
                                                                              ParamType.bool,
                                                                            ),
                                                                            'promoOn': serializeParam(
                                                                              homePageHotelSettingsRecord.promoOn,
                                                                              ParamType.bool,
                                                                            ),
                                                                            'promoDetail': serializeParam(
                                                                              homePageHotelSettingsRecord.promoDetail,
                                                                              ParamType.String,
                                                                            ),
                                                                            'promoDiscount': serializeParam(
                                                                              homePageHotelSettingsRecord.promoPercent,
                                                                              ParamType.double,
                                                                            ),
                                                                          }.withoutNulls,
                                                                          extra: <String,
                                                                              dynamic>{
                                                                            kTransitionInfoKey: const TransitionInfo(
                                                                              hasTransition: true,
                                                                              transitionType: PageTransitionType.rightToLeft,
                                                                            ),
                                                                          },
                                                                        );
                                                                                                                                            } else {
                                                                        context
                                                                            .pushNamed(
                                                                          'CheckedIn',
                                                                          queryParameters:
                                                                              {
                                                                            'ref':
                                                                                serializeParam(
                                                                              roomsItem.reference,
                                                                              ParamType.DocumentReference,
                                                                            ),
                                                                            'booking':
                                                                                serializeParam(
                                                                              roomsItem.currentBooking,
                                                                              ParamType.DocumentReference,
                                                                            ),
                                                                            'roomNo':
                                                                                serializeParam(
                                                                              roomsItem.number,
                                                                              ParamType.int,
                                                                            ),
                                                                          }.withoutNulls,
                                                                          extra: <String,
                                                                              dynamic>{
                                                                            kTransitionInfoKey:
                                                                                const TransitionInfo(
                                                                              hasTransition: true,
                                                                              transitionType: PageTransitionType.rightToLeft,
                                                                            ),
                                                                          },
                                                                        );
                                                                      }
                                                                    },
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          StreamBuilder<List<IssuesRecord>>(
                            stream: _model.issueHome(
                              uniqueQueryKey: FFAppState().hotel,
                              requestFn: () => queryIssuesRecord(
                                queryBuilder: (issuesRecord) => issuesRecord
                                    .where(
                                      'hotel',
                                      isEqualTo: FFAppState().hotel,
                                    )
                                    .where(
                                      'status',
                                      isEqualTo: 'pending',
                                    ),
                                limit: 10,
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
                              List<IssuesRecord> issuedBoxIssuesRecordList =
                                  snapshot.data!;

                              return Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          24.0, 10.0, 24.0, 0.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Issues',
                                            style: FlutterFlowTheme.of(context)
                                                .displaySmall
                                                .override(
                                                  fontFamily:
                                                      'Plus Jakarta Sans',
                                                  color: const Color(0xFF14181B),
                                                  fontSize: 18.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                10.0, 0.0),
                                                    child:
                                                        FlutterFlowIconButton(
                                                      borderColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      borderRadius: 10.0,
                                                      borderWidth: 1.0,
                                                      buttonSize: 40.0,
                                                      icon: Icon(
                                                        Icons
                                                            .lightbulb_outlined,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        size: 24.0,
                                                      ),
                                                      onPressed: () async {
                                                        context.pushNamed(
                                                            'Locations');
                                                      },
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                10.0, 0.0),
                                                    child: FutureBuilder<int>(
                                                      future:
                                                          queryRecordsRecordCount(
                                                        queryBuilder:
                                                            (recordsRecord) =>
                                                                recordsRecord
                                                                    .where(
                                                                      'hotel',
                                                                      isEqualTo:
                                                                          FFAppState()
                                                                              .hotel,
                                                                    )
                                                                    .where(
                                                                      'receivedBy',
                                                                      isEqualTo:
                                                                          '',
                                                                    ),
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
                                                        int badgeCount =
                                                            snapshot.data!;

                                                        return badges.Badge(
                                                          badgeContent: Text(
                                                            badgeCount
                                                                .toString(),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .titleSmall
                                                                .override(
                                                                  fontFamily:
                                                                      'Readex Pro',
                                                                  color: Colors
                                                                      .white,
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                          ),
                                                          showBadge:
                                                              badgeCount > 0,
                                                          shape: badges
                                                              .BadgeShape
                                                              .circle,
                                                          badgeColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .error,
                                                          elevation: 4.0,
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      8.0,
                                                                      8.0,
                                                                      8.0,
                                                                      8.0),
                                                          position: badges
                                                                  .BadgePosition
                                                              .topEnd(),
                                                          animationType: badges
                                                              .BadgeAnimationType
                                                              .scale,
                                                          toAnimate: true,
                                                          child:
                                                              FlutterFlowIconButton(
                                                            borderColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                            borderRadius: 10.0,
                                                            borderWidth: 1.0,
                                                            buttonSize: 40.0,
                                                            icon: Icon(
                                                              Icons
                                                                  .checklist_rounded,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primaryText,
                                                              size: 24.0,
                                                            ),
                                                            onPressed:
                                                                () async {
                                                              context.pushNamed(
                                                                  'RecordsList');
                                                            },
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                10.0, 0.0),
                                                    child: FutureBuilder<int>(
                                                      future:
                                                          queryIssuesRecordCount(
                                                        queryBuilder:
                                                            (issuesRecord) =>
                                                                issuesRecord
                                                                    .where(
                                                                      'hotel',
                                                                      isEqualTo:
                                                                          FFAppState()
                                                                              .hotel,
                                                                    )
                                                                    .where(
                                                                      'status',
                                                                      isEqualTo:
                                                                          'pending',
                                                                    ),
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
                                                        int badgeCount =
                                                            snapshot.data!;

                                                        return badges.Badge(
                                                          badgeContent: Text(
                                                            badgeCount
                                                                .toString(),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .titleSmall
                                                                .override(
                                                                  fontFamily:
                                                                      'Readex Pro',
                                                                  color: Colors
                                                                      .white,
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                          ),
                                                          showBadge:
                                                              badgeCount > 0,
                                                          shape: badges
                                                              .BadgeShape
                                                              .circle,
                                                          badgeColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .error,
                                                          elevation: 4.0,
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      8.0,
                                                                      8.0,
                                                                      8.0,
                                                                      8.0),
                                                          position: badges
                                                                  .BadgePosition
                                                              .topEnd(),
                                                          animationType: badges
                                                              .BadgeAnimationType
                                                              .scale,
                                                          toAnimate: true,
                                                          child:
                                                              FlutterFlowIconButton(
                                                            borderColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                            borderRadius: 10.0,
                                                            borderWidth: 1.0,
                                                            buttonSize: 40.0,
                                                            icon: Icon(
                                                              Icons
                                                                  .featured_play_list_outlined,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primaryText,
                                                              size: 24.0,
                                                            ),
                                                            onPressed:
                                                                () async {
                                                              context.pushNamed(
                                                                  'IssuesList');
                                                            },
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  FlutterFlowIconButton(
                                                    borderColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primaryText,
                                                    borderRadius: 10.0,
                                                    borderWidth: 1.0,
                                                    buttonSize: 40.0,
                                                    icon: Icon(
                                                      Icons.add,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      size: 24.0,
                                                    ),
                                                    onPressed: () async {
                                                      await showModalBottomSheet(
                                                        isScrollControlled:
                                                            true,
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        enableDrag: false,
                                                        context: context,
                                                        builder: (context) {
                                                          return GestureDetector(
                                                            onTap: () =>
                                                                FocusScope.of(
                                                                        context)
                                                                    .unfocus(),
                                                            child: Padding(
                                                              padding: MediaQuery
                                                                  .viewInsetsOf(
                                                                      context),
                                                              child:
                                                                  const NewIssueWidget(),
                                                            ),
                                                          );
                                                        },
                                                      ).then((value) =>
                                                          safeSetState(() {}));
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (issuedBoxIssuesRecordList.isNotEmpty)
                                      Container(
                                        width: double.infinity,
                                        height: 130.0,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                        ),
                                        child: Builder(
                                          builder: (context) {
                                            final issuesList = functions
                                                    .sortIssueDesc(
                                                        issuedBoxIssuesRecordList
                                                            .toList())
                                                    ?.toList() ??
                                                [];

                                            return ListView.builder(
                                              padding: EdgeInsets.zero,
                                              primary: false,
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              itemCount: issuesList.length,
                                              itemBuilder:
                                                  (context, issuesListIndex) {
                                                final issuesListItem =
                                                    issuesList[issuesListIndex];
                                                return Padding(
                                                  padding: const EdgeInsetsDirectional
                                                      .fromSTEB(16.0, 12.0,
                                                          16.0, 16.0),
                                                  child: InkWell(
                                                    splashColor:
                                                        Colors.transparent,
                                                    focusColor:
                                                        Colors.transparent,
                                                    hoverColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                    onTap: () async {
                                                      await showModalBottomSheet(
                                                        isScrollControlled:
                                                            true,
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        context: context,
                                                        builder: (context) {
                                                          return GestureDetector(
                                                            onTap: () =>
                                                                FocusScope.of(
                                                                        context)
                                                                    .unfocus(),
                                                            child: Padding(
                                                              padding: MediaQuery
                                                                  .viewInsetsOf(
                                                                      context),
                                                              child:
                                                                  OptionToIssueWidget(
                                                                issue:
                                                                    issuesListItem,
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ).then((value) =>
                                                          safeSetState(() {}));
                                                    },
                                                    child: Container(
                                                      width: 342.0,
                                                      height: 100.0,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: issuesListItem
                                                                        .status ==
                                                                    'pending'
                                                                ? FlutterFlowTheme.of(
                                                                        context)
                                                                    .error
                                                                : FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondary,
                                                            offset: const Offset(
                                                              3.0,
                                                              3.0,
                                                            ),
                                                          )
                                                        ],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                        border: Border.all(
                                                          color: issuesListItem
                                                                      .status ==
                                                                  'pending'
                                                              ? FlutterFlowTheme
                                                                      .of(
                                                                          context)
                                                                  .error
                                                              : FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondary,
                                                          width: 2.0,
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    8.0,
                                                                    8.0,
                                                                    12.0,
                                                                    8.0),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Container(
                                                              width: 4.0,
                                                              height: double
                                                                  .infinity,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: issuesListItem
                                                                            .status ==
                                                                        'pending'
                                                                    ? FlutterFlowTheme.of(
                                                                            context)
                                                                        .error
                                                                    : FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondary,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            4.0),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            12.0,
                                                                            0.0,
                                                                            0.0,
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
                                                                    Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Text(
                                                                          issuesListItem
                                                                              .status,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                fontFamily: 'Plus Jakarta Sans',
                                                                                color: issuesListItem.status == 'pending' ? FlutterFlowTheme.of(context).error : FlutterFlowTheme.of(context).secondary,
                                                                                fontSize: 14.0,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.w500,
                                                                              ),
                                                                        ),
                                                                        Text(
                                                                          functions.daysOfIssue(
                                                                              issuesListItem.date!,
                                                                              issuesListItem.dateFixed),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                fontFamily: 'Plus Jakarta Sans',
                                                                                color: issuesListItem.status == 'pending' ? FlutterFlowTheme.of(context).error : FlutterFlowTheme.of(context).secondary,
                                                                                fontSize: 14.0,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.w500,
                                                                              ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Flexible(
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            3.0,
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            RichText(
                                                                          textScaler:
                                                                              MediaQuery.of(context).textScaler,
                                                                          text:
                                                                              TextSpan(
                                                                            children: [
                                                                              TextSpan(
                                                                                text: 'Reported by ',
                                                                                style: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                      fontFamily: 'Plus Jakarta Sans',
                                                                                      letterSpacing: 0.0,
                                                                                    ),
                                                                              ),
                                                                              TextSpan(
                                                                                text: issuesListItem.staffName,
                                                                                style: const TextStyle(),
                                                                              ),
                                                                              const TextSpan(
                                                                                text: ' on ',
                                                                                style: TextStyle(),
                                                                              ),
                                                                              TextSpan(
                                                                                text: dateTimeFormat("MMM d h:mm a", issuesListItem.date!),
                                                                                style: const TextStyle(),
                                                                              )
                                                                            ],
                                                                            style: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                  fontFamily: 'Plus Jakarta Sans',
                                                                                  color: const Color(0xFF57636C),
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.w500,
                                                                                ),
                                                                          ),
                                                                          maxLines:
                                                                              1,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Flexible(
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            4.0,
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            AutoSizeText(
                                                                          issuesListItem
                                                                              .detail,
                                                                          minFontSize:
                                                                              12.0,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .headlineSmall
                                                                              .override(
                                                                                fontFamily: 'Outfit',
                                                                                color: const Color(0xFF14181B),
                                                                                fontSize: 24.0,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.w500,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
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
                                          },
                                        ),
                                      ),
                                  ],
                                ),
                              );
                            },
                          ),
                          Container(
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Visibility(
                              visible: valueOrDefault(
                                      currentUserDocument?.role, '') !=
                                  'generic',
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 16.0),
                                child: AuthUserStreamWidget(
                                  builder: (context) => Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 15.0, 0.0, 0.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Align(
                                              alignment: const AlignmentDirectional(
                                                  -1.0, 0.0),
                                              child: Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        24.0, 0.0, 0.0, 5.0),
                                                child: Text(
                                                  'Remittance',
                                                  textAlign: TextAlign.start,
                                                  maxLines: 1,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .labelMedium
                                                      .override(
                                                        fontFamily:
                                                            'Plus Jakarta Sans',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        fontSize: 18.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      24.0, 0.0, 24.0, 16.0),
                                              child: FutureBuilder<
                                                  List<RemittancesRecord>>(
                                                future: _model.homeRemittance(
                                                  uniqueQueryKey:
                                                      FFAppState().hotel,
                                                  requestFn: () =>
                                                      queryRemittancesRecordOnce(
                                                    queryBuilder:
                                                        (remittancesRecord) =>
                                                            remittancesRecord
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
                                                  ),
                                                ),
                                                builder: (context, snapshot) {
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
                                                  List<RemittancesRecord>
                                                      currentRemittancesRecordList =
                                                      snapshot.data!;
                                                  // Return an empty Container when the item does not exist.
                                                  if (snapshot.data!.isEmpty) {
                                                    return Container();
                                                  }
                                                  final currentRemittancesRecord =
                                                      currentRemittancesRecordList
                                                              .isNotEmpty
                                                          ? currentRemittancesRecordList
                                                              .first
                                                          : null;

                                                  return Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Expanded(
                                                        flex: 5,
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          10.0),
                                                              child: Text(
                                                                'Last Remitted Amount',
                                                                maxLines: 1,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Plus Jakarta Sans',
                                                                      color: const Color(
                                                                          0xFF57636C),
                                                                      fontSize:
                                                                          14.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                              ),
                                                            ),
                                                            FutureBuilder<
                                                                List<
                                                                    RemittancesRecord>>(
                                                              future:
                                                                  queryRemittancesRecordOnce(
                                                                queryBuilder: (remittancesRecord) =>
                                                                    remittancesRecord
                                                                        .where(
                                                                          'date',
                                                                          isGreaterThan:
                                                                              functions.dayBefore(currentRemittancesRecord!.date!),
                                                                        )
                                                                        .where(
                                                                          'date',
                                                                          isLessThan:
                                                                              currentRemittancesRecord.date,
                                                                        )
                                                                        .where(
                                                                          'hotel',
                                                                          isEqualTo:
                                                                              FFAppState().hotel,
                                                                        ),
                                                                singleRecord:
                                                                    true,
                                                              ),
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
                                                                          FlutterFlowTheme.of(context)
                                                                              .primary,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                }
                                                                List<RemittancesRecord>
                                                                    yesterdayRemittancesRecordList =
                                                                    snapshot
                                                                        .data!;
                                                                // Return an empty Container when the item does not exist.
                                                                if (snapshot
                                                                    .data!
                                                                    .isEmpty) {
                                                                  return Container();
                                                                }
                                                                final yesterdayRemittancesRecord =
                                                                    yesterdayRemittancesRecordList
                                                                            .isNotEmpty
                                                                        ? yesterdayRemittancesRecordList
                                                                            .first
                                                                        : null;

                                                                return Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          5.0),
                                                                      child:
                                                                          Text(
                                                                        valueOrDefault<
                                                                            String>(
                                                                          formatNumber(
                                                                            currentRemittancesRecord?.net,
                                                                            formatType:
                                                                                FormatType.decimal,
                                                                            decimalType:
                                                                                DecimalType.automatic,
                                                                            currency:
                                                                                'P ',
                                                                          ),
                                                                          '0',
                                                                        ),
                                                                        maxLines:
                                                                            1,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .displaySmall
                                                                            .override(
                                                                              fontFamily: 'Outfit',
                                                                              color: const Color(0xFF14181B),
                                                                              fontSize: 36.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.w600,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                                                          5.0,
                                                                          0.0,
                                                                          0.0,
                                                                          10.0),
                                                                      child:
                                                                          Text(
                                                                        (double todayRemittance,
                                                                            double
                                                                                yesterdayRemittance) {
                                                                          return '${((todayRemittance - yesterdayRemittance) / yesterdayRemittance * 100).toStringAsFixed(0)}%';
                                                                        }(currentRemittancesRecord!.net, yesterdayRemittancesRecord!.net),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              fontFamily: 'Readex Pro',
                                                                              color: currentRemittancesRecord.net > yesterdayRemittancesRecord.net ? FlutterFlowTheme.of(context).secondary : FlutterFlowTheme.of(context).error,
                                                                              fontSize: 18.0,
                                                                              letterSpacing: 0.0,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                    if (currentRemittancesRecord
                                                                            .net >
                                                                        yesterdayRemittancesRecord
                                                                            .net)
                                                                      Padding(
                                                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            10.0),
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .trending_up_sharp,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).secondary,
                                                                          size:
                                                                              22.0,
                                                                        ),
                                                                      ),
                                                                    if (currentRemittancesRecord
                                                                            .net <
                                                                        yesterdayRemittancesRecord
                                                                            .net)
                                                                      Padding(
                                                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            10.0),
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .trending_down,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).error,
                                                                          size:
                                                                              22.0,
                                                                        ),
                                                                      ),
                                                                  ],
                                                                );
                                                              },
                                                            ),
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .end,
                                                              children: [
                                                                Expanded(
                                                                  child: FutureBuilder<
                                                                      List<
                                                                          TransactionsRecord>>(
                                                                    future: _model
                                                                        .remittanceChange(
                                                                      uniqueQueryKey:
                                                                          FFAppState()
                                                                              .hotel,
                                                                      requestFn:
                                                                          () =>
                                                                              queryTransactionsRecordOnce(
                                                                        queryBuilder: (transactionsRecord) => transactionsRecord
                                                                            .where(
                                                                              'hotel',
                                                                              isEqualTo: FFAppState().hotel,
                                                                            )
                                                                            .where(
                                                                              'remitted',
                                                                              isEqualTo: false,
                                                                            )
                                                                            .where(
                                                                              'type',
                                                                              isEqualTo: 'change',
                                                                            ),
                                                                        singleRecord:
                                                                            true,
                                                                      ),
                                                                    ),
                                                                    builder:
                                                                        (context,
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
                                                                              valueColor: AlwaysStoppedAnimation<Color>(
                                                                                FlutterFlowTheme.of(context).primary,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      }
                                                                      List<TransactionsRecord>
                                                                          textTransactionsRecordList =
                                                                          snapshot
                                                                              .data!;
                                                                      // Return an empty Container when the item does not exist.
                                                                      if (snapshot
                                                                          .data!
                                                                          .isEmpty) {
                                                                        return Container();
                                                                      }
                                                                      final textTransactionsRecord = textTransactionsRecordList
                                                                              .isNotEmpty
                                                                          ? textTransactionsRecordList
                                                                              .first
                                                                          : null;

                                                                      return Text(
                                                                        textTransactionsRecord?.total !=
                                                                                0.0
                                                                            ? 'The remittance received exceeds the predetermined sum by ${(double change) {
                                                                                return "Php ${(change.abs()).toStringAsFixed(1).replaceAllMapped(
                                                                                          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                                                          (Match match) => '${match[1]},',
                                                                                        )}";
                                                                              }(textTransactionsRecord!.total)}.'
                                                                            : 'The remittance was received in its exact amount.',
                                                                        maxLines:
                                                                            2,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .labelSmall
                                                                            .override(
                                                                              fontFamily: 'Readex Pro',
                                                                              letterSpacing: 0.0,
                                                                            ),
                                                                      );
                                                                    },
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 2,
                                                        child: InkWell(
                                                          splashColor: Colors
                                                              .transparent,
                                                          focusColor: Colors
                                                              .transparent,
                                                          hoverColor: Colors
                                                              .transparent,
                                                          highlightColor: Colors
                                                              .transparent,
                                                          onTap: () async {
                                                            context.pushNamed(
                                                              'remittances',
                                                              extra: <String,
                                                                  dynamic>{
                                                                kTransitionInfoKey:
                                                                    const TransitionInfo(
                                                                  hasTransition:
                                                                      true,
                                                                  transitionType:
                                                                      PageTransitionType
                                                                          .rightToLeft,
                                                                ),
                                                              },
                                                            );
                                                          },
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .end,
                                                            children: [
                                                              Text(
                                                                'View All',
                                                                maxLines: 1,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Plus Jakarta Sans',
                                                                      color: const Color(
                                                                          0xFF57636C),
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            15.0,
                                                                            0.0,
                                                                            0.0),
                                                                child:
                                                                    FlutterFlowIconButton(
                                                                  borderColor:
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryText,
                                                                  borderRadius:
                                                                      30.0,
                                                                  borderWidth:
                                                                      1.0,
                                                                  buttonSize:
                                                                      44.0,
                                                                  icon: Icon(
                                                                    Icons
                                                                        .arrow_forward_rounded,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryText,
                                                                    size: 24.0,
                                                                  ),
                                                                  onPressed:
                                                                      () async {
                                                                    context
                                                                        .pushNamed(
                                                                      'remittances',
                                                                      extra: <String,
                                                                          dynamic>{
                                                                        kTransitionInfoKey:
                                                                            const TransitionInfo(
                                                                          hasTransition:
                                                                              true,
                                                                          transitionType:
                                                                              PageTransitionType.rightToLeft,
                                                                        ),
                                                                      },
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Divider(
                                        height: 4.0,
                                        thickness: 2.0,
                                        indent: 20.0,
                                        endIndent: 20.0,
                                        color: Color(0xFFE0E3E7),
                                      ),
                                      if (FFAppState().lockDown == false)
                                        FutureBuilder<
                                            List<GoodsRevenueRatioRecord>>(
                                          future: FFAppState().groceryHome(
                                            uniqueQueryKey: FFAppState().hotel,
                                            requestFn: () =>
                                                queryGoodsRevenueRatioRecordOnce(
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
                                                              descending: true),
                                              singleRecord: true,
                                            ),
                                          ),
                                          builder: (context, snapshot) {
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
                                            List<GoodsRevenueRatioRecord>
                                                groceryColumnGoodsRevenueRatioRecordList =
                                                snapshot.data!;
                                            // Return an empty Container when the item does not exist.
                                            if (snapshot.data!.isEmpty) {
                                              return Container();
                                            }
                                            final groceryColumnGoodsRevenueRatioRecord =
                                                groceryColumnGoodsRevenueRatioRecordList
                                                        .isNotEmpty
                                                    ? groceryColumnGoodsRevenueRatioRecordList
                                                        .first
                                                    : null;

                                            return Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          24.0, 0.0, 24.0, 0.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Expanded(
                                                        flex: 5,
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Align(
                                                              alignment:
                                                                  const AlignmentDirectional(
                                                                      -1.0,
                                                                      0.0),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            15.0,
                                                                            0.0,
                                                                            5.0),
                                                                child: Text(
                                                                  'Grocery',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                  maxLines: 1,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Plus Jakarta Sans',
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                        fontSize:
                                                                            18.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 2,
                                                        child: Container(
                                                          width: 100.0,
                                                          height: 1.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsetsDirectional
                                                      .fromSTEB(24.0, 0.0, 24.0,
                                                          16.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Expanded(
                                                        flex: 5,
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          5.0),
                                                                  child: Text(
                                                                    valueOrDefault<
                                                                        String>(
                                                                      formatNumber(
                                                                        groceryColumnGoodsRevenueRatioRecord
                                                                            ?.grocery,
                                                                        formatType:
                                                                            FormatType.decimal,
                                                                        decimalType:
                                                                            DecimalType.automatic,
                                                                        currency:
                                                                            'P ',
                                                                      ),
                                                                      '0',
                                                                    ),
                                                                    maxLines: 1,
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .displaySmall
                                                                        .override(
                                                                          fontFamily:
                                                                              'Outfit',
                                                                          color:
                                                                              const Color(0xFF14181B),
                                                                          fontSize:
                                                                              36.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .end,
                                                              children: [
                                                                Expanded(
                                                                  child:
                                                                      RichText(
                                                                    textScaler:
                                                                        MediaQuery.of(context)
                                                                            .textScaler,
                                                                    text:
                                                                        TextSpan(
                                                                      children: [
                                                                        const TextSpan(
                                                                          text:
                                                                              'Total spent for groceries since ',
                                                                          style:
                                                                              TextStyle(),
                                                                        ),
                                                                        TextSpan(
                                                                          text:
                                                                              functions.daysAgo(groceryColumnGoodsRevenueRatioRecord!.date!),
                                                                          style:
                                                                              const TextStyle(
                                                                            color:
                                                                                Color(0xFF6F61EF),
                                                                          ),
                                                                        ),
                                                                        const TextSpan(
                                                                          text:
                                                                              '. A ',
                                                                          style:
                                                                              TextStyle(),
                                                                        ),
                                                                        TextSpan(
                                                                          text: (double grocery,
                                                                              double revenue) {
                                                                            return '${(((grocery + revenue == 0) ? 0.0 : revenue / grocery) * 100).toStringAsFixed(1).replaceAll(RegExp(r'\.0*$'), '')}%';
                                                                          }(groceryColumnGoodsRevenueRatioRecord.grocery, groceryColumnGoodsRevenueRatioRecord.revenue),
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondary,
                                                                          ),
                                                                        ),
                                                                        const TextSpan(
                                                                          text:
                                                                              ' uptick in sales is contributing to the recovery of grocery expenditures.',
                                                                          style:
                                                                              TextStyle(),
                                                                        )
                                                                      ],
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelSmall
                                                                          .override(
                                                                            fontFamily:
                                                                                'Readex Pro',
                                                                            letterSpacing:
                                                                                0.0,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      if (valueOrDefault(
                                                              currentUserDocument
                                                                  ?.role,
                                                              '') ==
                                                          'admin')
                                                        Expanded(
                                                          flex: 2,
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .end,
                                                            children: [
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  Padding(
                                                                    padding: const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            10.0,
                                                                            0.0),
                                                                    child:
                                                                        FlutterFlowIconButton(
                                                                      borderColor:
                                                                          FlutterFlowTheme.of(context)
                                                                              .primaryText,
                                                                      borderRadius:
                                                                          30.0,
                                                                      borderWidth:
                                                                          1.0,
                                                                      buttonSize:
                                                                          44.0,
                                                                      icon:
                                                                          Icon(
                                                                        Icons
                                                                            .featured_play_list_outlined,
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                        size:
                                                                            24.0,
                                                                      ),
                                                                      onPressed:
                                                                          () async {
                                                                        // count
                                                                        _model.countGroceries =
                                                                            await queryGroceriesRecordCount(
                                                                          queryBuilder: (groceriesRecord) =>
                                                                              groceriesRecord.where(
                                                                            'hotel',
                                                                            isEqualTo:
                                                                                FFAppState().hotel,
                                                                          ),
                                                                        );
                                                                        if (_model.countGroceries! >
                                                                            0) {
                                                                          context
                                                                              .pushNamed('groceryList');
                                                                        } else {
                                                                          ScaffoldMessenger.of(context)
                                                                              .showSnackBar(
                                                                            SnackBar(
                                                                              content: Text(
                                                                                'There are no groceries yet!',
                                                                                style: TextStyle(
                                                                                  color: FlutterFlowTheme.of(context).info,
                                                                                ),
                                                                              ),
                                                                              duration: const Duration(milliseconds: 4000),
                                                                              backgroundColor: FlutterFlowTheme.of(context).error,
                                                                            ),
                                                                          );
                                                                        }

                                                                        safeSetState(
                                                                            () {});
                                                                      },
                                                                    ),
                                                                  ),
                                                                  FlutterFlowIconButton(
                                                                    borderColor:
                                                                        FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                    borderRadius:
                                                                        30.0,
                                                                    borderWidth:
                                                                        1.0,
                                                                    buttonSize:
                                                                        44.0,
                                                                    icon: Icon(
                                                                      Icons.add,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryText,
                                                                      size:
                                                                          24.0,
                                                                    ),
                                                                    onPressed:
                                                                        () async {
                                                                      await showModalBottomSheet(
                                                                        isScrollControlled:
                                                                            true,
                                                                        backgroundColor:
                                                                            Colors.transparent,
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (context) {
                                                                          return GestureDetector(
                                                                            onTap: () =>
                                                                                FocusScope.of(context).unfocus(),
                                                                            child:
                                                                                Padding(
                                                                              padding: MediaQuery.viewInsetsOf(context),
                                                                              child: const SizedBox(
                                                                                height: double.infinity,
                                                                                child: NewGroceryWidget(),
                                                                              ),
                                                                            ),
                                                                          );
                                                                        },
                                                                      ).then((value) =>
                                                                          safeSetState(
                                                                              () {}));
                                                                    },
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      if ((valueOrDefault(
                                                  currentUserDocument?.role,
                                                  '') !=
                                              'generic') &&
                                          (FFAppState().lockDown == false))
                                        const Divider(
                                          height: 4.0,
                                          thickness: 2.0,
                                          indent: 20.0,
                                          endIndent: 20.0,
                                          color: Color(0xFFE0E3E7),
                                        ),
                                      if ((valueOrDefault(
                                                  currentUserDocument?.role,
                                                  '') !=
                                              'generic') &&
                                          (FFAppState().lockDown == false))
                                        Padding(
                                          padding: const EdgeInsets.all(24.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                'Bills',
                                                maxLines: 1,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .displaySmall
                                                        .override(
                                                          fontFamily: 'Outfit',
                                                          color:
                                                              const Color(0xFF14181B),
                                                          fontSize: 36.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      10.0,
                                                                      0.0),
                                                          child:
                                                              FlutterFlowIconButton(
                                                            borderColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                            borderRadius: 30.0,
                                                            borderWidth: 1.0,
                                                            buttonSize: 44.0,
                                                            icon: Icon(
                                                              Icons
                                                                  .featured_play_list_outlined,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primaryText,
                                                              size: 24.0,
                                                            ),
                                                            onPressed:
                                                                () async {
                                                              _model.countBills =
                                                                  await queryBillsRecordCount(
                                                                queryBuilder:
                                                                    (billsRecord) =>
                                                                        billsRecord
                                                                            .where(
                                                                  'hotel',
                                                                  isEqualTo:
                                                                      FFAppState()
                                                                          .hotel,
                                                                ),
                                                              );
                                                              if (_model
                                                                      .countBills! >
                                                                  0) {
                                                                context.pushNamed(
                                                                    'billsList');
                                                              } else {
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                  SnackBar(
                                                                    content:
                                                                        Text(
                                                                      'There are no bills yet!',
                                                                      style:
                                                                          TextStyle(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .info,
                                                                      ),
                                                                    ),
                                                                    duration: const Duration(
                                                                        milliseconds:
                                                                            4000),
                                                                    backgroundColor:
                                                                        FlutterFlowTheme.of(context)
                                                                            .error,
                                                                  ),
                                                                );
                                                              }

                                                              safeSetState(
                                                                  () {});
                                                            },
                                                          ),
                                                        ),
                                                        FlutterFlowIconButton(
                                                          borderColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .primaryText,
                                                          borderRadius: 30.0,
                                                          borderWidth: 1.0,
                                                          buttonSize: 44.0,
                                                          icon: Icon(
                                                            Icons.add,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryText,
                                                            size: 24.0,
                                                          ),
                                                          onPressed: () async {
                                                            context.pushNamed(
                                                                'BillForm');
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      if (FFAppState().lockDown == false)
                                        const Divider(
                                          height: 4.0,
                                          thickness: 2.0,
                                          indent: 20.0,
                                          endIndent: 20.0,
                                          color: Color(0xFFE0E3E7),
                                        ),
                                      if (FFAppState().lockDown == false)
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  24.0, 24.0, 24.0, 0.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Payroll',
                                                maxLines: 1,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .displaySmall
                                                        .override(
                                                          fontFamily: 'Outfit',
                                                          color:
                                                              const Color(0xFF14181B),
                                                          fontSize: 36.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    FlutterFlowIconButton(
                                                      borderColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      borderRadius: 30.0,
                                                      borderWidth: 1.0,
                                                      buttonSize: 44.0,
                                                      icon: Icon(
                                                        Icons
                                                            .arrow_forward_rounded,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        size: 24.0,
                                                      ),
                                                      onPressed: () async {
                                                        context.pushNamed(
                                                          'Payroll',
                                                          extra: <String,
                                                              dynamic>{
                                                            kTransitionInfoKey:
                                                                const TransitionInfo(
                                                              hasTransition:
                                                                  true,
                                                              transitionType:
                                                                  PageTransitionType
                                                                      .rightToLeft,
                                                            ),
                                                          },
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
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
