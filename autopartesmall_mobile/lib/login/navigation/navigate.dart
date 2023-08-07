import 'package:autopartes_mall/login/screens/home_page.dart';
import 'package:autopartes_mall/login/screens/sign_in_page.dart';
import 'package:autopartes_mall/login/screens/welcome_page.dart';
import 'package:flutter/material.dart';




class Navigate {
  static Map<String, Widget Function(BuildContext)> routes =   {
    '/' : (context) => WelcomePage(),
    '/sign-in' : (context) => SignInPage(),
    '/home'  : (context) => HomePage()
  };
}
