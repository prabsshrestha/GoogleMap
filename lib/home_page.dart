import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(27.6974,85.3318),
    zoom: 14.4746,
  );

  List<Marker> _marker = [];
  final List<Marker> _list = const [
    Marker(markerId: MarkerId('1'),
     position: LatLng(27.6974,85.3318),
      infoWindow: InfoWindow(
        title: 'My Current Location'
      )
    ),
    Marker(markerId: MarkerId('2'),
        position: LatLng(27.6975906,85.3320997),
        infoWindow: InfoWindow(
            title: 'Aaglo Restro'
        )
    ),
    Marker(markerId: MarkerId('3'),
        position: LatLng(27.6976504,85.3323024),
        infoWindow: InfoWindow(
            title: 'Girls Hostel'
        )
    ),
    Marker(markerId: MarkerId('1'),
        position: LatLng(28.050708,82.406394),
        infoWindow: InfoWindow(
            title: 'Ghorahi, Dang'
        )
    ),

  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _marker.addAll(_list);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: GoogleMap(
            initialCameraPosition: _kGooglePlex,
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            compassEnabled: true,
            markers: Set<Marker>.of(_marker),
            onMapCreated: (GoogleMapController controller){
              _controller.complete(controller);
            },
          ),
        ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.location_searching_sharp),
        onPressed: ()async{
          GoogleMapController controller = await _controller.future;
          controller.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: LatLng(27.6974,85.3318),
              zoom: 14,
            ),
          ));
          setState(() {

          });
        },
      ),
    );
  }
}
