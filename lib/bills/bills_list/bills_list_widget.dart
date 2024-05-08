import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/forms/change_date/change_date_widget.dart';
import '/components/options/option_to_bill/option_to_bill_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
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
        queryBuilder: (billsRecord) => billsRecord.where(
          'hotel',
          isEqualTo: FFAppState().hotel,
        ),
        limit: 50,
      );
      // set all descriptions
      setState(() {
        _model.allDescriptions = functions
            .billsChoices(
                _model.allBills?.map((e) => e.description).toList().toList())
            .toList()
            .cast<String>();
        _model.year = functions.currentYear();
      });
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
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
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
                padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
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
                        setState(() {
                          _model.year =
                              functions.previousYear('January', _model.year);
                        });
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
                        setState(() {
                          _model.year =
                              functions.nextYear(_model.year, 'December');
                        });
                      },
                    ).animateOnPageLoad(
                        animationsMap['iconButtonOnPageLoadAnimation2']!),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                child: FlutterFlowChoiceChips(
                  options: _model.allDescriptions
                      .map((label) => ChipData(label))
                      .toList(),
                  onChanged: (val) async {
                    setState(() => _model.choiceChipsValue =
                        val?.firstOrNull); // reset showInList
                    setState(() {
                      _model.showInList = [];
                    });
                    if (_model.choiceChipsValue == 'All') {
                      // all
                      setState(() {
                        _model.showInList =
                            _model.allDescriptions.toList().cast<String>();
                      });
                    } else {
                      // choice only
                      setState(() {
                        _model.addToShowInList(_model.choiceChipsValue!);
                      });
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
                        const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
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
                        const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
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
                      const EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 10.0),
                  child: Container(
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).accent4,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 12.0, 8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 4.0,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color(0xFF4B39EF),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
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
                                          color: const Color(0xFF4B39EF),
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
                            padding: const EdgeInsetsDirectional.fromSTEB(
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
                                        functions.totalOfSpecificBill(
                                            textBillsRecordList.toList()),
                                        formatType: FormatType.decimal,
                                        decimalType: DecimalType.automatic,
                                        currency: 'Php ',
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .headlineSmall
                                          .override(
                                            fontFamily: 'Outfit',
                                            color: const Color(0xFF14181B),
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
                child: PagedListView<DocumentSnapshot<Object?>?,
                    BillsRecord>.separated(
                  pagingController: _model.setListViewController(
                    BillsRecord.collection
                        .where(
                          'hotel',
                          isEqualTo: FFAppState().hotel,
                        )
                        .whereIn('description', _model.showInList)
                        .where(
                          'date',
                          isGreaterThanOrEqualTo:
                              functions.startOfYear(_model.year),
                        )
                        .where(
                          'date',
                          isLessThanOrEqualTo: functions.endOfYear(_model.year),
                        )
                        .orderBy('date', descending: true),
                  ),
                  padding: EdgeInsets.zero,
                  primary: false,
                  shrinkWrap: true,
                  reverse: false,
                  scrollDirection: Axis.vertical,
                  separatorBuilder: (_, __) => const SizedBox(height: 1.0),
                  builderDelegate: PagedChildBuilderDelegate<BillsRecord>(
                    // Customize what your widget looks like when it's loading the first page.
                    firstPageProgressIndicatorBuilder: (_) => Center(
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
                    // Customize what your widget looks like when it's loading another page.
                    newPageProgressIndicatorBuilder: (_) => Center(
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

                    itemBuilder: (context, _, listViewIndex) {
                      final listViewBillsRecord = _model
                          .listViewPagingController!.itemList![listViewIndex];
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
                                      _model.unfocusNode.canRequestFocus
                                          ? FocusScope.of(context)
                                              .requestFocus(_model.unfocusNode)
                                          : FocusScope.of(context).unfocus(),
                                  child: Padding(
                                    padding: MediaQuery.viewInsetsOf(context),
                                    child: SizedBox(
                                      height: 218.0,
                                      child: OptionToBillWidget(
                                        bill: listViewBillsRecord,
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
                          setState(() {
                            _model.showInList = [];
                          });
                          // add to showInList
                          setState(() {
                            _model.addToShowInList(
                                listViewBillsRecord.description);
                          });
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
                                offset: const Offset(
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
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16.0, 12.0, 16.0, 5.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        var shouldSetState = false;
                                        if (valueOrDefault(
                                                currentUserDocument?.role,
                                                '') ==
                                            'admin') {
                                          await showModalBottomSheet(
                                            isScrollControlled: true,
                                            backgroundColor: Colors.transparent,
                                            context: context,
                                            builder: (context) {
                                              return GestureDetector(
                                                onTap: () => _model.unfocusNode
                                                        .canRequestFocus
                                                    ? FocusScope.of(context)
                                                        .requestFocus(
                                                            _model.unfocusNode)
                                                    : FocusScope.of(context)
                                                        .unfocus(),
                                                child: Padding(
                                                  padding:
                                                      MediaQuery.viewInsetsOf(
                                                          context),
                                                  child: SizedBox(
                                                    height: double.infinity,
                                                    child: ChangeDateWidget(
                                                      date: listViewBillsRecord
                                                          .date!,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ).then((value) => safeSetState(() =>
                                              _model.adjustedDate = value));

                                          shouldSetState = true;
                                          if (_model.adjustedDate != null) {
                                            if (dateTimeFormat('M',
                                                    listViewBillsRecord.date) ==
                                                dateTimeFormat(
                                                    'M', _model.adjustedDate)) {
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
                                                  duration: const Duration(
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
                                                          isEqualTo: dateTimeFormat(
                                                              'MMMM',
                                                              listViewBillsRecord
                                                                  .date),
                                                        )
                                                        .where(
                                                          'year',
                                                          isEqualTo: dateTimeFormat(
                                                              'y',
                                                              listViewBillsRecord
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
                                              shouldSetState = true;
                                              // deduct from prev stats

                                              await _model.prevStats!.reference
                                                  .update({
                                                ...mapToFirestore(
                                                  {
                                                    'bills':
                                                        FieldValue.increment(
                                                            -(listViewBillsRecord
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
                                                          isEqualTo: dateTimeFormat(
                                                              'MMMM',
                                                              _model
                                                                  .adjustedDate),
                                                        )
                                                        .where(
                                                          'year',
                                                          isEqualTo: dateTimeFormat(
                                                              'y',
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
                                              shouldSetState = true;
                                              if (_model.belongingStats
                                                      ?.reference !=
                                                  null) {
                                                // increment

                                                await _model
                                                    .belongingStats!.reference
                                                    .update({
                                                  ...mapToFirestore(
                                                    {
                                                      'bills':
                                                          FieldValue.increment(
                                                              listViewBillsRecord
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
                                                    duration: const Duration(
                                                        milliseconds: 4000),
                                                    backgroundColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .error,
                                                  ),
                                                );
                                                if (shouldSetState) {
                                                  setState(() {});
                                                }
                                                return;
                                              }

                                              // bill change

                                              await BillChangesRecord.collection
                                                  .doc()
                                                  .set(
                                                      createBillChangesRecordData(
                                                    date: getCurrentTimestamp,
                                                    description:
                                                        functions.monthWasChanged(
                                                            listViewBillsRecord
                                                                .date!,
                                                            _model
                                                                .adjustedDate!,
                                                            listViewBillsRecord
                                                                .description),
                                                    staff: currentUserReference,
                                                    hotel: FFAppState().hotel,
                                                  ));
                                              // moved month
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    'Bill has been moved to ${dateTimeFormat('MMMM', _model.adjustedDate)}!',
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

                                            // bill change

                                            await BillChangesRecord.collection
                                                .doc()
                                                .set(
                                                    createBillChangesRecordData(
                                                  date: getCurrentTimestamp,
                                                  description:
                                                      functions.dateWasChanged(
                                                          listViewBillsRecord
                                                              .date!,
                                                          _model.adjustedDate!,
                                                          listViewBillsRecord
                                                              .description),
                                                  staff: currentUserReference,
                                                  hotel: FFAppState().hotel,
                                                ));
                                            // adjust the time of this bill

                                            await listViewBillsRecord.reference
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
                                              duration:
                                                  const Duration(milliseconds: 4000),
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .error,
                                            ),
                                          );
                                        }

                                        if (shouldSetState) setState(() {});
                                      },
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            dateTimeFormat('MMM',
                                                listViewBillsRecord.date!),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Readex Pro',
                                                  color: functions.isThisMonth(
                                                          listViewBillsRecord
                                                              .date!)
                                                      ? const Color(0xFF6758FB)
                                                      : FlutterFlowTheme.of(
                                                              context)
                                                          .secondaryText,
                                                  letterSpacing: 0.0,
                                                ),
                                          ),
                                          Text(
                                            dateTimeFormat(
                                                'd', listViewBillsRecord.date!),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Readex Pro',
                                                  color: functions.isThisMonth(
                                                          listViewBillsRecord
                                                              .date!)
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
                                        padding: const EdgeInsetsDirectional.fromSTEB(
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

                                                      await listViewBillsRecord
                                                          .reference
                                                          .update(
                                                              createBillsRecordData(
                                                        description: functions
                                                            .startBigLetter(
                                                                listViewBillsRecord
                                                                    .description),
                                                      ));
                                                    },
                                                    child: Text(
                                                      listViewBillsRecord
                                                          .description,
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyLarge
                                                              .override(
                                                                fontFamily:
                                                                    'Readex Pro',
                                                                color: functions.isThisMonth(
                                                                        listViewBillsRecord
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
                                                  const Duration(milliseconds: 150),
                                              curve: Curves.easeInOut,
                                              width: double.infinity,
                                              decoration: const BoxDecoration(),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                10.0, 0.0),
                                                    child: Text(
                                                      valueOrDefault<String>(
                                                        formatNumber(
                                                          listViewBillsRecord
                                                              .amount,
                                                          formatType: FormatType
                                                              .decimal,
                                                          decimalType:
                                                              DecimalType
                                                                  .periodDecimal,
                                                          currency: 'P ',
                                                        ),
                                                        '0',
                                                      ),
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyLarge
                                                          .override(
                                                            fontFamily:
                                                                'Readex Pro',
                                                            color: functions
                                                                    .isThisMonth(
                                                                        listViewBillsRecord
                                                                            .date!)
                                                                ? FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText
                                                                : FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryText,
                                                            fontSize: 24.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                    ),
                                                  ),
                                                  if ((listViewBillsRecord
                                                              .afterDue !=
                                                          null) &&
                                                      (listViewBillsRecord
                                                              .afterDue !=
                                                          0.0))
                                                    Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        if ((listViewBillsRecord
                                                                    .afterDue !=
                                                                null) &&
                                                            (listViewBillsRecord
                                                                    .afterDue !=
                                                                0.0))
                                                          Text(
                                                            'After Due',
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyLarge
                                                                .override(
                                                                  fontFamily:
                                                                      'Readex Pro',
                                                                  color: functions.isThisMonth(
                                                                          listViewBillsRecord
                                                                              .date!)
                                                                      ? FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryText
                                                                      : FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryText,
                                                                  fontSize: 8.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                          ),
                                                        Text(
                                                          valueOrDefault<
                                                              String>(
                                                            formatNumber(
                                                              listViewBillsRecord
                                                                  .afterDue,
                                                              formatType:
                                                                  FormatType
                                                                      .decimal,
                                                              decimalType:
                                                                  DecimalType
                                                                      .periodDecimal,
                                                              currency: 'P ',
                                                            ),
                                                            '0',
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
                                                                        listViewBillsRecord
                                                                            .date!)
                                                                    ? FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryText
                                                                    : FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryText,
                                                                fontSize: 16.0,
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
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 16.0, 10.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    StreamBuilder<UsersRecord>(
                                      stream: UsersRecord.getDocument(
                                          listViewBillsRecord.staff!),
                                      builder: (context, snapshot) {
                                        // Customize what your widget looks like when it's loading.
                                        if (!snapshot.hasData) {
                                          return Center(
                                            child: SizedBox(
                                              width: 50.0,
                                              height: 50.0,
                                              child: CircularProgressIndicator(
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
                                        final textUsersRecord = snapshot.data!;
                                        return Text(
                                          'Recorded by ${textUsersRecord.displayName}',
                                          style: FlutterFlowTheme.of(context)
                                              .labelMedium
                                              .override(
                                                fontFamily: 'Readex Pro',
                                                color: functions.isThisMonth(
                                                        listViewBillsRecord
                                                            .date!)
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
                                    StreamBuilder<UsersRecord>(
                                      stream: UsersRecord.getDocument(
                                          listViewBillsRecord.staff!),
                                      builder: (context, snapshot) {
                                        // Customize what your widget looks like when it's loading.
                                        if (!snapshot.hasData) {
                                          return Center(
                                            child: SizedBox(
                                              width: 50.0,
                                              height: 50.0,
                                              child: CircularProgressIndicator(
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
                                        final textUsersRecord = snapshot.data!;
                                        return Text(
                                          dateTimeFormat('y', listViewBillsRecord.date),
                                          style: FlutterFlowTheme.of(context)
                                              .labelMedium
                                              .override(
                                                fontFamily: 'Readex Pro',
                                                color: functions.isThisMonth(
                                                        listViewBillsRecord
                                                            .date!)
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
                                  ],
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
            ],
          ),
        ),
      ),
    );
  }
}
