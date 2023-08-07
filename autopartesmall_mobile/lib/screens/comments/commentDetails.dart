import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:autopartes_mall/screens/comments/newCommentDetail.dart';

class CommentDetails extends StatefulWidget {

  final String productId, commentId;

  CommentDetails(this.productId,this.commentId);

  @override
  _commentDetailsState createState() => _commentDetailsState();
}

class _commentDetailsState extends State<CommentDetails> {

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [

          SizedBox(height: 50,),
          Text('Detalles de comentario'),

          Expanded(child: FutureBuilder(
                future: _db.collection('products')
                    .doc(widget.productId)
                    .collection('comments')
                    .doc(widget.commentId)
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
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(10),
                          child: ListView(
                            scrollDirection: Axis.vertical,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            children: [
                              Align(alignment: Alignment.topCenter,child: Column(children: [Text(ds['comment'], textAlign: TextAlign.left, style: TextStyle( fontSize: 18.0),),]),),
                              Align(alignment: Alignment.topLeft,child: Column(children: [Text(ds['date'], textAlign: TextAlign.left, style: TextStyle( fontSize: 15.0),),]),),
                              Row(
                                children: [
                                  Expanded( child: Align(alignment: Alignment.topLeft,child: Column(children: [Text(ds['rate'], textAlign: TextAlign.left, style: TextStyle( fontSize: 15.0),),]),),),
                                  Expanded( child: Align(alignment: Alignment.topRight,child: Column(children: [Text(ds['user'], textAlign: TextAlign.left, style: TextStyle( fontSize: 15.0),),]),),),
                                ],
                              ),

                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),),

          StreamBuilder (
            stream: _db.collection ( 'products' ).doc ( widget.productId )
                .collection ( 'comments' ).doc(widget.commentId).collection('commentDetail'). orderBy ( 'date', descending: true )
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
                          //rate
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

          Container(
            decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.all(Radius.circular(20))
            ),
            child: TextButton(child: Text('Agregar comentario',style: TextStyle(color: Colors.white),), onPressed: () async {

              Navigator.push(context, MaterialPageRoute(builder: (context) => NewCommentDetail(widget.productId,widget.commentId)));

            },),
          ),

          SizedBox(height: 10,),
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