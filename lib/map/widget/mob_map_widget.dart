import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:invasivex/map/utils/constants.dart';

import 'map_widget.dart';
import 'new_pin_listener.dart';

MapWidget getMapWidget({required NewPinListener listener}) => MobileMap(listener: listener,);

class MobileMap extends StatefulWidget implements MapWidget {
  final NewPinListener listener;
  const MobileMap({Key? key, required this.listener}) : super(key: key);


  @override
  State<MobileMap> createState() => MobileMapState();
}

class MobileMapState extends State<MobileMap> {
  final Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> markers = <Marker>{};

  static const CameraPosition _kFalentexHouse = CameraPosition(target: defaultLatLng, zoom: defaultZoomLevel);

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.hybrid,
      initialCameraPosition: _kFalentexHouse,
      markers: markers,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
      onLongPress: (latLng) {
        setState(() {
          // This adds a marker to the map!
          // Note the "MarkerId". What do you think that is for?
          // What happens if we add more than one pin to the map?
          markers.add(Marker(markerId: MarkerId("temp_marker"), position: latLng,));
          widget.listener(latLng.latitude, latLng.longitude);
          // Move the camera around!
          _controller.future.then((value) => value.animateCamera(CameraUpdate.newLatLng(latLng)));
        });
      },
    );
  }
}
