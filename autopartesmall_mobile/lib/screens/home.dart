import 'package:autopartes_mall/screens/products/products.dart';
import 'package:autopartes_mall/widgets/card-horizontal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:autopartes_mall/constants/Theme.dart';
import 'package:autopartes_mall/src/globalVariables.dart' as Globals;
import 'package:autopartes_mall/widgets/navbar.dart';
import 'package:autopartes_mall/widgets/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String productId, storeid, nameStore,imageURL, name = '', uid = '';
  TextEditingController buscarController = new TextEditingController();
  bool isAdmin = false;

  @override
  void initState() {
    try {
    FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser.uid).get().then((value) {
        name = value.data()['userName'];
        uid = value.id;

        Globals.userid = value.id;

        if(uid == 'Bl6EVDqYtzOIEga0NgeJqfjCTy42') {
          isAdmin = true;
          Globals.isAdmin = true;
        }

        setState(() {
          name;
          uid;
          isAdmin;
        });

    });
    } catch(onError){
      print('ER: ' + onError.toString());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Navbar(
          title: name.isEmpty ? "¡Bienvenido!" : "¡Bienvenido " + name + "!",
          searchBar: true,
          categoryOne: "Filtrar",
          categoryTwo: "Vender",
          searchController: buscarController,
        ),
        backgroundColor: ArgonColors.bgColorScreen,
        drawer: ArgonDrawer(currentPage: "Home", uid: uid.length > 0 ? uid : '', isAdmin: isAdmin,),
        body: _body(context));
  }
  
  _body(context ) {
      return Container(
        padding: EdgeInsets.only(left: 24.0, right: 24.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              StreamBuilder(
                stream: FirebaseFirestore.instance.collection('products').where('status', isEqualTo: 'active').orderBy('date', descending: true).snapshots(),
                // ignore: missing_return
                builder: (context, snapshot) {

                  if(snapshot.connectionState=='ConnectionState.waiting'){
                    return Container();
                  }

                  if(snapshot.hasError){
                    return Container(
                      height: 100,
                      width: 100,
                      child: Column(
                        children: [
                          SizedBox(
                            width: 60,
                            height: 60,
                            child: CircularProgressIndicator(),
                          ),Padding(
                            padding: EdgeInsets.only(top: 16),
                            child: Text('Cargando...'),
                          )
                        ],
                      ),
                    );
                  }

                  if(snapshot.hasData){
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
                                          return productsPage(ds.id, ds['name']);
                                        }));
                                      }),
                                );
                            });
                      }
                      catch(onError){
                        print(onError.toString());
                        return Container();
                      }
                    }
                  }

                },
              ),
            ],
          ),
        ),
      );

  }

}
