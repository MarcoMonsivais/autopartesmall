import 'package:autopartes_mall/constants/Theme.dart';
import 'package:autopartes_mall/screens/admin/dev/cargaMasiva.dart';
import 'package:autopartes_mall/widgets/card-horizontal.dart';
import 'package:autopartes_mall/widgets/drawer.dart';
import 'package:autopartes_mall/widgets/navbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//Elemetn
import 'package:autopartes_mall/widgets/navbar.dart';
import 'package:autopartes_mall/widgets/drawer.dart';
import 'package:autopartes_mall/widgets/input.dart';
import 'package:autopartes_mall/widgets/table-cell.dart';


class MenuDev extends StatefulWidget {

  @override
  _MenuDevState createState() => _MenuDevState();
}

class _MenuDevState extends State<MenuDev> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Navbar(
          title: "¡DevMode!",
        ),
        backgroundColor: ArgonColors.bgColorScreen,
        // key: _scaffoldKey,
        drawer: ArgonDrawer(currentPage: "Dev"),
        body: Container(
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            child: SingleChildScrollView(
                child: Column(children: [
                    CardHorizontal(
                        title: 'Elementos',
                        tap: () {

                            Navigator.pushReplacementNamed(context, '/elements');
                        }),

                  CardHorizontal(
                      title: 'Profile',
                      tap: () {

                        Navigator.pushReplacementNamed(context, '/profile');
                      }),

                  CardHorizontal(
                      title: 'Articulos',
                      tap: () {

                        Navigator.pushReplacementNamed(context, '/articles');
                      }),

                  CardHorizontal(
                      title: 'Carga masiva',
                      tap: () {

                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return cargaMasiva();}));

                      }),

                ]
                )
            )
        )
    );
  }

}
