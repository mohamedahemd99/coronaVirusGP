import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/healthNews/health_model.dart';
import '../model/healthNews/summary_model.dart';

class NewsProvider with ChangeNotifier {
  HealthModel? healthModel;
  SummaryModel? summaryModel;
  List<Countries>? searchModel;

  String url =
      'https://newsapi.org/v2/top-headlines?country=eg&apiKey=7142965a092f4cbe8c27fd750f23d344&category=health';
  String coronaURl = 'https://api.covid19api.com/summary';

  void getHealth() {
    http
        .get(
      Uri.parse(url),
    )
        .then((response) {
      final model = json.decode(response.body);
      healthModel = HealthModel.fromJson(model);
      print(healthModel!.articles![0].title);
      notifyListeners();
    }).catchError((error) {
      print(error);
      notifyListeners();
    });
  }

  void getSummaryCoronaVirus() {
    http.get(
      Uri.parse(coronaURl),
      headers: {"X-Access-Token": "5cf9dfd5-3449-485e-b5ae-70a60e997864"},
    ).then((response) {
      if (response.statusCode == 200) {
        final model = json.decode(response.body);
        summaryModel = SummaryModel.fromJson(model);
        print(summaryModel!.global!.newDeaths);
      } else {
        print(response.statusCode);
      }
      notifyListeners();
    }).catchError((error) {
      print(error);
      notifyListeners();
    });
  }

  void searchCountry(String value) {

      searchModel =
        summaryModel!.countries!.where((element)
        => element.slug!.contains(value)).toList();

    print(searchModel!.length);
    notifyListeners();
  }
}
