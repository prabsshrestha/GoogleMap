import 'dart:async';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolygoneScreenState extends StatefulWidget {
  const PolygoneScreenState({super.key});

  @override
  State<PolygoneScreenState> createState() => _PolygoneScreenStateState();
}

class _PolygoneScreenStateState extends State<PolygoneScreenState> {

  Completer<GoogleMapController> _controller = Completer();

  CameraPosition _kGoolePlex = CameraPosition(target: LatLng(27.6972933,85.3319718),
  zoom: 14);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Polygone')
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGoolePlex,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      ),
    );
  }
}
