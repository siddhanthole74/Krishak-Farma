import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:krishak_farma/screens/home/components/addproduct.dart';
import 'package:krishak_farma/screens/home/components/ecommerceimages.dart';

import '../home/home_screen.dart';

final Stream stream1 = FirebaseFirestore.instance.collection('products').snapshots();

final Stream stream2 = FirebaseFirestore.instance.collection('BiddingData').snapshots();

class PlaceBidScreen extends StatefulWidget {
  static const routeName = "/place-bid-screen";
  final String productId;
  final int index;
  const PlaceBidScreen({super.key, required this.productId, required this.index});

  @override
  State<PlaceBidScreen> createState() => _PlaceBidScreenState();
}

class _PlaceBidScreenState extends State<PlaceBidScreen> {
  GlobalKey<FormFieldState> _formKey = GlobalKey();
  final bidcontroller = TextEditingController();
  final namecontroller = TextEditingController();
  final mobileController = TextEditingController();

  Future postBiddingData(BiddingData user) async {
    final docUser = FirebaseFirestore.instance.collection('BiddingData').doc();
    //user.id=docUser.id;
    final json = user.toJson();
    await docUser.set(json).then(
          (value) => Fluttertoast.showToast(msg: "Product Bidding Added succesfully")
          .then((value) => Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()))),
    );
  }

  updateProductBiddingDetails(String userId) async {
    DocumentReference docRef = FirebaseFirestore.instance.collection('products').doc(widget.productId);

    DocumentSnapshot doc = await docRef.get();

    List price = doc['price'];
    docRef.update({
      'price': FieldValue.arrayUnion([
        {'price': bidcontroller.text, 'userId': userId}
      ])
    });
  }

  Future<void> updateFarmersDatabase() async {
    DocumentReference docRef = FirebaseFirestore.instance.collection('products').doc(widget.productId);

    DocumentSnapshot doc = await docRef.get();

    List price = doc['price'];
    docRef.update({
      'price': FieldValue.arrayUnion([
        {'price': 123, 'userId': ""}
      ])
    });
  }

  // Future<void> updateArrayAndShowLargestElement(
  //     Function(dynamic) showLargestElement) async {
  //   List<dynamic> sortedArray = List.from(price)
  //     ..sort((a, b) => b.compareTo(a));
  //   var largestElement = sortedArray[0];
  //   showLargestElement(largestElement);
  // }

  final startDateTime = DateTime.now();
  DateTime endDateTime = DateTime(2023, 4, 10, 10, 0, 0);
  late Timer _timer;
  Duration _duration = Duration();
  late StreamSubscription<DocumentSnapshot> _subscription;
  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), _updateCountdown);
    DateFormat inputFormat = DateFormat('dd-MM-yyyy hh:mm a');
    _subscription =
        FirebaseFirestore.instance.collection('products').doc(widget.productId).snapshots().listen((snapshot) {
          if (snapshot.exists) {
            // Update endDateTime whenever the data changes
            endDateTime = inputFormat.parse(
              "${snapshot['End_Biding_Date']} ${snapshot['End_time']}",
            );

            // Call _updateCountdown with the new value of endDateTime
            _updateCountdown(_timer);

            setState(() {}); // Update the widget once when the data changes
          }
        });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _updateCountdown(Timer timer) {
    setState(() {
      final now = DateTime.now();
      print(now.isAfter(endDateTime));
      print(endDateTime);
      print(now);
      if (now.isAfter(endDateTime)) {
        _duration = const Duration();
        _timer.cancel();
        print("Sahil");
      } else {
        _duration = endDateTime.difference(now);
        print("jnfkjnjf " + _duration.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final userId = user!.uid;
    var now = DateTime.now();
    var Dateformatter = DateFormat('yyyy-MM-dd');
    var timeFormatter = DateFormat("KK:mm a");
    DateFormat inputFormat = DateFormat('dd-MM-yyyy hh:mm a');
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            endDateTime = inputFormat.parse(
                "${snapshot.data?.docs[widget.index]['End_Biding_Date']} ${snapshot.data?.docs[widget.index]['End_time']}");
            var temp = snapshot.data?.docs[widget.index]['price'];

            List prices = [];
            for (var i in temp) {
              prices.add(i['price']);
              print(i['price'].runtimeType);
            }
            print("sjhfsf");
            print("end bidding time;" + endDateTime.toString());
            print("start bidding time;" + startDateTime.toString());
            print(endDateTime.difference(startDateTime));
            prices.sort();

            if (endDateTime.difference(startDateTime) <= Duration.zero) {
              var Prices_By_Dealers = snapshot.data?.docs[widget.index]['price'];
              var Product_By_Farmer = snapshot.data?.docs[widget.index]['userId'];
              var Farmer_Location = snapshot.data?.docs[widget.index]['Location'];
              var Farmer_Product = snapshot.data?.docs[widget.index]['Product'];
              var Farmer_Product_Quntity = snapshot.data?.docs[widget.index]['Quantity in KG'];
              var Farmer_Name = snapshot.data?.docs[widget.index]['name'];
              var Farmer_Product_images = snapshot.data?.docs[widget.index]['images'];
              FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
              Map<String, dynamic> toMap() {
                return {
                  'Prices_By_Dealers': Prices_By_Dealers,
                  'Farmers_details': Product_By_Farmer,
                  'Farmer_Lacation': Farmer_Location,
                  'Farmer_Produt': Farmer_Product,
                  'Farmer_Product_Quantity': Farmer_Product_Quntity,
                  'Farmer_Name': Farmer_Name,
                  'Farmer_Product_Images': Farmer_Product_images
                };
              }

              firebaseFirestore.collection("Time_Over").doc(user.uid).set(toMap());
            }

            return Scaffold(
              body: endDateTime.difference(startDateTime) <= Duration.zero
                  ? Scaffold(
                body: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: double.infinity,
                        // color: Colors.black,
                        child: Center(
                            child: Text("Bidding for the choosen product is Ended",
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500))),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const SizedBox(
                        width: double.infinity,
                        // color: Colors.black,
                        child: Center(
                            child: Text("Please try another product",
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500))),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: Color.fromRGBO(255, 114, 58, 1)),
                        child: const Text('Go to Flash Deal'),
                      )
                    ],
                  ),
                ),
              )
                  : SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Center(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        const Text('Time Remaining for Bidding'),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(9),
                                color: const Color.fromRGBO(255, 110, 64, 1),
                              ),
                              child: Center(
                                  child: Text(
                                    "${_duration.inDays}d",
                                    style:
                                    const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 17),
                                  )),
                            ),
                            // const SizedBox(
                            //   width: ,
                            // ),
                            const Text(
                              " : ",
                              style: TextStyle(fontSize: 30),
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(9),
                                color: const Color.fromRGBO(255, 110, 64, 1),
                              ),
                              child: Center(
                                  child: Text(
                                    "${_duration.inHours.remainder(24)}h",
                                    style:
                                    const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 17),
                                  )),
                            ),
                            const Text(
                              " : ",
                              style: TextStyle(fontSize: 30),
                            ),
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(9),
                                color: const Color.fromRGBO(255, 110, 64, 1),
                              ),
                              child: Center(
                                  child: Text(
                                    "${_duration.inMinutes.remainder(60)}m",
                                    style:
                                    const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 17),
                                  )),
                            ),
                            const Text(
                              " : ",
                              style: TextStyle(fontSize: 30),
                            ),
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(9),
                                color: const Color.fromRGBO(255, 110, 64, 1),
                              ),
                              child: Center(
                                child: Text(
                                  "${_duration.inSeconds.remainder(60)}s",
                                  style:
                                  const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 17),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        prices.length == 0
                            ? Text(
                          "Be the first to Bid on this product",
                        )
                            : Text(
                          "Current Bidding Price : ₹${prices[prices.length - 1]} per kg",
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: TextField(
                            controller: bidcontroller,
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            decoration: const InputDecoration(
                              labelText: 'Enter your bidding price (per kg)',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: TextField(
                            controller: namecontroller,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              labelText: 'Enter your name',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: TextFormField(
                            key: _formKey,
                            controller: mobileController,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              labelText: 'Enter your Mobile Number',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null) {
                                return "Please Enter your mobile number";
                              }
                              if (value.length != 10) {
                                return "Please enter a valid mobile number";
                              }

                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                postBiddingData(
                                  BiddingData(
                                      biddingPrice: bidcontroller.text,
                                      userId: userId,
                                      biddingDate: Dateformatter.format(now).toString(),
                                      productId: widget.productId,
                                      biddingTime: timeFormatter.format(now).toString(),
                                      mobileNo: mobileController.text,
                                      name: namecontroller.text),
                                );

                                updateProductBiddingDetails(userId);
                              }
                            },
                            style: ElevatedButton.styleFrom(backgroundColor: Color.fromRGBO(255, 114, 58, 1)),
                            child: const Text('Place Bid'),
                          ),
                        )
                      ],
                    )),
              ),
            );
          } else {
            return Skeleton(
              height: 20,
              width: 30,
            );
          }
        });
  }
}

class BiddingData {
  String userId;
  String biddingDate;
  String biddingTime;
  String productId;
  String biddingPrice;
  String mobileNo;
  String name;

  BiddingData({
    required this.biddingPrice,
    required this.userId,
    required this.biddingDate,
    required this.productId,
    required this.biddingTime,
    required this.mobileNo,
    required this.name,
  });

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'biddingDate': biddingDate,
    'biddingTime': biddingTime,
    'productId': productId,
    'biddingPrice': biddingPrice,
    'mobileNo': mobileNo,
    'name': name,
  };
}
