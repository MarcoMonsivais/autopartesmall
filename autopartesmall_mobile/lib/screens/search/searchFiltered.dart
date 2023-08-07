import 'package:autopartes_mall/constants/Theme.dart';
import 'package:autopartes_mall/screens/search/searchByMarca.dart';
import 'package:autopartes_mall/widgets/navbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class searchFilter extends StatefulWidget {
  @override
  _searchFilterState createState() => _searchFilterState();
}

class _searchFilterState extends State<searchFilter> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(
        title: "Marcas",
        backButton: true,
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
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot ds = snapshot.data.documents[index];

                      return Center (
                        child:

                        GestureDetector(
                          onTap: (){

                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return searchByM(ds['name']);
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