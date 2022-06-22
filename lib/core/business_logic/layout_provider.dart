import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_infected_helper/core/model/masks_model.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../ui/screens/Home/home.dart';
import '../../ui/screens/chart/layout_chart_screen.dart';
import '../../ui/screens/map/map_screen.dart';
import '../../ui/screens/news/news_screen.dart';
import '../model/healthNews/health_model.dart';
import '../utilities/dio_helper.dart';

class LayOutProvider with ChangeNotifier {
  int currentIndex = 0;
  List<MasksModel> masks=[];
  List<Widget> screens = [
    HomeScreen(),
     const NewsScreen(),
    const ChartScreen(),
     MapScreen(currentLocation: const LatLng( 30.0444,31.2357 )),
  ];

  HealthModel? healthModel;

  void changeIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  void getHealth() {
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'health',
      'apiKey': '7142965a092f4cbe8c27fd750f23d344'
    }).then((value) {
      healthModel = value.data['articles'];
      print(healthModel!.articles![0].content);
      notifyListeners();
    }).catchError((error) {
      print(error.toString());
      notifyListeners();
    });
  }


  void getAllMasksType() {
    FirebaseFirestore.instance.collection("masks").snapshots().listen((event) {
      masks = [];
      event.docs.forEach((user) {
        masks.add(MasksModel.fromJson(user.data() as Map<String, dynamic>));
        notifyListeners();
      });

      print(masks.length);
      print(masks[0].desc);
      print(masks[0].title);
      print(masks[0].image);
    });
  }


}
