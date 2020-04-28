import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:fluttertransport/services/service_method.dart';

class LineChartPage extends StatefulWidget {
  @override
  _LineChartPageState createState() => _LineChartPageState();
}


class _LineChartPageState extends State<LineChartPage> with AutomaticKeepAliveClientMixin{
  Future _futureBuilder;
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  bool showAvg = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _futureBuilder = _getLineChart();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _futureBuilder,
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          var dataMap = snapshot.data;
          return Stack(
            children: <Widget>[
              SizedBox(
                width: 1280,
                height: 720,
                child: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(18),
                      ),
                      color: Color(0xff232d37)),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 18.0, left: 0.0, top: 24, bottom: 12),
                    child: LineChart(
                      showAvg ? dataMap["avgData"] : dataMap["mainData"],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 1280,
                height: 180,
                child: FlatButton(
                  onPressed: () {
                    setState(() {
                      showAvg = !showAvg;
                    });
                  },
                  child: Text(
                    '每日总重量(万吨)',
                    style: TextStyle(
                        fontSize: 36, color: showAvg ? Colors.white.withOpacity(0.5) : Colors.white),
                  ),
                ),
              ),
            ],
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Future _getLineChart() async {
    List data = [];
    var dataMap = {};
    await request("totalWeightByDay", time: "1 week").then((val){
      print(val);
      data = val;
    });
    dataMap["mainData"] = LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          textStyle:
          const TextStyle(color: Color(0xff68737d), fontWeight: FontWeight.bold, fontSize: 16),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return data[0][0];
              case 2:
                return data[1][0].toString().substring(8);
              case 4:
                return data[2][0].toString().substring(8);
              case 6:
                return data[3][0].toString().substring(8);
              case 8:
                return data[4][0].toString().substring(8);
              case 10:
                return data[5][0].toString().substring(8);
              case 11:
                return data[6][0].toString().substring(8);
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '1';
              case 2:
                return '2';
              case 3:
                return '3';
              case 4:
                return '4';
              case 5:
                return '5';
              case 6:
                return '6';
              case 7:
                return '7';
            }
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData:
      FlBorderData(show: true, border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 7,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, data[0][1]/10000),
            FlSpot(2, data[1][1]/10000),
            FlSpot(4, data[2][1]/10000),
            FlSpot(6, data[3][1]/10000),
            FlSpot(8, data[4][1]/10000),
            FlSpot(10,data[5][1]/10000),
            FlSpot(11,data[6][1]/10000),
          ],
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
            dotSize: 5.0,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors: gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
    dataMap["avgData"] = LineChartData(
      lineTouchData: LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          textStyle:
          const TextStyle(color: Color(0xff68737d), fontWeight: FontWeight.bold, fontSize: 16),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return data[0][0];
              case 2:
                return data[1][0].toString().substring(8);
              case 4:
                return data[2][0].toString().substring(8);
              case 6:
                return data[3][0].toString().substring(8);
              case 8:
                return data[4][0].toString().substring(8);
              case 10:
                return data[5][0].toString().substring(8);
              case 11:
                return data[6][0].toString().substring(8);
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '1';
              case 2:
                return '2';
              case 3:
                return '3';
              case 4:
                return '4';
              case 5:
                return '5';
              case 6:
                return '6';
              case 7:
                return '7';
            }
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData:
      FlBorderData(show: true, border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 7,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, data[0][1]/10000),
            FlSpot(2, data[1][1]/10000),
            FlSpot(4, data[2][1]/10000),
            FlSpot(6, data[3][1]/10000),
            FlSpot(8, data[4][1]/10000),
            FlSpot(10,data[5][1]/10000),
            FlSpot(11,data[6][1]/10000),
          ],
          isCurved: true,
          colors: [
            ColorTween(begin: gradientColors[0], end: gradientColors[1]).lerp(0.2),
            ColorTween(begin: gradientColors[0], end: gradientColors[1]).lerp(0.2),
          ],
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(show: true, colors: [
            ColorTween(begin: gradientColors[0], end: gradientColors[1]).lerp(0.2).withOpacity(0.1),
            ColorTween(begin: gradientColors[0], end: gradientColors[1]).lerp(0.2).withOpacity(0.1),
          ]),
        ),
      ],
    );
    return dataMap;
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}