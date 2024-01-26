import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_count_controller.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'check_in_model.dart';
export 'check_in_model.dart';

class CheckInWidget extends StatefulWidget {
  const CheckInWidget({
    super.key,
    this.price,
    this.ref,
    double? totalAmount,
    required this.roomNo,
    bool? extend,
    this.bookingToExtend,
    bool? promoOn,
    String? promoDetail,
    double? promoDiscount,
  })  : this.totalAmount = totalAmount ?? 0.0,
        this.extend = extend ?? false,
        this.promoOn = promoOn ?? false,
        this.promoDetail = promoDetail ?? 'No promo',
        this.promoDiscount = promoDiscount ?? 0.0;

  final double? price;
  final DocumentReference? ref;
  final double totalAmount;
  final int? roomNo;
  final bool extend;
  final BookingsRecord? bookingToExtend;
  final bool promoOn;
  final String promoDetail;
  final double promoDiscount;

  @override
  State<CheckInWidget> createState() => _CheckInWidgetState();
}

class _CheckInWidgetState extends State<CheckInWidget>
    with TickerProviderStateMixin {
  late CheckInModel _model;

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
          begin: Offset(0.0, 100.0),
          end: Offset(0.0, 0.0),
        ),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CheckInModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      // default status
      setState(() {
        _model.paid = true;
      });
      if (widget.extend) {
        // room
        _model.room = await RoomsRecord.getDocumentOnce(widget.ref!);
        // set price, nights, beds, paid
        setState(() {
          _model.price = valueOrDefault<double>(
            (widget.bookingToExtend?.ability == 'senior') ||
                    (widget.bookingToExtend?.ability == 'pwd')
                ? (_model.room!.price - _model.room!.price * 0.2)
                : _model.room?.price,
            0.0,
          );
          _model.startingNights = widget.bookingToExtend?.nights;
          _model.startingBeds = widget.bookingToExtend?.extraBeds;
          _model.paid = widget.bookingToExtend?.status == 'paid';
          _model.pendings = widget.bookingToExtend!.pendings
              .toList()
              .cast<DocumentReference>();
          _model.transactions = widget.bookingToExtend!.transactions
              .toList()
              .cast<DocumentReference>();
          _model.ability = widget.bookingToExtend!.ability;
        });
      } else {
        setState(() {
          _model.price = valueOrDefault<double>(
            widget.price,
            0.0,
          );
          _model.startingNights = 0;
          _model.startingBeds = '-1';
        });
      }
    });

    _model.contactFieldController ??= TextEditingController(
        text: widget.extend == true ? widget.bookingToExtend?.contact : '');
    _model.contactFieldFocusNode ??= FocusNode();

    _model.detailsFieldController ??= TextEditingController(
        text: widget.extend == true ? widget.bookingToExtend?.details : '');
    _model.detailsFieldFocusNode ??= FocusNode();

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
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primary,
        automaticallyImplyLeading: false,
        leading: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30.0,
          buttonSize: 48.0,
          icon: Icon(
            Icons.arrow_back_rounded,
            color: FlutterFlowTheme.of(context).info,
            size: 30.0,
          ),
          onPressed: () async {
            context.safePop();
          },
        ),
        title: Text(
          '${widget.extend == false ? 'New Booking' : 'Extend Booking'} In Room ${widget.roomNo?.toString()}',
          style: FlutterFlowTheme.of(context).titleSmall,
        ),
        actions: [],
        centerTitle: false,
        elevation: 0.0,
      ),
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).primary,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                if (widget.promoOn)
                                  Align(
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 24.0, 16.0, 0.0),
                                      child: Container(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.9,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 8.0,
                                              color: Color(0x36000000),
                                              offset: Offset(0.0, 4.0),
                                            )
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(12.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Card(
                                                    clipBehavior: Clip
                                                        .antiAliasWithSaveLayer,
                                                    color: Color(0xFFFD949C),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      child: Icon(
                                                        Icons.discount_outlined,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .info,
                                                        size: 24.0,
                                                      ),
                                                    ),
                                                  ),
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Text(
                                                            widget.promoDetail,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .titleLarge
                                                                .override(
                                                                  fontFamily:
                                                                      'Outfit',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .info,
                                                                ),
                                                          ),
                                                        ],
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
                                                          '${widget.promoDiscount.toString()}%',
                                                          textAlign:
                                                              TextAlign.end,
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodySmall
                                                              .override(
                                                                fontFamily:
                                                                    'Lexend Deca',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .accent4,
                                                                fontSize: 14.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                Align(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 24.0, 16.0, 24.0),
                                    child: Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.9,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .accent4,
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 8.0,
                                            color: Color(0x36000000),
                                            offset: Offset(0.0, 4.0),
                                          )
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(12.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Card(
                                                  clipBehavior: Clip
                                                      .antiAliasWithSaveLayer,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: FaIcon(
                                                      FontAwesomeIcons.bed,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .info,
                                                      size: 24.0,
                                                    ),
                                                  ),
                                                ),
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Text(
                                                          _model.price
                                                              .toString(),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .titleLarge,
                                                        ),
                                                      ],
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
                                                        'per night',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodySmall
                                                                .override(
                                                                  fontFamily:
                                                                      'Lexend Deca',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryText,
                                                                  fontSize:
                                                                      14.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  width: 140.0,
                                                  height: 50.0,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .accent1,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25.0),
                                                    shape: BoxShape.rectangle,
                                                    border: Border.all(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .alternate,
                                                      width: 2.0,
                                                    ),
                                                  ),
                                                  child:
                                                      FlutterFlowCountController(
                                                    decrementIconBuilder:
                                                        (enabled) => FaIcon(
                                                      FontAwesomeIcons.minus,
                                                      color: enabled
                                                          ? FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryText
                                                          : Color(0xFFE0E3E7),
                                                      size: 20.0,
                                                    ),
                                                    incrementIconBuilder:
                                                        (enabled) => FaIcon(
                                                      FontAwesomeIcons.plus,
                                                      color: enabled
                                                          ? FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText
                                                          : Color(0xFFE0E3E7),
                                                      size: 20.0,
                                                    ),
                                                    countBuilder: (count) =>
                                                        Text(
                                                      count.toString(),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .headlineMedium,
                                                    ),
                                                    count: _model
                                                        .nightsValue ??= widget
                                                                .extend ==
                                                            true
                                                        ? widget
                                                            .bookingToExtend!
                                                            .nights
                                                        : 1,
                                                    updateCount: (count) =>
                                                        setState(() =>
                                                            _model.nightsValue =
                                                                count),
                                                    stepSize: 1,
                                                    minimum: 0,
                                                  ),
                                                ),
                                              ],
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
                      ],
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 16.0, 0.0, 0.0),
                                  child: TextFormField(
                                    controller: _model.contactFieldController,
                                    focusNode: _model.contactFieldFocusNode,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Contact',
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .labelMedium,
                                      hintText: 'Mobile Number',
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .labelMedium,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .alternate,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      filled: true,
                                      fillColor: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                        ),
                                    validator: _model
                                        .contactFieldControllerValidator
                                        .asValidator(context),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 16.0, 0.0, 0.0),
                                  child: TextFormField(
                                    controller: _model.detailsFieldController,
                                    focusNode: _model.detailsFieldFocusNode,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'ID',
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .labelMedium,
                                      hintText: 'Additional details',
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .labelMedium,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .alternate,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      filled: true,
                                      fillColor: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                        ),
                                    maxLines: null,
                                    minLines: 3,
                                    keyboardType: TextInputType.multiline,
                                    validator: _model
                                        .detailsFieldControllerValidator
                                        .asValidator(context),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              24.0, 16.0, 24.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'EXTRA BED',
                                style: FlutterFlowTheme.of(context)
                                    .bodySmall
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              if (FFAppState().bedPrice != null)
                                Text(
                                  formatNumber(
                                    FFAppState().bedPrice,
                                    formatType: FormatType.decimal,
                                    decimalType: DecimalType.automatic,
                                    currency: 'Php ',
                                  ),
                                  style:
                                      FlutterFlowTheme.of(context).bodyMedium,
                                ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              24.0, 12.0, 16.0, 0.0),
                          child: Wrap(
                            spacing: 0.0,
                            runSpacing: 0.0,
                            alignment: WrapAlignment.start,
                            crossAxisAlignment: WrapCrossAlignment.start,
                            direction: Axis.horizontal,
                            runAlignment: WrapAlignment.start,
                            verticalDirection: VerticalDirection.down,
                            clipBehavior: Clip.none,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 8.0, 0.0, 15.0),
                                child: FlutterFlowChoiceChips(
                                  options: [
                                    ChipData('0'),
                                    ChipData('1'),
                                    ChipData('2'),
                                    ChipData('3'),
                                    ChipData('4'),
                                    ChipData('5'),
                                    ChipData('6'),
                                    ChipData('7'),
                                    ChipData('8'),
                                    ChipData('9'),
                                    ChipData('10')
                                  ],
                                  onChanged: (val) => setState(
                                      () => _model.bedsValue = val?.first),
                                  selectedChipStyle: ChipStyle(
                                    backgroundColor:
                                        FlutterFlowTheme.of(context).primary,
                                    textStyle:
                                        FlutterFlowTheme.of(context).titleSmall,
                                    iconColor: Colors.white,
                                    iconSize: 18.0,
                                    labelPadding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            12.0, 4.0, 12.0, 4.0),
                                    elevation: 2.0,
                                  ),
                                  unselectedChipStyle: ChipStyle(
                                    backgroundColor:
                                        FlutterFlowTheme.of(context).alternate,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .labelMedium,
                                    iconColor: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    iconSize: 18.0,
                                    labelPadding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            12.0, 4.0, 12.0, 4.0),
                                    elevation: 0.0,
                                  ),
                                  chipSpacing: 12.0,
                                  rowSpacing: 24.0,
                                  multiselect: false,
                                  initialized: _model.bedsValue != null,
                                  alignment: WrapAlignment.start,
                                  controller: _model.bedsValueController ??=
                                      FormFieldController<List<String>>(
                                    [
                                      widget.extend
                                          ? widget.bookingToExtend!.extraBeds
                                          : '0'
                                    ],
                                  ),
                                  wrapped: true,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              24.0, 16.0, 24.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Number of Guests',
                                style: FlutterFlowTheme.of(context)
                                    .bodySmall
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              24.0, 12.0, 16.0, 0.0),
                          child: Wrap(
                            spacing: 0.0,
                            runSpacing: 0.0,
                            alignment: WrapAlignment.start,
                            crossAxisAlignment: WrapCrossAlignment.start,
                            direction: Axis.horizontal,
                            runAlignment: WrapAlignment.start,
                            verticalDirection: VerticalDirection.down,
                            clipBehavior: Clip.none,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 8.0, 0.0, 15.0),
                                child: FlutterFlowChoiceChips(
                                  options: [
                                    ChipData('1'),
                                    ChipData('2'),
                                    ChipData('3'),
                                    ChipData('4'),
                                    ChipData('5'),
                                    ChipData('6')
                                  ],
                                  onChanged: (val) => setState(
                                      () => _model.guestsValue = val?.first),
                                  selectedChipStyle: ChipStyle(
                                    backgroundColor:
                                        FlutterFlowTheme.of(context).primary,
                                    textStyle:
                                        FlutterFlowTheme.of(context).titleSmall,
                                    iconColor: Colors.white,
                                    iconSize: 18.0,
                                    labelPadding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            12.0, 4.0, 12.0, 4.0),
                                    elevation: 2.0,
                                  ),
                                  unselectedChipStyle: ChipStyle(
                                    backgroundColor:
                                        FlutterFlowTheme.of(context).alternate,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .labelMedium,
                                    iconColor: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    iconSize: 18.0,
                                    labelPadding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            12.0, 4.0, 12.0, 4.0),
                                    elevation: 0.0,
                                  ),
                                  chipSpacing: 12.0,
                                  rowSpacing: 24.0,
                                  multiselect: false,
                                  initialized: _model.guestsValue != null,
                                  alignment: WrapAlignment.start,
                                  controller: _model.guestsValueController ??=
                                      FormFieldController<List<String>>(
                                    [
                                      widget.extend == true
                                          ? widget.bookingToExtend!.guests
                                          : '1'
                                    ],
                                  ),
                                  wrapped: true,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (widget.extend)
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                24.0, 16.0, 24.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Extend hours',
                                  style: FlutterFlowTheme.of(context)
                                      .bodySmall
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                if (FFAppState().extPricePerHr != null)
                                  Text(
                                    formatNumber(
                                      FFAppState().extPricePerHr,
                                      formatType: FormatType.decimal,
                                      decimalType: DecimalType.automatic,
                                      currency: 'Php ',
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          fontSize: 12.0,
                                        ),
                                  ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                24.0, 12.0, 16.0, 0.0),
                            child: Wrap(
                              spacing: 0.0,
                              runSpacing: 0.0,
                              alignment: WrapAlignment.start,
                              crossAxisAlignment: WrapCrossAlignment.start,
                              direction: Axis.horizontal,
                              runAlignment: WrapAlignment.start,
                              verticalDirection: VerticalDirection.down,
                              clipBehavior: Clip.none,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 8.0, 0.0, 15.0),
                                  child: FlutterFlowChoiceChips(
                                    options: [
                                      ChipData('0'),
                                      ChipData('1'),
                                      ChipData('2'),
                                      ChipData('3'),
                                      ChipData('4'),
                                      ChipData('5')
                                    ],
                                    onChanged: (val) async {
                                      setState(() => _model
                                          .hoursLateCheckoutValue = val?.first);
                                      if (_model.paid == false) {
                                        if (_model.hoursLateCheckoutValue !=
                                            '0') {
                                          // make status paid
                                          setState(() {
                                            _model.paid = true;
                                          });
                                        }
                                      }
                                    },
                                    selectedChipStyle: ChipStyle(
                                      backgroundColor:
                                          FlutterFlowTheme.of(context).primary,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleSmall,
                                      iconColor: Colors.white,
                                      iconSize: 18.0,
                                      labelPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              12.0, 4.0, 12.0, 4.0),
                                      elevation: 2.0,
                                    ),
                                    unselectedChipStyle: ChipStyle(
                                      backgroundColor:
                                          FlutterFlowTheme.of(context)
                                              .alternate,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .labelMedium,
                                      iconColor: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      iconSize: 18.0,
                                      labelPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              12.0, 4.0, 12.0, 4.0),
                                      elevation: 0.0,
                                    ),
                                    chipSpacing: 12.0,
                                    rowSpacing: 24.0,
                                    multiselect: false,
                                    initialized:
                                        _model.hoursLateCheckoutValue != null,
                                    alignment: WrapAlignment.start,
                                    controller: _model
                                            .hoursLateCheckoutValueController ??=
                                        FormFieldController<List<String>>(
                                      ['0'],
                                    ),
                                    wrapped: true,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    Align(
                      alignment: AlignmentDirectional(0.0, -1.0),
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
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
                            padding: EdgeInsets.all(4.0),
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
                                        _model.paid = true;
                                      });
                                    },
                                    child: Container(
                                      width: 115.0,
                                      height: 100.0,
                                      decoration: BoxDecoration(
                                        color: _model.paid
                                            ? FlutterFlowTheme.of(context)
                                                .secondaryBackground
                                            : FlutterFlowTheme.of(context)
                                                .primaryBackground,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        border: Border.all(
                                          color: valueOrDefault<Color>(
                                            _model.paid
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
                                              'Paid',
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
                                        _model.paid = false;
                                      });
                                    },
                                    child: Container(
                                      width: 115.0,
                                      height: 100.0,
                                      decoration: BoxDecoration(
                                        color: !_model.paid
                                            ? FlutterFlowTheme.of(context)
                                                .secondaryBackground
                                            : FlutterFlowTheme.of(context)
                                                .primaryBackground,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        border: Border.all(
                                          color: !_model.paid
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
                    if (!widget.extend)
                      Align(
                        alignment: AlignmentDirectional(0.0, -1.0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 16.0),
                          child: Container(
                            width: double.infinity,
                            height: 50.0,
                            constraints: BoxConstraints(
                              maxWidth: 500.0,
                            ),
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              borderRadius: BorderRadius.circular(12.0),
                              border: Border.all(
                                color: FlutterFlowTheme.of(context).alternate,
                                width: 1.0,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(4.0),
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
                                          _model.ability = 'normal';
                                          _model.price = widget.price!;
                                        });
                                      },
                                      child: Container(
                                        width: 115.0,
                                        height: 100.0,
                                        decoration: BoxDecoration(
                                          color: _model.ability == 'normal'
                                              ? FlutterFlowTheme.of(context)
                                                  .secondaryBackground
                                              : FlutterFlowTheme.of(context)
                                                  .primaryBackground,
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          border: Border.all(
                                            color: valueOrDefault<Color>(
                                              _model.ability == 'normal'
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
                                              Icons.emoji_people_sharp,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              size: 16.0,
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(4.0, 0.0, 0.0, 0.0),
                                              child: Text(
                                                'Normal',
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Readex Pro',
                                                      color:
                                                          FlutterFlowTheme.of(
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
                                          _model.ability = 'senior';
                                          _model.price =
                                              (double roomPrice, bool promoOn) {
                                            return roomPrice -
                                                roomPrice *
                                                    (promoOn ? 0.1 : 0.2);
                                          }(widget.price!, widget.promoOn);
                                        });
                                      },
                                      child: Container(
                                        width: 115.0,
                                        height: 100.0,
                                        decoration: BoxDecoration(
                                          color: _model.ability == 'senior'
                                              ? FlutterFlowTheme.of(context)
                                                  .secondaryBackground
                                              : FlutterFlowTheme.of(context)
                                                  .primaryBackground,
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          border: Border.all(
                                            color: _model.ability == 'senior'
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
                                              Icons.wheelchair_pickup,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              size: 16.0,
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(4.0, 0.0, 0.0, 0.0),
                                              child: Text(
                                                'Senior',
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Readex Pro',
                                                      color:
                                                          FlutterFlowTheme.of(
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
                                          _model.ability = 'pwd';
                                          _model.price =
                                              (double roomPrice, bool promoOn) {
                                            return roomPrice -
                                                roomPrice *
                                                    (promoOn ? 0.1 : 0.2);
                                          }(widget.price!, widget.promoOn);
                                        });
                                      },
                                      child: Container(
                                        width: 115.0,
                                        height: 100.0,
                                        decoration: BoxDecoration(
                                          color: _model.ability == 'pwd'
                                              ? FlutterFlowTheme.of(context)
                                                  .secondaryBackground
                                              : FlutterFlowTheme.of(context)
                                                  .primaryBackground,
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          border: Border.all(
                                            color: _model.ability == 'pwd'
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
                                              Icons.personal_injury_outlined,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              size: 16.0,
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(4.0, 0.0, 0.0, 0.0),
                                              child: Text(
                                                'PWD',
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Readex Pro',
                                                      color:
                                                          FlutterFlowTheme.of(
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
                          EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 12.0),
                      child: Container(
                        width: MediaQuery.sizeOf(context).width * 1.0,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4.0,
                              color: Color(0x55000000),
                              offset: Offset(0.0, 2.0),
                            )
                          ],
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(
                            color: FlutterFlowTheme.of(context).alternate,
                            width: 1.0,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              24.0, 16.0, 16.0, 16.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        formatNumber(
                                          functions.getTotalAmount(
                                              valueOrDefault<String>(
                                                _model.bedsValue,
                                                '0',
                                              ),
                                              valueOrDefault<int>(
                                                _model.nightsValue,
                                                1,
                                              ),
                                              valueOrDefault<double>(
                                                _model.price,
                                                0.0,
                                              ),
                                              valueOrDefault<double>(
                                                FFAppState().bedPrice,
                                                0.0,
                                              ),
                                              '-1',
                                              0,
                                              widget.extend
                                                  ? ((FFAppState()
                                                              .extPricePerHr ??
                                                          0) *
                                                      double.parse(
                                                          valueOrDefault<
                                                              String>(
                                                        _model
                                                            .hoursLateCheckoutValue,
                                                        '0',
                                                      )))
                                                  : 0.0),
                                          formatType: FormatType.decimal,
                                          decimalType: DecimalType.automatic,
                                          currency: 'P ',
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .titleLarge,
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 4.0, 0.0, 0.0),
                                    child: Text(
                                      'Total',
                                      style: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .override(
                                            fontFamily: 'Lexend Deca',
                                            color: FlutterFlowTheme.of(context)
                                                .secondary,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.normal,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                              FFButtonWidget(
                                onPressed: () async {
                                  var _shouldSetState = false;
                                  if (widget.extend) {
                                    if (_model.paid) {
                                      if (functions.hasDifferencesInBookings(
                                          valueOrDefault<String>(
                                            _model.startingBeds,
                                            '-1',
                                          ),
                                          _model.startingNights!,
                                          _model.nightsValue!,
                                          valueOrDefault<String>(
                                            _model.bedsValue,
                                            '0',
                                          ),
                                          _model.hoursLateCheckoutValue !=
                                              '0')) {
                                        // Refund or Extend or Late Checkout

                                        var transactionsRecordReference1 =
                                            TransactionsRecord.collection.doc();
                                        await transactionsRecordReference1.set({
                                          ...createTransactionsRecordData(
                                            staff: currentUserReference,
                                            total: functions.getTotalAmount(
                                                _model.bedsValue!,
                                                _model.nightsValue!,
                                                _model.price,
                                                FFAppState().bedPrice,
                                                valueOrDefault<String>(
                                                  _model.startingBeds,
                                                  '0',
                                                ),
                                                valueOrDefault<int>(
                                                  _model.startingNights,
                                                  0,
                                                ),
                                                widget.extend
                                                    ? ((FFAppState()
                                                                .extPricePerHr ??
                                                            0) *
                                                        double.parse(
                                                            valueOrDefault<
                                                                String>(
                                                          _model
                                                              .hoursLateCheckoutValue,
                                                          '0',
                                                        )))
                                                    : 0.0),
                                            type: 'book',
                                            hotel: FFAppState().hotel,
                                            booking: widget
                                                .bookingToExtend?.reference,
                                            guests: functions.stringToInt(
                                                _model.guestsValue),
                                            room: widget.roomNo,
                                            description:
                                                '${functions.quantityDescriptionForBookings(_model.startingBeds!, _model.bedsValue!, _model.startingNights, _model.nightsValue, widget.roomNo!, _model.hoursLateCheckoutValue!)}${_model.ability != 'normal' ? ' by a ${_model.ability}' : ''}',
                                            remitted: false,
                                            pending: false,
                                          ),
                                          ...mapToFirestore(
                                            {
                                              'date':
                                                  FieldValue.serverTimestamp(),
                                            },
                                          ),
                                        });
                                        _model.refundTrans = TransactionsRecord
                                            .getDocumentFromData({
                                          ...createTransactionsRecordData(
                                            staff: currentUserReference,
                                            total: functions.getTotalAmount(
                                                _model.bedsValue!,
                                                _model.nightsValue!,
                                                _model.price,
                                                FFAppState().bedPrice,
                                                valueOrDefault<String>(
                                                  _model.startingBeds,
                                                  '0',
                                                ),
                                                valueOrDefault<int>(
                                                  _model.startingNights,
                                                  0,
                                                ),
                                                widget.extend
                                                    ? ((FFAppState()
                                                                .extPricePerHr ??
                                                            0) *
                                                        double.parse(
                                                            valueOrDefault<
                                                                String>(
                                                          _model
                                                              .hoursLateCheckoutValue,
                                                          '0',
                                                        )))
                                                    : 0.0),
                                            type: 'book',
                                            hotel: FFAppState().hotel,
                                            booking: widget
                                                .bookingToExtend?.reference,
                                            guests: functions.stringToInt(
                                                _model.guestsValue),
                                            room: widget.roomNo,
                                            description:
                                                '${functions.quantityDescriptionForBookings(_model.startingBeds!, _model.bedsValue!, _model.startingNights, _model.nightsValue, widget.roomNo!, _model.hoursLateCheckoutValue!)}${_model.ability != 'normal' ? ' by a ${_model.ability}' : ''}',
                                            remitted: false,
                                            pending: false,
                                          ),
                                          ...mapToFirestore(
                                            {
                                              'date': DateTime.now(),
                                            },
                                          ),
                                        }, transactionsRecordReference1);
                                        _shouldSetState = true;
                                        // add to trans list
                                        setState(() {
                                          _model.addToTransactions(
                                              _model.refundTrans!.reference);
                                        });
                                        // add this change to history

                                        await HistoryRecord.createDoc(
                                                widget.ref!)
                                            .set({
                                          ...createHistoryRecordData(
                                            description:
                                                '${functions.quantityDescriptionForBookings(_model.startingBeds!, _model.bedsValue!, _model.startingNights, _model.nightsValue, widget.roomNo!, _model.hoursLateCheckoutValue!)}${_model.ability != 'normal' ? ' by a ${_model.ability}' : ''}',
                                            staff: currentUserReference,
                                          ),
                                          ...mapToFirestore(
                                            {
                                              'date':
                                                  FieldValue.serverTimestamp(),
                                            },
                                          ),
                                        });
                                      } else {
                                        // update guest data history only

                                        await HistoryRecord.createDoc(
                                                widget.ref!)
                                            .set({
                                          ...createHistoryRecordData(
                                            description:
                                                'Something other than the price have been updated with this booking. Probably entered data of guest\'s ID or contact number.',
                                            staff: currentUserReference,
                                          ),
                                          ...mapToFirestore(
                                            {
                                              'date':
                                                  FieldValue.serverTimestamp(),
                                            },
                                          ),
                                        });
                                        // update details and contact

                                        await widget.bookingToExtend!.reference
                                            .update(createBookingsRecordData(
                                          details: _model
                                              .detailsFieldController.text,
                                          contact: _model
                                              .contactFieldController.text,
                                        ));
                                        // updated
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Updated guest details!',
                                              style: TextStyle(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                              ),
                                            ),
                                            duration:
                                                Duration(milliseconds: 4000),
                                            backgroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondary,
                                          ),
                                        );
                                        if (_shouldSetState) setState(() {});
                                        return;
                                      }

                                      while (_model.loopPendingTransactions !=
                                          widget.bookingToExtend?.pendings
                                              ?.length) {
                                        // pendingTrans
                                        _model.pendingTrans =
                                            await TransactionsRecord
                                                .getDocumentOnce(widget
                                                        .bookingToExtend!
                                                        .pendings[
                                                    _model
                                                        .loopPendingTransactions]);
                                        _shouldSetState = true;
                                        // pay balance of this transaction

                                        await widget
                                            .bookingToExtend!
                                            .pendings[
                                                _model.loopPendingTransactions]
                                            .update({
                                          ...createTransactionsRecordData(
                                            pending: false,
                                            description: _model
                                                        .pendingTrans!.total <
                                                    0.0
                                                ? _model
                                                    .pendingTrans?.description
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

                                        await widget.bookingToExtend!.reference
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
                                        setState(() {
                                          _model.loopPendingTransactions =
                                              _model.loopPendingTransactions +
                                                  1;
                                        });
                                      }
                                      // reset pending list
                                      setState(() {
                                        _model.pendings = [];
                                      });
                                      // paid booking status

                                      await widget.bookingToExtend!.reference
                                          .update({
                                        ...createBookingsRecordData(
                                          status: 'paid',
                                        ),
                                        ...mapToFirestore(
                                          {
                                            'pendings': _model.pendings,
                                          },
                                        ),
                                      });
                                    } else {
                                      // haven't paid balance
                                      var confirmDialogResponse =
                                          await showDialog<bool>(
                                                context: context,
                                                builder: (alertDialogContext) {
                                                  return AlertDialog(
                                                    title: Text(
                                                        'Did the guest not pay balance yet?'),
                                                    content: Text(
                                                        'Confirm to proceed even without paying the balance yet.'),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                alertDialogContext,
                                                                false),
                                                        child: Text('Cancel'),
                                                      ),
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                alertDialogContext,
                                                                true),
                                                        child: Text('Confirm'),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              ) ??
                                              false;
                                      if (confirmDialogResponse) {
                                        if (functions.getTotalAmount(
                                                _model.bedsValue!,
                                                _model.nightsValue!,
                                                _model.price,
                                                FFAppState().bedPrice,
                                                _model.startingBeds!,
                                                _model.startingNights!,
                                                FFAppState().extPricePerHr *
                                                    int.parse((_model
                                                        .hoursLateCheckoutValue!)))! >
                                            0.0) {
                                          // New Pending Transaction

                                          var transactionsRecordReference3 =
                                              TransactionsRecord.collection
                                                  .doc();
                                          await transactionsRecordReference3
                                              .set({
                                            ...createTransactionsRecordData(
                                              staff: currentUserReference,
                                              total: functions.getTotalAmount(
                                                  _model.bedsValue!,
                                                  _model.nightsValue!,
                                                  _model.price,
                                                  FFAppState().bedPrice,
                                                  _model.startingBeds!,
                                                  _model.startingNights!,
                                                  widget.extend
                                                      ? ((FFAppState()
                                                                  .extPricePerHr ??
                                                              0) *
                                                          double.parse(
                                                              valueOrDefault<
                                                                  String>(
                                                            _model
                                                                .hoursLateCheckoutValue,
                                                            '0',
                                                          )))
                                                      : 0.0),
                                              type: 'book',
                                              hotel: FFAppState().hotel,
                                              booking: widget
                                                  .bookingToExtend?.reference,
                                              guests: functions.stringToInt(
                                                  _model.guestsValue),
                                              room: widget.roomNo,
                                              description:
                                                  '${functions.quantityDescriptionForBookings(_model.startingBeds!, _model.bedsValue!, _model.startingNights, _model.nightsValue, widget.roomNo!, _model.hoursLateCheckoutValue!)}${_model.ability != 'normal' ? ' by a ${_model.ability}' : ''}',
                                              remitted: false,
                                              pending: true,
                                            ),
                                            ...mapToFirestore(
                                              {
                                                'date': FieldValue
                                                    .serverTimestamp(),
                                              },
                                            ),
                                          });
                                          _model.newExtPending =
                                              TransactionsRecord
                                                  .getDocumentFromData({
                                            ...createTransactionsRecordData(
                                              staff: currentUserReference,
                                              total: functions.getTotalAmount(
                                                  _model.bedsValue!,
                                                  _model.nightsValue!,
                                                  _model.price,
                                                  FFAppState().bedPrice,
                                                  _model.startingBeds!,
                                                  _model.startingNights!,
                                                  widget.extend
                                                      ? ((FFAppState()
                                                                  .extPricePerHr ??
                                                              0) *
                                                          double.parse(
                                                              valueOrDefault<
                                                                  String>(
                                                            _model
                                                                .hoursLateCheckoutValue,
                                                            '0',
                                                          )))
                                                      : 0.0),
                                              type: 'book',
                                              hotel: FFAppState().hotel,
                                              booking: widget
                                                  .bookingToExtend?.reference,
                                              guests: functions.stringToInt(
                                                  _model.guestsValue),
                                              room: widget.roomNo,
                                              description:
                                                  '${functions.quantityDescriptionForBookings(_model.startingBeds!, _model.bedsValue!, _model.startingNights, _model.nightsValue, widget.roomNo!, _model.hoursLateCheckoutValue!)}${_model.ability != 'normal' ? ' by a ${_model.ability}' : ''}',
                                              remitted: false,
                                              pending: true,
                                            ),
                                            ...mapToFirestore(
                                              {
                                                'date': DateTime.now(),
                                              },
                                            ),
                                          }, transactionsRecordReference3);
                                          _shouldSetState = true;
                                          // add to pendings list
                                          setState(() {
                                            _model.addToPendings(_model
                                                .newExtPending!.reference);
                                          });
                                          // add this change to history

                                          await HistoryRecord.createDoc(
                                                  widget.ref!)
                                              .set({
                                            ...createHistoryRecordData(
                                              description:
                                                  'Availed ${functions.quantityDescriptionForBookings(_model.startingBeds!, _model.bedsValue!, _model.startingNights, _model.nightsValue, widget.roomNo!, _model.hoursLateCheckoutValue!)}, but pending${_model.ability != 'normal' ? ' by a ${_model.ability}' : ''}',
                                              staff: currentUserReference,
                                              booking: widget
                                                  .bookingToExtend?.reference,
                                            ),
                                            ...mapToFirestore(
                                              {
                                                'date': FieldValue
                                                    .serverTimestamp(),
                                              },
                                            ),
                                          });
                                        } else {
                                          if (functions.getTotalAmount(
                                                  _model.bedsValue!,
                                                  _model.nightsValue!,
                                                  _model.price,
                                                  FFAppState().bedPrice,
                                                  _model.startingBeds!,
                                                  _model.startingNights!,
                                                  FFAppState().extPricePerHr *
                                                      int.parse((_model
                                                          .hoursLateCheckoutValue!)))! <
                                              0.0) {
                                            // New Pending Transaction

                                            var transactionsRecordReference4 =
                                                TransactionsRecord.collection
                                                    .doc();
                                            await transactionsRecordReference4
                                                .set({
                                              ...createTransactionsRecordData(
                                                staff: currentUserReference,
                                                total: functions.getTotalAmount(
                                                    _model.bedsValue!,
                                                    _model.nightsValue!,
                                                    _model.price,
                                                    FFAppState().bedPrice,
                                                    _model.startingBeds!,
                                                    _model.startingNights!,
                                                    widget.extend
                                                        ? ((FFAppState()
                                                                    .extPricePerHr ??
                                                                0) *
                                                            double.parse(
                                                                valueOrDefault<
                                                                    String>(
                                                              _model
                                                                  .hoursLateCheckoutValue,
                                                              '0',
                                                            )))
                                                        : 0.0),
                                                type: 'book',
                                                hotel: FFAppState().hotel,
                                                booking: widget
                                                    .bookingToExtend?.reference,
                                                guests: functions.stringToInt(
                                                    _model.guestsValue),
                                                room: widget.roomNo,
                                                description:
                                                    '${functions.quantityDescriptionForBookings(_model.startingBeds!, _model.bedsValue!, _model.startingNights, _model.nightsValue, widget.roomNo!, '0')}${_model.ability != 'normal' ? ' by a ${_model.ability}' : ''}',
                                                remitted: false,
                                                pending: true,
                                              ),
                                              ...mapToFirestore(
                                                {
                                                  'date': FieldValue
                                                      .serverTimestamp(),
                                                },
                                              ),
                                            });
                                            _model.newRefundPending =
                                                TransactionsRecord
                                                    .getDocumentFromData({
                                              ...createTransactionsRecordData(
                                                staff: currentUserReference,
                                                total: functions.getTotalAmount(
                                                    _model.bedsValue!,
                                                    _model.nightsValue!,
                                                    _model.price,
                                                    FFAppState().bedPrice,
                                                    _model.startingBeds!,
                                                    _model.startingNights!,
                                                    widget.extend
                                                        ? ((FFAppState()
                                                                    .extPricePerHr ??
                                                                0) *
                                                            double.parse(
                                                                valueOrDefault<
                                                                    String>(
                                                              _model
                                                                  .hoursLateCheckoutValue,
                                                              '0',
                                                            )))
                                                        : 0.0),
                                                type: 'book',
                                                hotel: FFAppState().hotel,
                                                booking: widget
                                                    .bookingToExtend?.reference,
                                                guests: functions.stringToInt(
                                                    _model.guestsValue),
                                                room: widget.roomNo,
                                                description:
                                                    '${functions.quantityDescriptionForBookings(_model.startingBeds!, _model.bedsValue!, _model.startingNights, _model.nightsValue, widget.roomNo!, '0')}${_model.ability != 'normal' ? ' by a ${_model.ability}' : ''}',
                                                remitted: false,
                                                pending: true,
                                              ),
                                              ...mapToFirestore(
                                                {
                                                  'date': DateTime.now(),
                                                },
                                              ),
                                            }, transactionsRecordReference4);
                                            _shouldSetState = true;
                                            // add to pendings list
                                            setState(() {
                                              _model.addToPendings(_model
                                                  .newRefundPending!.reference);
                                            });
                                            // add this change to history

                                            await HistoryRecord.createDoc(
                                                    widget.ref!)
                                                .set({
                                              ...createHistoryRecordData(
                                                description:
                                                    'Guest requested ${functions.quantityDescriptionForBookings(_model.startingBeds!, _model.bedsValue!, _model.startingNights, _model.nightsValue, widget.roomNo!, _model.hoursLateCheckoutValue!)}, but pending${_model.ability != 'normal' ? ' by a ${_model.ability}' : ''}',
                                                staff: currentUserReference,
                                                booking: widget
                                                    .bookingToExtend?.reference,
                                              ),
                                              ...mapToFirestore(
                                                {
                                                  'date': FieldValue
                                                      .serverTimestamp(),
                                                },
                                              ),
                                            });
                                          } else {
                                            // nothing changed
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'Nothing Changed!',
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
                                            if (_shouldSetState)
                                              setState(() {});
                                            return;
                                          }
                                        }
                                      } else {
                                        if (_shouldSetState) setState(() {});
                                        return;
                                      }
                                    }

                                    // update booking

                                    await widget.bookingToExtend!.reference
                                        .update({
                                      ...createBookingsRecordData(
                                        nights: _model.nightsValue,
                                        total: valueOrDefault<double>(
                                          functions.getTotalAmount(
                                              _model.bedsValue!,
                                              _model.nightsValue!,
                                              _model.price,
                                              FFAppState().bedPrice,
                                              '-1',
                                              0,
                                              FFAppState().extPricePerHr *
                                                  int.parse((_model
                                                      .hoursLateCheckoutValue!))),
                                          0.0,
                                        ),
                                        extraBeds: _model.bedsValue,
                                        status: functions
                                            .paidOrPending(_model.paid),
                                        details:
                                            _model.detailsFieldController.text,
                                        contact:
                                            _model.contactFieldController.text,
                                        staff: currentUserReference,
                                        guests: _model.guestsValue,
                                        room: widget.ref,
                                      ),
                                      ...mapToFirestore(
                                        {
                                          'pendings': _model.pendings,
                                          'transactions': _model.transactions,
                                        },
                                      ),
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Updated Booking!',
                                          style: TextStyle(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                          ),
                                        ),
                                        duration: Duration(milliseconds: 4000),
                                        backgroundColor:
                                            FlutterFlowTheme.of(context)
                                                .secondary,
                                      ),
                                    );
                                  } else {
                                    // Save Booking to Firestore

                                    var bookingsRecordReference =
                                        BookingsRecord.collection.doc();
                                    await bookingsRecordReference.set({
                                      ...createBookingsRecordData(
                                        nights: _model.nightsValue,
                                        details:
                                            _model.detailsFieldController.text,
                                        contact:
                                            _model.contactFieldController.text,
                                        hotel: FFAppState().hotel,
                                        room: widget.ref,
                                        extraBeds: _model.bedsValue,
                                        guests: _model.guestsValue,
                                        total: valueOrDefault<double>(
                                          functions.getTotalAmount(
                                              _model.bedsValue!,
                                              _model.nightsValue!,
                                              _model.price,
                                              FFAppState().bedPrice,
                                              '-1',
                                              0,
                                              0.0),
                                          0.0,
                                        ),
                                        status: functions
                                            .paidOrPending(_model.paid),
                                        staff: currentUserReference,
                                        ability: _model.ability,
                                        promo: widget.promoOn
                                            ? widget.promoDetail
                                            : 'No Promo',
                                      ),
                                      ...mapToFirestore(
                                        {
                                          'dateIn':
                                              FieldValue.serverTimestamp(),
                                          'pendings': _model.pendings,
                                          'transactions': _model.transactions,
                                        },
                                      ),
                                    });
                                    _model.savedBooking =
                                        BookingsRecord.getDocumentFromData({
                                      ...createBookingsRecordData(
                                        nights: _model.nightsValue,
                                        details:
                                            _model.detailsFieldController.text,
                                        contact:
                                            _model.contactFieldController.text,
                                        hotel: FFAppState().hotel,
                                        room: widget.ref,
                                        extraBeds: _model.bedsValue,
                                        guests: _model.guestsValue,
                                        total: valueOrDefault<double>(
                                          functions.getTotalAmount(
                                              _model.bedsValue!,
                                              _model.nightsValue!,
                                              _model.price,
                                              FFAppState().bedPrice,
                                              '-1',
                                              0,
                                              0.0),
                                          0.0,
                                        ),
                                        status: functions
                                            .paidOrPending(_model.paid),
                                        staff: currentUserReference,
                                        ability: _model.ability,
                                        promo: widget.promoOn
                                            ? widget.promoDetail
                                            : 'No Promo',
                                      ),
                                      ...mapToFirestore(
                                        {
                                          'dateIn': DateTime.now(),
                                          'pendings': _model.pendings,
                                          'transactions': _model.transactions,
                                        },
                                      ),
                                    }, bookingsRecordReference);
                                    _shouldSetState = true;
                                    if (_model.paid) {
                                      // New Transaction

                                      var transactionsRecordReference5 =
                                          TransactionsRecord.collection.doc();
                                      await transactionsRecordReference5.set({
                                        ...createTransactionsRecordData(
                                          staff: currentUserReference,
                                          total: functions.getTotalAmount(
                                              _model.bedsValue!,
                                              _model.nightsValue!,
                                              _model.price,
                                              FFAppState().bedPrice,
                                              _model.startingBeds!,
                                              _model.startingNights!,
                                              0.0),
                                          type: 'book',
                                          hotel: FFAppState().hotel,
                                          booking:
                                              _model.savedBooking?.reference,
                                          guests: functions
                                              .stringToInt(_model.guestsValue),
                                          room: widget.roomNo,
                                          description:
                                              'New checkin in room ${widget.roomNo?.toString()}${_model.ability != 'normal' ? ' by a ${_model.ability}' : ''} for ${_model.nightsValue?.toString()} ${_model.nightsValue! > 1 ? 'nights' : 'night'}${_model.bedsValue != '0' ? ' with ${_model.bedsValue} extra bed${functions.stringToInt(_model.bedsValue)! > 1 ? 's' : ''}' : ''}',
                                          remitted: false,
                                          pending: false,
                                        ),
                                        ...mapToFirestore(
                                          {
                                            'date':
                                                FieldValue.serverTimestamp(),
                                          },
                                        ),
                                      });
                                      _model.checkin1 = TransactionsRecord
                                          .getDocumentFromData({
                                        ...createTransactionsRecordData(
                                          staff: currentUserReference,
                                          total: functions.getTotalAmount(
                                              _model.bedsValue!,
                                              _model.nightsValue!,
                                              _model.price,
                                              FFAppState().bedPrice,
                                              _model.startingBeds!,
                                              _model.startingNights!,
                                              0.0),
                                          type: 'book',
                                          hotel: FFAppState().hotel,
                                          booking:
                                              _model.savedBooking?.reference,
                                          guests: functions
                                              .stringToInt(_model.guestsValue),
                                          room: widget.roomNo,
                                          description:
                                              'New checkin in room ${widget.roomNo?.toString()}${_model.ability != 'normal' ? ' by a ${_model.ability}' : ''} for ${_model.nightsValue?.toString()} ${_model.nightsValue! > 1 ? 'nights' : 'night'}${_model.bedsValue != '0' ? ' with ${_model.bedsValue} extra bed${functions.stringToInt(_model.bedsValue)! > 1 ? 's' : ''}' : ''}',
                                          remitted: false,
                                          pending: false,
                                        ),
                                        ...mapToFirestore(
                                          {
                                            'date': DateTime.now(),
                                          },
                                        ),
                                      }, transactionsRecordReference5);
                                      _shouldSetState = true;
                                      // add to trans list
                                      setState(() {
                                        _model.addToTransactions(
                                            _model.checkin1!.reference);
                                      });
                                      // Check In To History

                                      await HistoryRecord.createDoc(widget.ref!)
                                          .set({
                                        ...createHistoryRecordData(
                                          description:
                                              '${_model.guestsValue} new${_model.ability != 'normal' ? ' ${_model.ability}' : ''} guest${functions.stringToInt(_model.guestsValue)! > 1 ? 's' : ''}${_model.bedsValue != '0' ? ' with ${_model.bedsValue} extra bed${functions.stringToInt(_model.bedsValue)! > 1 ? 's' : ''}' : ''} have checked in!',
                                          staff: currentUserReference,
                                          booking:
                                              _model.savedBooking?.reference,
                                        ),
                                        ...mapToFirestore(
                                          {
                                            'date':
                                                FieldValue.serverTimestamp(),
                                          },
                                        ),
                                      });
                                    } else {
                                      // New Pending Transaction

                                      var transactionsRecordReference6 =
                                          TransactionsRecord.collection.doc();
                                      await transactionsRecordReference6.set({
                                        ...createTransactionsRecordData(
                                          staff: currentUserReference,
                                          total: functions.getTotalAmount(
                                              _model.bedsValue!,
                                              _model.nightsValue!,
                                              _model.price,
                                              FFAppState().bedPrice,
                                              _model.startingBeds!,
                                              _model.startingNights!,
                                              0.0),
                                          type: 'book',
                                          hotel: FFAppState().hotel,
                                          booking:
                                              _model.savedBooking?.reference,
                                          guests: functions
                                              .stringToInt(_model.guestsValue),
                                          room: widget.roomNo,
                                          description:
                                              'room ${widget.roomNo?.toString()} check in for ${_model.nightsValue?.toString()} ${_model.nightsValue! > 1 ? 'nights' : 'night'}${_model.ability != 'normal' ? ' by a ${_model.ability}' : ''}${_model.bedsValue != '0' ? ' with ${_model.bedsValue} extra bed${functions.stringToInt(_model.bedsValue)! > 1 ? 's' : ''}' : ''}',
                                          remitted: false,
                                          pending: true,
                                        ),
                                        ...mapToFirestore(
                                          {
                                            'date':
                                                FieldValue.serverTimestamp(),
                                          },
                                        ),
                                      });
                                      _model.newPending = TransactionsRecord
                                          .getDocumentFromData({
                                        ...createTransactionsRecordData(
                                          staff: currentUserReference,
                                          total: functions.getTotalAmount(
                                              _model.bedsValue!,
                                              _model.nightsValue!,
                                              _model.price,
                                              FFAppState().bedPrice,
                                              _model.startingBeds!,
                                              _model.startingNights!,
                                              0.0),
                                          type: 'book',
                                          hotel: FFAppState().hotel,
                                          booking:
                                              _model.savedBooking?.reference,
                                          guests: functions
                                              .stringToInt(_model.guestsValue),
                                          room: widget.roomNo,
                                          description:
                                              'room ${widget.roomNo?.toString()} check in for ${_model.nightsValue?.toString()} ${_model.nightsValue! > 1 ? 'nights' : 'night'}${_model.ability != 'normal' ? ' by a ${_model.ability}' : ''}${_model.bedsValue != '0' ? ' with ${_model.bedsValue} extra bed${functions.stringToInt(_model.bedsValue)! > 1 ? 's' : ''}' : ''}',
                                          remitted: false,
                                          pending: true,
                                        ),
                                        ...mapToFirestore(
                                          {
                                            'date': DateTime.now(),
                                          },
                                        ),
                                      }, transactionsRecordReference6);
                                      _shouldSetState = true;
                                      // add to pendings list

                                      await _model.savedBooking!.reference
                                          .update({
                                        ...mapToFirestore(
                                          {
                                            'pendings': FieldValue.arrayUnion(
                                                [_model.newPending?.reference]),
                                          },
                                        ),
                                      });
                                      // add this change to history

                                      await HistoryRecord.createDoc(widget.ref!)
                                          .set({
                                        ...createHistoryRecordData(
                                          description:
                                              'New check in ${_model.ability != 'normal' ? 'by a ${_model.ability}' : ''}${_model.bedsValue != '0' ? ' with ${_model.bedsValue} extra bed${functions.stringToInt(_model.bedsValue)! > 1 ? 's' : ''} ' : ''}but pending payment.',
                                          staff: currentUserReference,
                                          booking:
                                              _model.savedBooking?.reference,
                                        ),
                                        ...mapToFirestore(
                                          {
                                            'date':
                                                FieldValue.serverTimestamp(),
                                          },
                                        ),
                                      });
                                    }

                                    // new guest
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'A new guest has checked in!',
                                          style: TextStyle(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                          ),
                                        ),
                                        duration: Duration(milliseconds: 4000),
                                        backgroundColor:
                                            FlutterFlowTheme.of(context)
                                                .secondary,
                                      ),
                                    );
                                    // Update room display details

                                    await widget.ref!
                                        .update(createRoomsRecordData(
                                      vacant: false,
                                      guests: valueOrDefault<int>(
                                        functions
                                            .stringToInt(_model.guestsValue),
                                        1,
                                      ),
                                      currentBooking:
                                          _model.savedBooking?.reference,
                                    ));
                                  }

                                  context.safePop();
                                  if (_shouldSetState) setState(() {});
                                },
                                text:
                                    widget.extend == true ? 'Save' : 'Check In',
                                options: FFButtonOptions(
                                  width: 130.0,
                                  height: 50.0,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color: FlutterFlowTheme.of(context).primary,
                                  textStyle:
                                      FlutterFlowTheme.of(context).titleSmall,
                                  elevation: 3.0,
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ).animateOnPageLoad(
                          animationsMap['containerOnPageLoadAnimation']!),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
