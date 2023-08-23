
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class CustomMarkScreen extends StatefulWidget {
  const CustomMarkScreen({super.key});

  @override
  State<CustomMarkScreen> createState() => _CustomMarkScreenState();
}

class _CustomMarkScreenState extends State<CustomMarkScreen> {

  final Completer<GoogleMapController> _controller = Completer();

  Uint8List? markerImage;

  List<String> images = ['assets/images/car.png','assets/images/car2.png','assets/images/marker2.png',
    'assets/images/marker3.png','assets/images/marker.png','assets/images/motorcycle.png',];
  
  final List<Marker> _markers = <Marker>[

  ];
  final List<LatLng> _latlng = <LatLng>[
    LatLng(27.6972933,85.3319718),LatLng(27.6970918,85.3315641),LatLng(27.6967985,85.3322135),
    LatLng(27.6972143,85.3323937),LatLng(27.6979012,85.3309945),LatLng(27.6979012,85.3309945)
  ];

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(27.6972933,85.3319718),
    zoom: 15,
  );

  Future<Uint8List> getBytesFromAssets(String path, int width)async{
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return(await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadData();
  }

  loadData() async{
    for(int i =0 ;i< images.length ; i++){

      final Uint8List markerIcon = await getBytesFromAssets(images[i], 100);

      _markers.add(
        Marker(markerId: MarkerId(i.toString()),
        icon: BitmapDescriptor.fromBytes(markerIcon),
        position: _latlng[i],
        infoWindow: InfoWindow(
          title: 'This is title marker:' +i.toString()
        )),

      );
      setState(() {

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _kGooglePlex,
          mapType: MapType.normal,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          markers: Set<Marker>.of(_markers),
          onMapCreated: (GoogleMapController controller){
              _controller.complete(controller);
          },
        ),
      ),
    );
  }
}
