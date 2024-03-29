import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'new_grocery_model.dart';
export 'new_grocery_model.dart';

class NewGroceryWidget extends StatefulWidget {
  const NewGroceryWidget({super.key});

  @override
  State<NewGroceryWidget> createState() => _NewGroceryWidgetState();
}

class _NewGroceryWidgetState extends State<NewGroceryWidget> {
  late NewGroceryModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NewGroceryModel());

    _model.remarkController ??= TextEditingController();
    _model.remarkFocusNode ??= FocusNode();

    _model.amountController ??= TextEditingController();
    _model.amountFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xB20B191E),
      ),
      child: Align(
        alignment: const AlignmentDirectional(0.0, 1.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Align(
                alignment: const AlignmentDirectional(1.0, 0.0),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 12.0, 16.0),
                  child: FlutterFlowIconButton(
                    borderColor: Colors.transparent,
                    borderRadius: 30.0,
                    borderWidth: 1.0,
                    buttonSize: 44.0,
                    fillColor: FlutterFlowTheme.of(context).primaryBackground,
                    icon: Icon(
                      Icons.close_rounded,
                      color: FlutterFlowTheme.of(context).secondaryText,
                      size: 24.0,
                    ),
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              Material(
                color: Colors.transparent,
                elevation: 5.0,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0.0),
                    bottomRight: Radius.circular(0.0),
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                ),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(0.0),
                      bottomRight: Radius.circular(0.0),
                      topLeft: Radius.circular(16.0),
                      topRight: Radius.circular(16.0),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 12.0, 0.0, 12.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 0.0, 0.0),
                              child: Text(
                                'Amount Spent in Grocery',
                                style: FlutterFlowTheme.of(context)
                                    .headlineSmall
                                    .override(
                                      fontFamily: 'Outfit',
                                      letterSpacing: 0.0,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        height: 4.0,
                        thickness: 1.0,
                        color: Color(0xFFE0E3E7),
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            TextFormField(
                              controller: _model.remarkController,
                              focusNode: _model.remarkFocusNode,
                              autofocus: false,
                              textCapitalization: TextCapitalization.sentences,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Remark',
                                labelStyle: FlutterFlowTheme.of(context)
                                    .bodySmall
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      fontSize: 28.0,
                                      letterSpacing: 0.0,
                                    ),
                                hintText: 'Remark (Optional)',
                                hintStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Lexend Deca',
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      fontSize: 28.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.normal,
                                    ),
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                                filled: true,
                                fillColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                contentPadding: const EdgeInsetsDirectional.fromSTEB(
                                    16.0, 24.0, 20.0, 24.0),
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 28.0,
                                    letterSpacing: 0.0,
                                  ),
                              maxLines: 28,
                              validator: _model.remarkControllerValidator
                                  .asValidator(context),
                            ),
                            TextFormField(
                              controller: _model.amountController,
                              focusNode: _model.amountFocusNode,
                              autofocus: true,
                              textCapitalization: TextCapitalization.none,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Amount',
                                labelStyle: FlutterFlowTheme.of(context)
                                    .bodySmall
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      fontSize: 28.0,
                                      letterSpacing: 0.0,
                                    ),
                                hintText: 'Enter an amount',
                                hintStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Lexend Deca',
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      fontSize: 28.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.normal,
                                    ),
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                                filled: true,
                                fillColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                contentPadding: const EdgeInsetsDirectional.fromSTEB(
                                    16.0, 24.0, 20.0, 24.0),
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 28.0,
                                    letterSpacing: 0.0,
                                  ),
                              maxLines: 28,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      signed: true, decimal: true),
                              validator: _model.amountControllerValidator
                                  .asValidator(context),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        height: 4.0,
                        thickness: 1.0,
                        color: Color(0xFFE0E3E7),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            8.0, 4.0, 16.0, 10.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              flex: 5,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          10.0, 0.0, 0.0, 0.0),
                                      child: Text(
                                        'Start Counting Revenue',
                                        textAlign: TextAlign.start,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Readex Pro',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Align(
                                      alignment:
                                          const AlignmentDirectional(-1.0, 0.0),
                                      child: Switch.adaptive(
                                        value: _model.switchValue ??= false,
                                        onChanged: (newValue) async {
                                          setState(() =>
                                              _model.switchValue = newValue);
                                          if (newValue) {
                                            // on
                                            setState(() {
                                              _model.startCountingRevenue =
                                                  true;
                                            });
                                          } else {
                                            // off
                                            setState(() {
                                              _model.startCountingRevenue =
                                                  false;
                                            });
                                          }
                                        },
                                        activeColor:
                                            FlutterFlowTheme.of(context)
                                                .primary,
                                        activeTrackColor:
                                            FlutterFlowTheme.of(context)
                                                .accent1,
                                        inactiveTrackColor:
                                            FlutterFlowTheme.of(context)
                                                .alternate,
                                        inactiveThumbColor:
                                            FlutterFlowTheme.of(context)
                                                .secondaryText,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Container(
                                width: 250.0,
                                height: 44.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                ),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    if (_model.amountController.text != '') {
                                      var confirmDialogResponse =
                                          await showDialog<bool>(
                                                context: context,
                                                builder: (alertDialogContext) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                        'Have you really spent for grocery?'),
                                                    content: Text(
                                                        'You are recording an amount of Php ${_model.amountController.text}.'),
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
                                        await GroceriesRecord.collection
                                            .doc()
                                            .set({
                                          ...createGroceriesRecordData(
                                            hotel: FFAppState().hotel,
                                            recordedBy: currentUserReference,
                                            amount: double.tryParse(
                                                _model.amountController.text),
                                            remark:
                                                _model.remarkController.text,
                                          ),
                                          ...mapToFirestore(
                                            {
                                              'date':
                                                  FieldValue.serverTimestamp(),
                                            },
                                          ),
                                        });
                                        if (_model.startCountingRevenue) {
                                          // create goods revenue ratio

                                          await GoodsRevenueRatioRecord
                                              .collection
                                              .doc()
                                              .set({
                                            ...createGoodsRevenueRatioRecordData(
                                              grocery: double.tryParse(
                                                  _model.amountController.text),
                                              revenue: 0.0,
                                              hotel: FFAppState().hotel,
                                              daysToBreakEven: 0,
                                              daysPassed: 0,
                                            ),
                                            ...mapToFirestore(
                                              {
                                                'date': FieldValue
                                                    .serverTimestamp(),
                                              },
                                            ),
                                          });
                                        } else {
                                          // count grr
                                          _model.countGrr =
                                              await queryGoodsRevenueRatioRecordCount(
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
                                          );
                                          if (_model.countGrr! > 0) {
                                            // last grr
                                            _model.lastGrr =
                                                await queryGoodsRevenueRatioRecordOnce(
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
                                            ).then((s) => s.firstOrNull);
                                            // increment grocery

                                            await _model.lastGrr!.reference
                                                .update({
                                              ...mapToFirestore(
                                                {
                                                  'grocery':
                                                      FieldValue.increment(
                                                          double.parse(_model
                                                              .amountController
                                                              .text)),
                                                },
                                              ),
                                            });
                                            if (_model.lastGrr!.revenue <=
                                                valueOrDefault<double>(
                                                  _model.lastGrr!.grocery +
                                                      double.parse(_model
                                                          .amountController
                                                          .text),
                                                  0.0,
                                                )) {
                                              // reset daysToBreakEven

                                              await _model.lastGrr!.reference
                                                  .update(
                                                      createGoodsRevenueRatioRecordData(
                                                daysToBreakEven: 0,
                                              ));
                                            }
                                          }
                                        }

                                        // increment grocery expense

                                        await FFAppState()
                                            .statsReference!
                                            .update({
                                          ...mapToFirestore(
                                            {
                                              'groceryExpenses':
                                                  FieldValue.increment(
                                                      double.parse(_model
                                                          .amountController
                                                          .text)),
                                            },
                                          ),
                                        });
                                        // clear groceryHome
                                        FFAppState().clearGroceryHomeCache();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'You have recorded a spending in grocery.',
                                              style: TextStyle(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                              ),
                                            ),
                                            duration:
                                                const Duration(milliseconds: 4000),
                                            backgroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondary,
                                          ),
                                        );
                                      }
                                      Navigator.pop(context);
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Please enter an amount!',
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
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Expanded(
                                        flex: 5,
                                        child: Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 5.0, 0.0),
                                          child: Text(
                                            'Add to Grocery Grand Total',
                                            textAlign: TextAlign.end,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Readex Pro',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondary,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Icon(
                                          Icons.send_rounded,
                                          color: FlutterFlowTheme.of(context)
                                              .secondary,
                                          size: 28.0,
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
                    ],
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
