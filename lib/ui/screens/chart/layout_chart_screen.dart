import '../../../constants.dart';
import 'package:flutter/material.dart';

import 'app_chart_screen.dart';
import 'corona_chart_screen.dart';

class ChartScreen extends StatefulWidget {
  const ChartScreen({Key? key}) : super(key: key);

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Challenge",
              style: TextStyle(color: Colors.black)),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          bottom: const TabBar(
            indicatorColor: Colors.black45,
            tabs: [
              Tab(
                  icon: Icon(
                    Icons.group_outlined,
                    color: mainColor,
                  )),
              Tab(
                  icon: Icon(
                    Icons.coronavirus_outlined,
                    color: mainColor,
                  )),
            ],
          ),
        ),
        body:  const TabBarView(
          children: [
            AppChartScreen(),
            CoronaChartScreen(),
          ],
        ),
      ),
    );
  }
}
