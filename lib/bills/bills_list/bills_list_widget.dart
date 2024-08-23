import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/forms/change_date/change_date_widget.dart';
import '/components/options/option_to_bill/option_to_bill_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:math';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'bills_list_model.dart';
export 'bills_list_model.dart';

class BillsListWidget extends StatefulWidget {
  const BillsListWidget({super.key});

  @override
  State<BillsListWidget> createState() => _BillsListWidgetState();
}

class _BillsListWidgetState extends State<BillsListWidget>
    with TickerProviderStateMixin {
  late BillsListModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BillsListModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      // all bills
      _model.allBills = await queryBillsRecordOnce(
        queryBuilder: (billsRecord) => billsRecord
            .where(
              'hotel',
              isEqualTo: FFAppState().hotel,
            )
            .where(
              'date',
              isGreaterThanOrEqualTo: functions.startOfYear(_model.year),
            )
            .where(
              'date',
              isLessThanOrEqualTo: functions.endOfYear(_model.year),
            )
            .orderBy('date', descending: true),
        limit: 50,
      );
      // additional
      _model.additional = await queryOptionsRecordOnce(
        queryBuilder: (optionsRecord) => optionsRecord.where(
          'type',
          isEqualTo: 'bill',
        ),
      );
      // set all descriptions
      _model.allDescriptions = functions
          .billsChoices(
              _model.allBills?.map((e) => e.description).toList()?.toList(),
              _model.additional!.map((e) => e.choice).toList().toList())
          .toList()
          .cast<String>();
      _model.year = functions.currentYear();
      setState(() {});
    });

    animationsMap.addAll({
      'iconButtonOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: Offset(-100.0, 0.0),
            end: Offset(0.0, 0.0),
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
            begin: Offset(100.0, 0.0),
            end: Offset(0.0, 0.0),
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
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            fillColor: FlutterFlowTheme.of(context).secondaryBackground,
            icon: Icon(
              Icons.chevron_left,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 30.0,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          title: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Records of Bills',
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                      fontFamily: 'Outfit',
                      color: FlutterFlowTheme.of(context).primaryText,
                      fontSize: 22.0,
                      letterSpacing: 0.0,
                    ),
              ),
              if (valueOrDefault(currentUserDocument?.role, '') == 'admin')
                AuthUserStreamWidget(
                  builder: (context) => Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        FFAppState().hotel,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Readex Pro',
                              letterSpacing: 0.0,
                            ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            FFAppState().hotel =
                                functions.nextHotel(FFAppState().hotel);
                            setState(() {});
                          },
                          child: Icon(
                            Icons.switch_left,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            size: 18.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          actions: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                FlutterFlowIconButton(
                  borderRadius: 20.0,
                  borderWidth: 1.0,
                  buttonSize: 60.0,
                  icon: Icon(
                    Icons.list_alt_outlined,
                    color: FlutterFlowTheme.of(context).primaryText,
                    size: 24.0,
                  ),
                  onPressed: () async {
                    context.pushNamed('HistoryInBills');
                  },
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                  child: FlutterFlowIconButton(
                    borderRadius: 20.0,
                    borderWidth: 1.0,
                    buttonSize: 60.0,
                    icon: Icon(
                      Icons.add,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 24.0,
                    ),
                    onPressed: () async {
                      context.pushNamed('BillForm');
                    },
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
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        // set previous year
                        _model.year =
                            functions.previousYear('January', _model.year);
                        setState(() {});
                      },
                    ).animateOnPageLoad(
                        animationsMap['iconButtonOnPageLoadAnimation1']!),
                    Text(
                      _model.year,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
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
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 30.0,
                      ),
                      onPressed: () async {
                        // set next year
                        _model.year =
                            functions.nextYear(_model.year, 'December');
                        setState(() {});
                      },
                    ).animateOnPageLoad(
                        animationsMap['iconButtonOnPageLoadAnimation2']!),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                child: FlutterFlowChoiceChips(
                  options: _model.allDescriptions
                      .map((label) => ChipData(label))
                      .toList(),
                  onChanged: (val) async {
                    setState(() => _model.choiceChipsValue =
                        val?.firstOrNull); // reset showInList
                    _model.showInList = [];
                    setState(() {});
                    if (_model.choiceChipsValue == 'All') {
                      // all
                      _model.showInList =
                          _model.allDescriptions.toList().cast<String>();
                      setState(() {});
                    } else {
                      // choice only
                      _model.addToShowInList(_model.choiceChipsValue!);
                      setState(() {});
                    }
                  },
                  selectedChipStyle: ChipStyle(
                    backgroundColor: FlutterFlowTheme.of(context).primary,
                    textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Readex Pro',
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          letterSpacing: 0.0,
                        ),
                    iconColor: FlutterFlowTheme.of(context).secondaryBackground,
                    iconSize: 18.0,
                    labelPadding:
                        EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                    elevation: 4.0,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  unselectedChipStyle: ChipStyle(
                    backgroundColor: FlutterFlowTheme.of(context).alternate,
                    textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Readex Pro',
                          color: FlutterFlowTheme.of(context).secondaryText,
                          letterSpacing: 0.0,
                        ),
                    iconColor: FlutterFlowTheme.of(context).secondaryText,
                    iconSize: 18.0,
                    labelPadding:
                        EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                    elevation: 0.0,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  chipSpacing: 12.0,
                  rowSpacing: 12.0,
                  multiselect: false,
                  initialized: _model.choiceChipsValue != null,
                  alignment: WrapAlignment.start,
                  controller: _model.choiceChipsValueController ??=
                      FormFieldController<List<String>>(
                    ['All'],
                  ),
                  wrapped: false,
                ),
              ),
              if (_model.choiceChipsValue != 'All')
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 10.0),
                  child: Container(
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).accent4,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 12.0, 8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 4.0,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(0xFF4B39EF),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  12.0, 0.0, 0.0, 0.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Total',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Plus Jakarta Sans',
                                          color: Color(0xFF4B39EF),
                                          fontSize: 18.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                12.0, 0.0, 0.0, 0.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                FutureBuilder<List<BillsRecord>>(
                                  future: queryBillsRecordOnce(
                                    queryBuilder: (billsRecord) => billsRecord
                                        .where(
                                          'hotel',
                                          isEqualTo: FFAppState().hotel,
                                        )
                                        .whereIn(
                                            'description', _model.showInList)
                                        .where(
                                          'date',
                                          isGreaterThanOrEqualTo: functions
                                              .startOfYear(_model.year),
                                        )
                                        .where(
                                          'date',
                                          isLessThanOrEqualTo:
                                              functions.endOfYear(_model.year),
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
                                    List<BillsRecord> textBillsRecordList =
                                        snapshot.data!;

                                    return Text(
                                      formatNumber(
                                        functions.totalOfSpecificBill(functions
                                            .showBills(
                                                _model.allBills!.toList(),
                                                _model.choiceChipsValue!)
                                            ?.toList()),
                                        formatType: FormatType.decimal,
                                        decimalType: DecimalType.automatic,
                                        currency: 'Php ',
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .headlineSmall
                                          .override(
                                            fontFamily: 'Outfit',
                                            color: Color(0xFF14181B),
                                            fontSize: 24.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
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
                  ),
                ),
              Expanded(
                child: Builder(
                  builder: (context) {
                    final bills = functions
                            .showBills(_model.allBills!.toList(),
                                _model.choiceChipsValue!)
                            ?.toList() ??
                        [];

                    return ListView.separated(
                      padding: EdgeInsets.zero,
                      primary: false,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: bills.length,
                      separatorBuilder: (_, __) => SizedBox(height: 1.0),
                      itemBuilder: (context, billsIndex) {
                        final billsItem = bills[billsIndex];
                        return InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            if (valueOrDefault(currentUserDocument?.role, '') ==
                                'admin') {
                              await showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (context) {
                                  return GestureDetector(
                                    onTap: () =>
                                        FocusScope.of(context).unfocus(),
                                    child: Padding(
                                      padding: MediaQuery.viewInsetsOf(context),
                                      child: Container(
                                        height: 218.0,
                                        child: OptionToBillWidget(
                                          bill: billsItem,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ).then((value) => safeSetState(() {}));
                            }
                          },
                          onDoubleTap: () async {
                            // reset
                            _model.showInList = [];
                            setState(() {});
                            // add to showInList
                            _model.addToShowInList(billsItem.description);
                            setState(() {});
                          },
                          child: Container(
                            width: 100.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 0.0,
                                  color: FlutterFlowTheme.of(context).alternate,
                                  offset: Offset(
                                    0.0,
                                    1.0,
                                  ),
                                )
                              ],
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 12.0, 16.0, 5.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          var _shouldSetState = false;
                                          if (valueOrDefault(
                                                  currentUserDocument?.role,
                                                  '') ==
                                              'admin') {
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
                                                    child: Container(
                                                      height: double.infinity,
                                                      child: ChangeDateWidget(
                                                        date: billsItem.date!,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ).then((value) => safeSetState(() =>
                                                _model.adjustedDate = value));

                                            _shouldSetState = true;
                                            if (_model.adjustedDate != null) {
                                              if (dateTimeFormat(
                                                      "M", billsItem.date) ==
                                                  dateTimeFormat("M",
                                                      _model.adjustedDate)) {
                                                // adjusted
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      'Date has been adjusted!',
                                                      style: TextStyle(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                      ),
                                                    ),
                                                    duration: Duration(
                                                        milliseconds: 4000),
                                                    backgroundColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .secondary,
                                                  ),
                                                );
                                              } else {
                                                // prevStats
                                                _model.prevStats =
                                                    await queryStatsRecordOnce(
                                                  queryBuilder: (statsRecord) =>
                                                      statsRecord
                                                          .where(
                                                            'month',
                                                            isEqualTo:
                                                                dateTimeFormat(
                                                                    "MMMM",
                                                                    billsItem
                                                                        .date),
                                                          )
                                                          .where(
                                                            'year',
                                                            isEqualTo:
                                                                dateTimeFormat(
                                                                    "y",
                                                                    billsItem
                                                                        .date),
                                                          )
                                                          .where(
                                                            'hotel',
                                                            isEqualTo:
                                                                FFAppState()
                                                                    .hotel,
                                                          ),
                                                  singleRecord: true,
                                                ).then((s) => s.firstOrNull);
                                                _shouldSetState = true;
                                                // deduct from prev stats

                                                await _model
                                                    .prevStats!.reference
                                                    .update({
                                                  ...mapToFirestore(
                                                    {
                                                      'bills':
                                                          FieldValue.increment(
                                                              -(billsItem
                                                                  .amount)),
                                                    },
                                                  ),
                                                });
                                                // belongingStats
                                                _model.belongingStats =
                                                    await queryStatsRecordOnce(
                                                  queryBuilder: (statsRecord) =>
                                                      statsRecord
                                                          .where(
                                                            'month',
                                                            isEqualTo:
                                                                dateTimeFormat(
                                                                    "MMMM",
                                                                    _model
                                                                        .adjustedDate),
                                                          )
                                                          .where(
                                                            'year',
                                                            isEqualTo:
                                                                dateTimeFormat(
                                                                    "y",
                                                                    _model
                                                                        .adjustedDate),
                                                          )
                                                          .where(
                                                            'hotel',
                                                            isEqualTo:
                                                                FFAppState()
                                                                    .hotel,
                                                          ),
                                                  singleRecord: true,
                                                ).then((s) => s.firstOrNull);
                                                _shouldSetState = true;
                                                if (_model.belongingStats
                                                        ?.reference !=
                                                    null) {
                                                  // increment

                                                  await _model
                                                      .belongingStats!.reference
                                                      .update({
                                                    ...mapToFirestore(
                                                      {
                                                        'bills': FieldValue
                                                            .increment(billsItem
                                                                .amount),
                                                      },
                                                    ),
                                                  });
                                                } else {
                                                  // inexistent
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'Metrics from this date does not exist yet!',
                                                        style: TextStyle(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                        ),
                                                      ),
                                                      duration: Duration(
                                                          milliseconds: 4000),
                                                      backgroundColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .error,
                                                    ),
                                                  );
                                                  if (_shouldSetState)
                                                    setState(() {});
                                                  return;
                                                }

                                                // bill change

                                                await BillChangesRecord
                                                    .collection
                                                    .doc()
                                                    .set(
                                                        createBillChangesRecordData(
                                                      date: getCurrentTimestamp,
                                                      description: functions
                                                          .monthWasChanged(
                                                              billsItem.date!,
                                                              _model
                                                                  .adjustedDate!,
                                                              billsItem
                                                                  .description),
                                                      staff:
                                                          currentUserReference,
                                                      hotel: FFAppState().hotel,
                                                    ));
                                                // moved month
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      'Bill has been moved to ${dateTimeFormat("MMMM", _model.adjustedDate)}!',
                                                      style: TextStyle(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                      ),
                                                    ),
                                                    duration: Duration(
                                                        milliseconds: 4000),
                                                    backgroundColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .secondary,
                                                  ),
                                                );
                                              }

                                              // bill change

                                              await BillChangesRecord.collection
                                                  .doc()
                                                  .set(
                                                      createBillChangesRecordData(
                                                    date: getCurrentTimestamp,
                                                    description: functions
                                                        .dateWasChanged(
                                                            billsItem.date!,
                                                            _model
                                                                .adjustedDate!,
                                                            billsItem
                                                                .description),
                                                    staff: currentUserReference,
                                                    hotel: FFAppState().hotel,
                                                  ));
                                              // adjust the time of this bill

                                              await billsItem.reference
                                                  .update(createBillsRecordData(
                                                date: _model.adjustedDate,
                                              ));
                                            }
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'Only management can change date!',
                                                  style: TextStyle(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .info,
                                                  ),
                                                ),
                                                duration: Duration(
                                                    milliseconds: 4000),
                                                backgroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .error,
                                              ),
                                            );
                                          }

                                          if (_shouldSetState) setState(() {});
                                        },
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(
                                              dateTimeFormat(
                                                  "MMM", billsItem.date!),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Readex Pro',
                                                    color: functions
                                                            .isThisMonth(
                                                                billsItem.date!)
                                                        ? Color(0xFF6758FB)
                                                        : FlutterFlowTheme.of(
                                                                context)
                                                            .secondaryText,
                                                    letterSpacing: 0.0,
                                                  ),
                                            ),
                                            Text(
                                              dateTimeFormat(
                                                  "d", billsItem.date!),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Readex Pro',
                                                    color: functions
                                                            .isThisMonth(
                                                                billsItem.date!)
                                                        ? FlutterFlowTheme.of(
                                                                context)
                                                            .primary
                                                        : FlutterFlowTheme.of(
                                                                context)
                                                            .primaryText,
                                                    fontSize: 25.0,
                                                    letterSpacing: 0.0,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20.0, 0.0, 0.0, 0.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    flex: 7,
                                                    child: InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onDoubleTap: () async {
                                                        // start words with big letter

                                                        await billsItem
                                                            .reference
                                                            .update(
                                                                createBillsRecordData(
                                                          description: functions
                                                              .startBigLetter(
                                                                  billsItem
                                                                      .description),
                                                        ));
                                                      },
                                                      child: Text(
                                                        billsItem.description,
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyLarge
                                                                .override(
                                                                  fontFamily:
                                                                      'Readex Pro',
                                                                  color: functions.isThisMonth(
                                                                          billsItem
                                                                              .date!)
                                                                      ? FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryText
                                                                      : FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryText,
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              AnimatedContainer(
                                                duration:
                                                    Duration(milliseconds: 150),
                                                curve: Curves.easeInOut,
                                                width: double.infinity,
                                                decoration: BoxDecoration(),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  10.0,
                                                                  0.0),
                                                      child: Text(
                                                        formatNumber(
                                                          billsItem.amount,
                                                          formatType: FormatType
                                                              .decimal,
                                                          decimalType:
                                                              DecimalType
                                                                  .automatic,
                                                          currency: 'Php ',
                                                        ),
                                                        textAlign:
                                                            TextAlign.start,
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyLarge
                                                                .override(
                                                                  fontFamily:
                                                                      'Readex Pro',
                                                                  color: functions.isThisMonth(
                                                                          billsItem
                                                                              .date!)
                                                                      ? FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryText
                                                                      : FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryText,
                                                                  fontSize:
                                                                      24.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                      ),
                                                    ),
                                                    if ((billsItem.afterDue !=
                                                            null) &&
                                                        (billsItem.afterDue !=
                                                            0.0))
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          if ((billsItem
                                                                      .afterDue !=
                                                                  null) &&
                                                              (billsItem
                                                                      .afterDue !=
                                                                  0.0))
                                                            Text(
                                                              'After Due',
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyLarge
                                                                  .override(
                                                                    fontFamily:
                                                                        'Readex Pro',
                                                                    color: functions.isThisMonth(
                                                                            billsItem
                                                                                .date!)
                                                                        ? FlutterFlowTheme.of(context)
                                                                            .primaryText
                                                                        : FlutterFlowTheme.of(context)
                                                                            .secondaryText,
                                                                    fontSize:
                                                                        8.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                            ),
                                                          Text(
                                                            formatNumber(
                                                              billsItem
                                                                  .afterDue,
                                                              formatType:
                                                                  FormatType
                                                                      .decimal,
                                                              decimalType:
                                                                  DecimalType
                                                                      .automatic,
                                                              currency: 'Php ',
                                                            ),
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyLarge
                                                                .override(
                                                                  fontFamily:
                                                                      'Readex Pro',
                                                                  color: functions.isThisMonth(
                                                                          billsItem
                                                                              .date!)
                                                                      ? FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryText
                                                                      : FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryText,
                                                                  fontSize:
                                                                      16.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
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
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 0.0, 16.0, 10.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      StreamBuilder<UsersRecord>(
                                        stream: UsersRecord.getDocument(
                                            billsItem.staff!),
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

                                          final textUsersRecord =
                                              snapshot.data!;

                                          return Text(
                                            'Recorded by ${textUsersRecord.displayName}',
                                            style: FlutterFlowTheme.of(context)
                                                .labelMedium
                                                .override(
                                                  fontFamily: 'Readex Pro',
                                                  color: functions.isThisMonth(
                                                          billsItem.date!)
                                                      ? FlutterFlowTheme.of(
                                                              context)
                                                          .primaryText
                                                      : FlutterFlowTheme.of(
                                                              context)
                                                          .secondaryText,
                                                  letterSpacing: 0.0,
                                                ),
                                          );
                                        },
                                      ),
                                      Text(
                                        '${dateTimeFormat("y", billsItem.date)}',
                                        style: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              fontFamily: 'Readex Pro',
                                              color: functions.isThisMonth(
                                                      billsItem.date!)
                                                  ? FlutterFlowTheme.of(context)
                                                      .primaryText
                                                  : FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
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
        ),
      ),
    );
  }
}
