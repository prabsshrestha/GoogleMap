import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class GooglePlaceApiScreen extends StatefulWidget {
  const GooglePlaceApiScreen({super.key});

  @override
  State<GooglePlaceApiScreen> createState() => _GooglePlaceApiScreenState();
}

class _GooglePlaceApiScreenState extends State<GooglePlaceApiScreen> {

  TextEditingController _controller = TextEditingController();
  var uuid = Uuid();
  String _sessionToken = '12345';
  List<dynamic> _placesList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller.addListener(() {
      onChange();
    });
  }

  void onChange(){
    if(_sessionToken == null){
      setState(() {
        _sessionToken == uuid.v4();
      });
    }
    getSuggesstion(_controller.text);
  }

  void getSuggesstion(String input)async{
    String kPLACES_API_KEY = "AIzaSyBGPSaQRli7q_8Mqq3S9mNkTcqZ3S1-Ues";
    String baseURL ='https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request = '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken';

    var response = await http.get(Uri.parse(request));
    var data = response.body.toString();



    print('data');
    print(data);

    if(response.statusCode == 200){

      setState(() {
        _placesList = jsonDecode(response.body.toString())['predictions'];
      });

    }else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Search Places Api'),
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Search places with name'
                ),
              ),
            Expanded(
                child: ListView.builder(
                    itemCount: _placesList.length,
                    itemBuilder: (context, index){
                      return ListTile(
                        onTap: ()async{
                          List<Location> locations = await locationFromAddress(_placesList[index]['description']);

                          print(locations.last.longitude);
                          print(locations.last.latitude);
                        },
                        title: Text(_placesList[index]['description']),
                      );
                    })
                )
          ],
        ),
      ),
    );
  }
}
