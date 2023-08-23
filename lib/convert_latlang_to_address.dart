import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class CovertLatLangToAddress extends StatefulWidget {
  const CovertLatLangToAddress({super.key});

  @override
  State<CovertLatLangToAddress> createState() => _CovertLatLangToAddressState();
}

class _CovertLatLangToAddressState extends State<CovertLatLangToAddress> {

  String stAddress = '', stAdd = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GoogleMap'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

            Text(stAddress),
            Text(stAdd),
            GestureDetector(
              onTap: ()async{



                List<Location> locations = await locationFromAddress("Gronausestraat 710, Enschede");
                List<Placemark> placemarks = await placemarkFromCoordinates(52.2165157, 6.9437819);
                // From a query



                //final coordinates = new Coordinates(27.70169,85.3206);


                setState(() {
                      stAddress = locations.last.longitude.toString() + "  " +locations.last.latitude.toString();
                      stAdd = placemarks.reversed.last.country.toString() + "  " + placemarks.reversed.last.locality.toString();
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.teal,
                    
                  ),
                  child: Center(
                    child: Text('Convert',
                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
