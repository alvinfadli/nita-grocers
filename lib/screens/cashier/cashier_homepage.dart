import 'dart:math';
import 'package:flutter/material.dart';
import 'package:nita_grocers/screens/cashier/cashier_history.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'list_product.dart';
import '../widgets/bottom_navigation.dart';

class cashierHomepage extends StatefulWidget {
  const cashierHomepage({Key? key}) : super(key: key);
  @override
  _CashierHomepageState createState() => _CashierHomepageState();
}

class LineChartWidget extends StatelessWidget {
  final List<charts.Series<num, int>> seriesList;
  final bool animate;

  LineChartWidget(this.seriesList, {required this.animate});

  @override
  Widget build(BuildContext context) {
    return charts.LineChart(
      seriesList,
      animate: animate,
      defaultRenderer: charts.LineRendererConfig(
        includeArea: true,
        stacked: false,
      ),
      primaryMeasureAxis: charts.NumericAxisSpec(
        tickProviderSpec: charts.BasicNumericTickProviderSpec(
          desiredTickCount: 5,
        ),
      ),
    );
  }
}

class _CashierHomepageState extends State<cashierHomepage> {
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => _widgetOptions[index]()),
    );
  }

  int _selectedIndex = 0;
  static List<Widget Function()> _widgetOptions = <Widget Function()>[
    () => const cashierHomepage(),
    () => const CashierListProduct(),
    () => const CashierHistoryPage(),
  ];

  @override
  void initState() {
    super.initState();
  }
  //   return data;
  // }

  @override
  Widget build(BuildContext context) {
    final data = [
      {'x': 0, 'y': 5},
      {'x': 1, 'y': 10},
      {'x': 2, 'y': 15},
      {'x': 3, 'y': 12},
      {'x': 4, 'y': 8},
    ];

    final series = [
      charts.Series<num, int>(
        id: 'Line Chart',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (num point, _) => point.toInt(),
        measureFn: (num point, _) => point.toDouble(),
        data: data.map((point) => point['y'] as num).toList(),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Nita Grocers'),
        backgroundColor: Color.fromARGB(255, 124, 181, 24),
      ),
      body: ListView(
        shrinkWrap: true,
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Grafik Penjualan Bulanan',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Container(
                  height: 200,
                  //child: buildLineChart(generateChartData()),
                  child: LineChartWidget(series, animate: true),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Penjualan Hari Ini',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Container(
                  height: 200,
                  color: Colors.white,
                  child: Center(
                    child: Text(
                      'Container 2',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Produk Terlaris',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Container(
                  height: 200,
                  color: Colors.white,
                  child: Center(
                    child: Text(
                      'Container 3',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigation(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final DateTime year;
  final double sales;
}
