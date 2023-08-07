import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:autopartes_mall/screens/comments/commentDetails.dart';

class Comments extends StatefulWidget {

  final String productId;

  Comments(this.productId);

  @override
  _commentsState createState() => _commentsState();
}

class _commentsState extends State<Comments> {

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 50,),
          Text('Todos los comentarios' ),
          StreamBuilder (
            stream: _db.collection ( 'products' ).doc ( widget.productId )
                .collection ( 'comments' ).orderBy ( 'date', descending: true )
                .snapshots ( ),
            // ignore: missing_return
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.documents.length < 1) {
                  return _noOrdersOnboarding ( );
                }

                try {
                  return ListView.builder (
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      return GestureDetector (
                        onTap: () {

                          DocumentSnapshot ds = snapshot.data.documents[index];

                          Navigator.push ( context, MaterialPageRoute ( builder: (
                              context) => CommentDetails ( widget.productId, ds.id ) ) );
                        },
                        child: Column (
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[

                            ListTile (
                              title: Text (
                                  snapshot.data.documents[index]['comment']
                                      .toString ( ) ),
                              subtitle: Text (
                                  snapshot.data.documents[index]['date']
                                      .toString ( ) ),
                            ),

                          ],
                        ),
                      );
                    },
                  );
                }
                catch (onError) {
                  print ( onError.toString ( ) );
                }
              } else if (snapshot.hasError) {
                return _ordersErrorOnboarding ( );
              } else {
                return Container (
                  alignment: Alignment.center,
                  child: CircularProgressIndicator ( ),
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