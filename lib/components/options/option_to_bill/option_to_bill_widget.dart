import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/forms/bill_edit/bill_edit_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'option_to_bill_model.dart';
export 'option_to_bill_model.dart';

class OptionToBillWidget extends StatefulWidget {
  const OptionToBillWidget({
    super.key,
    required this.bill,
  });

  final BillsRecord? bill;

  @override
  State<OptionToBillWidget> createState() => _OptionToBillWidgetState();
}

class _OptionToBillWidgetState extends State<OptionToBillWidget> {
  late OptionToBillModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OptionToBillModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.stats = FFAppState().statsReference;
      setState(() {});
    });

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
                  'Options',
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
                    // read bill
                    _model.billToChange = await BillsRecord.getDocumentOnce(
                        widget.bill!.reference);
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
                            child: BillEditWidget(
                              bill: _model.billToChange!,
                              description: _model.billToChange!.description,
                              amount: _model.billToChange!.amount,
                              afterDue: valueOrDefault<double>(
                                _model.billToChange?.afterDue,
                                0.0,
                              ),
                            ),
                          ),
                        );
                      },
                    ).then((value) => safeSetState(() {}));

                    // close
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
                    // find similar
                    _model.existingBill = await queryOptionsRecordCount(
                      queryBuilder: (optionsRecord) => optionsRecord
                          .where(
                            'type',
                            isEqualTo: 'bill',
                          )
                          .where(
                            'choice',
                            isEqualTo: widget.bill?.description,
                          ),
                    );
                    if (_model.existingBill == 1) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'This bill option already exists in the bookmarks!',
                            style: TextStyle(
                              color: FlutterFlowTheme.of(context).accent4,
                            ),
                          ),
                          duration: const Duration(milliseconds: 4000),
                          backgroundColor: FlutterFlowTheme.of(context).error,
                        ),
                      );
                      // bill changes

                      await BillChangesRecord.collection
                          .doc()
                          .set(createBillChangesRecordData(
                            date: getCurrentTimestamp,
                            description:
                                'There was an attempt to create a duplicate bookmark on the bill ${widget.bill?.description}.',
                            staff: currentUserReference,
                            hotel: FFAppState().hotel,
                          ));
                      Navigator.pop(context);
                    } else {
                      var confirmDialogResponse = await showDialog<bool>(
                            context: context,
                            builder: (alertDialogContext) {
                              return AlertDialog(
                                title: const Text('Bookmark'),
                                content: const Text(
                                    'Bookmarking this bill detail will simplify future inputs. It\'ll appear in the choices box, just a click away.'),
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
                        await OptionsRecord.collection
                            .doc()
                            .set(createOptionsRecordData(
                              type: 'bill',
                              choice: widget.bill?.description,
                            ));
                        // bill changes

                        await BillChangesRecord.collection
                            .doc()
                            .set(createBillChangesRecordData(
                              date: getCurrentTimestamp,
                              description:
                                  'The bill \"${widget.bill?.description}\" has been bookmarked for easy access.',
                              staff: currentUserReference,
                              hotel: FFAppState().hotel,
                            ));
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Bookmark successfully created!',
                              style: TextStyle(
                                color: FlutterFlowTheme.of(context).primaryText,
                              ),
                            ),
                            duration: const Duration(milliseconds: 4000),
                            backgroundColor:
                                FlutterFlowTheme.of(context).secondary,
                          ),
                        );
                      }
                    }

                    setState(() {});
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
                              Icons.star_rate,
                              color: FlutterFlowTheme.of(context).warning,
                              size: 20.0,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  12.0, 0.0, 0.0, 0.0),
                              child: Text(
                                'Bookmark This Bill For Easy Access',
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
                    var confirmDialogResponse = await showDialog<bool>(
                          context: context,
                          builder: (alertDialogContext) {
                            return AlertDialog(
                              title: const Text('Delete'),
                              content: const Text(
                                  'This bill will be removed and its impact on the relevant monthly metrics will be deducted.'),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(alertDialogContext, false),
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
                      if (!functions.isThisMonth(widget.bill!.date!)) {
                        // which stats belong
                        _model.statsBillBelong = await queryStatsRecordOnce(
                          queryBuilder: (statsRecord) => statsRecord
                              .where(
                                'hotel',
                                isEqualTo: FFAppState().hotel,
                              )
                              .where(
                                'month',
                                isEqualTo:
                                    dateTimeFormat("MMMM", widget.bill?.date),
                              )
                              .where(
                                'year',
                                isEqualTo:
                                    dateTimeFormat("y", widget.bill?.date),
                              ),
                          singleRecord: true,
                        ).then((s) => s.firstOrNull);
                        // set stats ref
                        _model.stats = _model.statsBillBelong?.reference;
                        setState(() {});
                      }
                      // reduce from stat

                      await _model.stats!.update({
                        ...mapToFirestore(
                          {
                            'bills':
                                FieldValue.increment(-(widget.bill!.amount)),
                          },
                        ),
                      });
                      // bill change

                      await BillChangesRecord.collection
                          .doc()
                          .set(createBillChangesRecordData(
                            date: getCurrentTimestamp,
                            description:
                                'The bill attributed to ${widget.bill?.description} covered on ${dateTimeFormat("MMMMEEEEd", widget.bill?.date)} was deleted and the bill\'s amount was deducted from the ${dateTimeFormat("MMMM", widget.bill?.date)} records.',
                            staff: currentUserReference,
                            hotel: FFAppState().hotel,
                          ));
                      await widget.bill!.reference.delete();
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '${valueOrDefault<String>(
                              formatNumber(
                                widget.bill?.amount,
                                formatType: FormatType.decimal,
                                decimalType: DecimalType.automatic,
                                currency: 'Php ',
                              ),
                              '0',
                            )} is deducted from ${dateTimeFormat("MMMM y", widget.bill?.date)} metrics.',
                            style: TextStyle(
                              color: FlutterFlowTheme.of(context).primaryText,
                            ),
                          ),
                          duration: const Duration(milliseconds: 4000),
                          backgroundColor:
                              FlutterFlowTheme.of(context).secondary,
                        ),
                      );
                      context.safePop();

                      context.pushNamed('billsList');
                    }

                    setState(() {});
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
                                'Delete',
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
