import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'list_of_names_model.dart';
export 'list_of_names_model.dart';

class ListOfNamesWidget extends StatefulWidget {
  const ListOfNamesWidget({
    super.key,
    this.remittance,
    bool? preparedBy,
    this.issues,
    this.records,
    bool? issuer,
    this.replacement,
  })  : preparedBy = preparedBy ?? true,
        issuer = issuer ?? true;

  final DocumentReference? remittance;
  final bool preparedBy;
  final DocumentReference? issues;
  final DocumentReference? records;
  final bool issuer;
  final DocumentReference? replacement;

  @override
  State<ListOfNamesWidget> createState() => _ListOfNamesWidgetState();
}

class _ListOfNamesWidgetState extends State<ListOfNamesWidget> {
  late ListOfNamesModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ListOfNamesModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      // staffs
      _model.staffs = await queryStaffsRecordOnce(
        queryBuilder: (staffsRecord) => staffsRecord
            .where(
              'hotel',
              isEqualTo: FFAppState().hotel,
            )
            .where(
              'fired',
              isEqualTo: false,
            ),
      );
      _model.names =
          _model.staffs!.map((e) => e.name).toList().toList().cast<String>();
      safeSetState(() {});
    });

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
      child: FutureBuilder<List<UsersRecord>>(
        future: queryUsersRecordOnce(
          queryBuilder: (usersRecord) => usersRecord.where(
            'expired',
            isEqualTo: false,
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
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            );
          }
          List<UsersRecord> dropdown1OptionsUsersRecordList = snapshot.data!;

          return Container(
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
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            12.0, 12.0, 0.0, 0.0),
                        child: Text(
                          functions.whoInListOfNames(
                              widget.remittance != null,
                              widget.preparedBy,
                              widget.issues != null,
                              widget.records != null,
                              widget.issuer,
                              widget.replacement != null),
                          textAlign: TextAlign.start,
                          style:
                              FlutterFlowTheme.of(context).labelMedium.override(
                                    fontFamily: 'Readex Pro',
                                    letterSpacing: 0.0,
                                  ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 12.0, 0.0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.clear_sharp,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            size: 18.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 12.0),
                    child: Builder(
                      builder: (context) {
                        final allNames = functions
                            .concatNames(
                                _model.names.toList(),
                                dropdown1OptionsUsersRecordList
                                    .map((e) => e.displayName)
                                    .toList())
                            .toList();

                        return SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:
                                List.generate(allNames.length, (allNamesIndex) {
                              final allNamesItem = allNames[allNamesIndex];
                              return Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 12.0, 0.0, 0.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    if (widget.remittance != null) {
                                      if (widget.preparedBy) {
                                        // update prepared by

                                        await widget.remittance!
                                            .update(createRemittancesRecordData(
                                          preparedByName: allNamesItem,
                                        ));
                                      } else {
                                        // update collected by

                                        await widget.remittance!
                                            .update(createRemittancesRecordData(
                                          collectedByName: allNamesItem,
                                        ));
                                      }
                                    } else {
                                      if (widget.issues != null) {
                                        // updateName

                                        await widget.issues!
                                            .update(createIssuesRecordData(
                                          staffName: allNamesItem,
                                        ));
                                      } else {
                                        if (widget.records != null) {
                                          if (widget.issuer) {
                                            // update issuer

                                            await widget.records!
                                                .update(createRecordsRecordData(
                                              issuedBy: allNamesItem,
                                            ));
                                          } else {
                                            // update recipient

                                            await widget.records!
                                                .update(createRecordsRecordData(
                                              receivedBy: allNamesItem,
                                            ));
                                          }
                                        } else {
                                          if (widget.replacement != null) {
                                            // updated requested by

                                            await widget.replacement!.update(
                                                createReplacementRecordData(
                                              requestedBy: allNamesItem,
                                            ));
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'Something went wrong!',
                                                  style: TextStyle(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .info,
                                                  ),
                                                ),
                                                duration: const Duration(
                                                    milliseconds: 4000),
                                                backgroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .error,
                                              ),
                                            );
                                          }
                                        }
                                      }
                                    }

                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          0.0, 8.0, 0.0, 8.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    12.0, 0.0, 0.0, 0.0),
                                            child: Icon(
                                              Icons.location_history,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              size: 20.0,
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      12.0, 0.0, 0.0, 0.0),
                                              child: Text(
                                                allNamesItem,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Readex Pro',
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
                              );
                            }),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
