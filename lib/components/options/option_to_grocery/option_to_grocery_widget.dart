import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'option_to_grocery_model.dart';
export 'option_to_grocery_model.dart';

class OptionToGroceryWidget extends StatefulWidget {
  const OptionToGroceryWidget({
    Key? key,
    required this.ref,
  }) : super(key: key);

  final DocumentReference? ref;

  @override
  _OptionToGroceryWidgetState createState() => _OptionToGroceryWidgetState();
}

class _OptionToGroceryWidgetState extends State<OptionToGroceryWidget> {
  late OptionToGroceryModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OptionToGroceryModel());

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

    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Container(
        width: 300.0,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          boxShadow: [
            BoxShadow(
              blurRadius: 4.0,
              color: Color(0x33000000),
              offset: Offset(0.0, 2.0),
            )
          ],
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 12.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(12.0, 12.0, 0.0, 0.0),
                child: Text(
                  'Options',
                  textAlign: TextAlign.start,
                  style: FlutterFlowTheme.of(context).labelMedium,
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    var confirmDialogResponse = await showDialog<bool>(
                          context: context,
                          builder: (alertDialogContext) {
                            return AlertDialog(
                              title: Text('Starting Point'),
                              content: Text(
                                  'Are you sure you want to track revenue from this point forward?'),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(alertDialogContext, false),
                                  child: Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(alertDialogContext, true),
                                  child: Text('Confirm'),
                                ),
                              ],
                            );
                          },
                        ) ??
                        false;
                    if (confirmDialogResponse) {
                      // get grocery
                      _model.groceryToTrack =
                          await GroceriesRecord.getDocumentOnce(widget.ref!);
                      // count grr
                      _model.countGrr = await queryGoodsRevenueRatioRecordCount(
                        queryBuilder: (goodsRevenueRatioRecord) =>
                            goodsRevenueRatioRecord
                                .where(
                                  'hotel',
                                  isEqualTo: FFAppState().hotel,
                                )
                                .orderBy('date', descending: true),
                      );
                      if (_model.countGrr! > 0) {
                        // last grr
                        _model.lastGrr = await queryGoodsRevenueRatioRecordOnce(
                          queryBuilder: (goodsRevenueRatioRecord) =>
                              goodsRevenueRatioRecord
                                  .where(
                                    'hotel',
                                    isEqualTo: FFAppState().hotel,
                                  )
                                  .orderBy('date', descending: true),
                          singleRecord: true,
                        ).then((s) => s.firstOrNull);
                        // decrement grocery

                        await _model.lastGrr!.reference.update({
                          ...mapToFirestore(
                            {
                              'grocery': FieldValue.increment(
                                  -(_model.groceryToTrack!.amount)),
                            },
                          ),
                        });
                      }
                      // create grr

                      await GoodsRevenueRatioRecord.collection.doc().set({
                        ...createGoodsRevenueRatioRecordData(
                          grocery: _model.groceryToTrack?.amount,
                          revenue: 0.0,
                          hotel: FFAppState().hotel,
                          daysToBreakEven: 0,
                          daysPassed: valueOrDefault<int>(
                            functions.daysFrom(_model.groceryToTrack!.date!),
                            0,
                          ),
                        ),
                        ...mapToFirestore(
                          {
                            'date': FieldValue.serverTimestamp(),
                          },
                        ),
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'The sales will restart tracking from this day forward.',
                            style: TextStyle(
                              color: FlutterFlowTheme.of(context).primaryText,
                            ),
                          ),
                          duration: Duration(milliseconds: 4000),
                          backgroundColor:
                              FlutterFlowTheme.of(context).secondary,
                        ),
                      );
                    }
                    Navigator.pop(context);

                    setState(() {});
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                12.0, 0.0, 0.0, 0.0),
                            child: Icon(
                              Icons.start,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 20.0,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  12.0, 0.0, 0.0, 0.0),
                              child: Text(
                                'Mark as starting point',
                                style: FlutterFlowTheme.of(context).bodyMedium,
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
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    _model.grocery =
                        await GroceriesRecord.getDocumentOnce(widget.ref!);
                    // reduce from stat

                    await FFAppState().statsReference!.update({
                      ...mapToFirestore(
                        {
                          'groceryExpenses':
                              FieldValue.increment(-(_model.grocery!.amount)),
                        },
                      ),
                    });
                    // count grr
                    _model.countGrrr = await queryGoodsRevenueRatioRecordCount(
                      queryBuilder: (goodsRevenueRatioRecord) =>
                          goodsRevenueRatioRecord
                              .where(
                                'hotel',
                                isEqualTo: FFAppState().hotel,
                              )
                              .orderBy('date', descending: true),
                    );
                    if (_model.countGrrr! > 0) {
                      // last grr
                      _model.lastGrrr = await queryGoodsRevenueRatioRecordOnce(
                        queryBuilder: (goodsRevenueRatioRecord) =>
                            goodsRevenueRatioRecord
                                .where(
                                  'hotel',
                                  isEqualTo: FFAppState().hotel,
                                )
                                .orderBy('date', descending: true),
                        singleRecord: true,
                      ).then((s) => s.firstOrNull);
                      if (_model.grocery?.amount == _model.lastGrrr?.grocery) {
                        // delete lastGrrr
                        await _model.lastGrrr!.reference.delete();
                      } else {
                        if (_model.grocery!.amount < _model.lastGrrr!.grocery) {
                          // decrement grocery in lastGrrr

                          await _model.lastGrrr!.reference
                              .update(createGoodsRevenueRatioRecordData(
                            grocery: _model.lastGrrr!.grocery -
                                _model.grocery!.amount,
                          ));
                        }
                      }
                    }
                    await widget.ref!.delete();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Grocery is removed!',
                          style: TextStyle(
                            color: FlutterFlowTheme.of(context).info,
                          ),
                        ),
                        duration: Duration(milliseconds: 4000),
                        backgroundColor: FlutterFlowTheme.of(context).error,
                      ),
                    );
                    // clear groceryHome
                    FFAppState().clearGroceryHomeCache();
                    Navigator.pop(context);
                    context.safePop();

                    setState(() {});
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                12.0, 0.0, 0.0, 0.0),
                            child: Icon(
                              Icons.remove,
                              color: FlutterFlowTheme.of(context).error,
                              size: 20.0,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  12.0, 0.0, 0.0, 0.0),
                              child: Text(
                                'Remove',
                                style: FlutterFlowTheme.of(context).bodyMedium,
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
  }
}
