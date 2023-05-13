




//import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:krishak_farma/MobileAuth/mobile_login.dart';
import 'package:krishak_farma/MobileAuth/mobile_otp.dart';
import 'package:krishak_farma/screens/bid_placing/place_bid_screen.dart';
import 'package:krishak_farma/screens/cart/cart_screen.dart';
import 'package:krishak_farma/screens/details/details_screen.dart';
import 'package:krishak_farma/screens/forgot_password/forgot_password_screen.dart';
import 'package:krishak_farma/screens/home/components/addproduct.dart';
import 'package:krishak_farma/screens/home/components/flash_deal.dart';
import 'package:krishak_farma/screens/home/home_screen.dart';
import 'package:krishak_farma/screens/loginsucessscreen/login_sucess_screen.dart';
import 'package:krishak_farma/screens/message.dart';
import 'package:krishak_farma/screens/profile/profile_screen.dart';
import 'package:krishak_farma/screens/sign_in/sign_in_screen.dart';
import 'package:krishak_farma/screens/sign_up/components/verifyemailform.dart';
import 'package:krishak_farma/screens/sign_up/sign_up_screen.dart';
import 'package:krishak_farma/screens/splash/splash_screen.dart';
import 'package:krishak_farma/screens/sign_up/components/verifyemailform.dart';
import 'otp/otp_screen.dart';

final Map<String, WidgetBuilder> routes = {
  //Splash.routeName:(context)=>Splash(),
  SignInScreen.routeName:(context)=>SignInScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),

  SignUpScreen.routeName: (context) => SignUpScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  //ProfileScreen.routeName: (context) => ProfileScreen(),
  DetailsScreen.routeName: (context) => DetailsScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  // 'mobile_login':(context)=>MobileLogin(),
  // 'mobile_otp':(context)=>MobileOTP(),
  'home':(context)=>HomeScreen(),
  'login_sucess':(context)=>LoginSuccessScreen(),


  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  //LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  //CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  // OtpScreen.routeName: (context) => OtpScreen(),
  //HomeScreen.routeName: (context) => HomeScreen(),
  DetailsScreen.routeName: (context) => DetailsScreen(),
  CartScreen.routeName: (context) => CartScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  AddProduct.routeName:(context) =>AddProduct(txt: "",),
  //MainPage.routeName:(context) =>MainPage()
  //Notifications.routeName:(context)=>Notifications()
  Chat.routeName: (context) => Chat(),
};
