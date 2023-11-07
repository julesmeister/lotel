import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/change_remittance/change_remittance_widget.dart';
import '/components/new_issue/new_issue_widget.dart';
import '/components/option_to_issue/option_to_issue_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'home_page_model.dart';
export 'home_page_model.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget>
    with TickerProviderStateMixin {
  late HomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = {
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
          begin: Offset(30.0, 0.0),
          end: Offset(0.0, 0.0),
        ),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
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
      if (FFAppState().lastRemit == null) {
        // update last remit
        setState(() {
          FFAppState().lastRemit = functions.yesterdayDate();
        });
      }
      if (valueOrDefault(currentUserDocument?.role, '') == 'admin') {
        // does a remittance exist?
        _model.remittance = await queryRemittancesRecordCount(
          queryBuilder: (remittancesRecord) => remittancesRecord
              .where(
                'collected',
                isEqualTo: false,
              )
              .where(
                'hotel',
                isEqualTo: FFAppState().hotel,
              ),
        );
        // enable remit button visibility
        setState(() {
          _model.remittanceCount = _model.remittance!;
        });
      } else {
        if (valueOrDefault<bool>(currentUserDocument?.expired, false)) {
          GoRouter.of(context).prepareAuthEvent();
          await authManager.signOut();
          GoRouter.of(context).clearRedirectLocation();

          context.pushNamedAuth('Login', context.mounted);

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
      if (_model.fireStat!.length > 0) {
        // save new ref stat
        setState(() {
          FFAppState().statsReference = _model.fireStat?.first?.reference;
          FFAppState().currentStats = functions.currentMonthYear()!;
        });
        return;
      } else {
        // reset for loop
        setState(() {
          _model.loopRoomCounter = 0;
          _model.roomUsages = [];
        });
        // roomsFire
        _model.roomsFire = await queryRoomsRecordOnce(
          queryBuilder: (roomsRecord) => roomsRecord.where(
            'hotel',
            isEqualTo: FFAppState().hotel,
          ),
        );
        while (_model.loopRoomCounter != _model.roomsFire?.length) {
          // new roomUsage then increment loop
          setState(() {
            _model.addToRoomUsages(RoomUsageStruct(
              number: _model.roomsFire?[_model.loopRoomCounter]?.number,
              use: 0,
            ));
            _model.loopRoomCounter = _model.loopRoomCounter + 1;
          });
        }
        // new stat

        var statsRecordReference2 = StatsRecord.collection.doc();
        await statsRecordReference2.set({
          ...createStatsRecordData(
            hotel: FFAppState().hotel,
            year: functions.currentYear(),
            month: functions.currentMonth(),
            roomsIncome: 0.0,
            goodsIncome: 0.0,
            salaries: 0.0,
            expenses: 0.0,
            days: valueOrDefault<int>(
              functions.daysInTodaysMonth(),
              0,
            ),
            roomLine: updateLineGraphStruct(
              functions.initEmptyLineGraph(),
              clearUnsetFields: false,
              create: true,
            ),
            goodsLine: updateLineGraphStruct(
              functions.initEmptyLineGraph(),
              clearUnsetFields: false,
              create: true,
            ),
          ),
          ...mapToFirestore(
            {
              'roomUsage': getRoomUsageListFirestoreData(
                _model.roomUsages,
              ),
            },
          ),
        });
        _model.createStat = StatsRecord.getDocumentFromData({
          ...createStatsRecordData(
            hotel: FFAppState().hotel,
            year: functions.currentYear(),
            month: functions.currentMonth(),
            roomsIncome: 0.0,
            goodsIncome: 0.0,
            salaries: 0.0,
            expenses: 0.0,
            days: valueOrDefault<int>(
              functions.daysInTodaysMonth(),
              0,
            ),
            roomLine: updateLineGraphStruct(
              functions.initEmptyLineGraph(),
              clearUnsetFields: false,
              create: true,
            ),
            goodsLine: updateLineGraphStruct(
              functions.initEmptyLineGraph(),
              clearUnsetFields: false,
              create: true,
            ),
          ),
          ...mapToFirestore(
            {
              'roomUsage': getRoomUsageListFirestoreData(
                _model.roomUsages,
              ),
            },
          ),
        }, statsRecordReference2);
        // save new ref stat
        setState(() {
          FFAppState().statsReference = _model.createStat?.reference;
          FFAppState().currentStats = functions.currentMonthYear()!;
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

    return StreamBuilder<List<HotelSettingsRecord>>(
      stream: FFAppState().hoteSettings(
        requestFn: () => queryHotelSettingsRecord(
          queryBuilder: (hotelSettingsRecord) => hotelSettingsRecord.where(
            'hotel',
            isEqualTo: FFAppState().hotel,
          ),
          singleRecord: true,
        ),
      )..listen((snapshot) async {
          List<HotelSettingsRecord> homePageHotelSettingsRecordList = snapshot;
          final homePageHotelSettingsRecord =
              homePageHotelSettingsRecordList.isNotEmpty
                  ? homePageHotelSettingsRecordList.first
                  : null;
          if (_model.homePagePreviousSnapshot != null &&
              !const ListEquality(HotelSettingsRecordDocumentEquality()).equals(
                  homePageHotelSettingsRecordList,
                  _model.homePagePreviousSnapshot)) {
            // Get Hotel
            _model.hotel = await HotelSettingsRecord.getDocumentOnce(
                homePageHotelSettingsRecord!.reference);
            setState(() {
              FFAppState().lastRemit = _model.hotel?.lastRemit;
            });

            setState(() {});
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
          onTap: () => _model.unfocusNode.canRequestFocus
              ? FocusScope.of(context).requestFocus(_model.unfocusNode)
              : FocusScope.of(context).unfocus(),
          child: Scaffold(
            key: scaffoldKey,
            body: SafeArea(
              top: true,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 3.0,
                      color: Color(0x32000000),
                      offset: Offset(0.0, 1.0),
                    )
                  ],
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              24.0, 24.0, 24.0, 16.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Sales',
                                    style: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily: 'Plus Jakarta Sans',
                                          color: Color(0xFF57636C),
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                  if (valueOrDefault(
                                          currentUserDocument?.role, '') !=
                                      'generic')
                                    AuthUserStreamWidget(
                                      builder: (context) => StreamBuilder<
                                          List<TransactionsRecord>>(
                                        stream: _model.salesTotal(
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
                                          List<TransactionsRecord>
                                              textTransactionsRecordList =
                                              snapshot.data!;
                                          return Text(
                                            formatNumber(
                                              functions.totalToRemit(
                                                  textTransactionsRecordList
                                                      .toList()),
                                              formatType: FormatType.decimal,
                                              decimalType:
                                                  DecimalType.automatic,
                                              currency: 'P ',
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .displaySmall
                                                .override(
                                                  fontFamily: 'Outfit',
                                                  color: Color(0xFF14181B),
                                                  fontSize: 36.0,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          );
                                        },
                                      ),
                                    ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 4.0, 0.0, 0.0),
                                    child: Text(
                                      dateTimeFormat(
                                          'yMMMd', getCurrentTimestamp),
                                      textAlign: TextAlign.start,
                                      style: FlutterFlowTheme.of(context)
                                          .labelSmall
                                          .override(
                                            fontFamily: 'Plus Jakarta Sans',
                                            color: Color(0xFF57636C),
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 15.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        RichText(
                                          textScaleFactor:
                                              MediaQuery.of(context)
                                                  .textScaleFactor,
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: 'Last Remit: ',
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Readex Pro',
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryText,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                              ),
                                              TextSpan(
                                                text: dateTimeFormat('yMMMd',
                                                    FFAppState().lastRemit),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              )
                                            ],
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium,
                                          ),
                                        ),
                                        Text(
                                          dateTimeFormat(
                                              'jm', FFAppState().lastRemit),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Readex Pro',
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (valueOrDefault(
                                              currentUserDocument?.role, '') ==
                                          'admin'
                                      ? (_model.remittanceCount > 0)
                                      : (homePageHotelSettingsRecord!
                                              .remittable &&
                                          functions.moreThan12Hrs(
                                              homePageHotelSettingsRecord
                                                  ?.lastRemit)!))
                                    AuthUserStreamWidget(
                                      builder: (context) => FFButtonWidget(
                                        onPressed: () async {
                                          var _shouldSetState = false;
                                          if (FFAppState().role == 'admin') {
                                            // Accept Remittance
                                            var confirmDialogResponse =
                                                await showDialog<bool>(
                                                      context: context,
                                                      builder:
                                                          (alertDialogContext) {
                                                        return AlertDialog(
                                                          title: Text(
                                                              'Accept Remittance'),
                                                          content: Text(
                                                              'Are you sure you want to accept this remittance?'),
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
                                              _model.unRemitted =
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
                                                            .where(
                                                              'collected',
                                                              isEqualTo: false,
                                                            ),
                                                singleRecord: true,
                                              ).then((s) => s.firstOrNull);
                                              _shouldSetState = true;

                                              await _model.unRemitted!.reference
                                                  .update(
                                                      createRemittancesRecordData(
                                                collected: true,
                                                collectedBy:
                                                    currentUserReference,
                                              ));
                                            } else {
                                              if (_shouldSetState)
                                                setState(() {});
                                              return;
                                            }

                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'Remittance Collected',
                                                  style: TextStyle(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                  ),
                                                ),
                                                duration: Duration(
                                                    milliseconds: 4000),
                                                backgroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                              ),
                                            );
                                          } else {
                                            await showModalBottomSheet(
                                              isScrollControlled: true,
                                              backgroundColor:
                                                  Colors.transparent,
                                              useSafeArea: true,
                                              context: context,
                                              builder: (context) {
                                                return GestureDetector(
                                                  onTap: () => _model
                                                          .unfocusNode
                                                          .canRequestFocus
                                                      ? FocusScope.of(context)
                                                          .requestFocus(_model
                                                              .unfocusNode)
                                                      : FocusScope.of(context)
                                                          .unfocus(),
                                                  child: Padding(
                                                    padding:
                                                        MediaQuery.viewInsetsOf(
                                                            context),
                                                    child:
                                                        ChangeRemittanceWidget(),
                                                  ),
                                                );
                                              },
                                            ).then(
                                                (value) => safeSetState(() {}));
                                          }

                                          // Update lastremit
                                          setState(() {
                                            FFAppState().lastRemit =
                                                functions.today();
                                          });
                                          // Update hotel setting

                                          await homePageHotelSettingsRecord!
                                              .reference
                                              .update(
                                                  createHotelSettingsRecordData(
                                            lastRemit: functions.today(),
                                          ));
                                          if (_shouldSetState) setState(() {});
                                        },
                                        text: valueOrDefault(
                                                    currentUserDocument?.role,
                                                    '') ==
                                                'admin'
                                            ? 'Collect'
                                            : 'Remit',
                                        options: FFButtonOptions(
                                          width: 110.0,
                                          height: 40.0,
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 0.0),
                                          iconPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 0.0),
                                          color: Color(0xFF4B39EF),
                                          textStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily:
                                                        'Plus Jakarta Sans',
                                                    color: Colors.white,
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                    ),
                                ],
                              ).animateOnPageLoad(
                                  animationsMap['columnOnPageLoadAnimation']!),
                            ],
                          ),
                        ),
                        if (valueOrDefault(currentUserDocument?.role, '') ==
                            'admin')
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 12.0, 0.0),
                            child: AuthUserStreamWidget(
                              builder: (context) => Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 12.0, 12.0, 0.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Align(
                                          alignment:
                                              AlignmentDirectional(0.00, 0.00),
                                          child: Text(
                                            'Stats',
                                            style: FlutterFlowTheme.of(context)
                                                .headlineSmall,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  FlutterFlowIconButton(
                                    borderRadius: 20.0,
                                    borderWidth: 1.0,
                                    buttonSize: 40.0,
                                    icon: Icon(
                                      Icons.keyboard_arrow_right_rounded,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      size: 24.0,
                                    ),
                                    onPressed: () async {
                                      context.pushNamed('Stats');
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        if (valueOrDefault(currentUserDocument?.role, '') ==
                            'admin')
                          AuthUserStreamWidget(
                            builder: (context) => Container(
                              width: double.infinity,
                              height: 120.0,
                              constraints: BoxConstraints(
                                maxHeight: 140.0,
                              ),
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 4.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 8.0, 0.0, 0.0),
                                        child: ListView(
                                          padding: EdgeInsets.zero,
                                          primary: false,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      16.0, 0.0, 8.0, 8.0),
                                              child: Container(
                                                width: 130.0,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  border: Border.all(
                                                    color: Color(0xFFE0E3E7),
                                                    width: 2.0,
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(12.0, 12.0,
                                                          12.0, 12.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      FutureBuilder<int>(
                                                        future: FFAppState()
                                                            .checkInCount(
                                                          requestFn: () =>
                                                              queryRoomsRecordCount(
                                                            queryBuilder:
                                                                (roomsRecord) =>
                                                                    roomsRecord
                                                                        .where(
                                                                          'hotel',
                                                                          isEqualTo:
                                                                              FFAppState().hotel,
                                                                        )
                                                                        .where(
                                                                          'vacant',
                                                                          isEqualTo:
                                                                              false,
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
                                                          return Text(
                                                            textCount
                                                                .toString(),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .displaySmall,
                                                          );
                                                        },
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    4.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: Text(
                                                          'Check Ins',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .labelMedium,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 8.0, 8.0),
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  context
                                                      .pushNamed('Replenish');
                                                },
                                                child: Container(
                                                  width: 130.0,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    border: Border.all(
                                                      color: Color(0xFFE0E3E7),
                                                      width: 2.0,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                12.0,
                                                                12.0,
                                                                12.0,
                                                                12.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
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
                                                            return Text(
                                                              textCount
                                                                  .toString(),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .displaySmall
                                                                  .override(
                                                                    fontFamily:
                                                                        'Outfit',
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .tertiary,
                                                                  ),
                                                            );
                                                          },
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      4.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: Text(
                                                            'To Replenish',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .labelMedium,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 8.0, 8.0),
                                              child: Container(
                                                width: 130.0,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  border: Border.all(
                                                    color: Color(0xFFE0E3E7),
                                                    width: 2.0,
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(12.0, 12.0,
                                                          12.0, 12.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      FutureBuilder<int>(
                                                        future: _model
                                                            .totalTransactions(
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
                                                          return Text(
                                                            textCount
                                                                .toString(),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .displaySmall
                                                                .override(
                                                                  fontFamily:
                                                                      'Outfit',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary,
                                                                ),
                                                          );
                                                        },
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    4.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: Text(
                                                          'Transactions',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .labelMedium,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 0.0, 16.0, 8.0),
                                              child: Container(
                                                width: 150.0,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  border: Border.all(
                                                    color: Color(0xFFE0E3E7),
                                                    width: 2.0,
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(12.0, 12.0,
                                                          12.0, 12.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      FutureBuilder<int>(
                                                        future:
                                                            FFAppState().staffs(
                                                          requestFn: () =>
                                                              queryUsersRecordCount(
                                                            queryBuilder:
                                                                (usersRecord) =>
                                                                    usersRecord
                                                                        .where(
                                                                          'hotel',
                                                                          isEqualTo:
                                                                              FFAppState().hotel,
                                                                        )
                                                                        .where(
                                                                          'role',
                                                                          isEqualTo:
                                                                              'staff',
                                                                        )
                                                                        .where(
                                                                          'expired',
                                                                          isEqualTo:
                                                                              false,
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
                                                          return Text(
                                                            textCount
                                                                .toString(),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .displaySmall
                                                                .override(
                                                                  fontFamily:
                                                                      'Outfit',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondary,
                                                                ),
                                                          );
                                                        },
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    4.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: Text(
                                                          'Staffs',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .labelMedium,
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
                            ),
                          ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 4.0, 0.0, 12.0),
                          child: StreamBuilder<List<RoomsRecord>>(
                            stream: FFAppState().rooms(
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
                                      valueColor: AlwaysStoppedAnimation<Color>(
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
                                height: 230.0,
                                decoration: BoxDecoration(
                                  color: Color(0xFF4B39EF),
                                  borderRadius: BorderRadius.circular(0.0),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16.0, 12.0, 0.0, 0.0),
                                          child: Text(
                                            'Rooms',
                                            style: FlutterFlowTheme.of(context)
                                                .headlineMedium
                                                .override(
                                                  fontFamily: 'Outfit',
                                                  color: Colors.white,
                                                  fontSize: 24.0,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                          ),
                                        ),
                                        if (valueOrDefault(
                                                currentUserDocument?.role,
                                                '') ==
                                            'admin')
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 12.0, 0.0, 0.0),
                                            child: AuthUserStreamWidget(
                                              builder: (context) =>
                                                  FlutterFlowIconButton(
                                                borderColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                borderRadius: 20.0,
                                                borderWidth: 1.0,
                                                buttonSize: 40.0,
                                                fillColor:
                                                    FlutterFlowTheme.of(context)
                                                        .accent1,
                                                icon: Icon(
                                                  Icons.edit_note_rounded,
                                                  color: Colors.white,
                                                  size: 24.0,
                                                ),
                                                onPressed: () async {
                                                  context.pushNamed('RoomList');
                                                },
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                    Expanded(
                                      child: Builder(
                                        builder: (context) {
                                          final rooms =
                                              roomContainerRoomsRecordList
                                                  .map((e) => e)
                                                  .toList();
                                          return ListView.builder(
                                            padding: EdgeInsets.fromLTRB(
                                              0,
                                              0,
                                              20.0,
                                              0,
                                            ),
                                            primary: false,
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: rooms.length,
                                            itemBuilder: (context, roomsIndex) {
                                              final roomsItem =
                                                  rooms[roomsIndex];
                                              return Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        12.0, 12.0, 0.0, 12.0),
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
                                                        'RoomHistory',
                                                        queryParameters: {
                                                          'room':
                                                              serializeParam(
                                                            roomsItem,
                                                            ParamType.Document,
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
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .info,
                                                            ),
                                                          ),
                                                          duration: Duration(
                                                              milliseconds:
                                                                  4000),
                                                          backgroundColor:
                                                              Color(0xFFFF5963),
                                                        ),
                                                      );
                                                    }

                                                    setState(() {});
                                                  },
                                                  child: Container(
                                                    width: 210.0,
                                                    height: 100.0,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          blurRadius: 4.0,
                                                          color:
                                                              Color(0x2B202529),
                                                          offset:
                                                              Offset(0.0, 2.0),
                                                        )
                                                      ],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.0),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  12.0,
                                                                  12.0,
                                                                  12.0,
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
                                                            children: [
                                                              Expanded(
                                                                child: Text(
                                                                  'Room',
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyLarge
                                                                      .override(
                                                                        fontFamily:
                                                                            'Plus Jakarta Sans',
                                                                        color: Color(
                                                                            0xFF14181B),
                                                                        fontSize:
                                                                            16.0,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Text(
                                                                  roomsItem
                                                                      .number
                                                                      .toString(),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyLarge
                                                                      .override(
                                                                        fontFamily:
                                                                            'Plus Jakarta Sans',
                                                                        color: Color(
                                                                            0xFF14181B),
                                                                        fontSize:
                                                                            16.0,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                ),
                                                              ),
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            4.0,
                                                                            0.0),
                                                                    child: Text(
                                                                      roomsItem
                                                                          .guests
                                                                          .toString(),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'Plus Jakarta Sans',
                                                                            color:
                                                                                Color(0xFF14181B),
                                                                            fontSize:
                                                                                14.0,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            4.0,
                                                                            0.0),
                                                                    child: Text(
                                                                      'Guests',
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'Plus Jakarta Sans',
                                                                            color:
                                                                                Color(0xFF14181B),
                                                                            fontSize:
                                                                                14.0,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        20.0,
                                                                        0.0,
                                                                        0.0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .end,
                                                              children: [
                                                                Text(
                                                                  formatNumber(
                                                                    roomsItem
                                                                        .price,
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
                                                                      .displaySmall
                                                                      .override(
                                                                        fontFamily:
                                                                            'Outfit',
                                                                        color: Color(
                                                                            0xFF14181B),
                                                                        fontSize:
                                                                            36.0,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                      ),
                                                                ),
                                                                FlutterFlowIconButton(
                                                                  borderColor:
                                                                      Color(
                                                                          0xFFF1F4F8),
                                                                  borderRadius:
                                                                      30.0,
                                                                  borderWidth:
                                                                      2.0,
                                                                  buttonSize:
                                                                      44.0,
                                                                  icon: Icon(
                                                                    Icons
                                                                        .arrow_forward_rounded,
                                                                    color: Color(
                                                                        0xFF57636C),
                                                                    size: 24.0,
                                                                  ),
                                                                  onPressed:
                                                                      () async {
                                                                    if (roomsItem
                                                                            .vacant ==
                                                                        true) {
                                                                      if (FFAppState()
                                                                              .bedPrice ==
                                                                          null) {
                                                                        ScaffoldMessenger.of(context)
                                                                            .showSnackBar(
                                                                          SnackBar(
                                                                            content:
                                                                                Text(
                                                                              'Extra bed price has not yet been set',
                                                                              style: TextStyle(
                                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                              ),
                                                                            ),
                                                                            duration:
                                                                                Duration(milliseconds: 4000),
                                                                            backgroundColor:
                                                                                FlutterFlowTheme.of(context).secondary,
                                                                          ),
                                                                        );
                                                                      } else {
                                                                        context
                                                                            .pushNamed(
                                                                          'CheckIn',
                                                                          queryParameters:
                                                                              {
                                                                            'ref':
                                                                                serializeParam(
                                                                              roomsItem.reference,
                                                                              ParamType.DocumentReference,
                                                                            ),
                                                                            'price':
                                                                                serializeParam(
                                                                              roomsItem.price,
                                                                              ParamType.double,
                                                                            ),
                                                                            'roomNo':
                                                                                serializeParam(
                                                                              roomsItem.number,
                                                                              ParamType.int,
                                                                            ),
                                                                            'extend':
                                                                                serializeParam(
                                                                              false,
                                                                              ParamType.bool,
                                                                            ),
                                                                          }.withoutNulls,
                                                                        );
                                                                      }
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
                                                                      );
                                                                    }
                                                                  },
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        15.0,
                                                                        0.0,
                                                                        0.0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .meeting_room_outlined,
                                                                  color: roomsItem
                                                                              .vacant ==
                                                                          true
                                                                      ? FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondary
                                                                      : Color(
                                                                          0xFFFF5963),
                                                                  size: 24.0,
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          10.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child: Text(
                                                                    roomsItem.vacant ==
                                                                            true
                                                                        ? 'Vacant'
                                                                        : 'Occupied',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              'Plus Jakarta Sans',
                                                                          color:
                                                                              Color(0xFF14181B),
                                                                          fontSize:
                                                                              14.0,
                                                                          fontWeight:
                                                                              FontWeight.w500,
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
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: FutureBuilder<int>(
                            future: FFAppState().issued(
                              requestFn: () => queryIssuesRecordCount(
                                queryBuilder: (issuesRecord) =>
                                    issuesRecord.where(
                                  'hotel',
                                  isEqualTo: FFAppState().hotel,
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
                              int columnCount = snapshot.data!;
                              return Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 10.0, 16.0, 0.0),
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
                                                fontFamily: 'Outfit',
                                                color: Color(0xFF14181B),
                                                fontSize: 24.0,
                                                fontWeight: FontWeight.normal,
                                              ),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 0.0, 10.0, 0.0),
                                                  child: FlutterFlowIconButton(
                                                    borderColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .alternate,
                                                    borderRadius: 10.0,
                                                    borderWidth: 1.0,
                                                    buttonSize: 40.0,
                                                    icon: Icon(
                                                      Icons
                                                          .featured_play_list_outlined,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      size: 24.0,
                                                    ),
                                                    onPressed: () async {
                                                      context.pushNamed(
                                                          'IssuesList');
                                                    },
                                                  ),
                                                ),
                                                FlutterFlowIconButton(
                                                  borderColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .alternate,
                                                  borderRadius: 10.0,
                                                  borderWidth: 1.0,
                                                  buttonSize: 40.0,
                                                  icon: Icon(
                                                    Icons.add,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    size: 24.0,
                                                  ),
                                                  onPressed: () async {
                                                    await showModalBottomSheet(
                                                      isScrollControlled: true,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      enableDrag: false,
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
                                                                NewIssueWidget(),
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
                                  StreamBuilder<List<IssuesRecord>>(
                                    stream: _model.issueHome(
                                      requestFn: () => queryIssuesRecord(
                                        queryBuilder: (issuesRecord) =>
                                            issuesRecord
                                                .where(
                                                  'hotel',
                                                  isEqualTo: FFAppState().hotel,
                                                )
                                                .orderBy('date',
                                                    descending: true),
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
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                      List<IssuesRecord>
                                          containerIssuesRecordList =
                                          snapshot.data!;
                                      return Container(
                                        width: double.infinity,
                                        height: 130.0,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                        ),
                                        child: Visibility(
                                          visible: columnCount > 0,
                                          child: Builder(
                                            builder: (context) {
                                              final issuesList =
                                                  containerIssuesRecordList
                                                      .toList();
                                              return ListView.builder(
                                                padding: EdgeInsets.zero,
                                                shrinkWrap: true,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: issuesList.length,
                                                itemBuilder:
                                                    (context, issuesListIndex) {
                                                  final issuesListItem =
                                                      issuesList[
                                                          issuesListIndex];
                                                  return Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                16.0,
                                                                12.0,
                                                                16.0,
                                                                16.0),
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
                                                                    Container(
                                                                  height: 180.0,
                                                                  child:
                                                                      OptionToIssueWidget(
                                                                    ref: issuesListItem
                                                                        .reference,
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        ).then((value) =>
                                                            safeSetState(
                                                                () {}));
                                                      },
                                                      child: Container(
                                                        width: 342.0,
                                                        height: 100.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          boxShadow: [
                                                            BoxShadow(
                                                              blurRadius: 12.0,
                                                              color: Color(
                                                                  0x34000000),
                                                              offset: Offset(
                                                                  -2.0, 5.0),
                                                            )
                                                          ],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      8.0,
                                                                      8.0,
                                                                      12.0,
                                                                      8.0),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
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
                                                                  padding: EdgeInsetsDirectional
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
                                                                      Text(
                                                                        issuesListItem
                                                                            .status,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              fontFamily: 'Plus Jakarta Sans',
                                                                              color: issuesListItem.status == 'pending' ? FlutterFlowTheme.of(context).error : FlutterFlowTheme.of(context).secondary,
                                                                              fontSize: 14.0,
                                                                              fontWeight: FontWeight.w500,
                                                                            ),
                                                                      ),
                                                                      Flexible(
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              3.0,
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              StreamBuilder<UsersRecord>(
                                                                            stream:
                                                                                UsersRecord.getDocument(issuesListItem.staff!),
                                                                            builder:
                                                                                (context, snapshot) {
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
                                                                              final richTextUsersRecord = snapshot.data!;
                                                                              return RichText(
                                                                                textScaleFactor: MediaQuery.of(context).textScaleFactor,
                                                                                text: TextSpan(
                                                                                  children: [
                                                                                    TextSpan(
                                                                                      text: 'Reported by ',
                                                                                      style: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                            fontFamily: 'Plus Jakarta Sans',
                                                                                          ),
                                                                                    ),
                                                                                    TextSpan(
                                                                                      text: richTextUsersRecord.displayName,
                                                                                      style: TextStyle(),
                                                                                    ),
                                                                                    TextSpan(
                                                                                      text: ' on ',
                                                                                      style: TextStyle(),
                                                                                    ),
                                                                                    TextSpan(
                                                                                      text: dateTimeFormat('MMM d h:mm a', issuesListItem.date!),
                                                                                      style: TextStyle(),
                                                                                    )
                                                                                  ],
                                                                                  style: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                        fontFamily: 'Plus Jakarta Sans',
                                                                                        color: Color(0xFF57636C),
                                                                                        fontWeight: FontWeight.w500,
                                                                                      ),
                                                                                ),
                                                                              );
                                                                            },
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Flexible(
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              4.0,
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              AutoSizeText(
                                                                            issuesListItem.detail,
                                                                            style: FlutterFlowTheme.of(context).headlineSmall.override(
                                                                                  fontFamily: 'Outfit',
                                                                                  color: Color(0xFF14181B),
                                                                                  fontSize: 24.0,
                                                                                  fontWeight: FontWeight.w500,
                                                                                ),
                                                                            minFontSize:
                                                                                12.0,
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
                                      );
                                    },
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
