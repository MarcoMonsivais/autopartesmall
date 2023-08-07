import 'package:autopartes_mall/login/loginMail.dart';
import 'package:autopartes_mall/screens/account/account.dart';
import 'package:autopartes_mall/screens/addProduct/addProduct.dart';
import 'package:autopartes_mall/screens/addProduct/neededInformation.dart';
import 'package:autopartes_mall/screens/addProduct/newProduct.dart';
import 'package:autopartes_mall/screens/admin/dev/menuDeb.dart';
import 'package:autopartes_mall/screens/products/products.dart';
import 'package:autopartes_mall/screens/search/searchFiltered.dart';
import 'package:autopartes_mall/screens/admin/adminMode.dart';
import 'package:autopartes_mall/screens/search/variousDetails.dart';
import 'package:autopartes_mall/screens/store/storeDetail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:autopartes_mall/screens/onboarding.dart';
import 'package:autopartes_mall/screens/pro.dart';
import 'package:autopartes_mall/screens/home.dart';
import 'package:autopartes_mall/screens/profile.dart';
import 'package:autopartes_mall/screens/register.dart';
import 'package:autopartes_mall/screens/articles.dart';
import 'package:autopartes_mall/screens/elements.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:autopartes_mall/src/globalVariables.dart' as Globals;

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // Check for errors
        // if (snapshot.hasError) {
        //   return SomethingWentWrong();
        // }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {

          _EstablishVariables();

          return MyApp();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return CircularProgressIndicator();
      },
    );
  }

  _EstablishVariables() async{
    try {
      await FirebaseFirestore.instance
          .collection('conf')
          .doc('keys')
          .get()
          .then((val) {
        Globals.SK_STRIPE = val.data()['SK_KEY'];
        Globals.PK_STRIPE = val.data()['PK_KEY'];
        Globals.STRIPE_MERCHANTID = val.data()['STRIPE_MERCHANTID'];
        Globals.STRIPE_ANDROIDPAYMODE = val.data()['STRIPE_ANDROIDPAYMODE'];
      });
    }
    catch (onError){
      print('Error: ' + onError.toString());
    }
  }

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(fontFamily: 'OpenSans'),
        initialRoute: "/onboarding",
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
          "/onboarding": (BuildContext context) => new Onboarding(),
          "/home": (BuildContext context) => new Home(),
          "/profile": (BuildContext context) => new Profile(),
          "/articles": (BuildContext context) => new Articles(),
          "/elements": (BuildContext context) => new Elements(),
          "/account": (BuildContext context) => new Register(false),
          // "/accountLogged": (BuildContext context) => new Account('SRb8315lVzNPhL3Chf5yqjoIICh1'),
          "/pro": (BuildContext context) => new Pro(),
          "/addProduct/": (BuildContext context) => new addProduct(),
          "/store/": (BuildContext context) => new storeDetail(),
          "/admin/": (BuildContext context) => new AdminMode(),
          "/admin/dev/": (BuildContext context) => new MenuDev(),
          "/search/": (BuildContext context) => new searchFilter(),
          "/login/": (BuildContext context) => new EmailLogIn(),
          // "/variousDetails": (BuildContext context) => new variousDetails('puerta'),
        });
  }
}
