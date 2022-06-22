import 'package:covid_infected_helper/core/business_logic/map_provider.dart';
import 'package:flutter/material.dart';
// import 'package:geocoder/geocoder.dart';
// import 'package:geocoder/model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  MapScreen({this.currentLocation});

  LatLng? currentLocation;

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? pos1;
  String? address1;
  LatLng? currentPossition;

  // getAddressLocation(Coordinates pos1) async {
  //   var addresses = await Geocoder.local.findAddressesFromCoordinates(pos1);
  //   var first = addresses.first;
  //   return "${first.addressLine}";
  // }

  @override
  void initState() {
    super.initState();
// Provider.of(context)
    currentPossition = widget.currentLocation;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
            target: currentPossition != null
                ? currentPossition!
                : LatLng(31.025222515, 31.006656),
            zoom: 5.0),
        onMapCreated: (c){
          setState(() {

          });

        },
        zoomControlsEnabled: false,
        markers: Provider.of<MapProvider>(context,listen: false).markers!,
      ),
    );
  }
}
