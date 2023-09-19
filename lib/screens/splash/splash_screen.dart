
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:krishak_farma/MobileAuth/mobile_register.dart';
import 'package:krishak_farma/MobileAuth/otp_screen.dart';
import 'package:krishak_farma/MobileAuth/userinformationscreen.dart';
import 'package:krishak_farma/screens/home/home_screen.dart';
import '../../constants.dart';
import '../../size_config.dart';
import '../sign_in/sign_in_screen.dart';
class  SplashScreen extends StatefulWidget {

  static String routeName="/splash";
  const SplashScreen({Key? key}) : super(key: key);
  //static String routeName="/splash";
  //static String routeName="/splash";
  _SplashScreenState createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  var auth =FirebaseAuth.instance;
  var isLogin =false;
  checkIfLogin() async{
    auth.authStateChanges().listen((User? user) {
      if(user!=null && mounted){
        setState(() {

          isLogin=true;
        });
      }
      
    });
  }

  void initState()
  {
    checkIfLogin();
    super.initState();
    _navigatetohome();
  }
  _navigatetohome()async
  {
    await Future.delayed(Duration(milliseconds: 3000),(){});// await for 1.5 seconds
    Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=> RegisterScreen()));
    // if(isLogin==true)
    // {
    //   Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=> HomeScreen()));
    //   //Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=> RegisterScreen()));
    // }
    // else
    // {
    //   Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=> SignInScreen()));


    // }


  }



  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,

            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Container(
              //     height: getProportionateScreenHeight(150.0),
              //     width: getProportionateScreenWidth(150.0),
              //
              //     child: CircleAvatar(
              //       radius:(50.0), ///////
              //       backgroundImage: AssetImage('assets/images/Agri safe logo.png'),
              //
              //
              //     )
              // ),
              Container(


                child: Text('Krishak Farma',
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(36),
                    color: Colors.deepOrangeAccent,
                    fontWeight: FontWeight.bold,
                  ),

                ),
              ),
              // Container(
              //     height:getProportionateScreenHeight(400.0),
              //     width:getProportionateScreenWidth(400.0),
              //     //color: Colors.orangeAccent,
              //     decoration: BoxDecoration(
              //       image: DecorationImage(
              //         image: AssetImage(
              //             'assets/images/Splash screen image 1.jpg'),
              //         fit: BoxFit.fill,
              //         //fit: BoxFit.fitHeight,
              //       ),
              //     )
              // )
            ],
          )
      ),
    );
  }
}




//import 'dart:html';



// import 'package:flutter/material.dart';
//
// import '../../../size_config.dart';
// import '../../components/default_button.dart';
// import '../../constants.dart';
// import '../sign_in/sign_in_screen.dart';
// import 'components/splash_content.dart';
//
// class SplashScreen extends StatelessWidget {
//   static String routeName = "/splash";
//   @override
//   Widget build(BuildContext context) {
//     // You have to call it on your starting screen
//     SizeConfig().init(context);
//     return Scaffold(
//       //body: Body(),
//       body: Body(),
//     );
//   }
// }
//
//
// class Body extends StatefulWidget {
//   @override
//   _BodyState createState() => _BodyState();
// }
//
// class _BodyState extends State<Body> {
//   int currentPage = 0;
//   List<Map<String, String>> splashData = [
//     // {
//     //   "text": "Welcome toKrishakFarma",
//     //   "image": "assets/images/splash_1.png"
//     // },
//     {
//       "text":
//       "Welcome to Krishak Farma We help to connect farmers \nwith stores virtually to get best market prices",
//       "image": "assets/images/splash_2.png"
//     },
//     // {
//     //   "text": "We show the easy way to shop. \nJust stay at home with us",
//     //   "image": "assets/images/splash_3.png"
//     // },
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//
//       child: SizedBox(
//         width: double.infinity,
//         child: Column(
//           children: <Widget>[
//             Expanded(
//               flex: 3,
//               child: PageView.builder(
//                 onPageChanged: (value) {
//                   setState(() {
//                     currentPage = value;
//                   });
//                 },
//                 itemCount: splashData.length,
//                 itemBuilder: (context, index) => SplashContent(
//                   image: splashData[index]["image"],
//                   text: splashData[index]['text'],
//                 ),
//               ),
//             ),
//             Expanded(
//               flex: 2,
//               child: Padding(
//                 padding: EdgeInsets.symmetric(
//                     horizontal: getProportionateScreenWidth(20)),
//                 child: Column(
//                   children: <Widget>[
//                     Spacer(),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: List.generate(
//                         splashData.length,
//                             (index) => buildDot(index: index),
//                       ),
//                     ),
//                     Spacer(flex: 3),
//                     DefaultButton(
//                       text: "Continue",
//                       press: () {
//                         Navigator.pushNamed(context, SignInScreen.routeName); // insert after work is done SignInScreen.routeName
//                       },
//                     ),
//                     Spacer(),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   AnimatedContainer buildDot({int? index}) {
//     return AnimatedContainer(
//       duration: kAnimationDuration,
//       margin: EdgeInsets.only(right: 5),
//       height: 6,
//       width: currentPage == index ? 20 : 6,
//       decoration: BoxDecoration(
//         color: currentPage == index ? kPrimaryColor : Color(0xFFD8D8D8),
//         borderRadius: BorderRadius.circular(3),
//       ),
//     );
//   }
// }
