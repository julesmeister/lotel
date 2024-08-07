// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:pie_chart/pie_chart.dart';

class GroceryProfitability extends StatefulWidget {
  const GroceryProfitability({
    Key? key,
    this.width,
    this.height,
    required this.grocery,
    required this.revenue,
  }) : super(key: key);

  final double? width;
  final double? height;
  final double grocery;
  final double revenue;

  @override
  _GroceryProfitabilityState createState() => _GroceryProfitabilityState();
}

class _GroceryProfitabilityState extends State<GroceryProfitability> {
  Map<String, double>? dataMap;
  List<List<Color>>? gradientList;

  @override
  void initState() {
    super.initState();
    updateChartData();
  }

  @override
  void didUpdateWidget(covariant GroceryProfitability oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.grocery != widget.grocery ||
        oldWidget.revenue != widget.revenue) {
      updateChartData();
    }
  }

  void updateChartData() {
    String formatCurrency(double value) {
      return NumberFormat.currency(
        symbol: 'Php ',
        decimalDigits: 2,
      ).format(value);
    }

    dataMap = <String, double>{
      "Grocery ${formatCurrency(widget.grocery)}": widget.grocery,
      "Revenue": widget.revenue,
    };

    gradientList = <List<Color>>[
      [
        Color.fromRGBO(223, 250, 92, 1),
        Color.fromRGBO(129, 250, 112, 1),
      ],
      [
        Color.fromRGBO(129, 182, 205, 1),
        Color.fromRGBO(91, 253, 199, 1),
      ],
    ];
  }

  @override
  Widget build(BuildContext context) {
    if (dataMap == null || gradientList == null) {
      // Return a loading state or an empty container until data is ready
      return Container();
    }
    return PieChart(
      dataMap: dataMap!,
      animationDuration: Duration(milliseconds: 800),
      chartLegendSpacing: 32,
      chartRadius: MediaQuery.of(context).size.width / 1.2,
      gradientList: gradientList!,
      initialAngleInDegree: 0,
      ringStrokeWidth: 32,
      legendOptions: LegendOptions(
        showLegendsInRow: false,
        legendPosition: LegendPosition.bottom,
        showLegends: true,
        legendTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      chartValuesOptions: ChartValuesOptions(
        showChartValueBackground: true,
        showChartValues: true,
        showChartValuesInPercentage: true,
        showChartValuesOutside: false,
        decimalPlaces: 0,
      ),
      // gradientList: ---To add gradient colors---
      // emptyColorGradient: ---Empty Color gradient---
    );
  }
}
