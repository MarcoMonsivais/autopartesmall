import 'package:autopartes_mall/screens/addProduct/succedAddedProduct.dart';
import 'package:autopartes_mall/constants/Theme.dart';
import 'package:autopartes_mall/src/globalVariables.dart';
import 'package:autopartes_mall/widgets/navbar.dart';
import 'package:autopartes_mall/widgets/input.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

import 'neededInformation.dart';

File _image;

File _image1;
bool imgOp1 = false;

File _image2;
bool imgOp2 = false;

File _image3;
bool imgOp3 = false;

List<String> typeList = [];

List<String> marcaList = [];

List<String> transmisionList = [];
//----------------------------------------------WIDGETS
class addProduct extends StatefulWidget {

  @override
  _addProductoState createState() => _addProductoState();
}

class _addProductoState extends State<addProduct> {

  @override
  void initState() {
    _getMarcaList();
    _getTypeList();
    _getTransmisionList();
    super.initState();
  }

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
                child: Text("Carga tus productos",
                    style: TextStyle(fontSize: 30, color: ArgonColors.text)),
              ),
              SizedBox(height: 10,),

              Align(
                alignment: Alignment.center,
                child: Text("Llena la siguiente información\npara tus artículos amostrar",
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

  String productId;
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
//                    Expanded(
//                      child: GestureDetector(
//                        onTap: () async {
//                          try {
//                            print('0.0');
//                            _image1 = await getImage ( true );
//
//                            print('1.0');
//                            setState(() {
//                              imgOp1 = true;
//                            });
//
//                          } catch(onError){
//                            print(onError.toString());
//                          }
//                        },
//                        child:
//                        Container(
//                          height: 150,
//                          child: Padding(
//                            padding: const EdgeInsets.all(8.0),
//                            child: Container(
//                              decoration: BoxDecoration(boxShadow: [
//                                BoxShadow(
//                                    color: Colors.transparent,
//                                    blurRadius: 8,
//                                    spreadRadius: 0.3,
//                                    offset: Offset(0, 3))
//                              ]),
//                              child: AspectRatio(
//                                aspectRatio: 2 / 2,
//                                child: ClipRRect(
//                                  borderRadius: BorderRadius.circular(4),
//                                  child: _imageAdded1()
//                                ),
//                              ),
//                            ),
//                          ),
//                        ),
//                      ),
//                    ),
//                    Expanded(
//                      child: GestureDetector(
//                        onTap: () async {
//                          try {
//                            _image2 = await getImage ( true );
//
//                            print('1.0');
//                            setState(() {
//                              imgOp2 = true;
//                            });
//
//                          } catch(onError){
//                            print(onError.toString());
//                          }
//                        },
//                        child:
//                        Container(
//                          height: 150,
//                          child: Padding(
//                            padding: const EdgeInsets.all(8.0),
//                            child: Container(
//                              decoration: BoxDecoration(boxShadow: [
//                                BoxShadow(
//                                    color: Colors.transparent,
//                                    blurRadius: 8,
//                                    spreadRadius: 0.3,
//                                    offset: Offset(0, 3))
//                              ]),
//                              child: AspectRatio(
//                                aspectRatio: 2 / 2,
//                                child: ClipRRect(
//                                    borderRadius: BorderRadius.circular(4),
//                                    child: _imageAdded2()
//                                ),
//                              ),
//                            ),
//                          ),
//                        ),
//                      ),
//                    ),
//                    Expanded(
//                      child: GestureDetector(
//                        onTap: () async {
//                          try {
//                            _image3 = await getImage ( true );
//
//                            print('1.0');
//                            setState(() {
//                              imgOp3 = true;
//                            });
//                          } catch(onError){
//                            print(onError.toString());
//                          }
//                        },
//                        child:
//                        Container(
//                          height: 150,
//                          child: Padding(
//                            padding: const EdgeInsets.all(8.0),
//                            child: Container(
//                              decoration: BoxDecoration(boxShadow: [
//                                BoxShadow(
//                                    color: Colors.transparent,
//                                    blurRadius: 8,
//                                    spreadRadius: 0.3,
//                                    offset: Offset(0, 3))
//                              ]),
//                              child: AspectRatio(
//                                aspectRatio: 2 / 2,
//                                child: ClipRRect(
//                                    borderRadius: BorderRadius.circular(4),
//                                    child: _imageAdded3()
//                                ),
//                              ),
//                            ),
//                          ),
//                        ),
//                      ),
//                    ),
                  ],
                ),
                Divider(height: 3.0, thickness: 3.0,),
                Column(
                  children: [
                    // Padding(
                    //   padding: EdgeInsets.only(top: padTop, left: padSide, right: padSide,),
                    //   child: TextField(
                    //       controller: nameController,
                    //       cursorColor: ArgonColors.muted,
                    //       style:
                    //       TextStyle(height: 0.85, fontSize: 14.0, color: ArgonColors.initial),
                    //       textAlignVertical: TextAlignVertical(y: 0.6),
                    //       decoration: InputDecoration(
                    //           filled: true,
                    //           fillColor: ArgonColors.white,
                    //           hintStyle: TextStyle(
                    //             color: ArgonColors.muted,
                    //           ),
                    //           enabledBorder: OutlineInputBorder(
                    //               borderRadius: BorderRadius.circular(4.0),
                    //               borderSide: BorderSide(
                    //                   color: ArgonColors.border, width: 1.0, style: BorderStyle.solid)),
                    //           focusedBorder: OutlineInputBorder(
                    //               borderRadius: BorderRadius.circular(4.0),
                    //               borderSide: BorderSide(
                    //                   color: ArgonColors.border, width: 1.0, style: BorderStyle.solid)),
                    //           hintText: 'Nombre de la pieza')),
                    // ),
                    Padding(
                      padding: EdgeInsets.only(top: padTop, left: padSide, right: padSide,),
                      child: DropDownField(
                        hintText: 'Tipo de vehículo',
                        controller: typeController,
                        items: typeList,
                        enabled: true,
                        strict: true,
                        onValueChanged: (value) {
                          print(value);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: padTop, left: padSide, right: padSide,),
                      child: DropDownField(
                        controller: marcaController,
                        hintText: 'Marca',
                        items: marcaList,
                        enabled: true,
                        strict: true,
                        onValueChanged: (value) {
                          print(value);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: padTop, left: padSide, right: padSide,),
                      child: DropDownField(
                        controller: transmisionController,
                        hintText: 'Transmisión',
                        items: transmisionList,
                        enabled: true,
                        strict: true,
                        onValueChanged: (value) {
                          print(value);
                        },
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child:
                          Padding(
                            padding: EdgeInsets.only(top: padTop, left: padSide, right: padSide,),
                            child: TextField(
                                controller: parteController,
                                keyboardType: TextInputType.text,
                                cursorColor: ArgonColors.muted,
                                style: TextStyle(height: 0.85, fontSize: 14.0, color: ArgonColors.initial),
                                textAlignVertical: TextAlignVertical(y: 0.6),
                                textCapitalization: TextCapitalization.sentences,
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
                                    hintText: 'Parte')),
                          ),
                        ),
                        Expanded(
                          child:
                          Padding(
                            padding: EdgeInsets.only(top: padTop, left: padSide, right: padSide,),
                            child: TextField(
                                controller: priceController,
                                keyboardType: TextInputType.number,
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
                                    hintText: 'Precio')),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: padTop, left: padSide, right: padSide,),
                        child: TextField(
                            controller: descripcionController,
                            maxLines: 3,
                            cursorColor: ArgonColors.muted,
                            style: TextStyle(height: 0.85, fontSize: 14.0, color: ArgonColors.initial),
                            textCapitalization: TextCapitalization.sentences,
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
                                hintText: 'Descripción general')),
                      ),
                    Padding(
                          padding:
                          const EdgeInsets.only(left: 34.0, right: 34.0, top: 8),
                          child: RaisedButton(
                            textColor: ArgonColors.white,
                            color: ArgonColors.primary,
                            onPressed: () async {

                              int validation = 0;

                              if(typeController.text!=''){validation++;}
                              if(marcaController.text!=''){validation++;}
                              if(priceController.text!=''){validation++;}
                              if(parteController.text!=''){validation++;}

                              marcaList.forEach((element) {
                                if(element == marcaController.text){
                                  validation++;
                                }
                              });

                              if(validation == 5) {
                                try {
                                  FirebaseFirestore _db = FirebaseFirestore.instance;

                                  await _db.collection ( 'products' ).add ( {
                                    'date': DateTime.now ( ).toString ( ),
                                    'description': descripcionController.text,
                                    'name': parteController.text + ' ' + marcaController.text,
                                    'image': '',
                                    'price': priceController.text,
                                    'parte': parteController.text,
                                    'rate': '',
                                    'store': nameStore,
                                    'user': userid,
                                    'marca': marcaController.text,
                                    'transmision': transmisionController.text,
                                    'type': typeController.text,
                                    'status': 'pendent'
                                  } ).then ( (value) {
                                    productId = value.id;
                                  } );

                                  List<File> _images = [];

                                  _images.add ( _image );

                                  if (_image != null) {
                                    DocumentReference sightingRef = _db
                                        .collection ( 'products' ).doc (
                                        productId );
                                    print ( sightingRef.path );
                                    await saveImages ( _images, sightingRef );
                                  }

                                  if(userid.isNotEmpty) {

                                    await _db.collection ( 'products' ).doc(productId).update({
                                      'status': 'active'
                                    });

                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                          successAddedProduct();
                                    }));
                                  } else {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                          NeededInfo(productId);
                                        }));
                                  }

                              } catch (onError) {
                                  print ( onError.toString ( ) );
                                }
                              } else {
                                if(validation == 4){
                                  _showMyDialog('Debes seleccionar una marca valida', context);
                                } else {
                                  _showMyDialog('Hacen falta llenar los datos obligatorios', context);
                                }
                              }

                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Padding(
                                padding: EdgeInsets.only(
                                    left: 16.0, right: 16.0, top: 12, bottom: 12),
                                child: Text("Vender",
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
        ref.update({"image": imageURL});
      }
      catch (onError){
        print('saveImages: '+ onError.toString());
      }
    });
  }

  Future<String> uploadFile(File _image,String pathFBStorage) async {
    try {
      Reference storageReference = FirebaseStorage.instance.ref().child(pathFBStorage + '/imageOrder');
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

//_imageAdded1(){
//  print('0');
//  if(imgOp1){
//    print('1');
//    return Image.file(_image1);
//  } else {
//    print('2');
//    return Image.asset('assets/img/add.png');
//  }
//
//}
//
//_imageAdded2(){
//
//  if(imgOp2){
//    return Image.file(_image2);
//  } else {
//    return Image.asset('assets/img/add.png');
//  }
//
//}
//
//_imageAdded3(){
//
//  if(imgOp3){
//    return Image.file(_image3);
//  } else {
//    return Image.asset('assets/img/add.png');
//  }
//
//}

Future<void> _showMyDialog(string, context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('AutopartesMall dice:\n'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(string),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Aceptar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<File> getImage(bool gallery) async {

  ImagePicker picker = ImagePicker();
  PickedFile pickedFile;

  pickedFile = await picker.getImage(source: ImageSource.gallery,);

  _image = File(pickedFile.path);
  return _image;

}
//----------------------------------------------LISTAS
_getTypeList() async {

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  await _db.collection('conf').doc('listas').collection('type').snapshots().forEach((element) {
//    print(element.documents.length);
    if(typeList.length==0) {
      for (var i = 0; i < element.docs.length; ++i) {
        DocumentSnapshot ds = element.docs[i];
        typeList.add ( ds['name'] );
      }
    }

  });

}

_getMarcaList() async {

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  await _db.collection('conf').doc('listas').collection('marca').snapshots().forEach((element) {
    if(marcaList.length==0) {
      for (var i = 0; i < element.docs.length; ++i) {
        DocumentSnapshot ds = element.docs[i];
        marcaList.add ( ds['name'] );
      }
    }

  });

}

_getTransmisionList() async {

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  await _db.collection('conf').doc('listas').collection('transmision').snapshots().forEach((element) {
//    print(element.documents.length);
    if(transmisionList.length==0) {
      for (var i = 0; i < element.docs.length; ++i) {
        DocumentSnapshot ds = element.docs[i];
        transmisionList.add ( ds['name'] );
      }
    }

  });

}