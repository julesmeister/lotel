import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'option_to_reasses_model.dart';
export 'option_to_reasses_model.dart';

class OptionToReassesWidget extends StatefulWidget {
  const OptionToReassesWidget({
    super.key,
    required this.room,
  });

  final RoomsRecord? room;

  @override
  State<OptionToReassesWidget> createState() => _OptionToReassesWidgetState();
}

class _OptionToReassesWidgetState extends State<OptionToReassesWidget> {
  late OptionToReassesModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OptionToReassesModel());

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
                    var confirmDialogResponse = await showDialog<bool>(
                          context: context,
                          builder: (alertDialogContext) {
                            return AlertDialog(
                              title: const Text('Reassess'),
                              content: const Text(
                                  'This will try to refresh if this room is really occupied still.'),
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
                      // latest transaction of this room
                      _model.transaction = await queryTransactionsRecordOnce(
                        queryBuilder: (transactionsRecord) => transactionsRecord
                            .where(
                              'hotel',
                              isEqualTo: FFAppState().hotel,
                            )
                            .where(
                              'room',
                              isEqualTo: widget.room?.number,
                            )
                            .where(
                              'type',
                              isEqualTo: 'book',
                            )
                            .orderBy('date', descending: true),
                        singleRecord: true,
                      ).then((s) => s.firstOrNull);
                      if (_model.transaction != null) {
                        // booking
                        _model.booking = await BookingsRecord.getDocumentOnce(
                            _model.transaction!.booking!);
                        if (_model.booking?.status == 'out') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Room remains vacant!',
                                style: TextStyle(
                                  color: FlutterFlowTheme.of(context).info,
                                ),
                              ),
                              duration: const Duration(milliseconds: 4000),
                              backgroundColor:
                                  FlutterFlowTheme.of(context).error,
                            ),
                          );
                          if (widget.room?.currentBooking != null) {
                            // delete current booked reference

                            await widget.room!.reference.update({
                              ...createRoomsRecordData(
                                vacant: true,
                                guests: 0,
                              ),
                              ...mapToFirestore(
                                {
                                  'currentBooking': FieldValue.delete(),
                                  'last': FieldValue.serverTimestamp(),
                                },
                              ),
                            });
                          }
                        } else {
                          // update room's last transaction and booking

                          await widget.room!.reference
                              .update(createRoomsRecordData(
                            vacant: false,
                            currentBooking: _model.transaction?.booking,
                            guests: _model.transaction?.guests,
                            last: _model.transaction?.date,
                          ));
                          // create history

                          var historyRecordReference =
                              HistoryRecord.createDoc(widget.room!.reference);
                          await historyRecordReference.set({
                            ...createHistoryRecordData(
                              description: 'Reclassified as occupied!',
                              staff: currentUserReference,
                              booking: _model.booking?.reference,
                            ),
                            ...mapToFirestore(
                              {
                                'date': FieldValue.serverTimestamp(),
                              },
                            ),
                          });
                          _model.history = HistoryRecord.getDocumentFromData({
                            ...createHistoryRecordData(
                              description: 'Reclassified as occupied!',
                              staff: currentUserReference,
                              booking: _model.booking?.reference,
                            ),
                            ...mapToFirestore(
                              {
                                'date': DateTime.now(),
                              },
                            ),
                          }, historyRecordReference);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'This room is occupied!',
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
                    }
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
                              Icons.refresh,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 20.0,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  12.0, 0.0, 0.0, 0.0),
                              child: Text(
                                'Check Room Occupancy',
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
