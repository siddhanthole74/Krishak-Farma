import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:krishak_farma/MobileAuth/authprovider.dart';
import 'package:krishak_farma/routes.dart';
import 'package:krishak_farma/screens/home/home_screen.dart';
import 'package:krishak_farma/screens/sign_in/sign_in_screen.dart';
import 'package:krishak_farma/screens/splash/splash_screen.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'models/add_date.dart';
Future<void> main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();//// for add product
  Hive.registerAdapter(AdddataAdapter());
  await Hive.openBox<Add_data>('data');
  runApp(MyApp());

}
class MyApp extends StatelessWidget
{

  MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    // TODO: implement build

    // return  OverlaySupport(
    //   child: MaterialApp(
    //     debugShowCheckedModeBanner: false,
    //     initialRoute: SplashScreen.routeName,
    //     // home: FutureBuilder(future: checkLoginStatus(),builder:(BuildContext context,AsyncSnapshot<bool>snapshot){
    //     //   if(snapshot.data==false){
    //     //     return SignInScreen();
    //     //   }
    //     //   if(snapshot.connectionState==ConnectionState.waiting){
    //     //     return Container(
    //     //       color: Colors.white,
    //     //       child: Center(
    //     //         child: CircularProgressIndicator(),
    //     //       ),
    //     //     );
    //     //   }
    //     //   return HomeScreen();
    //     //
    //     // } ),
    //     routes: routes,






    //   ),
    // );

    // for final otp verification 
    return  MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: SplashScreen.routeName,
        
        routes: routes,
      ),
    );
  }

}











