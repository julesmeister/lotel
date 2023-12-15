import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/options/option_to_booking/option_to_booking_widget.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'checked_in_model.dart';
export 'checked_in_model.dart';

class CheckedInWidget extends StatefulWidget {
  const CheckedInWidget({
    Key? key,
    this.ref,
    required this.booking,
    required this.roomNo,
  }) : super(key: key);

  final DocumentReference? ref;
  final DocumentReference? booking;
  final int? roomNo;

  @override
  _CheckedInWidgetState createState() => _CheckedInWidgetState();
}

class _CheckedInWidgetState extends State<CheckedInWidget> {
  late CheckedInModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CheckedInModel());

    _model.newPriceController ??= TextEditingController();
    _model.newPriceFocusNode ??= FocusNode();

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

    return StreamBuilder<BookingsRecord>(
      stream: _model.bookingDetails(
        requestFn: () => BookingsRecord.getDocument(widget.booking!),
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
        final checkedInBookingsRecord = snapshot.data!;
        return GestureDetector(
          onTap: () => _model.unfocusNode.canRequestFocus
              ? FocusScope.of(context).requestFocus(_model.unfocusNode)
              : FocusScope.of(context).unfocus(),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            appBar: AppBar(
              backgroundColor: FlutterFlowTheme.of(context).primary,
              automaticallyImplyLeading: false,
              leading: FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30.0,
                borderWidth: 1.0,
                buttonSize: 60.0,
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: FlutterFlowTheme.of(context).info,
                  size: 30.0,
                ),
                onPressed: () async {
                  context.pop();
                },
              ),
              title: Text(
                'Booking Details',
                style: FlutterFlowTheme.of(context).titleMedium,
              ),
              actions: [],
              centerTitle: false,
              elevation: 2.0,
            ),
            body: SafeArea(
              top: true,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Align(
                      alignment: AlignmentDirectional(0.0, -1.0),
                      child: Container(
                        width: double.infinity,
                        constraints: BoxConstraints(
                          maxWidth: 1170.0,
                        ),
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                width: double.infinity,
                                constraints: BoxConstraints(
                                  maxWidth: 1170.0,
                                ),
                                decoration: BoxDecoration(),
                              ),
                              Align(
                                alignment: AlignmentDirectional(0.0, -1.0),
                                child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Container(
                                    width: double.infinity,
                                    constraints: BoxConstraints(
                                      maxWidth: 1170.0,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.0),
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context)
                                            .alternate,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          flex: 8,
                                          child: Padding(
                                            padding: EdgeInsets.all(16.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 0.0, 0.0, 15.0),
                                                  child: Text(
                                                    'Booking Details',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .headlineMedium,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 8.0, 0.0, 0.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Room',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium,
                                                      ),
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Text(
                                                            (int room) {
                                                              return "Room $room";
                                                            }(valueOrDefault<
                                                                int>(
                                                              widget.roomNo,
                                                              0,
                                                            )),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium,
                                                          ),
                                                          if (!((checkedInBookingsRecord
                                                                      .status ==
                                                                  'out') ||
                                                              (widget.ref ==
                                                                  null)))
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          5.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                              child: InkWell(
                                                                splashColor: Colors
                                                                    .transparent,
                                                                focusColor: Colors
                                                                    .transparent,
                                                                hoverColor: Colors
                                                                    .transparent,
                                                                highlightColor:
                                                                    Colors
                                                                        .transparent,
                                                                onTap:
                                                                    () async {
                                                                  setState(() {
                                                                    _model.showMoveRoom =
                                                                        !_model
                                                                            .showMoveRoom;
                                                                  });
                                                                },
                                                                child: Icon(
                                                                  Icons
                                                                      .move_down,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryText,
                                                                  size: 14.0,
                                                                ),
                                                              ),
                                                            ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                if (_model.showMoveRoom)
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 5.0,
                                                                0.0, 0.0),
                                                    child: FutureBuilder<
                                                        List<RoomsRecord>>(
                                                      future:
                                                          queryRoomsRecordOnce(
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
                                                                    )
                                                                    .orderBy(
                                                                        'number'),
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
                                                        List<RoomsRecord>
                                                            choiceChipsRoomsRecordList =
                                                            snapshot.data!;
                                                        return FlutterFlowChoiceChips(
                                                          options: functions
                                                              .intListToStringList(
                                                                  choiceChipsRoomsRecordList
                                                                      .map((e) => e
                                                                          .number)
                                                                      .toList())
                                                              .map((label) =>
                                                                  ChipData(
                                                                      label))
                                                              .toList(),
                                                          onChanged:
                                                              (val) async {
                                                            setState(() => _model
                                                                    .choiceChipsValue =
                                                                val?.first); // from room history

                                                            await HistoryRecord
                                                                    .createDoc(
                                                                        widget
                                                                            .ref!)
                                                                .set({
                                                              ...createHistoryRecordData(
                                                                description:
                                                                    'Guest is moving out of this room and into room ${_model.choiceChipsValue}',
                                                                staff:
                                                                    currentUserReference,
                                                                booking: widget
                                                                    .booking,
                                                              ),
                                                              ...mapToFirestore(
                                                                {
                                                                  'date': FieldValue
                                                                      .serverTimestamp(),
                                                                },
                                                              ),
                                                            });
                                                            // transfer to room history

                                                            await HistoryRecord.createDoc(choiceChipsRoomsRecordList
                                                                    .where((e) =>
                                                                        e.number ==
                                                                        (int.parse(
                                                                            _model.choiceChipsValue!)))
                                                                    .toList()
                                                                    .first
                                                                    .reference)
                                                                .set({
                                                              ...createHistoryRecordData(
                                                                description:
                                                                    'Guest${functions.stringToInt(checkedInBookingsRecord.guests)! > 1 ? 's' : ''} have transferred in from room ${widget.roomNo?.toString()}',
                                                                staff:
                                                                    currentUserReference,
                                                                booking: widget
                                                                    .booking,
                                                              ),
                                                              ...mapToFirestore(
                                                                {
                                                                  'date': FieldValue
                                                                      .serverTimestamp(),
                                                                },
                                                              ),
                                                            });
                                                            // rebook to selected room

                                                            await choiceChipsRoomsRecordList
                                                                .where((e) =>
                                                                    e.number ==
                                                                    (int.parse(
                                                                        _model
                                                                            .choiceChipsValue!)))
                                                                .toList()
                                                                .first
                                                                .reference
                                                                .update(
                                                                    createRoomsRecordData(
                                                                  vacant: false,
                                                                  currentBooking:
                                                                      widget
                                                                          .booking,
                                                                  guests: int.parse(
                                                                      checkedInBookingsRecord
                                                                          .guests),
                                                                ));
                                                            // revacant current room

                                                            await checkedInBookingsRecord
                                                                .room!
                                                                .update({
                                                              ...createRoomsRecordData(
                                                                vacant: true,
                                                                guests: 0,
                                                              ),
                                                              ...mapToFirestore(
                                                                {
                                                                  'currentBooking':
                                                                      FieldValue
                                                                          .delete(),
                                                                },
                                                              ),
                                                            });
                                                            // read transaction
                                                            _model.transaction =
                                                                await queryTransactionsRecordOnce(
                                                              queryBuilder: (transactionsRecord) =>
                                                                  transactionsRecord
                                                                      .where(
                                                                        'booking',
                                                                        isEqualTo:
                                                                            widget.booking,
                                                                      )
                                                                      .orderBy(
                                                                          'date',
                                                                          descending:
                                                                              true),
                                                              singleRecord:
                                                                  true,
                                                            ).then((s) => s
                                                                    .firstOrNull);
                                                            // booking's room ref update

                                                            await widget
                                                                .booking!
                                                                .update(
                                                                    createBookingsRecordData(
                                                              room: choiceChipsRoomsRecordList
                                                                  .where((e) =>
                                                                      e.number ==
                                                                      (int.parse(
                                                                          _model
                                                                              .choiceChipsValue!)))
                                                                  .toList()
                                                                  .first
                                                                  .reference,
                                                              total: choiceChipsRoomsRecordList
                                                                      .where((e) =>
                                                                          e.number ==
                                                                          (int.parse(_model
                                                                              .choiceChipsValue!)))
                                                                      .toList()
                                                                      .first
                                                                      .price *
                                                                  checkedInBookingsRecord
                                                                      .nights,
                                                            ));
                                                            // change room of transaction

                                                            await _model
                                                                .transaction!
                                                                .reference
                                                                .update({
                                                              ...createTransactionsRecordData(
                                                                room: int.parse(
                                                                    _model
                                                                        .choiceChipsValue!),
                                                                description: functions.modifyTransactionRoomDescription(
                                                                    _model
                                                                        .transaction!
                                                                        .description,
                                                                    _model
                                                                        .choiceChipsValue!,
                                                                    widget
                                                                        .roomNo!
                                                                        .toString()),
                                                                total: choiceChipsRoomsRecordList
                                                                    .where((e) =>
                                                                        e.number ==
                                                                        (int.parse(
                                                                            _model.choiceChipsValue!)))
                                                                    .toList()
                                                                    .first
                                                                    .price,
                                                              ),
                                                              ...mapToFirestore(
                                                                {
                                                                  'date': FieldValue
                                                                      .serverTimestamp(),
                                                                },
                                                              ),
                                                            });
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              SnackBar(
                                                                content: Text(
                                                                  'The guest has been moved to a new room!',
                                                                  style:
                                                                      TextStyle(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryText,
                                                                  ),
                                                                ),
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        4000),
                                                                backgroundColor:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondary,
                                                              ),
                                                            );
                                                            // hide move room again
                                                            setState(() {
                                                              _model.showMoveRoom =
                                                                  false;
                                                            });

                                                            setState(() {});
                                                          },
                                                          selectedChipStyle:
                                                              ChipStyle(
                                                            backgroundColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
                                                            textStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Readex Pro',
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .info,
                                                                    ),
                                                            iconColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .accent4,
                                                            iconSize: 18.0,
                                                            elevation: 4.0,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16.0),
                                                          ),
                                                          unselectedChipStyle:
                                                              ChipStyle(
                                                            backgroundColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .alternate,
                                                            textStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Readex Pro',
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryText,
                                                                    ),
                                                            iconColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .info,
                                                            iconSize: 18.0,
                                                            elevation: 0.0,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16.0),
                                                          ),
                                                          chipSpacing: 12.0,
                                                          rowSpacing: 12.0,
                                                          multiselect: false,
                                                          alignment:
                                                              WrapAlignment
                                                                  .start,
                                                          controller: _model
                                                                  .choiceChipsValueController ??=
                                                              FormFieldController<
                                                                  List<String>>(
                                                            [],
                                                          ),
                                                          wrapped: true,
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 8.0, 0.0, 0.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Extra Bed/s',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium,
                                                      ),
                                                      Text(
                                                        (String extraBeds) {
                                                          return extraBeds ==
                                                                  "0"
                                                              ? "There are no extra beds"
                                                              : "There's $extraBeds extra bed${extraBeds != "1" ? 's' : ''}";
                                                        }(checkedInBookingsRecord
                                                            .extraBeds),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 8.0, 0.0, 0.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Occupants',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Readex Pro',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                ),
                                                      ),
                                                      Text(
                                                        (String guests) {
                                                          return '$guests guest${guests != "1" ? 's' : ''}';
                                                        }(checkedInBookingsRecord
                                                            .guests),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 8.0, 0.0, 0.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Ability',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Readex Pro',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                ),
                                                      ),
                                                      Text(
                                                        (String ability) {
                                                          return ability ==
                                                                  "normal"
                                                              ? "No disability"
                                                              : "${ability[0].toUpperCase()}${ability.substring(1)}";
                                                        }(checkedInBookingsRecord
                                                            .ability),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 8.0, 0.0, 0.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Nights',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Readex Pro',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                ),
                                                      ),
                                                      Text(
                                                        (int nights) {
                                                          return '$nights night${nights != 1 ? 's' : ''} stay';
                                                        }(checkedInBookingsRecord
                                                            .nights),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 8.0, 0.0, 0.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Promo',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Readex Pro',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                ),
                                                      ),
                                                      Text(
                                                        checkedInBookingsRecord
                                                                        .promo !=
                                                                    null &&
                                                                checkedInBookingsRecord
                                                                        .promo !=
                                                                    ''
                                                            ? checkedInBookingsRecord
                                                                .promo
                                                            : 'No Promo',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 8.0, 0.0, 0.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Status',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Readex Pro',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                ),
                                                      ),
                                                      Text(
                                                        (String status) {
                                                          return status == "out"
                                                              ? "Checked Out"
                                                              : status[0]
                                                                      .toUpperCase() +
                                                                  status
                                                                      .substring(
                                                                          1);
                                                        }(checkedInBookingsRecord
                                                            .status),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 15.0, 0.0, 0.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Total',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelLarge,
                                                      ),
                                                      Text(
                                                        formatNumber(
                                                          checkedInBookingsRecord
                                                              .total,
                                                          formatType: FormatType
                                                              .decimal,
                                                          decimalType:
                                                              DecimalType
                                                                  .automatic,
                                                          currency: 'P ',
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .headlineSmall,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 10.0, 0.0, 0.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      if ((checkedInBookingsRecord
                                                                  .status !=
                                                              'out') &&
                                                          (widget.ref != null))
                                                        Expanded(
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        12.0,
                                                                        0.0,
                                                                        0.0),
                                                            child:
                                                                FFButtonWidget(
                                                              onPressed:
                                                                  () async {
                                                                // Open Bottom Sheet
                                                                await showModalBottomSheet(
                                                                  isScrollControlled:
                                                                      true,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .transparent,
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return GestureDetector(
                                                                      onTap: () => _model
                                                                              .unfocusNode
                                                                              .canRequestFocus
                                                                          ? FocusScope.of(context).requestFocus(_model
                                                                              .unfocusNode)
                                                                          : FocusScope.of(context)
                                                                              .unfocus(),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            MediaQuery.viewInsetsOf(context),
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              180.0,
                                                                          child:
                                                                              OptionToBookingWidget(
                                                                            ref:
                                                                                widget.ref!,
                                                                            roomNo:
                                                                                widget.roomNo!,
                                                                            bookingToExtend:
                                                                                checkedInBookingsRecord,
                                                                            extend:
                                                                                true,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                ).then((value) =>
                                                                    safeSetState(() =>
                                                                        _model.toChangePrice =
                                                                            value));

                                                                if (_model
                                                                    .toChangePrice!) {
                                                                  // showChangePrice
                                                                  setState(() {
                                                                    _model.showChangePrice =
                                                                        true;
                                                                  });
                                                                }

                                                                setState(() {});
                                                              },
                                                              text: 'Modify',
                                                              icon: Icon(
                                                                Icons
                                                                    .edit_outlined,
                                                                size: 15.0,
                                                              ),
                                                              options:
                                                                  FFButtonOptions(
                                                                height: 48.0,
                                                                padding: EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        16.0,
                                                                        0.0,
                                                                        16.0,
                                                                        0.0),
                                                                iconPadding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryBackground,
                                                                textStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLarge,
                                                                elevation: 0.0,
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .alternate,
                                                                  width: 2.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12.0),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      if ((checkedInBookingsRecord
                                                                  .status !=
                                                              'out') &&
                                                          (widget.ref != null))
                                                        Expanded(
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        12.0,
                                                                        0.0,
                                                                        0.0),
                                                            child:
                                                                FFButtonWidget(
                                                              onPressed:
                                                                  () async {
                                                                var _shouldSetState =
                                                                    false;
                                                                if (checkedInBookingsRecord
                                                                        .status ==
                                                                    'pending') {
                                                                  // confirm pay all pendings
                                                                  var confirmDialogResponse =
                                                                      await showDialog<
                                                                              bool>(
                                                                            context:
                                                                                context,
                                                                            builder:
                                                                                (alertDialogContext) {
                                                                              return AlertDialog(
                                                                                title: Text('Is the guest paying?'),
                                                                                content: Text('The guest will be marked paid if you confirm.'),
                                                                                actions: [
                                                                                  TextButton(
                                                                                    onPressed: () => Navigator.pop(alertDialogContext, false),
                                                                                    child: Text('Cancel'),
                                                                                  ),
                                                                                  TextButton(
                                                                                    onPressed: () => Navigator.pop(alertDialogContext, true),
                                                                                    child: Text('Confirm'),
                                                                                  ),
                                                                                ],
                                                                              );
                                                                            },
                                                                          ) ??
                                                                          false;
                                                                  if (confirmDialogResponse) {
                                                                    while (_model
                                                                            .loopPendingCounter !=
                                                                        checkedInBookingsRecord
                                                                            .pendings
                                                                            .length) {
                                                                      // pendingTrans
                                                                      _model
                                                                          .pendingTrans = await TransactionsRecord.getDocumentOnce(checkedInBookingsRecord
                                                                              .pendings[
                                                                          _model
                                                                              .loopPendingCounter]);
                                                                      _shouldSetState =
                                                                          true;
                                                                      // pay balance of this transaction

                                                                      await checkedInBookingsRecord
                                                                          .pendings[
                                                                              _model.loopPendingCounter]
                                                                          .update({
                                                                        ...createTransactionsRecordData(
                                                                          pending:
                                                                              false,
                                                                          description: _model.pendingTrans!.total < 0.0
                                                                              ? _model.pendingTrans?.description
                                                                              : 'Guest paid the balance for ${_model.pendingTrans?.description}',
                                                                        ),
                                                                        ...mapToFirestore(
                                                                          {
                                                                            'date':
                                                                                FieldValue.serverTimestamp(),
                                                                          },
                                                                        ),
                                                                      });
                                                                      // remove trans from pending in booking

                                                                      await widget
                                                                          .booking!
                                                                          .update({
                                                                        ...mapToFirestore(
                                                                          {
                                                                            'pendings':
                                                                                FieldValue.arrayRemove([
                                                                              _model.pendingTrans?.reference
                                                                            ]),
                                                                            'transactions':
                                                                                FieldValue.arrayUnion([
                                                                              _model.pendingTrans?.reference
                                                                            ]),
                                                                          },
                                                                        ),
                                                                      });
                                                                      // increment loop
                                                                      setState(
                                                                          () {
                                                                        _model.loopPendingCounter =
                                                                            _model.loopPendingCounter +
                                                                                1;
                                                                      });
                                                                    }
                                                                    // paid booking status

                                                                    await widget
                                                                        .booking!
                                                                        .update({
                                                                      ...createBookingsRecordData(
                                                                        status:
                                                                            'paid',
                                                                      ),
                                                                      ...mapToFirestore(
                                                                        {
                                                                          'pendings':
                                                                              _model.pendings,
                                                                        },
                                                                      ),
                                                                    });
                                                                    // add paid amount to history

                                                                    await HistoryRecord.createDoc(
                                                                            checkedInBookingsRecord.room!)
                                                                        .set({
                                                                      ...createHistoryRecordData(
                                                                        description:
                                                                            'Guest${functions.stringToInt(checkedInBookingsRecord.guests)! > 1 ? 's have' : 'has'} settled balance.',
                                                                        staff:
                                                                            currentUserReference,
                                                                        booking:
                                                                            widget.booking,
                                                                      ),
                                                                      ...mapToFirestore(
                                                                        {
                                                                          'date':
                                                                              FieldValue.serverTimestamp(),
                                                                        },
                                                                      ),
                                                                    });
                                                                    // Paid Balance
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(
                                                                      SnackBar(
                                                                        content:
                                                                            Text(
                                                                          'Guest has finally paid balance',
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primaryText,
                                                                          ),
                                                                        ),
                                                                        duration:
                                                                            Duration(milliseconds: 4000),
                                                                        backgroundColor:
                                                                            FlutterFlowTheme.of(context).secondary,
                                                                      ),
                                                                    );
                                                                  } else {
                                                                    if (_shouldSetState)
                                                                      setState(
                                                                          () {});
                                                                    return;
                                                                  }
                                                                } else {
                                                                  // confirm check out
                                                                  var confirmDialogResponse =
                                                                      await showDialog<
                                                                              bool>(
                                                                            context:
                                                                                context,
                                                                            builder:
                                                                                (alertDialogContext) {
                                                                              return AlertDialog(
                                                                                title: Text('Is this guest checking out?'),
                                                                                content: Text('This guest will be checked out if you confirm.'),
                                                                                actions: [
                                                                                  TextButton(
                                                                                    onPressed: () => Navigator.pop(alertDialogContext, false),
                                                                                    child: Text('Cancel'),
                                                                                  ),
                                                                                  TextButton(
                                                                                    onPressed: () => Navigator.pop(alertDialogContext, true),
                                                                                    child: Text('Confirm'),
                                                                                  ),
                                                                                ],
                                                                              );
                                                                            },
                                                                          ) ??
                                                                          false;
                                                                  if (confirmDialogResponse) {
                                                                    // Free up room

                                                                    await widget
                                                                        .ref!
                                                                        .update(
                                                                            createRoomsRecordData(
                                                                      vacant:
                                                                          true,
                                                                      guests: 0,
                                                                    ));
                                                                    // add checkout to history

                                                                    await HistoryRecord.createDoc(
                                                                            checkedInBookingsRecord.room!)
                                                                        .set({
                                                                      ...createHistoryRecordData(
                                                                        description:
                                                                            '${checkedInBookingsRecord.guests} guest${functions.stringToInt(checkedInBookingsRecord.guests)! > 1 ? 's' : ''} in room ${widget.roomNo?.toString()} have checked out.',
                                                                        staff:
                                                                            currentUserReference,
                                                                        booking:
                                                                            widget.booking,
                                                                      ),
                                                                      ...mapToFirestore(
                                                                        {
                                                                          'date':
                                                                              FieldValue.serverTimestamp(),
                                                                        },
                                                                      ),
                                                                    });
                                                                    // Check out

                                                                    await widget
                                                                        .booking!
                                                                        .update({
                                                                      ...createBookingsRecordData(
                                                                        status:
                                                                            'out',
                                                                      ),
                                                                      ...mapToFirestore(
                                                                        {
                                                                          'dateOut':
                                                                              FieldValue.serverTimestamp(),
                                                                        },
                                                                      ),
                                                                    });
                                                                    // Left hotel
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(
                                                                      SnackBar(
                                                                        content:
                                                                            Text(
                                                                          'Guest has left this establishment',
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primaryText,
                                                                          ),
                                                                        ),
                                                                        duration:
                                                                            Duration(milliseconds: 4000),
                                                                        backgroundColor:
                                                                            FlutterFlowTheme.of(context).secondary,
                                                                      ),
                                                                    );
                                                                    context
                                                                        .safePop();
                                                                  } else {
                                                                    if (_shouldSetState)
                                                                      setState(
                                                                          () {});
                                                                    return;
                                                                  }
                                                                }

                                                                if (_shouldSetState)
                                                                  setState(
                                                                      () {});
                                                              },
                                                              text: checkedInBookingsRecord
                                                                          .status ==
                                                                      'pending'
                                                                  ? 'Pay Balance'
                                                                  : 'Check Out',
                                                              options:
                                                                  FFButtonOptions(
                                                                height: 48.0,
                                                                padding: EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        16.0,
                                                                        0.0,
                                                                        16.0,
                                                                        0.0),
                                                                iconPadding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                color: checkedInBookingsRecord
                                                                            .status ==
                                                                        'pending'
                                                                    ? FlutterFlowTheme.of(
                                                                            context)
                                                                        .primary
                                                                    : FlutterFlowTheme.of(
                                                                            context)
                                                                        .error,
                                                                textStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall,
                                                                elevation: 3.0,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12.0),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                    ].divide(
                                                        SizedBox(width: 16.0)),
                                                  ),
                                                ),
                                                if (_model.showChangePrice)
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 10.0,
                                                                0.0, 0.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  -1.0, 0.0),
                                                          child:
                                                              FlutterFlowDropDown<
                                                                  String>(
                                                            controller: _model
                                                                    .priceChangedescriptionValueController ??=
                                                                FormFieldController<
                                                                    String>(
                                                              _model.priceChangedescriptionValue ??=
                                                                  'Discount',
                                                            ),
                                                            options: [
                                                              'Discount',
                                                              'Extend Hours',
                                                              'Change Room'
                                                            ],
                                                            onChanged: (val) =>
                                                                setState(() =>
                                                                    _model.priceChangedescriptionValue =
                                                                        val),
                                                            width: 308.0,
                                                            height: 50.0,
                                                            textStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium,
                                                            hintText:
                                                                'Please select...',
                                                            icon: Icon(
                                                              Icons
                                                                  .keyboard_arrow_down_rounded,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryText,
                                                              size: 24.0,
                                                            ),
                                                            fillColor: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                            elevation: 2.0,
                                                            borderColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .alternate,
                                                            borderWidth: 2.0,
                                                            borderRadius: 8.0,
                                                            margin:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        16.0,
                                                                        4.0,
                                                                        16.0,
                                                                        4.0),
                                                            hidesUnderline:
                                                                true,
                                                            isSearchable: false,
                                                            isMultiSelect:
                                                                false,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      5.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            children: [
                                                              Text(
                                                                formatNumber(
                                                                  checkedInBookingsRecord
                                                                      .total,
                                                                  formatType:
                                                                      FormatType
                                                                          .decimal,
                                                                  decimalType:
                                                                      DecimalType
                                                                          .automatic,
                                                                  currency: '₱',
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Readex Pro',
                                                                      fontSize:
                                                                          18.0,
                                                                    ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        20.0,
                                                                        0.0,
                                                                        20.0,
                                                                        0.0),
                                                                child: Icon(
                                                                  Icons
                                                                      .arrow_forward,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryText,
                                                                  size: 24.0,
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          8.0,
                                                                          0.0,
                                                                          8.0,
                                                                          0.0),
                                                                  child:
                                                                      Container(
                                                                    width:
                                                                        100.0,
                                                                    child:
                                                                        TextFormField(
                                                                      controller:
                                                                          _model
                                                                              .newPriceController,
                                                                      focusNode:
                                                                          _model
                                                                              .newPriceFocusNode,
                                                                      autofocus:
                                                                          true,
                                                                      obscureText:
                                                                          false,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        labelText:
                                                                            'New Price',
                                                                        labelStyle:
                                                                            FlutterFlowTheme.of(context).labelMedium,
                                                                        hintStyle:
                                                                            FlutterFlowTheme.of(context).labelMedium,
                                                                        enabledBorder:
                                                                            UnderlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).alternate,
                                                                            width:
                                                                                2.0,
                                                                          ),
                                                                          borderRadius:
                                                                              BorderRadius.circular(8.0),
                                                                        ),
                                                                        focusedBorder:
                                                                            UnderlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primary,
                                                                            width:
                                                                                2.0,
                                                                          ),
                                                                          borderRadius:
                                                                              BorderRadius.circular(8.0),
                                                                        ),
                                                                        errorBorder:
                                                                            UnderlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).error,
                                                                            width:
                                                                                2.0,
                                                                          ),
                                                                          borderRadius:
                                                                              BorderRadius.circular(8.0),
                                                                        ),
                                                                        focusedErrorBorder:
                                                                            UnderlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).error,
                                                                            width:
                                                                                2.0,
                                                                          ),
                                                                          borderRadius:
                                                                              BorderRadius.circular(8.0),
                                                                        ),
                                                                      ),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium,
                                                                      keyboardType:
                                                                          TextInputType
                                                                              .number,
                                                                      validator: _model
                                                                          .newPriceControllerValidator
                                                                          .asValidator(
                                                                              context),
                                                                      inputFormatters: [
                                                                        FilteringTextInputFormatter.allow(
                                                                            RegExp('[0-9]'))
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              FlutterFlowIconButton(
                                                                borderRadius:
                                                                    20.0,
                                                                borderWidth:
                                                                    1.0,
                                                                buttonSize:
                                                                    40.0,
                                                                icon: FaIcon(
                                                                  FontAwesomeIcons
                                                                      .check,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  size: 24.0,
                                                                ),
                                                                onPressed:
                                                                    () async {
                                                                  if (_model.newPriceController
                                                                              .text !=
                                                                          null &&
                                                                      _model.newPriceController
                                                                              .text !=
                                                                          '') {
                                                                    // update Booking

                                                                    await widget
                                                                        .booking!
                                                                        .update(
                                                                            createBookingsRecordData(
                                                                      total: double.tryParse(_model
                                                                          .newPriceController
                                                                          .text),
                                                                    ));
                                                                    // hotel settings
                                                                    _model.hotelSetting =
                                                                        await queryHotelSettingsRecordOnce(
                                                                      queryBuilder:
                                                                          (hotelSettingsRecord) =>
                                                                              hotelSettingsRecord.where(
                                                                        'hotel',
                                                                        isEqualTo:
                                                                            FFAppState().hotel,
                                                                      ),
                                                                      singleRecord:
                                                                          true,
                                                                    ).then((s) =>
                                                                            s.firstOrNull);
                                                                    if (checkedInBookingsRecord
                                                                            .status ==
                                                                        'paid') {
                                                                      // new transaction

                                                                      var transactionsRecordReference1 = TransactionsRecord
                                                                          .collection
                                                                          .doc();
                                                                      await transactionsRecordReference1
                                                                          .set({
                                                                        ...createTransactionsRecordData(
                                                                          staff:
                                                                              currentUserReference,
                                                                          total: functions.priceHasChanged(
                                                                              checkedInBookingsRecord.total,
                                                                              double.parse(_model.newPriceController.text)),
                                                                          booking:
                                                                              widget.booking,
                                                                          hotel:
                                                                              FFAppState().hotel,
                                                                          type:
                                                                              'book',
                                                                          guests:
                                                                              int.parse(checkedInBookingsRecord.guests),
                                                                          room:
                                                                              widget.roomNo,
                                                                          description: '${_model.priceChangedescriptionValue == 'Extra Bed' ? ((double priceChange, double bedPrice) {
                                                                              return (priceChange / bedPrice).toInt().abs().toString() + " ";
                                                                            }(functions.priceHasChanged(checkedInBookingsRecord.total, double.parse(_model.newPriceController.text)), _model.hotelSetting!.bedPrice)) : ''}${_model.priceChangedescriptionValue} for room ${widget.roomNo?.toString()}',
                                                                          remitted:
                                                                              false,
                                                                          pending:
                                                                              false,
                                                                        ),
                                                                        ...mapToFirestore(
                                                                          {
                                                                            'date':
                                                                                FieldValue.serverTimestamp(),
                                                                          },
                                                                        ),
                                                                      });
                                                                      _model.changePriceTrans =
                                                                          TransactionsRecord
                                                                              .getDocumentFromData({
                                                                        ...createTransactionsRecordData(
                                                                          staff:
                                                                              currentUserReference,
                                                                          total: functions.priceHasChanged(
                                                                              checkedInBookingsRecord.total,
                                                                              double.parse(_model.newPriceController.text)),
                                                                          booking:
                                                                              widget.booking,
                                                                          hotel:
                                                                              FFAppState().hotel,
                                                                          type:
                                                                              'book',
                                                                          guests:
                                                                              int.parse(checkedInBookingsRecord.guests),
                                                                          room:
                                                                              widget.roomNo,
                                                                          description: '${_model.priceChangedescriptionValue == 'Extra Bed' ? ((double priceChange, double bedPrice) {
                                                                              return (priceChange / bedPrice).toInt().abs().toString() + " ";
                                                                            }(functions.priceHasChanged(checkedInBookingsRecord.total, double.parse(_model.newPriceController.text)), _model.hotelSetting!.bedPrice)) : ''}${_model.priceChangedescriptionValue} for room ${widget.roomNo?.toString()}',
                                                                          remitted:
                                                                              false,
                                                                          pending:
                                                                              false,
                                                                        ),
                                                                        ...mapToFirestore(
                                                                          {
                                                                            'date':
                                                                                DateTime.now(),
                                                                          },
                                                                        ),
                                                                      }, transactionsRecordReference1);

                                                                      await widget
                                                                          .booking!
                                                                          .update({
                                                                        ...mapToFirestore(
                                                                          {
                                                                            'transactions':
                                                                                FieldValue.arrayUnion([
                                                                              _model.changePriceTrans?.reference
                                                                            ]),
                                                                          },
                                                                        ),
                                                                      });
                                                                      // add this price change to history

                                                                      await HistoryRecord.createDoc(
                                                                              checkedInBookingsRecord.room!)
                                                                          .set({
                                                                        ...createHistoryRecordData(
                                                                          description:
                                                                              'There was a change of price from ${checkedInBookingsRecord.total.toString()} to ${_model.newPriceController.text}. For the reason ${_model.priceChangedescriptionValue}. This caused a price change of ${functions.priceHasChanged(checkedInBookingsRecord.total, double.parse(_model.newPriceController.text)).toString()}.',
                                                                          staff:
                                                                              currentUserReference,
                                                                          booking:
                                                                              widget.booking,
                                                                        ),
                                                                        ...mapToFirestore(
                                                                          {
                                                                            'date':
                                                                                FieldValue.serverTimestamp(),
                                                                          },
                                                                        ),
                                                                      });
                                                                    } else {
                                                                      // new pending transaction

                                                                      var transactionsRecordReference2 = TransactionsRecord
                                                                          .collection
                                                                          .doc();
                                                                      await transactionsRecordReference2
                                                                          .set({
                                                                        ...createTransactionsRecordData(
                                                                          staff:
                                                                              currentUserReference,
                                                                          total: functions.priceHasChanged(
                                                                              checkedInBookingsRecord.total,
                                                                              double.parse(_model.newPriceController.text)),
                                                                          booking:
                                                                              widget.booking,
                                                                          hotel:
                                                                              FFAppState().hotel,
                                                                          type:
                                                                              'book',
                                                                          guests:
                                                                              int.parse(checkedInBookingsRecord.guests),
                                                                          room:
                                                                              widget.roomNo,
                                                                          description: '${_model.priceChangedescriptionValue == 'Extra Bed' ? ((double priceChange, double bedPrice) {
                                                                              return (priceChange / bedPrice).toInt().abs().toString() + " ";
                                                                            }(functions.priceHasChanged(checkedInBookingsRecord.total, double.parse(_model.newPriceController.text)), _model.hotelSetting!.bedPrice)) : ''}${_model.priceChangedescriptionValue} for room ${widget.roomNo?.toString()}',
                                                                          remitted:
                                                                              false,
                                                                          pending:
                                                                              true,
                                                                        ),
                                                                        ...mapToFirestore(
                                                                          {
                                                                            'date':
                                                                                FieldValue.serverTimestamp(),
                                                                          },
                                                                        ),
                                                                      });
                                                                      _model.newPending =
                                                                          TransactionsRecord
                                                                              .getDocumentFromData({
                                                                        ...createTransactionsRecordData(
                                                                          staff:
                                                                              currentUserReference,
                                                                          total: functions.priceHasChanged(
                                                                              checkedInBookingsRecord.total,
                                                                              double.parse(_model.newPriceController.text)),
                                                                          booking:
                                                                              widget.booking,
                                                                          hotel:
                                                                              FFAppState().hotel,
                                                                          type:
                                                                              'book',
                                                                          guests:
                                                                              int.parse(checkedInBookingsRecord.guests),
                                                                          room:
                                                                              widget.roomNo,
                                                                          description: '${_model.priceChangedescriptionValue == 'Extra Bed' ? ((double priceChange, double bedPrice) {
                                                                              return (priceChange / bedPrice).toInt().abs().toString() + " ";
                                                                            }(functions.priceHasChanged(checkedInBookingsRecord.total, double.parse(_model.newPriceController.text)), _model.hotelSetting!.bedPrice)) : ''}${_model.priceChangedescriptionValue} for room ${widget.roomNo?.toString()}',
                                                                          remitted:
                                                                              false,
                                                                          pending:
                                                                              true,
                                                                        ),
                                                                        ...mapToFirestore(
                                                                          {
                                                                            'date':
                                                                                DateTime.now(),
                                                                          },
                                                                        ),
                                                                      }, transactionsRecordReference2);
                                                                      // add to pending list

                                                                      await widget
                                                                          .booking!
                                                                          .update({
                                                                        ...mapToFirestore(
                                                                          {
                                                                            'pendings':
                                                                                FieldValue.arrayUnion([
                                                                              _model.newPending?.reference
                                                                            ]),
                                                                          },
                                                                        ),
                                                                      });
                                                                      // add this price change to history

                                                                      await HistoryRecord.createDoc(
                                                                              checkedInBookingsRecord.room!)
                                                                          .set({
                                                                        ...createHistoryRecordData(
                                                                          description:
                                                                              'There was a change of price from ${checkedInBookingsRecord.total.toString()} to ${_model.newPriceController.text}. For the reason ${_model.priceChangedescriptionValue}. This caused a price change of ${functions.priceHasChanged(checkedInBookingsRecord.total, double.parse(_model.newPriceController.text)).toString()}. But payment is pending.',
                                                                          staff:
                                                                              currentUserReference,
                                                                          booking:
                                                                              widget.booking,
                                                                        ),
                                                                        ...mapToFirestore(
                                                                          {
                                                                            'date':
                                                                                FieldValue.serverTimestamp(),
                                                                          },
                                                                        ),
                                                                      });
                                                                    }

                                                                    if (_model
                                                                            .priceChangedescriptionValue ==
                                                                        'Extra Bed') {
                                                                      // change extra bed value

                                                                      await widget
                                                                          .booking!
                                                                          .update(
                                                                              createBookingsRecordData(
                                                                        extraBeds:
                                                                            ((functions.priceHasChanged(checkedInBookingsRecord.total, double.parse(_model.newPriceController.text)) / _model.hotelSetting!.bedPrice).toInt().abs()).toString(),
                                                                      ));
                                                                    }
                                                                    context
                                                                        .safePop();
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(
                                                                      SnackBar(
                                                                        content:
                                                                            Text(
                                                                          'Price has been adjusted!',
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primaryText,
                                                                          ),
                                                                        ),
                                                                        duration:
                                                                            Duration(milliseconds: 4000),
                                                                        backgroundColor:
                                                                            FlutterFlowTheme.of(context).secondary,
                                                                      ),
                                                                    );
                                                                  } else {
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(
                                                                      SnackBar(
                                                                        content:
                                                                            Text(
                                                                          'You left the price empty!',
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).accent4,
                                                                          ),
                                                                        ),
                                                                        duration:
                                                                            Duration(milliseconds: 4000),
                                                                        backgroundColor:
                                                                            FlutterFlowTheme.of(context).error,
                                                                      ),
                                                                    );
                                                                  }

                                                                  setState(
                                                                      () {});
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),

                                                // Create this as a component if you want to use it best.
                                                if (responsiveVisibility(
                                                  context: context,
                                                  tabletLandscape: false,
                                                  desktop: false,
                                                ))
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 16.0,
                                                                0.0, 0.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      4.0,
                                                                      0.0,
                                                                      12.0),
                                                          child: Text(
                                                            'Checked In By',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .labelMedium,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      12.0),
                                                          child: StreamBuilder<
                                                              UsersRecord>(
                                                            stream: UsersRecord
                                                                .getDocument(
                                                                    checkedInBookingsRecord
                                                                        .staff!),
                                                            builder: (context,
                                                                snapshot) {
                                                              // Customize what your widget looks like when it's loading.
                                                              if (!snapshot
                                                                  .hasData) {
                                                                return Center(
                                                                  child:
                                                                      SizedBox(
                                                                    width: 50.0,
                                                                    height:
                                                                        50.0,
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
                                                              final containerUsersRecord =
                                                                  snapshot
                                                                      .data!;
                                                              return Container(
                                                                width: double
                                                                    .infinity,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryBackground,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12.0),
                                                                  border: Border
                                                                      .all(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .alternate,
                                                                    width: 2.0,
                                                                  ),
                                                                ),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          12.0),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Padding(
                                                                        padding:
                                                                            EdgeInsets.all(12.0),
                                                                        child:
                                                                            Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children: [
                                                                            Container(
                                                                              width: 44.0,
                                                                              height: 44.0,
                                                                              decoration: BoxDecoration(
                                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                borderRadius: BorderRadius.circular(12.0),
                                                                                border: Border.all(
                                                                                  color: FlutterFlowTheme.of(context).alternate,
                                                                                ),
                                                                              ),
                                                                              child: Padding(
                                                                                padding: EdgeInsets.all(2.0),
                                                                                child: ClipRRect(
                                                                                  borderRadius: BorderRadius.circular(10.0),
                                                                                  child: Image.asset(
                                                                                    'assets/images/x7hc1_7.png',
                                                                                    width: 44.0,
                                                                                    height: 44.0,
                                                                                    fit: BoxFit.cover,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                                                                              child: Column(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Text(
                                                                                    containerUsersRecord.displayName,
                                                                                    style: FlutterFlowTheme.of(context).bodyLarge,
                                                                                  ),
                                                                                  Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                                                                                    child: Text(
                                                                                      'staff',
                                                                                      style: FlutterFlowTheme.of(context).labelSmall.override(
                                                                                            fontFamily: 'Readex Pro',
                                                                                            color: FlutterFlowTheme.of(context).primaryText,
                                                                                          ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            16.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            Text(
                                                                          'Date of Check In',
                                                                          style:
                                                                              FlutterFlowTheme.of(context).labelSmall,
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            16.0,
                                                                            3.0,
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            Text(
                                                                          dateTimeFormat(
                                                                              'MMMM EEEE d h:mm a',
                                                                              checkedInBookingsRecord.dateIn!),
                                                                          style:
                                                                              FlutterFlowTheme.of(context).bodyMedium,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 8.0, 0.0, 0.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Contact',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Readex Pro',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                ),
                                                      ),
                                                      Text(
                                                        checkedInBookingsRecord
                                                            .contact,
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 8.0, 0.0, 0.0),
                                                  child: Text(
                                                    'Guest Details',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .labelMedium,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 8.0, 0.0, 0.0),
                                                  child: Text(
                                                    checkedInBookingsRecord
                                                        .details,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyLarge,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ].divide(SizedBox(width: 16.0)),
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
