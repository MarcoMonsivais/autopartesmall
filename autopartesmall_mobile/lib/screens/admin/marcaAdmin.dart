import 'package:autopartes_mall/constants/Theme.dart';
import 'package:autopartes_mall/screens/admin/marcaAdd.dart';
import 'package:autopartes_mall/screens/search/searchByMarca.dart';
import 'package:autopartes_mall/widgets/navbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:autopartes_mall/screens/admin/marcaDetailsAdmin.dart';

class AdminMarca extends StatefulWidget {
  @override
  _AdminMarcaState createState() => _AdminMarcaState();
}

class _AdminMarcaState extends State<AdminMarca> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Navbar(
          title: "Marcas",
          backButton: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return AgregarMarca();}));
          },
          child: const Icon(Icons.add),
          backgroundColor: Colors.purpleAccent,
        ),
        body: SingleChildScrollView(
            child:
              StreamBuilder(
                stream: FirebaseFirestore.instance.collection('conf').doc('listas').collection('marca').snapshots(),
                // ignore: missing_return
                builder: (context, snapshot) {
                  return
                    GridView.builder (
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 5.0,
                          mainAxisSpacing: 5.0,
                        ),
                        physics: const NeverScrollableScrollPhysics( ),
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot ds = snapshot.data.docs[index];

                          return Center (
                              child:

                              GestureDetector(
                                onTap: (){

                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                    return MarcaDetail(ds.id, ds['name']);
                                  }));

                                },
                                child: Card(
                                  elevation: 0.6,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(6.0))),
                                  child: Row(
                                    children: [
                                      Flexible(
                                        flex: 1,
                                        child: Container(
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: NetworkImage(ds['img']),
                                                  fit: BoxFit.scaleDown,
                                                ))),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                          );
                        } );
                }

            )
        )
    );
  }

}