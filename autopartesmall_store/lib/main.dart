import 'package:apmall_web/add/add_product.dart';
import 'package:apmall_web/login/log_page.dart';
import 'package:apmall_web/product_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:apmall_web/on_boarding.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:apmall_web/global_variables.dart' as Global;

import 'login/reg_page.dart';

void main() => runApp(App());

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {

          //storage



          _EstablishVariables();

          return MyApp();
        }

        return const CircularProgressIndicator();
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

            Global.SK_STRIPE = val.data()!['SK_KEY'];
            Global.PK_STRIPE = val.data()!['PK_KEY'];

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
          "/onboarding": (BuildContext context) => OnBoarding(),
          "/loggin": (BuildContext context) => LogginPage(),
          "/register": (BuildContext context) => RegisterPage(),
          "/add": (BuildContext context) => AddProduct(),
          // "/product": (BuildContext context) => productDetails('','',''),
        });
  }

}
