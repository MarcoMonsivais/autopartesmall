import 'package:autopartes_mall/constants/Theme.dart';
import 'package:autopartes_mall/screens/admin/dev/menuDeb.dart';
import 'package:autopartes_mall/screens/admin/marcaAdmin.dart';
import 'package:autopartes_mall/screens/admin/productsAdmin.dart';
import 'package:autopartes_mall/widgets/card-horizontal.dart';
import 'package:autopartes_mall/widgets/drawer.dart';
import 'package:autopartes_mall/widgets/navbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminMode extends StatefulWidget {

  @override
  _AdminModeState createState() => _AdminModeState();
}

class _AdminModeState extends State<AdminMode> {

  String productId, storeid, nameStore,imageURL;
  TextEditingController buscarController;
  final TextEditingController _confirmationController2 = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Navbar(
          title: "Admin Mode",
          searchBar: true,
          searchController: buscarController,
        ),
        // floatingActionButton: FloatingActionButton(
        //     onPressed: () async {
        //       List<String> ele = [];
        //
        //       // for (int i=0; i<ele.length;i++) {
        //       //   // print(ele[i]);
        //       //   await FirebaseFirestore.instance.collection('products').doc(ele[i]).update({'parte': 'generica'});
        //       // }
        //
        //       // FirebaseFirestore.instance.collection('products').doc('P9z9XcZc45hJmn8pIwqM').update({'parte':'generica'});
        //       // FirebaseFirestore.instance.collection('products').snapshots().forEach((element) {
        //       //   element.docs.forEach((element2) async {
        //       //     print(element2.id);
        //       //     //await FirebaseFirestore.instance.collection('products').doc(element2.id).update({'parte': 'generica'});
        //       //     print('done');
        //       //   });
        //       // });
        //     },
        //     child: const Icon(Icons.add),
        //     backgroundColor: Colors.purpleAccent,
        // ),
        // key: _scaffoldKey,
        drawer: ArgonDrawer(currentPage: "admin"),
        body: _body(context));
  }

  _body(context ) {
    return Container(
      padding: EdgeInsets.only(left: 24.0, right: 24.0),
      child: SingleChildScrollView(
        child: Column(
          children: [

            CardHorizontal(
                title: 'En desarrollo',
                img: 'https://images.assetsdelivery.com/compings_v2/putracetol/putracetol1808/putracetol180800305.jpg',
                tap: () {
                  _Confirmation();
                }),

            CardHorizontal(
                title: 'Marcas',
                img: 'https://e00-marca.uecdn.es/assets/multimedia/imagenes/2020/04/27/15879867959089.jpg',
                tap: () {

                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return AdminMarca();}));
                }),

            StreamBuilder(
              stream: FirebaseFirestore.instance.collection('products').where('status', isEqualTo: 'active').orderBy('date', descending: true).snapshots(),
              // ignore: missing_return
              builder: (context, snapshot) {

                for (var i = 0; i < snapshot.data.docs.length; ++i) {
                  try {

                    return
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: CardHorizontal(
                            cta: snapshot.data.docs.length.toString(),
                            title: 'Productos activos',
                            img: 'https://www.shareicon.net/data/128x128/2017/05/24/886398_add_512x512.png',
                            tap: () {

                              // Navigator.push(context, MaterialPageRoute(builder: (context) {
                              //   return productsAdminPage(ds.documentID, ds['name']);
                              // }));
                            }),
                      );

                  }
                  catch(onError){
                    return Text('error: ' +  onError.toString());
                    print(onError.toString());
                  }
                }

              },
            ),

            StreamBuilder(
              stream: FirebaseFirestore.instance.collection('products').where('status', isEqualTo: 'active').orderBy('date', descending: true).snapshots(),
              // ignore: missing_return
              builder: (context, snapshot) {

                for (var i = 0; i < snapshot.data.docs.length; ++i) {
                  try {

                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {

                          DocumentSnapshot ds = snapshot.data.docs[index];

                          return
                            Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: CardHorizontal(
                                  cta: '\$' + ds['price'],
                                  title: ds['marca'],
                                  img: ds['image'],
                                  tap: () {

                                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                                      return productsAdminPage(ds.id, ds['name']);
                                    }));
                                  }),
                            );
                        });

                  }
                  catch(onError){
                    print(onError.toString());
                  }
                }

              },
            ),
          ],
        ),
      ),
    );

  }

  Future<void> _Confirmation() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Escribe la contraseña'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextFormField(
                  controller: _confirmationController2,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Container(child:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  TextButton(
                    child: Text('Cancelar'),
                    onPressed: () {

                      Navigator.of(context).pop();
                    },
                  ),


                  TextButton(
                    child: Text('Aceptar'),
                    onPressed: () {
                      if(_confirmationController2.text == 'MDEV') {

                        Navigator.of(context)
                            .pushNamedAndRemoveUntil('/admin/dev/', (Route<dynamic> route) => false);

                        // Navigator.push(context, MaterialPageRoute(builder: (context) {return MenuDev();}));
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

}