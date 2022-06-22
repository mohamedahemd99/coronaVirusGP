import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_infected_helper/core/model/vaccine_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapProvider with ChangeNotifier {
  List<VaccineUser> users = [];
int coronaUsers=0;
int nonCoronaUsers=0;
int subCoronaUsers=0;
  void getAllUsers() {
    FirebaseFirestore.instance.collection("users").snapshots().listen((event) {
      users = [];
      event.docs.forEach((user) {
        users.add(VaccineUser.fromJson(user.data() as Map<String, dynamic>));
        notifyListeners();
      });
      getAllMakers(users);

      print(users.length);
    });
  }

  Set<Marker>? markers = {};

  void getAllMakers(List<VaccineUser> users2) {
    coronaUsers=0;
    nonCoronaUsers=0;
    subCoronaUsers=0;
    markers = {};
    users2.forEach((e) {
      if (e.status == "Corona") {
        coronaUsers++;
        Marker m = Marker(
          markerId: MarkerId("${e.uid}"),
          position: LatLng(double.parse(e.lat!), double.parse(e.lang!)),
        );
        markers!.add(m);
      }
      else if(e.status == "subCoronaUsers") {
        subCoronaUsers++;
      }
      else {
        nonCoronaUsers++;
      }

      notifyListeners();
      print(e);
    });
    print(markers);
    notifyListeners();
  }

  Position ?currentLocation;

  void determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }

    currentLocation= await Geolocator.getCurrentPosition();
    print(currentLocation!.latitude);
    notifyListeners();
  }



}
