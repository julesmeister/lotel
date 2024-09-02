import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_autocomplete_options_list.dart';
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
import 'package:provider/provider.dart';
import 'check_out_model.dart';
export 'check_out_model.dart';

class CheckOutWidget extends StatefulWidget {
  const CheckOutWidget({
    super.key,
    required this.cart,
  });

  final List<GoodsRecord>? cart;

  @override
  State<CheckOutWidget> createState() => _CheckOutWidgetState();
}

class _CheckOutWidgetState extends State<CheckOutWidget>
    with TickerProviderStateMixin {
  late CheckOutModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CheckOutModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.loopCounter = 0;
      _model.loopGoodsCounter = 0;
      setState(() {});
    });

    _model.priceTextController1 ??= TextEditingController();

    _model.priceTextController2 ??= TextEditingController();
    _model.priceFocusNode2 ??= FocusNode();

    animationsMap.addAll({
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
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
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
              context.safePop();
            },
          ),
          title: Text(
            'Check Out',
            style: FlutterFlowTheme.of(context).bodyLarge.override(
                  fontFamily: 'Readex Pro',
                  fontSize: 24.0,
                  letterSpacing: 0.0,
                ),
          ),
          actions: [
            Visibility(
              visible:
                  valueOrDefault(currentUserDocument?.role, '') != 'generic',
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 16.0, 0.0),
                child: AuthUserStreamWidget(
                  builder: (context) => FlutterFlowIconButton(
                    borderColor: FlutterFlowTheme.of(context).primaryBackground,
                    borderRadius: 20.0,
                    borderWidth: 1.0,
                    buttonSize: 60.0,
                    fillColor: FlutterFlowTheme.of(context).primaryBackground,
                    disabledIconColor: const Color(0xFFDADBDC),
                    icon: Icon(
                      Icons.check,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 24.0,
                    ),
                    onPressed: (widget.cart?.length == 0)
                        ? null
                        : () async {
                            var shouldSetState = false;
                            if (_model.expense) {
                              if ((_model.whichExpense == 'consumedBy') &&
                                  (_model.priceTextController1.text == '')) {
                                // who consumed?
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Who consumed?',
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
                                if (shouldSetState) setState(() {});
                                return;
                              }
                            }
                            if (_model.pending) {
                              if (_model.choiceChipsValue != null &&
                                  _model.choiceChipsValue != '') {
                                // room
                                _model.room = await queryRoomsRecordOnce(
                                  queryBuilder: (roomsRecord) => roomsRecord
                                      .where(
                                        'number',
                                        isEqualTo: int.parse(
                                            (_model.choiceChipsValue!)),
                                      )
                                      .where(
                                        'hotel',
                                        isEqualTo: FFAppState().hotel,
                                      ),
                                  singleRecord: true,
                                ).then((s) => s.firstOrNull);
                                shouldSetState = true;
                                // booking
                                _model.booking = _model.room?.currentBooking;
                                setState(() {});
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'A room must be selected!',
                                      style: TextStyle(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                      ),
                                    ),
                                    duration: const Duration(milliseconds: 4000),
                                    backgroundColor:
                                        FlutterFlowTheme.of(context).error,
                                  ),
                                );
                                if (shouldSetState) setState(() {});
                                return;
                              }
                            }
                            // loading
                            _model.isLoading = true;
                            setState(() {});
                            while (_model.loopCounter !=
                                valueOrDefault<int>(
                                  widget.cart?.length,
                                  0,
                                )) {
                              // Subtract Quantity of Item

                              await widget.cart![_model.loopCounter].reference
                                  .update({
                                ...mapToFirestore(
                                  {
                                    'quantity': FieldValue.increment(-(1)),
                                  },
                                ),
                              });
                              // incrementLoopCounter
                              _model.loopCounter = _model.loopCounter + 1;
                            }
                            // New Transaction

                            var transactionsRecordReference =
                                TransactionsRecord.collection.doc();
                            await transactionsRecordReference.set({
                              ...createTransactionsRecordData(
                                staff: currentUserReference,
                                total: _model.expense
                                    ? ((functions
                                        .totalOfCart(widget.cart?.toList())!))
                                    : functions
                                        .totalOfCart(widget.cart?.toList()),
                                hotel: FFAppState().hotel,
                                type: _model.expense ? 'expense' : 'goods',
                                remitted: false,
                                description: _model.expense
                                    ? valueOrDefault<String>(
                                        functions.descriptionOfExpense(
                                            _model.whichExpense,
                                            _model.priceTextController1.text,
                                            _model.priceTextController2.text),
                                        'deducted for some reason',
                                      )
                                    : 'sold',
                                pending: _model.pending,
                                booking: _model.pending ? _model.booking : null,
                                room: _model.pending
                                    ? (int.parse((_model.choiceChipsValue!)))
                                    : null,
                              ),
                              ...mapToFirestore(
                                {
                                  'date': FieldValue.serverTimestamp(),
                                  'goods': getCartGoodsListFirestoreData(
                                    functions
                                        .summarizeCart(widget.cart?.toList()),
                                  ),
                                },
                              ),
                            });
                            _model.newTransaction =
                                TransactionsRecord.getDocumentFromData({
                              ...createTransactionsRecordData(
                                staff: currentUserReference,
                                total: _model.expense
                                    ? ((functions
                                        .totalOfCart(widget.cart?.toList())!))
                                    : functions
                                        .totalOfCart(widget.cart?.toList()),
                                hotel: FFAppState().hotel,
                                type: _model.expense ? 'expense' : 'goods',
                                remitted: false,
                                description: _model.expense
                                    ? valueOrDefault<String>(
                                        functions.descriptionOfExpense(
                                            _model.whichExpense,
                                            _model.priceTextController1.text,
                                            _model.priceTextController2.text),
                                        'deducted for some reason',
                                      )
                                    : 'sold',
                                pending: _model.pending,
                                booking: _model.pending ? _model.booking : null,
                                room: _model.pending
                                    ? (int.parse((_model.choiceChipsValue!)))
                                    : null,
                              ),
                              ...mapToFirestore(
                                {
                                  'date': DateTime.now(),
                                  'goods': getCartGoodsListFirestoreData(
                                    functions
                                        .summarizeCart(widget.cart?.toList()),
                                  ),
                                },
                              ),
                            }, transactionsRecordReference);
                            shouldSetState = true;
                            while (_model.loopGoodsCounter !=
                                functions
                                    .summarizeCart(widget.cart?.toList())
                                    ?.length) {
                              // create inventory

                              var inventoriesRecordReference =
                                  InventoriesRecord.collection.doc();
                              await inventoriesRecordReference
                                  .set(createInventoriesRecordData(
                                date: functions.today(),
                                activity: _model.expense
                                    ? valueOrDefault<String>(
                                        functions.descriptionOfExpense(
                                            _model.whichExpense,
                                            _model.priceTextController1.text,
                                            _model.priceTextController2.text),
                                        'deducted for some reason',
                                      )
                                    : 'sold',
                                hotel: FFAppState().hotel,
                                staff: currentUserReference,
                                quantityChange: (functions.summarizeCart(widget
                                        .cart
                                        ?.toList())?[_model.loopGoodsCounter])
                                    ?.quantity,
                                previousQuantity: (functions.summarizeCart(
                                            widget.cart?.toList())?[
                                        _model.loopGoodsCounter])
                                    ?.previousQuantity,
                                item: (functions.summarizeCart(widget.cart
                                        ?.toList())?[_model.loopGoodsCounter])
                                    ?.description,
                                operator: 'minus',
                                previousPrice: (functions.summarizeCart(widget
                                        .cart
                                        ?.toList())?[_model.loopGoodsCounter])
                                    ?.price,
                                priceChange: (functions.summarizeCart(widget
                                        .cart
                                        ?.toList())?[_model.loopGoodsCounter])
                                    ?.price,
                                remitted: false,
                              ));
                              _model.newInventory =
                                  InventoriesRecord.getDocumentFromData(
                                      createInventoriesRecordData(
                                        date: functions.today(),
                                        activity: _model.expense
                                            ? valueOrDefault<String>(
                                                functions.descriptionOfExpense(
                                                    _model.whichExpense,
                                                    _model.priceTextController1
                                                        .text,
                                                    _model.priceTextController2
                                                        .text),
                                                'deducted for some reason',
                                              )
                                            : 'sold',
                                        hotel: FFAppState().hotel,
                                        staff: currentUserReference,
                                        quantityChange: (functions
                                                    .summarizeCart(widget.cart
                                                        ?.toList())?[
                                                _model.loopGoodsCounter])
                                            ?.quantity,
                                        previousQuantity: (functions
                                                    .summarizeCart(widget.cart
                                                        ?.toList())?[
                                                _model.loopGoodsCounter])
                                            ?.previousQuantity,
                                        item: (functions.summarizeCart(
                                                    widget.cart?.toList())?[
                                                _model.loopGoodsCounter])
                                            ?.description,
                                        operator: 'minus',
                                        previousPrice: (functions.summarizeCart(
                                                    widget.cart?.toList())?[
                                                _model.loopGoodsCounter])
                                            ?.price,
                                        priceChange: (functions.summarizeCart(
                                                    widget.cart?.toList())?[
                                                _model.loopGoodsCounter])
                                            ?.price,
                                        remitted: false,
                                      ),
                                      inventoriesRecordReference);
                              shouldSetState = true;
                              // collect inventories to list
                              _model.addToInventories(
                                  _model.newInventory!.reference);
                              setState(() {});
                              // Increment loopGoodsCounter
                              _model.loopGoodsCounter =
                                  _model.loopGoodsCounter + 1;
                              setState(() {});
                            }
                            // add inventories to transaction

                            await _model.newTransaction!.reference.update({
                              ...mapToFirestore(
                                {
                                  'inventories': _model.inventories,
                                },
                              ),
                            });
                            if ((_model.choiceChipsValue != null &&
                                    _model.choiceChipsValue != '') &&
                                _model.pending) {
                              // add transaction to pending

                              await _model.booking!.update({
                                ...mapToFirestore(
                                  {
                                    'pendings': FieldValue.arrayUnion(
                                        [_model.newTransaction?.reference]),
                                  },
                                ),
                              });
                            }
                            // finish loading
                            _model.isLoading = false;
                            setState(() {});
                            if (Navigator.of(context).canPop()) {
                              context.pop();
                            }
                            context.pushNamed(
                              'mart',
                              extra: <String, dynamic>{
                                kTransitionInfoKey: const TransitionInfo(
                                  hasTransition: true,
                                  transitionType:
                                      PageTransitionType.rightToLeft,
                                ),
                              },
                            );

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Transaction Successful!',
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
                            if (shouldSetState) setState(() {});
                          },
                  ),
                ),
              ),
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
                      const EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 0.0, 12.0),
                  child: Text(
                    'Items',
                    style: FlutterFlowTheme.of(context).labelMedium.override(
                          fontFamily: 'Readex Pro',
                          letterSpacing: 0.0,
                        ),
                  ),
                ),
                Stack(
                  children: [
                    if (!_model.isLoading)
                      Builder(
                        builder: (context) {
                          final cartGoods = functions
                                  .summarizeCart(widget.cart?.toList())
                                  ?.toList() ??
                              [];

                          return ListView.builder(
                            padding: EdgeInsets.zero,
                            primary: false,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: cartGoods.length,
                            itemBuilder: (context, cartGoodsIndex) {
                              final cartGoodsItem = cartGoods[cartGoodsIndex];
                              return Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 1.0),
                                child: Container(
                                  width: double.infinity,
                                  height: 60.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    boxShadow: [
                                      BoxShadow(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        offset: const Offset(
                                          0.0,
                                          1.0,
                                        ),
                                      )
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        16.0, 5.0, 16.0, 5.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              cartGoodsItem.description,
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyLarge
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        letterSpacing: 0.0,
                                                      ),
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 5.0, 0.0, 0.0),
                                                  child: Text(
                                                    'x ',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .labelMedium
                                                        .override(
                                                          fontFamily:
                                                              'Readex Pro',
                                                          letterSpacing: 0.0,
                                                        ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 5.0, 0.0, 0.0),
                                                  child: Text(
                                                    cartGoodsItem.quantity
                                                        .toString(),
                                                    style: FlutterFlowTheme.of(
                                                            context)
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
                                          ],
                                        ),
                                        Text(
                                          formatNumber(
                                            cartGoodsItem.price,
                                            formatType: FormatType.decimal,
                                            decimalType: DecimalType.automatic,
                                            currency: 'P ',
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .titleLarge
                                              .override(
                                                fontFamily: 'Outfit',
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    if (_model.isLoading)
                      Container(
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).info,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  16.0, 20.0, 16.0, 0.0),
                              child: Text(
                                'Please don\'t touch anything while transaction is being completed.',
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      fontSize: 24.0,
                                      letterSpacing: 0.0,
                                    ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(0.0, -2.13),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.asset(
                                  'assets/images/giphy.gif',
                                  width: double.infinity,
                                  height: 159.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ).animateOnPageLoad(
                          animationsMap['containerOnPageLoadAnimation']!),
                  ],
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 0.0, 0.0),
                  child: Text(
                    'Total',
                    style: FlutterFlowTheme.of(context).labelMedium.override(
                          fontFamily: 'Readex Pro',
                          letterSpacing: 0.0,
                        ),
                  ),
                ),
                ListView(
                  padding: EdgeInsets.zero,
                  primary: false,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 1.0),
                      child: Container(
                        width: double.infinity,
                        height: 60.0,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          boxShadow: [
                            BoxShadow(
                              color: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              offset: const Offset(
                                0.0,
                                1.0,
                              ),
                            )
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              16.0, 5.0, 16.0, 5.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Total Amount',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        0.0, 5.0, 0.0, 0.0),
                                    child: Text(
                                      valueOrDefault<int>(
                                                widget.cart?.length,
                                                0,
                                              ) >
                                              0
                                          ? (valueOrDefault<int>(
                                                    widget.cart?.length,
                                                    0,
                                                  ) ==
                                                  1
                                              ? '1 item in the basket'
                                              : '${valueOrDefault<String>(
                                                  widget.cart?.length
                                                      .toString(),
                                                  '0',
                                                )} items in the basket')
                                          : 'No items in the basket',
                                      style: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            fontFamily: 'Readex Pro',
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                valueOrDefault<String>(
                                  formatNumber(
                                    functions
                                        .totalOfCart(widget.cart?.toList()),
                                    formatType: FormatType.decimal,
                                    decimalType: DecimalType.automatic,
                                    currency: 'P ',
                                  ),
                                  '0',
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .titleLarge
                                    .override(
                                      fontFamily: 'Outfit',
                                      letterSpacing: 0.0,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 1.0),
                      child: Container(
                        width: double.infinity,
                        height: 60.0,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          boxShadow: [
                            BoxShadow(
                              color: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              offset: const Offset(
                                0.0,
                                1.0,
                              ),
                            )
                          ],
                        ),
                        child: Align(
                          alignment: const AlignmentDirectional(0.0, -1.0),
                          child: SwitchListTile.adaptive(
                            value: _model.switchListTileValue1 ??=
                                _model.pending,
                            onChanged: (newValue) async {
                              setState(() =>
                                  _model.switchListTileValue1 = newValue);
                              if (newValue) {
                                _model.pending = true;
                                setState(() {});
                              } else {
                                _model.pending = false;
                                setState(() {});
                              }
                            },
                            title: Text(
                              'Pending',
                              style: FlutterFlowTheme.of(context)
                                  .bodyLarge
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    letterSpacing: 0.0,
                                  ),
                            ),
                            subtitle: Text(
                              'Has the guest not paid yet?',
                              style: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    letterSpacing: 0.0,
                                  ),
                            ),
                            tileColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            activeColor: FlutterFlowTheme.of(context).primary,
                            activeTrackColor:
                                FlutterFlowTheme.of(context).accent1,
                            dense: true,
                            controlAffinity: ListTileControlAffinity.trailing,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 1.0),
                      child: Container(
                        width: double.infinity,
                        height: 60.0,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          boxShadow: [
                            BoxShadow(
                              color: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              offset: const Offset(
                                0.0,
                                1.0,
                              ),
                            )
                          ],
                        ),
                        child: Align(
                          alignment: const AlignmentDirectional(0.0, -1.0),
                          child: SwitchListTile.adaptive(
                            value: _model.switchListTileValue2 ??=
                                _model.expense,
                            onChanged: (newValue) async {
                              setState(() =>
                                  _model.switchListTileValue2 = newValue);
                              if (newValue) {
                                _model.expense = true;
                                setState(() {});
                              } else {
                                _model.expense = false;
                                setState(() {});
                              }
                            },
                            title: Text(
                              'Expense',
                              style: FlutterFlowTheme.of(context)
                                  .bodyLarge
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    letterSpacing: 0.0,
                                  ),
                            ),
                            subtitle: Text(
                              'Is this an expense?',
                              style: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    letterSpacing: 0.0,
                                  ),
                            ),
                            tileColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            activeColor: FlutterFlowTheme.of(context).primary,
                            activeTrackColor:
                                FlutterFlowTheme.of(context).accent1,
                            dense: true,
                            controlAffinity: ListTileControlAffinity.trailing,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                if (_model.expense)
                  Align(
                    alignment: const AlignmentDirectional(0.0, -1.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 600),
                        curve: Curves.easeIn,
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
                              Expanded(
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    _model.whichExpense = 'consumedBy';
                                    setState(() {});
                                  },
                                  child: Container(
                                    width: 145.0,
                                    height: 100.0,
                                    decoration: BoxDecoration(
                                      color: _model.whichExpense == 'consumedBy'
                                          ? FlutterFlowTheme.of(context)
                                              .secondaryBackground
                                          : FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                      borderRadius: BorderRadius.circular(10.0),
                                      border: Border.all(
                                        color: valueOrDefault<Color>(
                                          _model.whichExpense == 'consumedBy'
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
                                          Icons.emoji_people_rounded,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          size: 16.0,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  4.0, 0.0, 0.0, 0.0),
                                          child: Text(
                                            'Consumed By',
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
                              InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  _model.whichExpense = 'spoilage';
                                  setState(() {});
                                },
                                child: Container(
                                  width: 115.0,
                                  height: 100.0,
                                  decoration: BoxDecoration(
                                    color: _model.whichExpense == 'spoilage'
                                        ? FlutterFlowTheme.of(context)
                                            .secondaryBackground
                                        : FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(
                                      color: _model.whichExpense == 'spoilage'
                                          ? FlutterFlowTheme.of(context)
                                              .alternate
                                          : FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                      width: 1.0,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.no_food_outlined,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        size: 16.0,
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            4.0, 0.0, 0.0, 0.0),
                                        child: Text(
                                          'Spoilage',
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
                              InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  _model.whichExpense = 'other';
                                  setState(() {});
                                },
                                child: Container(
                                  width: 80.0,
                                  height: 100.0,
                                  decoration: BoxDecoration(
                                    color: _model.whichExpense == 'other'
                                        ? FlutterFlowTheme.of(context)
                                            .secondaryBackground
                                        : FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(
                                      color: _model.whichExpense == 'other'
                                          ? FlutterFlowTheme.of(context)
                                              .alternate
                                          : FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                      width: 1.0,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.question_mark,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        size: 16.0,
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            4.0, 0.0, 0.0, 0.0),
                                        child: Text(
                                          'Other',
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
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                if ((_model.whichExpense == 'consumedBy') && _model.expense)
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 16.0),
                    child: Autocomplete<String>(
                      initialValue: const TextEditingValue(),
                      optionsBuilder: (textEditingValue) {
                        if (textEditingValue.text == '') {
                          return const Iterable<String>.empty();
                        }
                        return ['Dodong', 'Niko', 'Guard'].where((option) {
                          final lowercaseOption = option.toLowerCase();
                          return lowercaseOption
                              .contains(textEditingValue.text.toLowerCase());
                        });
                      },
                      optionsViewBuilder: (context, onSelected, options) {
                        return AutocompleteOptionsList(
                          textFieldKey: _model.priceKey1,
                          textController: _model.priceTextController1!,
                          options: options.toList(),
                          onSelected: onSelected,
                          textStyle:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Readex Pro',
                                    letterSpacing: 0.0,
                                  ),
                          textHighlightStyle: const TextStyle(),
                          elevation: 4.0,
                          optionBackgroundColor:
                              FlutterFlowTheme.of(context).primaryBackground,
                          optionHighlightColor:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          maxHeight: 200.0,
                        );
                      },
                      onSelected: (String selection) {
                        setState(() => _model.priceSelectedOption1 = selection);
                        FocusScope.of(context).unfocus();
                      },
                      fieldViewBuilder: (
                        context,
                        textEditingController,
                        focusNode,
                        onEditingComplete,
                      ) {
                        _model.priceFocusNode1 = focusNode;

                        _model.priceTextController1 = textEditingController;
                        return TextFormField(
                          key: _model.priceKey1,
                          controller: textEditingController,
                          focusNode: focusNode,
                          onEditingComplete: onEditingComplete,
                          textCapitalization: TextCapitalization.words,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Who consumed?',
                            labelStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  letterSpacing: 0.0,
                                ),
                            hintStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  letterSpacing: 0.0,
                                ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).alternate,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primary,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            filled: true,
                            fillColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            contentPadding: const EdgeInsetsDirectional.fromSTEB(
                                20.0, 24.0, 0.0, 24.0),
                            prefixIcon: const Icon(
                              Icons.emoji_people_sharp,
                            ),
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Readex Pro',
                                    letterSpacing: 0.0,
                                  ),
                          validator: _model.priceTextController1Validator
                              .asValidator(context),
                        );
                      },
                    ),
                  ),
                if ((_model.whichExpense == 'other') && _model.expense)
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 16.0),
                    child: TextFormField(
                      controller: _model.priceTextController2,
                      focusNode: _model.priceFocusNode2,
                      textCapitalization: TextCapitalization.words,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'What reason?',
                        labelStyle:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: 'Readex Pro',
                                  letterSpacing: 0.0,
                                ),
                        hintStyle:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: 'Readex Pro',
                                  letterSpacing: 0.0,
                                ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).alternate,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).primary,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).error,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).error,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        filled: true,
                        fillColor:
                            FlutterFlowTheme.of(context).secondaryBackground,
                        contentPadding: const EdgeInsetsDirectional.fromSTEB(
                            20.0, 24.0, 0.0, 24.0),
                        prefixIcon: const Icon(
                          Icons.question_mark,
                        ),
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Readex Pro',
                            letterSpacing: 0.0,
                          ),
                      validator: _model.priceTextController2Validator
                          .asValidator(context),
                    ),
                  ),
                if (_model.pending)
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(20.0, 16.0, 0.0, 6.0),
                    child: Text(
                      'Room',
                      style: FlutterFlowTheme.of(context).labelMedium.override(
                            fontFamily: 'Readex Pro',
                            letterSpacing: 0.0,
                          ),
                    ),
                  ),
                if (_model.pending)
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 16.0),
                    child: FutureBuilder<List<RoomsRecord>>(
                      future: queryRoomsRecordOnce(
                        queryBuilder: (roomsRecord) => roomsRecord
                            .where(
                              'hotel',
                              isEqualTo: FFAppState().hotel,
                            )
                            .where(
                              'vacant',
                              isEqualTo: false,
                            )
                            .orderBy('number'),
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
                        List<RoomsRecord> choiceChipsRoomsRecordList =
                            snapshot.data!;

                        return FlutterFlowChoiceChips(
                          options: functions
                              .intListToStringList(choiceChipsRoomsRecordList
                                  .map((e) => e.number)
                                  .toList())
                              .map((label) => ChipData(label))
                              .toList(),
                          onChanged: (val) => setState(
                              () => _model.choiceChipsValue = val?.firstOrNull),
                          selectedChipStyle: ChipStyle(
                            backgroundColor:
                                FlutterFlowTheme.of(context).primary,
                            textStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  color: FlutterFlowTheme.of(context).info,
                                  letterSpacing: 0.0,
                                ),
                            iconColor: FlutterFlowTheme.of(context).accent4,
                            iconSize: 18.0,
                            elevation: 4.0,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          unselectedChipStyle: ChipStyle(
                            backgroundColor:
                                FlutterFlowTheme.of(context).alternate,
                            textStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  letterSpacing: 0.0,
                                ),
                            iconColor: FlutterFlowTheme.of(context).info,
                            iconSize: 18.0,
                            elevation: 0.0,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          chipSpacing: 12.0,
                          rowSpacing: 12.0,
                          multiselect: false,
                          alignment: WrapAlignment.start,
                          controller: _model.choiceChipsValueController ??=
                              FormFieldController<List<String>>(
                            [],
                          ),
                          wrapped: true,
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
