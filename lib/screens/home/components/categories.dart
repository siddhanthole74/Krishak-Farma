import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:krishak_farma/screens/home/my_bids.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../size_config.dart';
import 'package:krishak_farma/screens/home/components/addproduct.dart';
import 'package:krishak_farma/screens/home/components/advice.dart';
import 'package:krishak_farma/screens/home/components/flash_deal.dart';

import 'package:fluttertoast/fluttertoast.dart';

import 'market view.dart';









openURL1(url) async {
  if(await canLaunch(url)){
    await launch(url);

  }
  else
  {
    throw 'could not lunch url';
  }
}











class Categories extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    List<Map<String, dynamic>> categories = [
      {"icon": "assets/icons/Flash Icon.svg", "text": "Flash Deal","key":"1"},
      {"icon": "assets/icons/adviceImage2.svg", "text": "Advice","key":"2"},
      //{"icon": "assets/icons/Game Icon.svg", "text": "Game"},
      {"icon": "assets/icons/Market View2.svg", "text": "Market View","key":"3"},
      {"icon": "assets/icons/Discover.svg", "text": " Add Product","key":"4"},
      {"icon": "assets/icons/Gift Icon.svg", "text": "My Bids", "key": "5"},
    ];
    return Padding(
      padding: EdgeInsets.all(getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          categories.length,
              (index) => CategoryCard(
            icon: categories[index]["icon"],
            text: categories[index]["text"],


            press: (){
           if(categories[index]["key"]=="1") // Flash deal
           {
             Navigator.push(context,
               MaterialPageRoute(builder: (context)=>FlashDeal())
             );
             Fluttertoast.showToast(msg: "Flash Deal");
           }
           else if(categories[index]["key"]=="2")  // Advice
           {
             Navigator.push(context,
               MaterialPageRoute(builder: (context)=>Advice())
             );
             Fluttertoast.showToast(msg: "Advice");
           }
           else if(categories[index]["key"]=="3") // Market view
           {
              Navigator.push(context,
                MaterialPageRoute(builder: (context)=>MarketView())
              );
              Fluttertoast.showToast(msg: "Market View");
           }
           else if(categories[index]["key"]=="4") // Add product
           {
             Navigator.push(context,
               MaterialPageRoute(builder: (context)=>AddProduct(txt: '',))
             );
             Fluttertoast.showToast(msg: "Add Product");

                } else if (categories[index]["key"] == "5") // Add product
                {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyBids(
                                userId: '',
                              )));
                  Fluttertoast.showToast(msg: "My Bids");

           }
            }


          ),


        ),


      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String? icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: getProportionateScreenWidth(55),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(15)),
              height: getProportionateScreenWidth(55),
              width: getProportionateScreenWidth(55),
              decoration: BoxDecoration(
                color: Color(0xFFFFECDF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: SvgPicture.asset(icon!),
            ),
            SizedBox(height: 5),
            Text(text!, textAlign: TextAlign.center)
          ],
        ),
      ),
    );
  }
}
