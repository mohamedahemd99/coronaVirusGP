import 'package:covid_infected_helper/core/business_logic/map_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AppChartScreen extends StatefulWidget {
  const AppChartScreen({Key? key}) : super(key: key);

  @override
  State<AppChartScreen> createState() => _AppChartScreenState();
}

class _AppChartScreenState extends State<AppChartScreen> {
  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<MapProvider>(context);
    return Scaffold(
      body: Center(
        child: Container(
          child: SfCartesianChart(
              // Initialize category axis
              primaryXAxis: CategoryAxis(),
              series: <ChartSeries<SalesData, String>>[
                ColumnSeries<SalesData, String>(
                  borderRadius: BorderRadius.circular(5),
                  spacing: 2,

                  // Bind data source
                  dataSource: <SalesData>[
                    SalesData('Corona', provider.coronaUsers),
                    SalesData('Non Corona', provider.nonCoronaUsers),
                    SalesData('Sub Corona', provider.subCoronaUsers ),
                  ],
                  xValueMapper: (SalesData sales, _) => sales.status,
                  yValueMapper: (SalesData sales, _) => sales.counter,

                  animationDuration: 2000,
                ),
              ]),
        ),
      ),
    );
  }
}

class SalesData {
  SalesData(this.status, this.counter);

  final String status;
  final int counter;
}
