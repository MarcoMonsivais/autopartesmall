import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:autopartes_mall/cons.dart';
import 'package:autopartes_mall/screens/comments/comments.dart';

class ProductDetails extends StatefulWidget {

  final String productId;

  ProductDetails(this.productId);

  @override
  _productDetailState createState() => _productDetailState();
}

class _productDetailState extends State<ProductDetails> {

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: [

                FutureBuilder(
                  future: _db
                      .collection('products')
                      .doc(widget.productId)
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
                          _headerPhoto(ds['image']),
                          Row(children: [
                            Expanded(
                                child: ListTile(
                                  title: Text(
                                    ds['name'],
                                    textAlign: TextAlign.left,
                                    style: TextStyle(color: Color(0xFF535353)),
                                  ),
                                  subtitle: Text(ds['rate'],
                                      textAlign: TextAlign.left),
                                )
                            ),
                            Expanded(
                                child: ListTile(
                                  title: Text(
                                    'Precio',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(color: Color(0xFF535353)),
                                  ),
                                  subtitle: Text(
                                      '\$' + ds['price'].toString() + ' M.N.',
                                      textAlign: TextAlign.right),
                                )),
                          ]),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(5),
                            child: ListView(
                              scrollDirection: Axis.vertical,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              children: [
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Column(children: [
                                    Text(
                                      ds['name'],
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                  ]),
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Column(children: [
                                    Text(
                                      'Publicado por: ' +
                                          ds['store'] +
                                          ' el día ' +
                                          ds['date'],
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 15.0),
                                    ),
                                  ]),
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Column(children: [
                                    Text(
                                      'Año del producto: ' +
                                          ds['year'] +
                                          '\n',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 15.0),
                                    ),
                                  ]),
                                ),
                                Divider(
                                  height: 3.0,
                                  thickness: 3.0,
                                  color: Colors.grey,
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Column(children: [
                                    Text(
                                      'Descripción del producto\n' +
                                          ds['description'],
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 15.0),
                                    ),
                                  ]),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                Center(
                  child: Text('Comentarios'),
                ),
                _comments(),
                Center(
                  child: Container(
                    width: 300,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () {
//                              Navigator.push(
//                                  context,
//                                  MaterialPageRoute(
//                                      builder: (context) =>
//                                          NewComment(widget.productId)));
                            },
                            child: Text(
                              'Comentar',
                              style: TextStyle(color: Colors.white),
                            )),
                        Container(
                          height: 20,
                          color: Colors.white,
                          width: 3.0,
                        ),
                        TextButton(
                            onPressed: () {

                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             ProductPayment(widget.productId)));
                            },
                            child: Text(
                              'Comprar',
                              style: TextStyle(color: Colors.white),
                            )),
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }

  _headerPhoto(String photoUrl) {
    if(photoUrl.length<=0) {
      return Image(image: AssetImage("assets/no_data.png"), height: 150);
    } else {
      return Image.network(photoUrl, height: 150,fit: BoxFit.fill);
    }
  }

  _comments() {
    return StreamBuilder(
      stream: _db.collection('products').doc(widget.productId).collection('comments').limit(5).orderBy('date', descending: true).snapshots(),
      // ignore: missing_return
      builder: (context, snapshot) {

        if (snapshot.hasData) {

          if (snapshot.data.documents.length < 1) {
            return _noOrdersOnboarding();
          }

          try {
            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {

                return GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Comments(widget.productId)));
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ListTile(
                        title: Text(snapshot.data.documents[index]['title'].toString()),
                        subtitle: Text(snapshot.data.documents[index]['date'].toString()),
                      ),
                    ],
                  ),
                );
              },
            );
          }
          catch(onError){
            print(onError.toString());
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
    );
  }

  _noOrdersOnboarding() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "No hay comentarios para este producto",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins'),
          ),
          Center(
            child: Text(
              "Este producto no ha recibido comentarios.\n Crea uno en el botón de abajo",
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
      width: double.infinity,
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
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