import 'package:autopartes_mall/constants/Theme.dart';
import 'package:autopartes_mall/widgets/card-horizontal.dart';
import 'package:autopartes_mall/widgets/drawer.dart';
import 'package:autopartes_mall/widgets/navbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MarcaDetail extends StatefulWidget {

  final String documentId, nameProduct;

  MarcaDetail(this.documentId, this.nameProduct);

  @override
  _MarcaDetailState createState() => _MarcaDetailState();
}

class _MarcaDetailState extends State<MarcaDetail> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Navbar(
          title: widget.nameProduct,
          backButton: true,
        ),
        backgroundColor: ArgonColors.bgColorScreen,
        // drawer: ArgonDrawer(currentPage: "productsAdmin"),
        body: Container(
            padding: EdgeInsets.only(right: 24, left: 24, bottom: 36),
            child: SingleChildScrollView(
              child: Column(
                children: [

                  FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('conf')
                        .doc('listas')
                        .collection('marca')
                        .doc(widget.documentId)
                        .get(),
                    // ignore: missing_return
                    builder: (context, snapshot) {
                      //DocumentSnapshot
                      DocumentSnapshot ds = snapshot.data;

                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.network(
                                ds['img'], width: 140.0, height: 140.0),
                            // Text(ds['marca']),
                            // Text(ds['price']),
                            Text(ds['name']),
                            // Text(ds['description']),

                          ],
                        ),
                      );
                    },
                  ),

                  Padding(
                    padding:
                    const EdgeInsets.only(left: 34.0, right: 34.0, top: 8),
                    child: RaisedButton(
                      textColor: ArgonColors.white,
                      color: ArgonColors.primary,
                      onPressed: () async {


                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Padding(
                          padding: EdgeInsets.only(
                              left: 16.0, right: 16.0, top: 12, bottom: 12),
                          child: Text("Comprar",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.0))),
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(left: 34.0, right: 34.0, top: 8),
                    child: RaisedButton(
                      textColor: ArgonColors.white,
                      color: ArgonColors.primary,
                      onPressed: () async {


                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Padding(
                          padding: EdgeInsets.only(
                              left: 16.0, right: 16.0, top: 12, bottom: 12),
                          child: Text("Eliminar",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.0))),
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(left: 34.0, right: 34.0, top: 8),
                    child: RaisedButton(
                      textColor: ArgonColors.white,
                      color: ArgonColors.primary,
                      onPressed: () async {


                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Padding(
                          padding: EdgeInsets.only(
                              left: 16.0, right: 16.0, top: 12, bottom: 12),
                          child: Text("Editar",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.0))),
                    ),
                  ),

                ],
              ),
            )
        )
    );
  }
}