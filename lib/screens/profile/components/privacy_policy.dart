import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:krishak_farma/MobileAuth/mobile_login.dart';
import 'privacy_policy.dart';

import '../../../models/user_model.dart';
import '../../home/components/myaccount.dart';
import '../../home/components/notifications.dart';
import '../../sign_in/sign_in_screen.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';
import 'package:url_launcher/url_launcher.dart';
import 'body.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.deepOrangeAccent,
      //   title: Text("Privacy Policy"),
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  "Privacy Policy",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Text(
                    "This Privacy Policy describes Our policies and procedures on the collection, use and disclosure of Your information when You use the Service and tells You about Your privacy rights and how the law protectsYou.We use Your Personal data to provide and improve the Service. Byusing the Service, You agree to the collection and use of information accordance Privacy Policy",
                    textAlign: TextAlign.justify,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Collecting and Using Your Personal Data",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Text(
                    "While using Our Service, We may ask You to provide Us with certain personally identifiable information that can be used to contact or identify You. \n"
                        "Personally identifiable information may include, but is not limited to:\n  \n 1) email address \n 2) first name and last name \n 3) phone number \n 4) address, state, province, postal code, city \n 5) cookies and usage data \n 6) Usage Data \n \n We may also collect information that Your browser sends whenever You visit Our Service or when You access the Service by or through a mobile device. \n ",
                    textAlign: TextAlign.justify,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Delete Your Personal Data",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Text(
                    "You have the right to delete or request that We assist in deleting the Personal Data that We have collected about You. \n Our Service may give You the ability to delete certain information about You from within the Service \nYou may update, amend, or delete Your information at any time by\n signing in to Your Account, if you have one, and visiting the account settings section that allows you to manage Your personal information.",
                    textAlign: TextAlign.justify,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Security of Your Personal Data",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Text(
                    "The security of Your Personal Data is important to Us, but remember that no method of transmission over the Internet, or method of electronic storage is 100% secure. While We strive to use commercially acceptable means to protect Your Personal Data, We cannot guarantee its absolute security.",
                    textAlign: TextAlign.justify,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text("Copyright policy of Krishak Farma",style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                SizedBox(height: 10,),
                Container(
                  child: Text(
                   " 1.Intellectual property rights: The content on this app, including text, images, logos, and videos, is owned by the app owner and is protected by copyright laws. The app respects the intellectual property rights of others and expects users to do the same.\n\n 2.DMCA policy: The app complies with the Digital Millennium Copyright Act (DMCA) and provides a process for copyright owners to report infringing content on the app. If you believe that your copyrighted material has been copied and posted on the app in a way that constitutes copyright infringement, please provide the app's designated agent with the following information:\n   ○ A description of the copyrighted work that you claim has been infringed.\n   ○ A description of where the infringing material is located on the app. \n   ○ Your contact information, including your name, address, telephone number, and email address. \n   ○ A statement by you that you have a good faith belief that the disputed use is not authorized by the copyright owner, its agent, or the law .\n   ○ A statement by you, made under penalty of perjury, that the above information in your notice is accurate and that you are the copyright owner or authorized to act on the copyright owner's behalf.\n\n 3.User-generated content: Users may post reviews, comments, and other content on the app. By posting content on the app, users grant the app a non-exclusive, royalty-free, perpetual, irrevocable, and fully sublicensable right to use, reproduce, modify, adapt, publish, translate, create derivative works from, distribute, and display such content throughout the world in any media. Users represent and warrant that they own or control all rights to the content they post, that the content is accurate, that use of the content does not violate this policy and will not cause injury to any person or entity.\n\n 4.Copyright infringement: The app takes copyright infringement seriously and may remove or disable access to content that appears to infringe upon the copyright or other intellectual property rights of others. The app reserves the right to terminate user accounts that repeatedly infringe or are believed to be infringing upon the intellectual property rights of others.\n\n 5.License to use the app: The app grants users a limited, non-exclusive, non-transferable, revocable license to use the app for personal, non-commercial purposes in accordance with these terms and conditions.\n\n 6.Contact information: To report copyright infringement or for any other copyright-related issues, please contact the app's designated agent",
                    textAlign: TextAlign.justify,
                  ),
                ),

                Text(
                  "Contact Us",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Text(
                    "By email: krishakfarma@gmail.com",
                    textAlign: TextAlign.justify,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}