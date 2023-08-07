import 'package:autopartes_mall/constants/Theme.dart';
import 'package:autopartes_mall/widgets/drawer.dart';
import 'package:autopartes_mall/widgets/navbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class storeDetail extends StatefulWidget {

  @override
  _storeDetailState createState() => _storeDetailState();

}

class _storeDetailState extends State<storeDetail> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Navbar(
          title: "Bienvenido",
          searchBar: true,
          categoryOne: "Comprar",
          categoryTwo: "Vender",
        ),
        backgroundColor: ArgonColors.bgColorScreen,
        // key: _scaffoldKey,
        drawer: ArgonDrawer(currentPage: "storeDetail"),
        body: _body(context));
  }

  _body(context){
    return Text('hola');
  }

}