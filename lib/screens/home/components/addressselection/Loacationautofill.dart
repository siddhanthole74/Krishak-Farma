import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:krishak_farma/screens/home/components/addproduct.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:krishak_farma/screens/home/components/addressselection/autocomplete_prediction.dart';
import 'package:krishak_farma/screens/home/components/addressselection/placeautocompleteresponse.dart';
import 'package:uuid/uuid.dart';
import 'network_utility.dart';
import 'package:http/http.dart' as http;

class Locationautofill extends StatefulWidget {
  @override
  _LocationautofillState createState() => _LocationautofillState();
}

class _LocationautofillState extends State<Locationautofill> {
  TextEditingController _searchController = TextEditingController();
  var uuid = Uuid();
  String sessionToken = "12345";
  String apiKey = "AIzaSyA0YP0uj7CM8wISZLQ3z-BluBG-f30PnBo";
  List<dynamic> placesList = [];

  late Map<String, dynamic> mp;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      onChange();
    });
  }

  void onChange() {
    if (sessionToken == null) {
      sessionToken = uuid.v4();
    }

    getSuggetions(_searchController.text);
  }

  void getSuggetions(String input) async {
    String baseUrl =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json";
    String request =
        '$baseUrl?input=$input&key=$apiKey&sessiontoken=$sessionToken';

    var response = await http.get(Uri.parse(request));

    var data = response.body.toString();
    placesList.clear();

    // print(data);
    if (response.statusCode == 200) {
      setState(() {
        mp = jsonDecode(response.body.toString());
        placesList.addAll(mp.values.first);
      });
    } else {
      throw Exception("Failed to load data");
    }

    print(placesList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Enter your location"),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            margin: EdgeInsets.only(top: 16),
            child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Enter your location",
                  prefixIcon: Icon(
                    Icons.location_on_outlined,
                    color: Colors.deepOrangeAccent,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                // onChanged: (value){
                //   placeAutocomplete(value);
                // },
                onEditingComplete: () {
                  // String value="default";
                  // value=_searchController.text;
                  //
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AddProduct(txt: _searchController.text)));
                  //
                }),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: placesList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(placesList[index]['description'].toString()),
                  onTap: () {
                    _searchController.text = placesList[index]['description'];
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
