import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'replenish_model.dart';
export 'replenish_model.dart';

class ReplenishWidget extends StatefulWidget {
  const ReplenishWidget({Key? key}) : super(key: key);

  @override
  _ReplenishWidgetState createState() => _ReplenishWidgetState();
}

class _ReplenishWidgetState extends State<ReplenishWidget> {
  late ReplenishModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ReplenishModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.replenishNeeded = await queryGoodsRecordCount(
        queryBuilder: (goodsRecord) => goodsRecord.where(
          'replenish',
          isEqualTo: true,
        ),
      );
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
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    context.watch<FFAppState>();

    return FutureBuilder<List<GoodsRecord>>(
      future: queryGoodsRecordOnce(),
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
        List<GoodsRecord> replenishGoodsRecordList = snapshot.data!;
        return GestureDetector(
          onTap: () => _model.unfocusNode.canRequestFocus
              ? FocusScope.of(context).requestFocus(_model.unfocusNode)
              : FocusScope.of(context).unfocus(),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            appBar: AppBar(
              backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
              automaticallyImplyLeading: false,
              leading: FlutterFlowIconButton(
                borderRadius: 20.0,
                borderWidth: 1.0,
                buttonSize: 40.0,
                icon: Icon(
                  Icons.chevron_left,
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 24.0,
                ),
                onPressed: () async {
                  context.safePop();
                },
              ),
              title: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'To Replenish',
                    style: FlutterFlowTheme.of(context).headlineSmall,
                  ),
                  Text(
                    'Are we low on these items?',
                    style: FlutterFlowTheme.of(context).labelMedium,
                  ),
                ],
              ),
              actions: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 12.0, 4.0),
                  child: FlutterFlowIconButton(
                    borderColor: Colors.transparent,
                    borderRadius: 30.0,
                    borderWidth: 1.0,
                    buttonSize: 44.0,
                    fillColor: FlutterFlowTheme.of(context).alternate,
                    icon: Icon(
                      Icons.close_rounded,
                      color: FlutterFlowTheme.of(context).secondaryText,
                      size: 24.0,
                    ),
                    onPressed: () async {
                      // replenished items
                      _model.replenished = await queryGoodsRecordOnce(
                        queryBuilder: (goodsRecord) => goodsRecord
                            .where(
                              'hotel',
                              isEqualTo: FFAppState().hotel,
                            )
                            .where(
                              'replenish',
                              isEqualTo: true,
                            ),
                      );
                      // reset loop
                      setState(() {
                        _model.loopCounter = 0;
                      });
                      while (_model.loopCounter != _model.replenished?.length) {
                        // unreplenish

                        await _model.replenished![_model.loopCounter].reference
                            .update(createGoodsRecordData(
                          replenish: false,
                        ));
                        // increment
                        setState(() {
                          _model.loopCounter = _model.loopCounter + 1;
                        });
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'You have restocked!',
                            style: TextStyle(
                              color: FlutterFlowTheme.of(context).primaryText,
                            ),
                          ),
                          duration: Duration(milliseconds: 4000),
                          backgroundColor:
                              FlutterFlowTheme.of(context).secondary,
                        ),
                      );

                      setState(() {});
                    },
                  ),
                ),
              ],
              centerTitle: false,
              elevation: 0.0,
            ),
            body: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                      child: LinearPercentIndicator(
                        percent: _model.replenishNeeded! /
                            replenishGoodsRecordList.length,
                        width: MediaQuery.sizeOf(context).width * 1.0,
                        lineHeight: 12.0,
                        animation: true,
                        animateFromLastPercent: true,
                        progressColor: FlutterFlowTheme.of(context).secondary,
                        backgroundColor: Color(0xFFE0E3E7),
                        barRadius: Radius.circular(0.0),
                        padding: EdgeInsets.zero,
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 16.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 12.0, 0.0, 0.0),
                              child: Text(
                                'Items',
                                style: FlutterFlowTheme.of(context).labelMedium,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 12.0, 0.0, 0.0),
                            child: Text(
                              valueOrDefault<String>(
                                _model.replenishNeeded?.toString(),
                                '0',
                              ),
                              style: FlutterFlowTheme.of(context).bodyMedium,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                2.0, 12.0, 0.0, 0.0),
                            child: Text(
                              'items need replenishing',
                              style: FlutterFlowTheme.of(context).bodyMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (replenishGoodsRecordList.length > 0)
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 12.0, 0.0, 0.0),
                          child: Builder(
                            builder: (context) {
                              final replenish = replenishGoodsRecordList
                                  .where((e) => e.replenish == true)
                                  .toList()
                                  .map((e) => e)
                                  .toList();
                              return ListView.builder(
                                padding: EdgeInsets.zero,
                                primary: false,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: replenish.length,
                                itemBuilder: (context, replenishIndex) {
                                  final replenishItem =
                                      replenish[replenishIndex];
                                  return Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 16.0, 8.0),
                                    child: Container(
                                      width: 100.0,
                                      height: 70.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        border: Border.all(
                                          color: FlutterFlowTheme.of(context)
                                              .alternate,
                                          width: 1.0,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: Theme(
                                              data: ThemeData(
                                                unselectedWidgetColor:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                              ),
                                              child: CheckboxListTile(
                                                value:
                                                    _model.checkboxListTileValueMap1[
                                                            replenishItem] ??=
                                                        replenishItem.replenish,
                                                onChanged: (newValue) async {
                                                  setState(() => _model
                                                          .checkboxListTileValueMap1[
                                                      replenishItem] = newValue!);
                                                  if (newValue!) {
                                                    // replenish

                                                    await replenishItem
                                                        .reference
                                                        .update(
                                                            createGoodsRecordData(
                                                      replenish: true,
                                                    ));
                                                  } else {
                                                    // unreplenish

                                                    await replenishItem
                                                        .reference
                                                        .update(
                                                            createGoodsRecordData(
                                                      replenish: false,
                                                    ));
                                                  }
                                                },
                                                title: Text(
                                                  replenishItem.description,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyLarge
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        lineHeight: 2.0,
                                                      ),
                                                ),
                                                subtitle: Text(
                                                  'Quantities: ${replenishItem.quantity.toString()}',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodySmall
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .success,
                                                      ),
                                                ),
                                                tileColor:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                                activeColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                checkColor: Colors.white,
                                                dense: false,
                                                controlAffinity:
                                                    ListTileControlAffinity
                                                        .trailing,
                                                contentPadding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(
                                                            8.0, 0.0, 8.0, 0.0),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
