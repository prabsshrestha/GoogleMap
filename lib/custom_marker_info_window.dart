import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarkerInfoWindow extends StatefulWidget {
  const CustomMarkerInfoWindow({super.key});

  @override
  State<CustomMarkerInfoWindow> createState() => _CustomMarkerInfoWindowState();
}

class _CustomMarkerInfoWindowState extends State<CustomMarkerInfoWindow> {


  CustomInfoWindowController _customInfoWindowController = CustomInfoWindowController();

  final List<Marker> _markers = <Marker>[];
  final List<LatLng> _latlng = <LatLng>[
    LatLng(27.6972933,85.3319718),LatLng(27.6970918,85.3315641),LatLng(27.6967985,85.3322135),
    LatLng(27.6972143,85.3323937),LatLng(27.6979012,85.3309945),LatLng(27.6979012,85.3309945)
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() {
    for (int i = 0; i < _latlng.length; i ++) {

      if(i%2 ==0){
        _markers.add(
          Marker(
              markerId: MarkerId(i.toString()),
              icon: BitmapDescriptor.defaultMarker,
              position: _latlng[i],
              onTap: (){
                _customInfoWindowController.addInfoWindow!(
                    Container(
                      height: 300,
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Center(child: CircleAvatar(radius: 30,
                      backgroundColor: Colors.blue),),
                    ),
                    _latlng[i]
                );
              }

          ),);
      }else{
        _markers.add(
          Marker(
              markerId: MarkerId(i.toString()),
              icon: BitmapDescriptor.defaultMarker,
              position: _latlng[i],
              onTap: (){
                _customInfoWindowController.addInfoWindow!(
                    Container(
                      height: 300,
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 100,
                            width: 300,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage('https://images.pexels.com/photos/1566837/pexels-photo-1566837.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
                                  fit:BoxFit.fitWidth,
                                  filterQuality: FilterQuality.high
                              ),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(10)
                              ),
                            ),
                          ),
                          Padding(padding: const EdgeInsets.only(top: 10,left: 10,right: 10),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: Text(
                                    'Pizza Hut',
                                    maxLines: 1,
                                    overflow: TextOverflow.fade,
                                    softWrap: false,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                    '3 mi'
                                )
                              ],
                            ),
                          ),
                          Padding(padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                            child: Text(
                                'Help me finish these pizza!! I got a platter from this Hotel and its to much',
                                maxLines:2
                            ),
                          )

                        ],
                      ),
                    ),
                    _latlng[i]
                );
              }

          ),);
      }

      setState(() {

      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Info Window Example'),
        backgroundColor: Colors.red,
      ),
      body: Stack(
        children: [
          GoogleMap(initialCameraPosition: CameraPosition(
            target: LatLng(27.6972933,85.3319718),
            zoom: 14,
          ),
          markers: Set<Marker>.of(_markers),
            onTap: (position){
            _customInfoWindowController.hideInfoWindow!();
            },
            onCameraMove: (position){
            _customInfoWindowController.onCameraMove!();
            },
            onMapCreated: (GoogleMapController controller){
              _customInfoWindowController.googleMapController = controller;
            },
          ),
          CustomInfoWindow(controller: _customInfoWindowController,
          height: 200,
          width: 250,
          offset: 35,)
        ],
      ),
    );
  }
}
