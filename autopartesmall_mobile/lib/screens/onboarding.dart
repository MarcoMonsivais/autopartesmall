import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:autopartes_mall/constants/Theme.dart';

class Onboarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Timer(const Duration(seconds: 3), () {Navigator.pushNamed(context, '/home');});

    return Scaffold(
        body: Stack(children: <Widget>[
          Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/img/main_back.png"),
                      fit: BoxFit.cover))),
          Padding(
              padding:
                  const EdgeInsets.only(top: 73, left: 32, right: 32, bottom: 16),
              child:
                Column(crossAxisAlignment: CrossAxisAlignment.stretch, mainAxisAlignment: MainAxisAlignment.end, children: [
                  TextButton(
                      child: Text("Ver productos", style: TextStyle(color: ArgonColors.white),),
                      onPressed: () {
                        Navigator.pushNamed(context, '/home');
                      },
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: ArgonColors.border)
                              )
                          )
                      )
                  ),
                  SizedBox(height: 40.0,),
                ],)
          ),
//      Padding(
//        padding:
//            const EdgeInsets.only(top: 73, left: 32, right: 32, bottom: 16),
//        child: Container(
//          child: SafeArea(
//            child: Column(
//              mainAxisAlignment: MainAxisAlignment.spaceAround,
//              crossAxisAlignment: CrossAxisAlignment.start,
//              children: <Widget>[
////                Image.asset("assets/img/logo_am.png", scale: 1),
////                Column(
////                  crossAxisAlignment: CrossAxisAlignment.start,
////                  mainAxisAlignment: MainAxisAlignment.end,
////                  children: [
////                    Padding(
////                      padding: const EdgeInsets.only(right: 48.0),
////                      child: Text.rich(TextSpan(
////                        text: "Autopartes Mall",
////                        style: TextStyle(
////                            color: Colors.white,
////                            fontSize: 42,
////                            fontWeight: FontWeight.w600),
////                      )),
////                    ),
////                    Padding(
////                      padding: const EdgeInsets.only(top: 24.0),
////                      child: Text("Tu autoparte en un solo lugar",
////                          style: TextStyle(
////                              color: Colors.white,
////                              fontSize: 17,
////                              fontWeight: FontWeight.w200)),
////                    ),
////                  ],
////                ),
//                Padding(
//                  padding: const EdgeInsets.only(top: 12.0),
//                  child: SizedBox(
//                    width: double.infinity,
//                    child: FlatButton(
//                      textColor: ArgonColors.text,
//                      color: ArgonColors.secondary,
//                      onPressed: () {
//                        Navigator.pushReplacementNamed(context, '/home');
//                      },
//                      shape: RoundedRectangleBorder(
//                        borderRadius: BorderRadius.circular(12.0),
//                      ),
//                      child: Padding(
//                          padding: EdgeInsets.only(
//                              left: 16.0, right: 16.0, top: 6, bottom: 6),
//                          child: Text("Ver productos",
//                              style: TextStyle(
//                                  fontWeight: FontWeight.w600,
//                                  fontSize: 16.0))),
//                    ),
//                  ),
//                )
//              ],
//            ),
//          ),
//        ),
//      )
    ]));
  }
}
