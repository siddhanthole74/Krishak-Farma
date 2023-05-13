import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:krishak_farma/MobileAuth/mobile_login.dart';
import 'package:krishak_farma/screens/profile/components/privacy_policy.dart';


import '../../../models/user_model.dart';
import '../../home/components/myaccount.dart';
import '../../home/components/notifications.dart';
import '../../sign_in/sign_in_screen.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';
class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  User? user=FirebaseAuth.instance.currentUser;
  UserModel loggedInUser=UserModel();
  final storage=new FlutterSecureStorage();
  @override
  void initState()
  {
    super.initState();
    FirebaseFirestore.instance.collection("users").doc(user!.uid).get().then((value){
      loggedInUser=UserModel.fromMap(value.data());
      setState(() {

      });

    });
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(),
          SizedBox(height: 20),
          //facing problem to fecth the first name
          ProfileMenu(
            text:  " ${loggedInUser.firstName} ${loggedInUser.secondName}",
            icon: "assets/icons/User Icon.svg",
            press: () => {
            },
          ),
          ProfileMenu(
            text: "${loggedInUser.email}",
            icon: "assets/icons/Mail.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Notifications",
            icon: "assets/icons/Bell.svg",
            press: () =>  Navigator.of(context).push(MaterialPageRoute(builder:(context)=> Notifications()),),
          ),
          // ProfileMenu(
          //   text: "Settings",
          //   icon: "assets/icons/Settings.svg",
          //   press: () {},
          // ),
          ProfileMenu(
            text: "Share",
            icon: "assets/icons/icons8-connect.svg",
            press: () {
              //Share.share("com.example.krishak_farma");
              //Share.share("")
            },
          ),
          ProfileMenu(
            text: "Log Out",
            icon: "assets/icons/Log out.svg",
            press: () async=>{
              await FirebaseAuth.instance.signOut(),
              await storage.delete(key: "uid"),
              // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>MobileLogin()), (route) => false)
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>SignInScreen()), (route) => false)
            }
          ),
          GestureDetector(
            child: ProfileMenu(
              text: "Privacy Policy",
              icon: "assets/icons/privacypolicy.svg",
              //  press: () {
              //    _launched = _launchInBrowser(toLaunch);
              //
              // },
              press: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => PrivacyPolicy()),
              ),
            ),
          ),
        ],
      ),
    );
  }
  // Future<void> logout(BuildContext context) async
  // {
  //   await FirebaseAuth.instance.signOut();
  //   Navigator.pushNamed(context, SignInScreen.routeName);
  // }
}







