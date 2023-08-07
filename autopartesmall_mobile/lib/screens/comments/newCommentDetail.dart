import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:autopartes_mall/screens/comments/commentDetails.dart';

class NewCommentDetail extends StatefulWidget {
  final String productId, comentId;

  NewCommentDetail(this.productId, this.comentId);

  @override
  _newCommentDetailState createState() => _newCommentDetailState();
}

class _newCommentDetailState extends State<NewCommentDetail> {

  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column( children: [
          SizedBox(height: 50,),
          Text('Escribe tu comentario'),
          SizedBox(height: 20.0,),
          TextFormField(
            controller: _titleController,
            keyboardType: TextInputType.emailAddress,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            autocorrect: false,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Titulo',
            ),
          ),
          SizedBox(height: 20.0,),
          Expanded(child:
          TextFormField(
            controller: _commentController,
            keyboardType: TextInputType.emailAddress,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            autocorrect: false,
            maxLines: 5,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Descrpción',
              alignLabelWithHint: true,
            ),
          ),
          ),
          SizedBox(height: 20.0,),

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
                      onPressed: () async {
                        try {
                          String nickname = 'curentUser';

                          await FirebaseFirestore.instance
                              .collection('products')
                              .doc(widget.productId)
                              .collection('comments')
                              .doc(widget.comentId)
                              .collection('commentDetail')
                              .add({
                            'title': _titleController.text,
                            'comment': _commentController.text,
                            'date': DateTime.now().toString(),
                            'rate': '0',
                            'user': nickname
                          });

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CommentDetails(widget.productId,widget.comentId)));
                        } catch (onError) {
                          print(onError.toString());
                        }
                      },
                      child: Text(
                        'Agregar comentario',
                        style: TextStyle(color: Colors.white),
                      )),
                ],
              ),
            ),
          ),
          SizedBox(height: 15,),

        ]
        ),
      ),
    );
  }

}