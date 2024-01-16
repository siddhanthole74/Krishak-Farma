import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:krishak_farma/screens/home/components/addressselection/Loacationautofill.dart';
import 'package:krishak_farma/screens/home/components/addressselection/network_utility.dart';
import 'package:krishak_farma/screens/home/components/addressselection/getCurrentLocation.dart';
import 'package:krishak_farma/screens/home/home_screen.dart';
import 'package:image_picker/image_picker.dart';
import '../../../components/custom_surfix_icon.dart';
import '../../../models/add_date.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddProduct extends StatefulWidget {
  var txt = "select location Press icon";
  static String routeName = "/addproduct";

  AddProduct({Key? key, required this.txt}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final controllerName = TextEditingController();
  final controllerProduct = TextEditingController();
  final controllerQuantity = TextEditingController();
  final controllerMobileNo = TextEditingController();
  final controllerLocation = TextEditingController();
  final controllerDealDate = TextEditingController();
  // DateTime startBidingDate = new DateTime.now();
  // DateTime endBidingDate = new DateTime.now();

  String startBidingDate = "";
  String endBidingDate = "";
  TimeOfDay startTime = new TimeOfDay.now();
  TimeOfDay endTime = new TimeOfDay.now();
  var myDateFormat = DateFormat('d-MM-yyyy');

  final box = Hive.box<Add_data>('data');
  DateTime date = new DateTime.now();
  String? selctedItem;
  String? selctedItemi;

  final TextEditingController expalin_C = TextEditingController();
  FocusNode ex = FocusNode();
  final TextEditingController amount_c = TextEditingController();
  FocusNode amount_ = FocusNode();
  final List<String> _item = [
    "Apple",
    "Banana",
    "Grapes",
    "Orange",
    "Cotton",
    "Brinjal",
    "Wheat",
    "Corn",
    "Lady_Finger",
    "Gram",
    "Peanut",
    "Soyabin",
    "Cabbage",
    "Marigold",
    "Mogara",
    "Onion",
    "Garlic",
    "Carrot",
    "Tomato",
    "Raddish",
    "Sapodila",
    "Sugarcan",
    "Patato",
    "Ginger",
    "Mustard",
    "Coriander",
    "Caulflower",
    "Shepu",
    "Fenugreek",
    "Ambadi",
    "BitterGaurd",
    "DrumStick",
    "Chawali",
    "Masoor",
    "Moong",
    "Mataki",
    "Pea",
    "Ailanthus",
    "Allspice",
    "Almond",
    "Alovera",
    "Antherium",
    "Arecanut",
    "AshGourd",
    "Ashwagandha",
    "Beans",
    "Beatroot",
    "BengalGram",
    "Ber",
    "Betelvine",
    "Bajra",
    "Brocali",
    "BlackGram",
    "BottleGourd",
    "Capsicum",
    "Mango",
    "Cardamom",
    "CashewNut",
    "Champak",
    "Chive",
    "Cinnamon",
    "CitronellaGrass",
    "Colve",
    "Cocoa",
    "Coconut",
    "Coffee",
    "Coleus",
    "Cowpea",
    "Cucumber",
    "Cumin",
    "CurryLeaves",
    "Rose",
    "Daylily",
    "Dill",
    "DragonFruit",
    "Fig",
    "FoxTailMillet",
    "FrenchBean",
    "Guava",
    "Jackfruit",
    "Jasmine",
    "Lemon",
    "Mint",
    "PearlMillet",
    "Pomegranate",
    "Pumpkin",
    "Rice",
    "Rubber",
    "Sunflower",
    "Strawbery",
    "Tamarind",
    "Tea",
    "Termeric",
    "Watermelon",
    "Vanila",
    "Walnut"
  ];
  // List<PlacesSearchResult> searchResults = [];
  // late PlacesAutocompleteResponse autocompleteResponse;
  // late GoogleMapController mapController;
  String apiKey = "AIzaSyA0YP0uj7CM8wISZLQ3z-BluBG-f30PnBo";

  final List<String> _itemei = [
    'Income',
    "Expand",
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ex.addListener(() {
      setState(() {});
    });
    amount_.addListener(() {
      setState(() {});
    });
    controllerLocation.addListener(() {
      if (controllerLocation.text.isEmpty) {
        setState(() {
          // searchResults = [];
        });
        return;
      }

      // getAutocomplete();
    });
  }

  void onMapCreated(GoogleMapController controller) {
    // mapController = controller;
  }

  // Future<void> getAutocomplete() async {
  //   final places = new GoogleMapsPlaces(apiKey: "YOUR_API_KEY");
  //   PlacesAutocompleteResponse response = await places.autocomplete(
  //     controllerLocation.text,
  //     types: ['(cities)'],
  //   );
  //   if (response.isOkay) {
  //     setState(() {
  //       autocompleteResponse = response;
  //       // searchResults = response.result;
  //     });
  //   } else {
  //     print('Error: ${response.errorMessage}');
  //   }
  // }

  Future<void> placeAutocomplete(String query) async {
    Uri uri =
        Uri.http("maps.googleapis.com", "maps/api/place/autocomplete/json", {
      "input": query,
      "key": apiKey,
    });

    String? response = await Networkutility.fetchUrl(uri);
    if (response != null) {
      print(response);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            background_container(context),
            Positioned(
              top: 120,
              left: 0,
              right: 0,
              bottom: 0,
              child: SingleChildScrollView(child: main_container()),
            ),
          ],
        ),
      ),
    );
  }

  Container main_container() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      height: 1500,
      width: 340,
      child: Column(
        children: [
          SizedBox(height: 30),
          Location(),
          SizedBox(height: 30),
          Name(), // for name
          SizedBox(height: 30),
          Product(), // for select the product
          SizedBox(height: 30),
          Quantity(), // for quantity of product
          // for location of farmer
          SizedBox(height: 30),
          TakeMobileNo(),
          //finalloc()
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                imagePick(0),
                SizedBox(width: 10),
                imagePick(1),
                SizedBox(width: 10),
                imagePick(2),
              ],
            ),
          ),
          SizedBox(height: 30),
          start_date(),
          SizedBox(height: 30),
          startBidingTime(),
          SizedBox(height: 30),
          end_date(),
          SizedBox(height: 30),
          endBidingTime(),

          // SizedBox(height: 30),
          // Image1(),
          // SizedBox(height: 30),
          // Image2(),
          // SizedBox(height: 30),
          // Image3(),
          // SizedBox(height: 30),
          // Image4(), // Take mobile No input
          SizedBox(height: 30),
          save(),
          SizedBox(height: 25),
        ],
      ),
    );
  }

  GestureDetector save() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final userId = user != null ? user.uid : 'default user';
    print("The user is in addProducts is ${userId}");
    return GestureDetector(
      onTap: () {
        final products = Products(
            name: controllerName.text,
            product: selctedItem!,
            Quantity: controllerQuantity.text,
            imageUrls: imageUrls,
            mobileno: controllerMobileNo.text,
            startBidingDate: startBidingDate,
            endBidingDate: endBidingDate,
            startTime: startTime.format(context),
            endTime: endTime.format(context),
            location: widget.txt,
            dealDate: date,
            userId: userId,
            price: []);
        createProduct(products);

        //   var add = Add_data(
        //       selctedItemi!, amount_c.text, date, expalin_C.text, selctedItem!);
        //   box.add(add);
        //   //final products=Products()
        //   //Navigator.of(context).pop();
        //
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.deepOrangeAccent,
        ),
        width: 120,
        height: 50,
        child: Text(
          'Save',
          style: TextStyle(
            fontFamily: 'f',
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 17,
          ),
        ),
      ),
    );
  }

  GestureDetector Image1() {
    return GestureDetector(
      onTap: () {
        ImagePicker();
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.deepOrangeAccent,
        ),
        width: 120,
        height: 50,
        child: Text(
          'Pick image 1',
          style: TextStyle(
            fontFamily: 'f',
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 17,
          ),
        ),
      ),
    );
  }

  GestureDetector Image2() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.deepOrangeAccent,
        ),
        width: 120,
        height: 50,
        child: Text(
          'Pick image 2',
          style: TextStyle(
            fontFamily: 'f',
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 17,
          ),
        ),
      ),
    );
  }

  GestureDetector Image3() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.deepOrangeAccent,
        ),
        width: 120,
        height: 50,
        child: Text(
          'Pick image 3',
          style: TextStyle(
            fontFamily: 'f',
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 17,
          ),
        ),
      ),
    );
  }

  GestureDetector Image4() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.deepOrangeAccent,
        ),
        width: 120,
        height: 50,
        child: Text(
          'Pick image 4',
          style: TextStyle(
            fontFamily: 'f',
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 17,
          ),
        ),
      ),
    );
  }

  List<String> imageUrls = [];

  void imageFromGallary() async {
    String imageUrl = '';
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    print(image!.path);
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImage = referenceRoot.child('image');
    Reference referenceImageToUpload = referenceDirImage.child('${image.name}');
    try {
      referenceImageToUpload.putFile(File(image.path));
      imageUrl = await referenceImageToUpload.getDownloadURL();
      imageUrls.add(imageUrl);
    } catch (e) {
      print(e);
      print("Zala Bhau");
    }
    print("ewkjnfkjnff");
    print(imageUrls);
    print(imageUrl);
    setState(() {});
  }

  GestureDetector imagePick(int ind) {
    return GestureDetector(
      onTap: imageFromGallary,
      child: imageUrls.length < ind + 1
          ? DottedBorder(
              color: Colors.black,
              borderType: BorderType.RRect,
              radius: const Radius.circular(10),
              dashPattern: const [10, 4],
              strokeCap: StrokeCap.round,
              child: Container(
                // padding: EdgeInsets.only(left: 20),
                height: 100,
                width: 100,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.folder_open,
                      size: 20,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Select Image",
                      style:
                          TextStyle(fontSize: 13, color: Colors.grey.shade400),
                    )
                  ],
                ),
              ),
            )
          : Container(
              height: 100,
              width: 100,
              child: Image.network(
                imageUrls[ind],
                fit: BoxFit.contain,
              ),
            ),
    );
  }

  Widget date_time() {
    return Container(
      alignment: Alignment.bottomLeft,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 2, color: Color(0xffC5C5C5))),
      width: 300,
      child: TextButton(
        onPressed: () async {
          DateTime? newDate = await showDatePicker(
              context: context,
              initialDate: date,
              firstDate: DateTime(2020),
              lastDate: DateTime(2100));
          if (newDate == Null) return;
          setState(() {
            date = newDate!;
          });
        },
        child: Text(
          'Approximate deal date :  ${date.day}/${date.month}/${date.year}',
          style: TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget start_date() {
    return Container(
      alignment: Alignment.bottomLeft,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 2, color: Color(0xffC5C5C5))),
      width: 300,
      child: TextButton(
        onPressed: () async {
          DateTime? newDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2020),
              lastDate: DateTime(2100));
          if (newDate == Null) return;
          setState(() {
            // print("Sahsdkfdkjbf " + myDateFormat.format(newDate!) as DateTime);
            // print("kjsfkrskfur : " + newDate.toString());
            startBidingDate = myDateFormat.format(newDate!);
          });
        },
        child: Text(
          'Start Biding date :  $startBidingDate',
          style: TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget end_date() {
    return Container(
      alignment: Alignment.bottomLeft,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 2, color: Color(0xffC5C5C5))),
      width: 300,
      child: TextButton(
        onPressed: () async {
          DateTime? newDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2020),
              lastDate: DateTime(2100));

          if (newDate == Null) return;
          print(newDate.toString());
          setState(() {
            endBidingDate = myDateFormat.format(newDate!);
            print(endBidingDate);
            // endBiddindDate = endBidingDate.
          });
          print("akjddsc" + endBidingDate);
        },
        child: Text(
          'End Biding date :  $endBidingDate',
          style: TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  TimeOfDay stringToTimeOfDay(String tod) {
    final format = DateFormat.jm(); //"6:00 AM"

    return TimeOfDay.fromDateTime(format.parse(tod));
  }

  Widget startBidingTime() {
    return Container(
      alignment: Alignment.bottomLeft,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 2, color: Color(0xffC5C5C5))),
      width: 300,
      child: TextButton(
        onPressed: () async {
          TimeOfDay? newTime = await showTimePicker(
            context: context,
            initialTime: stringToTimeOfDay(startTime.format(context)),
          );
          if (newTime != null) {
            setState(() {
              startTime = stringToTimeOfDay(newTime.format(context));
            });
          }
        },
        child: Text(
          'Starting Biding Time :  ${startTime.format(context)}',
          style: TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget endBidingTime() {
    return Container(
      alignment: Alignment.bottomLeft,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 2, color: Color(0xffC5C5C5))),
      width: 300,
      child: TextButton(
        onPressed: () async {
          TimeOfDay? newtime = await showTimePicker(
            context: context,
            initialTime: stringToTimeOfDay(endTime.format(context)),
          );
          if (newtime != null) {
            endTime = stringToTimeOfDay(newtime.format(context));
            ;
          }
        },
        child: Text(
          'Ending Biding Time :  ${endTime.format(context)}',
          style: TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Padding How() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 2,
            color: Color(0xffC5C5C5),
          ),
        ),
        child: DropdownButton<String>(
          value: selctedItemi,
          onChanged: ((value) {
            setState(() {
              selctedItemi = value!;
            });
          }),
          items: _itemei
              .map((e) => DropdownMenuItem(
                    child: Container(
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          Text(
                            e,
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                    value: e,
                  ))
              .toList(),
          selectedItemBuilder: (BuildContext context) => _itemei
              .map((e) => Row(
                    children: [Text(e)],
                  ))
              .toList(),
          hint: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Text(
              'How',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          dropdownColor: Colors.white,
          isExpanded: true,
          underline: Container(),
        ),
      ),
    );
  }

  Padding amount() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        keyboardType: TextInputType.number,
        focusNode: amount_,
        controller: amount_c,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          labelText: 'amount',
          labelStyle: TextStyle(fontSize: 17, color: Colors.grey.shade500),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 2, color: Color(0xffC5C5C5))),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 2, color: Colors.deepOrangeAccent)),
        ),
      ),
    );
  }

  Padding explain() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        focusNode: ex,
        controller: expalin_C,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          labelText: 'explain',
          labelStyle: TextStyle(fontSize: 17, color: Colors.grey.shade500),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 2, color: Color(0xffC5C5C5))),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 2, color: Colors.deepOrangeAccent)),
        ),
      ),
    );
  }

  // for name of farmer
  Padding Name() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        //focusNode: ex,
        //controller: expalin_C,// here for storing the name of farmer modify code later
        controller: controllerName,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          labelText: 'Enter name',
          labelStyle: TextStyle(fontSize: 17, color: Colors.grey.shade500),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 2, color: Color(0xffC5C5C5))),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 2, color: Colors.deepOrangeAccent)),
          suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
        ),
      ),
    );
  }
Padding Location() {
  String currentLocation = ''; // Variable to store the current location

  // Fetch the user's current location during widget initialization
  getCurrentLocation().then((location) {
    if (location.isNotEmpty) {
      currentLocation = location;
      // Update the placeholder text of the TextField
      controllerLocation.text = currentLocation;
    }
  });

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: TextField(
      controller: controllerLocation,
      showCursor: true,
      keyboardType: TextInputType.streetAddress,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        hintStyle: TextStyle(color: Colors.grey),
        hintText: currentLocation.isNotEmpty
            ? currentLocation
            : "Select location or tap to autofill",
        labelText: "${widget.txt}",
        labelStyle: TextStyle(fontSize: 15, color: Colors.black),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(width: 2, color: Color(0xffC5C5C5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(width: 2, color: Colors.deepOrangeAccent),
        ),
        suffixIcon: IconButton(
          icon: SvgPicture.asset("assets/icons/Locationpoint.svg"),
          onPressed: () {
            // Navigate to the Locationautofill page when the suffix icon is tapped
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Locationautofill()),
            );
          },
        ),
      ),
      onTap: () {
        // Navigate to the Locationautofill page when the TextField is tapped
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Locationautofill()),
        );
      },
    ),
  );
}

  // for location
// Padding Location() {
//   return Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 20),
//     child: TextField(
//       controller: controllerLocation,
//       showCursor: true,
//       keyboardType: TextInputType.streetAddress,
//       decoration: InputDecoration(
//         contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
//         hintStyle: TextStyle(color: Colors.grey),
//         hintText: "Select location or tap to autofill",
//         labelText: "${widget.txt}",
//         labelStyle: TextStyle(fontSize: 15, color: Colors.black),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: BorderSide(width: 2, color: Color(0xffC5C5C5)),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: BorderSide(width: 2, color: Colors.deepOrangeAccent),
//         ),
//         suffixIcon: IconButton(
//           icon: SvgPicture.asset("assets/icons/Locationpoint.svg"),
//           onPressed: () {
//             // Handle tap on the suffix icon if needed
//           },
//         ),
//       ),
//       onTap: () async {
//         // Fetch the user's current location when the TextField is tapped
//         String result = await Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => Locationautofill()),
//         );

//         // Update the TextField with the obtained location
//         if (result != null && result.isNotEmpty) {
//           controllerLocation.text = result;
//         }
//       },
//     ),
//   );
// }

  // Padding Location() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 20),
  //     child: TextField(

  //         //focusNode: ex,
  //         //autofocus: false,
  //         //initialValue: 'your initial text',
  //         controller:
  //             controllerLocation, // here for storing the name of farmer modify code later
  //         showCursor: true,
  //         keyboardType: TextInputType.streetAddress,
  //         decoration: InputDecoration(
  //           contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
  //           // labelText: "${widget.txt}",
  //           hintStyle: TextStyle(color: Colors.grey),
  //           hintText: "select location press icon ",
  //           labelText: "${widget.txt}",
  //           // hintText: "${widget.txt}",
  //           // labelText: "select location press icon at right side",
  //           labelStyle: TextStyle(fontSize: 15, color: Colors.black),
  //           enabledBorder: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(10),
  //               borderSide: BorderSide(width: 2, color: Color(0xffC5C5C5))),
  //           focusedBorder: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(10),
  //               borderSide:
  //                   BorderSide(width: 2, color: Colors.deepOrangeAccent)),
  //           // suffixIcon: IconButton(
  //           //
  //           //   // onPressed:() {
  //           //   //   Navigator.of(context).pushReplacement(
  //           //   //     MaterialPageRoute(builder: (context) =>LocationPage())
  //           //   //   );
  //           //   },
  //           //   icon: CustomSurffixIcon(svgIcon: "assets/icons/Discover.svg"),
  //           // )
  //           //suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Discover.svg",),
  //           suffixIcon: IconButton(
  //               icon: SvgPicture.asset(
  //                 "assets/icons/Locationpoint.svg",
  //               ),
  //               onPressed: () {
  //                 Navigator.of(context).pushReplacement(
  //                   MaterialPageRoute(builder: (context) => Locationautofill()),
  //                 );
  //               }),
  //         ),
  //         onTap: () {
  //           Navigator.of(context).pushReplacement(
  //               MaterialPageRoute(builder: (context) => Locationautofill()));
  //         }),
  //   );
  // }

  // for quantity of product

  Padding Quantity() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: controllerQuantity,
        keyboardType: TextInputType.number,
        //focusNode: ex,
        //controller: expalin_C,// here for storing the name of farmer modify code later
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          labelText: 'Enter quantity of product in Kg',
          labelStyle: TextStyle(fontSize: 17, color: Colors.grey.shade500),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 2, color: Color(0xffC5C5C5))),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 2, color: Colors.deepOrangeAccent)),
          suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/receipt.svg"),
        ),
      ),
    );
  }

  Padding TakeMobileNo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: controllerMobileNo,
        keyboardType: TextInputType.number,
        //focusNode: ex,
        //controller: expalin_C,// here for storing the name of farmer modify code later
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          labelText: 'Enter Mobile No',
          labelStyle: TextStyle(fontSize: 17, color: Colors.grey.shade500),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 2, color: Color(0xffC5C5C5))),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 2, color: Colors.deepOrangeAccent)),
          suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
        ),
      ),
    );
  }

  Padding Product() {
    _item.sort();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 2,
            color: Color(0xffC5C5C5),
          ),
        ),
        child: DropdownButton<String>(
          value: selctedItem,
          onChanged: ((value) {
            setState(() {
              selctedItem = value!;
            });
          }),
          items: _item
              .map((e) => DropdownMenuItem(
                    child: Container(
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          Container(
                            width: 40,

                            //child: Image.asset('images/${e}.png'),
                            child: Image.asset('assets/images/${e}_Small.png'),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            e,
                            style: const TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                    value: e,
                  ))
              .toList(),
          selectedItemBuilder: (BuildContext context) => _item
              .map((e) => Row(
                    children: [
                      Container(
                        width: 42,
                        //child: Image.asset('images/${e}.png'),
                        child: Image.asset('assets/images/${e}_Small.png'),
                      ),
                      SizedBox(width: 5),
                      Text(e)
                    ],
                  ))
              .toList(),
          hint: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Text(
              'Select Product',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          dropdownColor: Colors.white,
          isExpanded: true,
          underline: Container(),
        ),
      ),
    );
  }

  Column background_container(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 240,
          decoration: BoxDecoration(
            color: Colors.deepOrangeAccent,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 40),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    Text(
                      'Add Product',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    Icon(
                      Icons.attach_file_outlined,
                      color: Colors.white,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Future createProduct(Products user) async {
    final docUser = FirebaseFirestore.instance.collection('products').doc();
    //user.id=docUser.id;
    final json = user.toJson();
    await docUser.set(json).then(
          (value) => Fluttertoast.showToast(msg: "Product added succesfully")
              .then((value) => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()))),
        );
  }
}

class Products {
  final String name;
  final String product;
  final String Quantity;
  final List<String> imageUrls;

  ///
  final String mobileno;
  final String location;
  final DateTime dealDate;
  // final DateTime startBidingDate;
  // final DateTime endBidingDate;
  final String startBidingDate;
  final String endBidingDate;
  final String startTime;
  final String endTime;
  final String userId;
  final List price;

  Products(
      {required this.name,
      required this.product,
      required this.Quantity,
      required this.mobileno,
      required this.location,
      required this.dealDate,
      required this.startBidingDate,
      required this.endBidingDate,
      required this.startTime,
      required this.endTime,
      required this.imageUrls,
      required this.userId,
      required this.price});

  Map<String, dynamic> toJson() => {
        'name': name,
        'Product': product,
        'Quantity in KG': Quantity,
        'images': imageUrls,
        'Mobileno': mobileno,
        'Location': location,
        'Deal_Date': dealDate.toString(),
        'Start_Biding_Date': startBidingDate.toString(),
        'End_Biding_Date': endBidingDate.toString(),
        'Start_time': startTime.toString(),
        'End_time': endTime.toString(),
        'userId': userId,
        'price': price
      };
}
