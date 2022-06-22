import '../../../constants.dart';
import '../../../core/business_logic/news_provider.dart';
import '../../../core/model/healthNews/summary_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CoronaChartScreen extends StatefulWidget {
  const CoronaChartScreen({Key? key}) : super(key: key);

  @override
  State<CoronaChartScreen> createState() => _CoronaChartScreenState();
}

class _CoronaChartScreenState extends State<CoronaChartScreen> {
  TextEditingController searchCr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SummaryModel model = Provider.of<NewsProvider>(context).summaryModel!;
    if (model != null) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextFormField(
                controller: searchCr,
                onChanged: (value) =>
                    Provider.of<NewsProvider>(context, listen: false)
                        .searchCountry(value),
              ),
              free,
              Expanded(
                child: SingleChildScrollView(
                  child: searchCr.text.isEmpty
                      ? Column(
                          children: [
                            const Text("Global",
                                style: TextStyle(fontSize: 20)),
                            free,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                buildGlobalCoronaCircle(
                                    count: model.global!.newConfirmed,
                                    title: "New Confirmed"),
                                buildGlobalCoronaCircle(
                                    count: model.global!.totalConfirmed,
                                    title: "Total Confirmed"),
                              ],
                            ),
                            free,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                buildGlobalCoronaCircle(
                                    count: model.global!.newDeaths,
                                    title: "New Deaths"),
                                buildGlobalCoronaCircle(
                                    count: model.global!.totalDeaths,
                                    title: "Total Deaths"),
                              ],
                            ),
                            free,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                buildGlobalCoronaCircle(
                                    count: model.global!.newRecovered,
                                    title: "NewRecovered"),
                                buildGlobalCoronaCircle(
                                    count: model.global!.totalRecovered,
                                    title: "TotalRecovered"),
                              ],
                            ),
                          ],
                        )
                      : ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) =>
                              buildCountryDataBlock(
                                  Provider.of<NewsProvider>(context)
                                      .searchModel![index]),
                          separatorBuilder: (context, index) => SizedBox(
                              height: 20,
                              child: Divider(height: 2, thickness: 5)),
                          itemCount: Provider.of<NewsProvider>(context)
                              .searchModel!
                              .length),
                ),
              )
            ],
          ),
        ),
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}

Widget buildGlobalCoronaCircle({String? title, int? count}) {
  return CircleAvatar(
    foregroundColor: Colors.white,
    backgroundColor: mainColor,
    radius: 75,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title!, style: TextStyle(fontWeight: FontWeight.bold)),
        free,
        Text("$count"),
      ],
    ),
  );
}

Widget buildCountryDataBlock(Countries model) {
  return Column(
    children: [
      free,
      Text(model.slug!.toUpperCase(), style: TextStyle(fontSize: 20)),
      free,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildGlobalCoronaCircle(
              count: model.newConfirmed, title: "New Confirmed"),
          buildGlobalCoronaCircle(
              count: model.totalConfirmed, title: "Total Confirmed"),
        ],
      ),
      free,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildGlobalCoronaCircle(count: model.newDeaths, title: "New Deaths"),
          buildGlobalCoronaCircle(
              count: model.totalDeaths, title: "Total Deaths"),
        ],
      ),
      free,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildGlobalCoronaCircle(
              count: model.newRecovered, title: "NewRecovered"),
          buildGlobalCoronaCircle(
              count: model.totalRecovered, title: "TotalRecovered"),
        ],
      ),
    ],
  );
}
