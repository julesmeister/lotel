import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'option_to_booking_model.dart';
export 'option_to_booking_model.dart';

class OptionToBookingWidget extends StatefulWidget {
  const OptionToBookingWidget({
    super.key,
    required this.ref,
    required this.roomNo,
    required this.bookingToExtend,
    this.extend,
  });

  final DocumentReference? ref;
  final int? roomNo;
  final BookingsRecord? bookingToExtend;
  final bool? extend;

  @override
  State<OptionToBookingWidget> createState() => _OptionToBookingWidgetState();
}

class _OptionToBookingWidgetState extends State<OptionToBookingWidget> {
  late OptionToBookingModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OptionToBookingModel());

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
              offset: Offset(
                0.0,
                2.0,
              ),
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
                  style: FlutterFlowTheme.of(context).labelMedium.override(
                        fontFamily: 'Readex Pro',
                        letterSpacing: 0.0,
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
                    // hotelSetting
                    _model.hotelSettings =
                        await HotelSettingsRecord.getDocumentOnce(
                            FFAppState().settingRef!);
                    // room
                    _model.room = await RoomsRecord.getDocumentOnce(
                        widget!.bookingToExtend!.room!);
                    // go to check in

                    context.pushNamed(
                      'CheckIn',
                      queryParameters: {
                        'extend': serializeParam(
                          true,
                          ParamType.bool,
                        ),
                        'roomNo': serializeParam(
                          valueOrDefault<int>(
                            _model.room?.number,
                            1,
                          ),
                          ParamType.int,
                        ),
                        'bookingToExtend': serializeParam(
                          widget!.bookingToExtend,
                          ParamType.Document,
                        ),
                        'ref': serializeParam(
                          widget!.bookingToExtend?.room,
                          ParamType.DocumentReference,
                        ),
                        'promoOn': serializeParam(
                          _model.hotelSettings?.promoOn,
                          ParamType.bool,
                        ),
                        'promoDetail': serializeParam(
                          _model.hotelSettings?.promoDetail,
                          ParamType.String,
                        ),
                        'promoDiscount': serializeParam(
                          valueOrDefault<double>(
                            _model.hotelSettings?.promoPercent,
                            0.0,
                          ),
                          ParamType.double,
                        ),
                        'price': serializeParam(
                          valueOrDefault<double>(
                            _model.hotelSettings!.promoOn
                                ? ((valueOrDefault<double>(
                                          _model.room?.price,
                                          900.0,
                                        ) -
                                        (valueOrDefault<double>(
                                              _model.room?.price,
                                              900.0,
                                            ) *
                                            valueOrDefault<double>(
                                              _model
                                                  .hotelSettings?.promoPercent,
                                              0.0,
                                            ) /
                                            100))
                                    .toInt()
                                    .toDouble())
                                : ((double price, String ability) {
                                    return (ability != "normal")
                                        ? (price * 0.8)
                                        : (price);
                                  }(
                                    valueOrDefault<double>(
                                      _model.room?.price,
                                      900.0,
                                    ),
                                    widget!.bookingToExtend!.ability)),
                            900.0,
                          ),
                          ParamType.double,
                        ),
                        'totalAmount': serializeParam(
                          widget!.bookingToExtend?.total,
                          ParamType.double,
                        ),
                      }.withoutNulls,
                      extra: <String, dynamic>{
                        'bookingToExtend': widget!.bookingToExtend,
                        kTransitionInfoKey: TransitionInfo(
                          hasTransition: true,
                          transitionType: PageTransitionType.rightToLeft,
                        ),
                      },
                    );

                    // return false
                    Navigator.pop(context, false);

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
                              Icons.extension_outlined,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 20.0,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  12.0, 0.0, 0.0, 0.0),
                              child: Text(
                                'Refund / Extend',
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
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    Navigator.pop(context, true);
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
                              Icons.price_change_outlined,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 20.0,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  12.0, 0.0, 0.0, 0.0),
                              child: Text(
                                'Change Price',
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
