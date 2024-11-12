import '/backend/backend.dart';
import '/components/forms/edit_grocery/edit_grocery_widget.dart';
import '/components/forms/new_grocery/new_grocery_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'option_to_grocery_model.dart';
export 'option_to_grocery_model.dart';

class OptionToGroceryWidget extends StatefulWidget {
  const OptionToGroceryWidget({
    super.key,
    required this.grocery,
  });

  final GroceriesRecord? grocery;

  @override
  State<OptionToGroceryWidget> createState() => _OptionToGroceryWidgetState();
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

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
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
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: 300.0,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          boxShadow: const [
            BoxShadow(
              blurRadius: 4.0,
              color: Color(0x33000000),
              offset: Offset(
                0.0,
                2.0,
              ),
            )
          ],
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 12.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(12.0, 12.0, 0.0, 0.0),
                  child: Text(
                    'Options',
                    textAlign: TextAlign.start,
                    style: FlutterFlowTheme.of(context).labelMedium.override(
                          fontFamily: 'Readex Pro',
                          letterSpacing: 0.0,
                        ),
                  ),
                ),
                if (FFAppState().role == 'admin')
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        await showModalBottomSheet(
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          enableDrag: false,
                          context: context,
                          builder: (context) {
                            return Padding(
                              padding: MediaQuery.viewInsetsOf(context),
                              child: SizedBox(
                                height: double.infinity,
                                child: EditGroceryWidget(
                                  grocery: widget.grocery!,
                                ),
                              ),
                            );
                          },
                        ).then((value) => safeSetState(() {}));
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 8.0, 0.0, 8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    12.0, 0.0, 0.0, 0.0),
                                child: Icon(
                                  Icons.edit_outlined,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 20.0,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      12.0, 0.0, 0.0, 0.0),
                                  child: Text(
                                    'Change Details',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          letterSpacing: 0.0,
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
                if (FFAppState().role == 'admin')
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        await showModalBottomSheet(
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          enableDrag: false,
                          context: context,
                          builder: (context) {
                            return Padding(
                              padding: MediaQuery.viewInsetsOf(context),
                              child: SizedBox(
                                height: double.infinity,
                                child: NewGroceryWidget(
                                  duplicate: widget.grocery?.remark,
                                ),
                              ),
                            );
                          },
                        ).then((value) => safeSetState(() {}));
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 8.0, 0.0, 8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    12.0, 0.0, 0.0, 0.0),
                                child: Icon(
                                  Icons.control_point_duplicate,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 20.0,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      12.0, 0.0, 0.0, 0.0),
                                  child: Text(
                                    'Duplicate Grocery Info',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          letterSpacing: 0.0,
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
                if (FFAppState().role == 'admin')
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
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
                                  title: const Text('Starting Point'),
                                  content: const Text(
                                      'Are you sure you want to track revenue from this point forward?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(
                                          alertDialogContext, false),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () => Navigator.pop(
                                          alertDialogContext, true),
                                      child: const Text('Confirm'),
                                    ),
                                  ],
                                );
                              },
                            ) ??
                            false;
                        if (confirmDialogResponse) {
                          // get grocery
                          _model.groceryToTrack =
                              await GroceriesRecord.getDocumentOnce(
                                  widget.grocery!.reference);
                          // count grr
                          _model.countGrr =
                              await queryGoodsRevenueRatioRecordCount(
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
                            _model.lastGrr =
                                await queryGoodsRevenueRatioRecordOnce(
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
                                functions
                                    .daysFrom(_model.groceryToTrack!.date!),
                                0,
                              ),
                            ),
                            ...mapToFirestore(
                              {
                                'date': FieldValue.serverTimestamp(),
                              },
                            ),
                          });
                          // statsRef
                          _model.statsRef = await StatsRecord.getDocumentOnce(
                              FFAppState().statsReference!);
                          if (_model.statsRef?.groceryExpenses == 0.0) {
                            // set grocery expenses to amount

                            await FFAppState()
                                .statsReference!
                                .update(createStatsRecordData(
                                  groceryExpenses:
                                      _model.groceryToTrack?.amount,
                                ));
                          }
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'The sales will restart tracking from this day forward.',
                                style: TextStyle(
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                ),
                              ),
                              duration: const Duration(milliseconds: 4000),
                              backgroundColor:
                                  FlutterFlowTheme.of(context).secondary,
                            ),
                          );
                        }
                        Navigator.pop(context);

                        safeSetState(() {});
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 8.0, 0.0, 8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    12.0, 0.0, 0.0, 0.0),
                                child: Icon(
                                  Icons.start,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 20.0,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      12.0, 0.0, 0.0, 0.0),
                                  child: Text(
                                    'Mark as starting point',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          letterSpacing: 0.0,
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
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      _model.grocery = await GroceriesRecord.getDocumentOnce(
                          widget.grocery!.reference);
                      // reduce from stat

                      await FFAppState().statsReference!.update({
                        ...mapToFirestore(
                          {
                            'groceryExpenses': FieldValue.increment(
                                -(widget.grocery!.amount)),
                          },
                        ),
                      });
                      // count grr
                      _model.countGrrr =
                          await queryGoodsRevenueRatioRecordCount(
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
                        _model.lastGrrr =
                            await queryGoodsRevenueRatioRecordOnce(
                          queryBuilder: (goodsRevenueRatioRecord) =>
                              goodsRevenueRatioRecord
                                  .where(
                                    'hotel',
                                    isEqualTo: FFAppState().hotel,
                                  )
                                  .orderBy('date', descending: true),
                          singleRecord: true,
                        ).then((s) => s.firstOrNull);
                        if (_model.grocery?.amount ==
                            _model.lastGrrr?.grocery) {
                          // delete lastGrrr
                          await _model.lastGrrr!.reference.delete();
                        } else {
                          if (_model.grocery!.amount <
                              _model.lastGrrr!.grocery) {
                            // decrement grocery in lastGrrr

                            await _model.lastGrrr!.reference
                                .update(createGoodsRevenueRatioRecordData(
                              grocery: _model.lastGrrr!.grocery -
                                  _model.grocery!.amount,
                            ));
                          }
                        }
                      }
                      await widget.grocery!.reference.delete();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Grocery is removed!',
                            style: TextStyle(
                              color: FlutterFlowTheme.of(context).info,
                            ),
                          ),
                          duration: const Duration(milliseconds: 4000),
                          backgroundColor: FlutterFlowTheme.of(context).error,
                        ),
                      );
                      // clear groceryHome
                      FFAppState().clearGroceryHomeCache();
                      Navigator.pop(context);
                      context.safePop();

                      safeSetState(() {});
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  12.0, 0.0, 0.0, 0.0),
                              child: Icon(
                                Icons.remove,
                                color: FlutterFlowTheme.of(context).error,
                                size: 20.0,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    12.0, 0.0, 0.0, 0.0),
                                child: Text(
                                  'Remove',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        letterSpacing: 0.0,
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
      ),
    );
  }
}
