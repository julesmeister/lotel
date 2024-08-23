import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future createNewStats(BuildContext context) async {
  List<RoomsRecord>? roomsFire;
  StatsRecord? createStat;

  // reset for loop
  FFAppState().loopCounter = 0;
  FFAppState().roomUsages = [];
  // creating
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        'Creating new stat!',
        style: TextStyle(),
      ),
      duration: Duration(milliseconds: 4000),
      backgroundColor: FlutterFlowTheme.of(context).secondary,
    ),
  );
  // roomsFire
  roomsFire = await queryRoomsRecordOnce(
    queryBuilder: (roomsRecord) => roomsRecord.where(
      'hotel',
      isEqualTo: FFAppState().hotel,
    ),
  );
  while (FFAppState().loopCounter != roomsFire?.length) {
    // new roomUsage then increment loop
    FFAppState().addToRoomUsages(RoomUsageStruct(
      number: roomsFire?[FFAppState().loopCounter]?.number,
      use: 0,
    ));
    // increment
    FFAppState().loopCounter = FFAppState().loopCounter + 1;
  }
  // new stat

  var statsRecordReference = StatsRecord.collection.doc();
  await statsRecordReference.set({
    ...createStatsRecordData(
      hotel: FFAppState().hotel,
      year: functions.currentYear(),
      month: functions.currentMonth(),
      roomsIncome: 0.0,
      goodsIncome: 0.0,
      salaries: 0.0,
      expenses: 0.0,
      days: valueOrDefault<int>(
        functions.daysInTodaysMonth(),
        0,
      ),
      roomLine: updateLineGraphStruct(
        functions.initEmptyLineGraph(),
        clearUnsetFields: false,
        create: true,
      ),
      goodsLine: updateLineGraphStruct(
        functions.initEmptyLineGraph(),
        clearUnsetFields: false,
        create: true,
      ),
      groceryExpenses: 0.0,
      net: 0.0,
    ),
    ...mapToFirestore(
      {
        'roomUsage': getRoomUsageListFirestoreData(
          FFAppState().roomUsages,
        ),
      },
    ),
  });
  createStat = StatsRecord.getDocumentFromData({
    ...createStatsRecordData(
      hotel: FFAppState().hotel,
      year: functions.currentYear(),
      month: functions.currentMonth(),
      roomsIncome: 0.0,
      goodsIncome: 0.0,
      salaries: 0.0,
      expenses: 0.0,
      days: valueOrDefault<int>(
        functions.daysInTodaysMonth(),
        0,
      ),
      roomLine: updateLineGraphStruct(
        functions.initEmptyLineGraph(),
        clearUnsetFields: false,
        create: true,
      ),
      goodsLine: updateLineGraphStruct(
        functions.initEmptyLineGraph(),
        clearUnsetFields: false,
        create: true,
      ),
      groceryExpenses: 0.0,
      net: 0.0,
    ),
    ...mapToFirestore(
      {
        'roomUsage': getRoomUsageListFirestoreData(
          FFAppState().roomUsages,
        ),
      },
    ),
  }, statsRecordReference);
  // save new ref stat
  FFAppState().statsReference = createStat?.reference;
  FFAppState().currentStats = functions.currentMonthYear()!;
}

Future payBalanceOfPending(
  BuildContext context, {
  required BookingsRecord? booking,
}) async {
  TransactionsRecord? pendingTrans;

  // reset counter
  FFAppState().loopCounter = 0;
  while (FFAppState().loopCounter != booking?.pendings?.length) {
    // pendingTrans
    pendingTrans = await TransactionsRecord.getDocumentOnce(
        booking!.pendings[FFAppState().loopCounter]);
    // pay balance of this transaction

    await booking!.pendings[FFAppState().loopCounter].update({
      ...createTransactionsRecordData(
        pending: false,
        description: pendingTrans!.total < 0.0
            ? pendingTrans?.description
            : 'Guest paid the outstanding balance since ${functions.hoursAgo(pendingTrans!.date!)} for ${pendingTrans?.description}',
      ),
      ...mapToFirestore(
        {
          'date': FieldValue.serverTimestamp(),
        },
      ),
    });
    // remove trans from pending in booking

    await booking!.reference.update({
      ...mapToFirestore(
        {
          'pendings': FieldValue.arrayRemove(
              [booking?.pendings?[FFAppState().loopCounter]]),
          'transactions': FieldValue.arrayUnion(
              [booking?.pendings?[FFAppState().loopCounter]]),
        },
      ),
    });
    // increment loop
    FFAppState().loopCounter = FFAppState().loopCounter + 1;
  }
  // paid booking status

  await booking!.reference.update(createBookingsRecordData(
    status: 'paid',
  ));
  // add paid amount to history

  await HistoryRecord.createDoc(booking!.room!).set({
    ...createHistoryRecordData(
      description: 'Guest settled balance.',
      staff: currentUserReference,
      booking: booking?.reference,
    ),
    ...mapToFirestore(
      {
        'date': FieldValue.serverTimestamp(),
      },
    ),
  });
}

Future clearCacheDashboard(BuildContext context) async {}
