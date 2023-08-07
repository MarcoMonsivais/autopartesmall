import 'package:autopartes_mall/screens/products/products.dart';
import 'package:autopartes_mall/widgets/card-horizontal.dart';
import 'package:autopartes_mall/widgets/navbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class searchByM extends StatefulWidget {

  final String marcaName;

  searchByM(this.marcaName);

  @override
  _searchByMState createState() => _searchByMState();

}

class _searchByMState extends State<searchByM>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(
        backButton: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection('products').where('marca', isEqualTo: widget.marcaName).orderBy('date', descending: true).snapshots(),
            // ignore: missing_return
            builder: (context, snapshot) {
              if (snapshot.hasData) {

                if (snapshot.data.documents.length < 1) {
                  return _noOrdersOnboarding();
                }
                for (var i = 0; i < snapshot.data.documents.length; ++i) {
                  try {

                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) {

                          DocumentSnapshot ds = snapshot.data.docs[index];

                          return
                            Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: CardHorizontal(
                                  cta: ds['price'],
                                  title: ds['marca'],
                                  img: ds['image'],
                                  tap: () {

                                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                                      return productsPage(ds.id,ds['name']);
                                    }));
//                                    Navigator.of(context).pushNamedAndRemoveUntil('/search', (Route<dynamic> route) => false);

                                  }),
                            );
                        });

                  }
                  catch(onError){
                    print(onError.toString());
                  }
                }
            } else if (snapshot.hasError) {
              return _ordersErrorOnboarding();
            } else {
              return Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );

  }

  _noOrdersOnboarding() {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image(
            image: AssetImage("assets/no_data.png"),
            height: 200,
          ),
          SizedBox(height: 10),
          Text(
            "Sin ordenes registradas",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins'),
          ),
          Center(
            child: Text(
              "Cuando se termine una orden, aparecera en este apartado",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Poppins'),
            ),
          )
        ],
      ),
    );
  }

  _ordersErrorOnboarding() {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image(
            image: AssetImage("assets/error.png"),
            height: 200,
          ),
          SizedBox(height: 10),
          Text(
            "Ha ocurrido un error",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins'),
          ),
          Center(
            child: Text(
              "Inténtalo de nuevo más tarde",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Poppins'),
            ),
          )
        ],
      ),
    );
  }

}