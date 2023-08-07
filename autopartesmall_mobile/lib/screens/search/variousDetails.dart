import 'dart:ui' as ui;
import 'package:autopartes_mall/constants/Theme.dart';
import 'package:autopartes_mall/screens/products/products.dart';
import 'package:autopartes_mall/src/globalVariables.dart';
import 'package:autopartes_mall/widgets/card-horizontal.dart';
import 'package:autopartes_mall/widgets/drawer.dart';
import 'package:autopartes_mall/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:autopartes_mall/screens/onboarding.dart';
// import 'package:autopartes_mall/screens/products/product_details.dart';
// import 'package:autopartes_mall/login/log_page.dart';
// import 'package:autopartes_mall/login/reg_page.dart';
import 'package:autopartes_mall/src/globalVariables.dart';
import 'package:firebase_auth/firebase_auth.dart';

class variousDetails extends StatefulWidget {

  final String parte;

  variousDetails(this.parte);

  @override
  State<variousDetails> createState() => variousDetailsState();

}

class variousDetailsState extends State<variousDetails> {

  final TextEditingController _nameinstructionsTextController = TextEditingController();

  TextEditingController buscarController = new TextEditingController();

  double filterSize = 13.0;
  String name = '' , vehicle = '', userName = '', userUid = '';

  bool filterMarca = true;

  int limitFilter = 4;

  var qry;

  Color clrs = Colors.black;

  List<String> ids = [];

  bool controlador = false;

  List<Product> lproducts = [];

  Product prd;

  @override
  void initState() {
    _Query();
    _filter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Navbar(
          title: 'Buscando ' + widget.parte,
          searchBar: true,
          searchController: buscarController,
        ),
        backgroundColor: ArgonColors.bgColorScreen,
        drawer: ArgonDrawer(currentPage: "Search", uid: userUid.length > 0 ? userUid : '', isAdmin: isAdmin,),
        body: SingleChildScrollView(
          child: Column(
            children: [

              controlador ?
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: lproducts.length,
                    itemBuilder: (context, index) {

                      return Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: CardHorizontal(
                        cta: '\$' + lproducts.elementAt(index).pprice,
                          title: lproducts.elementAt(index).pname,
                          img: lproducts.elementAt(index).pimg,
                          tap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return productsPage(lproducts.elementAt(index).pid, lproducts.elementAt(index).pname);
                            }));
                          }),
                        );

                    })
                )
                  : Container(
                      color: Colors.white,
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            "assets/img/product.png",
                            width: 200,),
                          const SizedBox(height: 10),
                          const Text(
                            "Sin productos registrados",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins'),
                          ),
                          const Center(
                            child: Text(
                              "No hay productos relacionados al filtro seleccionado",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Poppins'),
                            ),
                          )
                        ],
                      ),
                    )

            ],
          ),
        ));
  }

  _filter(){

    FirebaseFirestore.instance
        .collection('products')
        .where('status', isEqualTo: 'active')
        .orderBy('date', descending: true)
        .snapshots().forEach((element) {

      for (var i = 0; i < element.docs.length; ++i) {

        if(element.docs[i].data()['description'].toString().contains(widget.parte)){

          try {

            lproducts.add(
                Product(
                    pid: element.docs[i].id,
                    pimg: element.docs[i].data()['image'],
                    pname: element.docs[i].data()['name'],
                    pprice: element.docs[i].data()['price'],
                    prate: element.docs[i].data()['rate'],
                    pstore: element.docs[i].data()['store'],
                    pparte: element.docs[i].data()['parte']
                )
            );

          }
          catch (onerror) {
            print('Fatal error: ' + onerror.toString() + ' en posicion ' + i.toString());
          }
        }

        // print('proceso set finalizado');

      }

      // print('Leng: ' + lproducts.length.toString());

      if(lproducts.isNotEmpty) {
        setState(() {
          controlador = true;
        });
      }


    });

  }

  _Query(){

    if(name.isEmpty){
      if(vehicle.isEmpty){
        // print('qry 1');
        qry = FirebaseFirestore.instance
            .collection('products')
            .where('status', isEqualTo: 'active')
            .orderBy('date', descending: true).snapshots();
      } else {
        // print('qry 2');
        qry = FirebaseFirestore.instance
            .collection('products')
            .where('status', isEqualTo: 'active')
            .where('type', isEqualTo: vehicle)
            .orderBy('date', descending: true).snapshots();
      }
    } else {
      if(vehicle.isEmpty){
        // print('qry 3');
        qry = FirebaseFirestore.instance
            .collection('products')
            .where('status', isEqualTo: 'active')
            .where('marca', isEqualTo: name)
            .orderBy('date', descending: true).snapshots();
      } else {
        // print('qry 4');
        qry = FirebaseFirestore.instance
            .collection('products')
            .where('status', isEqualTo: 'active')
            .where('marca', isEqualTo: name)
            .where('type', isEqualTo: vehicle)
            .orderBy('date', descending: true).snapshots();
      }
    }

  }

}
