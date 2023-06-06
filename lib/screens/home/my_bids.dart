import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:krishak_farma/models/Product.dart';
import 'package:krishak_farma/screens/home/components/addproduct.dart';

class MyBids extends StatefulWidget {
  final String userId;

  const MyBids({super.key, required this.userId});

  @override
  State<MyBids> createState() => _MyBidsState();
}

class _MyBidsState extends State<MyBids> {
  List<Prod> newList = [];

  void getPraticularUserProductData() async {
    List<Prod> products = [];
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final userId = user!.uid;
    print("jhdsbchsd");
    await FirebaseFirestore.instance.collection("products").where('userId', isEqualTo: userId).get().then((value) => {
          value.docs.forEach((element) {
            List prices = [];
            for (var i in element.data()['price']) {
              prices.add(i['price']);
            }

            prices.sort();
            Prod product = Prod(
              price: element.data()['price'],
              prodName: element.data()['Product'],
              maxPrice: prices.length == 0 ? "No One Added Bid" : prices[prices.length - 1],
            );
            products.add(product);
          })
        });
    setState(() {
      newList = products;
    });

    print(products[0].prodName);
    print(products[1].prodName);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPraticularUserProductData();
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final userId = user!.uid;
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bids'),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('BiddingData').snapshots(),
        builder: (context, snapshot) {
          if (newList.length == 0) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final bidDocs = snapshot.data!.docs;
          return ListView.builder(
            itemCount: newList.length,
            itemBuilder: (context, index) {
              final bid = bidDocs[index];
              return ListTile(
                title: Container(
                  height: 65,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 114, 58, 1), borderRadius: BorderRadius.all(Radius.circular(7))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Product Name : " + newList[index].prodName,
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Current Bid : ₹ ${newList[index].maxPrice}",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                //subtitle: Text('Bid Amount: \$${bid['bidAmount']}'),
              );
            },
          );
        },
      ),
    );
  }
}

class Prod {
  List price;
  String prodName;
  String maxPrice;
  Prod({required this.price, required this.prodName, required this.maxPrice});
}
