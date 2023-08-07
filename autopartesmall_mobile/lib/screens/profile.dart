import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:autopartes_mall/constants/Theme.dart';
import 'package:autopartes_mall/widgets/navbar.dart';
import 'package:autopartes_mall/widgets/drawer.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: Navbar(
          title: "Perfil",
          transparent: true,
        ),
        backgroundColor: ArgonColors.bgColorScreen,
        drawer: ArgonDrawer(currentPage: "Profile"),
        body: Stack(children: <Widget>[
          Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      alignment: Alignment.topCenter,
                      image: AssetImage("assets/img/profile-screen-bg.png"),
                      fit: BoxFit.fitWidth))),
          SafeArea(
            child: ListView(children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 74.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Stack(children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Card(
                            semanticContainer: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            elevation: .0,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0))),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 85.0, bottom: 20.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: ArgonColors.info,
                                                borderRadius:
                                                    BorderRadius.circular(3.0),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.3),
                                                    spreadRadius: 1,
                                                    blurRadius: 7,
                                                    offset: Offset(0,
                                                        3), // changes position of shadow
                                                  ),
                                                ],
                                              ),
                                              child: Text(
                                                "DETALLES",
                                                style: TextStyle(
                                                    color: ArgonColors.white,
                                                    fontSize: 12.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8.0,
                                                  vertical: 8.0),
                                            ),
                                            SizedBox(
                                              width: 30.0,
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: ArgonColors.initial,
                                                borderRadius:
                                                    BorderRadius.circular(3.0),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.3),
                                                    spreadRadius: 1,
                                                    blurRadius: 7,
                                                    offset: Offset(0,
                                                        3), // changes position of shadow
                                                  ),
                                                ],
                                              ),
                                              child: Text(
                                                "CONTACTO",
                                                style: TextStyle(
                                                    color: ArgonColors.white,
                                                    fontSize: 12.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8.0,
                                                  vertical: 8.0),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 40.0),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Column(
                                              children: [
                                                Text("1989",
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            82, 95, 127, 1),
                                                        fontSize: 20.0,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Text("Año",
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            50, 50, 93, 1),
                                                        fontSize: 12.0))
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text("\$380",
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            82, 95, 127, 1),
                                                        fontSize: 20.0,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Text("Precio",
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            50, 50, 93, 1),
                                                        fontSize: 12.0))
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text("89",
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            82, 95, 127, 1),
                                                        fontSize: 20.0,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Text("Comentarios",
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            50, 50, 93, 1),
                                                        fontSize: 12.0))
                                              ],
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 40.0),
                                        Align(
                                          child: Text("Cadena usada",
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      50, 50, 93, 1),
                                                  fontSize: 28.0)),
                                        ),
                                        SizedBox(height: 10.0),
                                        Align(
                                          child: Text("Monterrey, Nuevo León",
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      50, 50, 93, 1),
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.w200)),
                                        ),
                                        Divider(
                                          height: 40.0,
                                          thickness: 1.5,
                                          indent: 32.0,
                                          endIndent: 32.0,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 32.0, right: 32.0),
                                          child: Align(
                                            child: Text(
                                                "Cadena de moto usada estilo Harley Davidson",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        82, 95, 127, 1),
                                                    fontSize: 17.0,
                                                    fontWeight:
                                                        FontWeight.w200)),
                                          ),
                                        ),
                                        SizedBox(height: 15.0),
                                        Align(
                                            child: Text("Ver detalles",
                                                style: TextStyle(
                                                    color: ArgonColors.primary,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 16.0))),
                                        SizedBox(height: 25.0),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 25.0, left: 25.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Chuy partes",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16.0,
                                                    color: ArgonColors.text),
                                              ),
                                              Text(
                                                "Detalles",
                                                style: TextStyle(
                                                    color: ArgonColors.primary,
                                                    fontSize: 13.0,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 250,
                                          child: GridView.count(
                                              primary: false,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 24.0,
                                                  vertical: 15.0),
                                              crossAxisSpacing: 10,
                                              mainAxisSpacing: 10,
                                              crossAxisCount: 3,
                                              children: <Widget>[
                                                Container(
                                                    height: 100,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  6.0)),
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              "https://firebasestorage.googleapis.com/v0/b/go-pitts.appspot.com/o/products%2F0Ea6IA7dqW5dNjiAXIYb%2FimageOrder?alt=media&token=cc414335-802c-4b33-bdfe-b13c446137c5"),
                                                          fit: BoxFit.cover),
                                                    )),
                                                Container(
                                                    decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(6.0)),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          "https://firebasestorage.googleapis.com/v0/b/go-pitts.appspot.com/o/products%2F5Voh4cxVR0zcM8WutK6V%2FimageOrder?alt=media&token=2b2ff8b4-8c3d-4819-8a98-126cc9e0a28f"),
                                                      fit: BoxFit.cover),
                                                )),
                                                Container(
                                                    decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(6.0)),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          "https://firebasestorage.googleapis.com/v0/b/go-pitts.appspot.com/o/products%2FFwQE54w2Ier7KtOQSJ3b%2FimageOrder?alt=media&token=68a42ff2-80fe-4eb8-ab68-c9c6d1186537"),
                                                      fit: BoxFit.cover),
                                                )),
                                                Container(
                                                    decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(6.0)),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          "https://firebasestorage.googleapis.com/v0/b/go-pitts.appspot.com/o/products%2FFwQE54w2Ier7KtOQSJ3b%2FimageOrder?alt=media&token=68a42ff2-80fe-4eb8-ab68-c9c6d1186537"),
                                                      fit: BoxFit.cover),
                                                )),
                                                Container(
                                                    decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(6.0)),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          "https://firebasestorage.googleapis.com/v0/b/go-pitts.appspot.com/o/products%2FRhRylKFCY1vm2HmPBog9%2FimageOrder?alt=media&token=5c1418fb-24bc-42fb-83ee-ee4bf509474b"),
                                                      fit: BoxFit.cover),
                                                )),
                                                Container(
                                                    decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(6.0)),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          "https://firebasestorage.googleapis.com/v0/b/go-pitts.appspot.com/o/products%2FlOkXhr2NiDM87nz78vxQ%2FimageOrder?alt=media&token=4e704cac-11dd-405e-a246-9aa268e29b75"),
                                                      fit: BoxFit.cover),
                                                )),
                                              ]),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ),
                      FractionalTranslation(
                          translation: Offset(0.0, -0.5),
                          child: Align(
                            child: CircleAvatar(
                              backgroundImage: AssetImage(
                                  "assets/img/product.png"),
                              radius: 65.0,
                              // maxRadius: 200.0,
                            ),
                            alignment: FractionalOffset(0.5, 0.0),
                          ))
                    ]),
                  ],
                ),
              ),
            ]),
          )
        ]));
  }
}
