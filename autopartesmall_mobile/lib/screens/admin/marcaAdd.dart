import 'package:autopartes_mall/screens/admin/addSuccessMarca.dart';
import 'package:autopartes_mall/constants/Theme.dart';
import 'package:autopartes_mall/widgets/navbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

File _image;

class AgregarMarca extends StatefulWidget {

  @override
  _AgregarMarcaoState createState() => _AgregarMarcaoState();
}

class _AgregarMarcaoState extends State<AgregarMarca> {

  @override
  Widget build (BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () async {

          _image = await getImage(true);

          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return DetailScreen();
          }));
        },
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Align(
                  alignment: Alignment.center,
                  child: Text("Carga el logo de la marca",
                      style: TextStyle(fontSize: 30, color: ArgonColors.text)),
                ),
                SizedBox(height: 10,),

                Align(
                  alignment: Alignment.center,
                  child: Text("Agrega un logo en formato PNG con el fondo blanco para un mejor formato",
                    style: TextStyle(fontSize: 14, color: ArgonColors.muted,),
                    textAlign: TextAlign.center,),
                ),
                SizedBox(height: 20,),

                Hero(
                    tag: 'imageHero',
                    child: Image.asset('assets/img/addarticle.png')
                ),

              ],)
        ),
      ),
    );
  }

}

class DetailScreen extends StatefulWidget {

  @override
  DetailScreenState createState() => DetailScreenState();

}

class DetailScreenState extends State<DetailScreen> {

  double padTop = 20.0, padSide = 15.0;
  final marcaController = TextEditingController();
  final typeController = TextEditingController();
  final transmisionController = TextEditingController();
  final descripcionController = TextEditingController();
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final parteController = TextEditingController();

  String marcaId;
  String storeid;
  String nameStore = "anonymous";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Navbar(
          title: "Carga la información de tu producto",
          backButton: true,
        ),
        body: SafeArea(
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [

                  Row(
                    children: [
                      Expanded(
                        child:
                        Container(
                          height: 150,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(boxShadow: [
                                BoxShadow(
                                    color: ArgonColors.secondary,
                                    blurRadius: 8,
                                    spreadRadius: 0.3,
                                    offset: Offset(0, 3))
                              ]),
                              child: AspectRatio(
                                aspectRatio: 2 / 2,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: Image.file(
                                    _image,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  Divider(height: 3.0, thickness: 3.0,),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: padTop, left: padSide, right: padSide,),
                        child: TextField(
                            controller: nameController,
                            cursorColor: ArgonColors.muted,
                            style:
                            TextStyle(height: 0.85, fontSize: 14.0, color: ArgonColors.initial),
                            textAlignVertical: TextAlignVertical(y: 0.6),
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: ArgonColors.white,
                                hintStyle: TextStyle(
                                  color: ArgonColors.muted,
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4.0),
                                    borderSide: BorderSide(
                                        color: ArgonColors.border, width: 1.0, style: BorderStyle.solid)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4.0),
                                    borderSide: BorderSide(
                                        color: ArgonColors.border, width: 1.0, style: BorderStyle.solid)),
                                hintText: 'Nombre de la marca')),
                      ),
                      
                      Padding(
                        padding:
                        const EdgeInsets.only(left: 34.0, right: 34.0, top: 8),
                        child: RaisedButton(
                          textColor: ArgonColors.white,
                          color: ArgonColors.primary,
                          onPressed: () async {


                                FirebaseFirestore _db = FirebaseFirestore.instance;

                                await _db.collection ( 'conf' ).doc('listas').collection('marca').add ( {
                                  // 'date': DateTime.now ( ).toString ( ),
                                  'name': nameController.text,
                                  'img': '',
                                } ).then ( (value) {
                                  marcaId = value.id;
                                } );

                                List<File> _images = [];

                                _images.add ( _image );

                                if (_image != null) {
                                  DocumentReference sightingRef = _db.collection ( 'conf' ).doc('listas').collection('marca').doc(marcaId);
                                  await saveImages ( _images, sightingRef );
                                }

                                Navigator.push ( context,
                                    MaterialPageRoute ( builder: (context) {
                                      return successAddedMarca();
                                    } ) );
                              

                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Padding(
                              padding: EdgeInsets.only(
                                  left: 16.0, right: 16.0, top: 12, bottom: 12),
                              child: Text("Cargar marca",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600, fontSize: 16.0))),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }

  Future<void> saveImages(List<File> _images, DocumentReference ref) async {

    _images.forEach((image) async {
      try {
        String imageURL = await uploadFile(image, ref.path.toString());
        print('path to update: ' + ref.path);
        ref.update({"img": imageURL});
      }
      catch (onError){
        print('saveImages: '+ onError.toString());
      }
    });
  }

  Future<String> uploadFile(File _image,String pathFBStorage) async {
    try {
      Reference storageReference = FirebaseStorage.instance.ref().child('conf/listas/marca/' + nameController.text + '-logo');
      UploadTask uploadTask = storageReference.putFile(_image);
      await uploadTask.whenComplete(() => null);
      String returnURL;
      await storageReference.getDownloadURL().then((fileURL) {
        returnURL = fileURL;
      });
      return returnURL;
    }
    catch (onError) {
      print('upload error: ' + onError.toString());
    }
  }

}
Future<File> getImage(bool gallery) async {

  ImagePicker picker = ImagePicker();
  PickedFile pickedFile;

  pickedFile = await picker.getImage(source: ImageSource.gallery,);

  _image = File(pickedFile.path);
  return _image;

}
