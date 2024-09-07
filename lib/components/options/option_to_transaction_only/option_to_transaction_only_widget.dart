import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/forms/transaction_edit/transaction_edit_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'option_to_transaction_only_model.dart';
export 'option_to_transaction_only_model.dart';

class OptionToTransactionOnlyWidget extends StatefulWidget {
  const OptionToTransactionOnlyWidget({
    super.key,
    required this.ref,
    required this.description,
    required this.price,
  });

  final DocumentReference? ref;
  final String? description;
  final double? price;

  @override
  State<OptionToTransactionOnlyWidget> createState() =>
      _OptionToTransactionOnlyWidgetState();
}

class _OptionToTransactionOnlyWidgetState
    extends State<OptionToTransactionOnlyWidget> {
  late OptionToTransactionOnlyModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OptionToTransactionOnlyModel());

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
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(12.0, 12.0, 0.0, 0.0),
                child: Text(
                  'Options For ${widget.description}',
                  textAlign: TextAlign.start,
                  style: FlutterFlowTheme.of(context).labelMedium.override(
                        fontFamily: 'Readex Pro',
                        letterSpacing: 0.0,
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
                    // edit transaction description
                    await showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: MediaQuery.viewInsetsOf(context),
                          child: SizedBox(
                            height: double.infinity,
                            child: TransactionEditWidget(
                              ref: widget.ref!,
                              description: widget.description!,
                              price: widget.price!,
                            ),
                          ),
                        );
                      },
                    ).then((value) => safeSetState(() {}));

                    // close
                    Navigator.pop(context);
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
                              Icons.auto_awesome_motion_outlined,
                              color: FlutterFlowTheme.of(context).primaryText,
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
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    // read transaction
                    _model.transactionToMark =
                        await TransactionsRecord.getDocumentOnce(widget.ref!);
                    if (_model.transactionToMark?.type == 'expense') {
                      var confirmDialogResponse = await showDialog<bool>(
                            context: context,
                            builder: (alertDialogContext) {
                              return AlertDialog(
                                title: const Text('Mark as Grocery'),
                                content:
                                    const Text('This will be recorded as grocery.'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(
                                        alertDialogContext, false),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(alertDialogContext, true),
                                    child: const Text('Confirm'),
                                  ),
                                ],
                              );
                            },
                          ) ??
                          false;
                      if (confirmDialogResponse) {
                        // create grocery

                        var groceriesRecordReference =
                            GroceriesRecord.collection.doc();
                        await groceriesRecordReference.set({
                          ...createGroceriesRecordData(
                            hotel: FFAppState().hotel,
                            recordedBy: _model.transactionToMark?.staff,
                            amount: _model.transactionToMark?.total,
                            remark: _model.transactionToMark?.description,
                          ),
                          ...mapToFirestore(
                            {
                              'date': FieldValue.serverTimestamp(),
                            },
                          ),
                        });
                        _model.grocery = GroceriesRecord.getDocumentFromData({
                          ...createGroceriesRecordData(
                            hotel: FFAppState().hotel,
                            recordedBy: _model.transactionToMark?.staff,
                            amount: _model.transactionToMark?.total,
                            remark: _model.transactionToMark?.description,
                          ),
                          ...mapToFirestore(
                            {
                              'date': DateTime.now(),
                            },
                          ),
                        }, groceriesRecordReference);
                        // count grr
                        _model.countGrr =
                            await queryGoodsRevenueRatioRecordCount(
                          queryBuilder: (goodsRevenueRatioRecord) =>
                              goodsRevenueRatioRecord
                                  .where(
                                    'hotel',
                                    isEqualTo: FFAppState().hotel,
                                  )
                                  .where(
                                    'date',
                                    isLessThanOrEqualTo:
                                        _model.transactionToMark?.date,
                                  )
                                  .orderBy('date', descending: true),
                        );
                        if (_model.countGrr! > 0) {
                          // correct grr category
                          _model.lastGrr =
                              await queryGoodsRevenueRatioRecordOnce(
                            queryBuilder: (goodsRevenueRatioRecord) =>
                                goodsRevenueRatioRecord
                                    .where(
                                      'hotel',
                                      isEqualTo: FFAppState().hotel,
                                    )
                                    .where(
                                      'date',
                                      isLessThanOrEqualTo:
                                          _model.transactionToMark?.date,
                                    )
                                    .orderBy('date', descending: true),
                            singleRecord: true,
                          ).then((s) => s.firstOrNull);
                          // increment grocery

                          await _model.lastGrr!.reference.update({
                            ...mapToFirestore(
                              {
                                'grocery': FieldValue.increment(
                                    _model.transactionToMark!.total),
                              },
                            ),
                          });
                          // stats
                          _model.stats = await queryStatsRecordOnce(
                            queryBuilder: (statsRecord) => statsRecord
                                .where(
                                  'hotel',
                                  isEqualTo: FFAppState().hotel,
                                )
                                .where(
                                  'year',
                                  isEqualTo: dateTimeFormat(
                                      "y", _model.transactionToMark?.date),
                                )
                                .where(
                                  'month',
                                  isEqualTo: dateTimeFormat(
                                      "MMMM", _model.transactionToMark?.date),
                                ),
                            singleRecord: true,
                          ).then((s) => s.firstOrNull);
                          // increment grocery expenses

                          await _model.stats!.reference.update({
                            ...mapToFirestore(
                              {
                                'groceryExpenses': FieldValue.increment(
                                    _model.transactionToMark!.total),
                              },
                            ),
                          });
                          FFAppState().clearGroceryHomeCache();
                          // Added to grocery and metrics!
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Added to grocery and metrics!',
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
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Only expenses can be marked sa grocery!',
                            style: TextStyle(
                              color: FlutterFlowTheme.of(context).info,
                            ),
                          ),
                          duration: const Duration(milliseconds: 4000),
                          backgroundColor: FlutterFlowTheme.of(context).error,
                        ),
                      );
                    }

                    // close
                    Navigator.pop(context);

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
                              Icons.auto_awesome_motion_outlined,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 20.0,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  12.0, 0.0, 0.0, 0.0),
                              child: Text(
                                'Mark as Grocery',
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
                    if (valueOrDefault(currentUserDocument?.role, '') ==
                        'admin') {
                      // delete transaction?
                      var confirmDialogResponse = await showDialog<bool>(
                            context: context,
                            builder: (alertDialogContext) {
                              return AlertDialog(
                                title: const Text('Are you sure?'),
                                content:
                                    const Text('This transaction will be deleted.'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(
                                        alertDialogContext, false),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(alertDialogContext, true),
                                    child: const Text('Confirm'),
                                  ),
                                ],
                              );
                            },
                          ) ??
                          false;
                      if (confirmDialogResponse) {
                        // transaction action output
                        _model.transaction =
                            await TransactionsRecord.getDocumentOnce(
                                widget.ref!);
                        if ((_model.transaction!.inventories.isNotEmpty) &&
                            (_model.transaction?.type != 'book')) {
                          while (_model.loopInvetoryCounter !=
                              _model.transaction?.inventories.length) {
                            // inventory
                            _model.inventory =
                                await InventoriesRecord.getDocumentOnce(_model
                                    .transaction!
                                    .inventories[_model.loopInvetoryCounter]);
                            // item
                            _model.item = await queryGoodsRecordOnce(
                              queryBuilder: (goodsRecord) => goodsRecord
                                  .where(
                                    'description',
                                    isEqualTo: _model.inventory?.item,
                                  )
                                  .where(
                                    'hotel',
                                    isEqualTo: FFAppState().hotel,
                                  ),
                              singleRecord: true,
                            ).then((s) => s.firstOrNull);
                            // reverse quantity sold

                            await _model.item!.reference.update({
                              ...mapToFirestore(
                                {
                                  'quantity': FieldValue.increment(
                                      _model.inventory!.quantityChange),
                                },
                              ),
                            });
                            // delete inventory also
                            await _model.transaction!
                                .inventories[_model.loopInvetoryCounter]
                                .delete();
                            // increment loop
                            _model.loopInvetoryCounter =
                                _model.loopInvetoryCounter + 1;
                            safeSetState(() {});
                          }
                        }
                        // delete transactions
                        await widget.ref!.delete();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Transaction is deleted!',
                              style: TextStyle(
                                color: FlutterFlowTheme.of(context).info,
                              ),
                            ),
                            duration: const Duration(milliseconds: 4000),
                            backgroundColor: FlutterFlowTheme.of(context).error,
                          ),
                        );
                      }
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Consult Admin First!',
                            style: TextStyle(
                              color: FlutterFlowTheme.of(context).info,
                            ),
                          ),
                          duration: const Duration(milliseconds: 4000),
                          backgroundColor: FlutterFlowTheme.of(context).error,
                        ),
                      );
                    }

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
                              Icons.delete_outlined,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 20.0,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  12.0, 0.0, 0.0, 0.0),
                              child: Text(
                                'Delete Transaction',
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
    );
  }
}
