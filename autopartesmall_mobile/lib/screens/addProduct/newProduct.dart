import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
//import 'package:autopartes_mall/cons.dart';
import 'package:autopartes_mall/screens/home.dart';
import 'package:autopartes_mall/src/globalVariables.dart';
import 'package:image_picker/image_picker.dart';

class NewProduct extends StatefulWidget {

  @override
  _newProductoState createState() => _newProductoState();
}

class _newProductoState extends State<NewProduct> {

  final TextEditingController _categoryController = new TextEditingController( );
  final TextEditingController _dateCotroller = new TextEditingController( );
  final TextEditingController _descriptionController = new TextEditingController( );
  final TextEditingController _imageController = new TextEditingController( );
  final TextEditingController _nameController = new TextEditingController( );
  final TextEditingController _priceController = new TextEditingController( );
  final TextEditingController _rateController = new TextEditingController( );
  final TextEditingController _storeController = new TextEditingController( );
  final TextEditingController _userController = new TextEditingController( );
  final TextEditingController _yearController = new TextEditingController( );

  String productId;
  String storeid;
  String nameStore;
  String imageURL;
  String _chosenValue;

  List<String> litems = [];
  File _image;
  bool countImage = false;

//  List<String> litems;
//  List<File> _images;
//  File _image;
//  bool countImage;
//  ImagePicker picker = ImagePicker ( );
//  PickedFile pickedFile;

//  @override
//  void initState() {
//    // TODO: implement initState
//    super.initState();
//    countImage = false;
//    litems = [];
//   _images = [];
//  }

  @override
  Widget build (BuildContext context) {
    return Scaffold (
      body: Stack( children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/img/back.png"),
                  fit: BoxFit.cover))),
        SafeArea (
          child: Padding (
            padding: EdgeInsets.all ( 20.0 ),
            child: ListView (
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: [

                _uploadImage ( ),
                Center ( child:
                  DropdownButton<String> (
                  value: _chosenValue,
                  //elevation: 5,
                  style: TextStyle ( color: Colors.black ),

                  items: <String>[
                    "Otras",
                    "Chásis",
                    "Manubrios",
                    "Llantas",
                    "Motor",
                    "Cadenas",
                    "Asientos",
                    "Espejos"
                  ].map<DropdownMenuItem<String>> ( (String value) {
                    return DropdownMenuItem<String> (
                      value: value,
                      child: Text ( value ),
                    );
                  } ).toList ( ),
                  hint: Text (
                    "Categoria del producto",
                    style: TextStyle (
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600 ),
                  ),
                  onChanged: (String value) {
                    setState ( () {
                      _chosenValue = value;
                    } );
                  },
                ),
                ),
                TextFormField (
                  controller: _nameController,
                  keyboardType: TextInputType.multiline,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration (
                      border: OutlineInputBorder ( ), labelText: 'Nombre' ),
                ),
                SizedBox ( height: 20.0 / 2, ),
                Row (
                  children: [
                    Expanded (
                      child: TextFormField (
                        controller: _priceController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration (
                            border: OutlineInputBorder ( ),
                            labelText: 'Precio',
                            suffixText: 'M.N',
                            prefixText: '\$' ),
                      ),
                    ),
                    Expanded (
                      child: TextFormField (
                        controller: _yearController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration (
                            border: OutlineInputBorder ( ), labelText: 'Año' ),
                      ),
                    ),
                  ],
                ),
                SizedBox ( height: 20.0 / 2, ),
                TextFormField (
                  controller: _descriptionController,
                  keyboardType: TextInputType.multiline,
                  textCapitalization: TextCapitalization.sentences,
                  maxLines: 4,
                  decoration: InputDecoration (
                      border: OutlineInputBorder ( ),
                      alignLabelWithHint: true,
                      labelText: 'Descripcion' ),
                ),
                SizedBox ( height: 20.0 / 2, ),
                Container (
                  width: 500,
                  color: Colors.blue,
                  child: TextButton ( onPressed: () async {
                    if(_categoryController.text==''&&_nameController.text==''&&_priceController.text=='') {
                      _showMyDialog('Debes agregar la información faltante');
                    } else {
                      try {
                        FirebaseFirestore _db = FirebaseFirestore.instance;

                        await _db.collection ( "store" ).where (
                            'user', isEqualTo: userid ).get ( ).then ( (
                            querySnapshot) {
                          querySnapshot.docs.forEach ( (result) {
                            storeid = result.id;
                          } );
                        } );

                        await _db.collection ( 'store' ).doc (
                            storeid ).get ( ).then ( (value) =>
                        nameStore = value.data()['name'] );

                        if (nameStore.isEmpty) {
                          await _db.collection ( 'users' ).doc (
                              userid ).get ( ).then ( (value) =>
                          nameStore = value.data()['userEmail'] );
                        }

                        await _db.collection ( 'products' ).add ( {
                          'category': _chosenValue,
                          'date': DateTime.now ( ).toString ( ),
                          'description': _descriptionController.text,
                          'image': '',
                          'name': _nameController.text,
                          'price': _priceController.text,
                          'rate': '',
                          'store': nameStore,
                          'user': userid,
                          'year': _yearController.text
                        } ).then ( (value) {
                          productId = value.id;
                        } );


                        List<File> _images = [];

                        _images.add(_image);

  //                      DocumentReference sightingRef = _db.collection ( 'products' ).document ( productId );

  //                      print ( _images.first.path + ' / ' + sightingRef.path );

                        if(_image!=null) {
                          DocumentReference sightingRef  =_db.collection ( 'products' ).doc ( productId );
                          await saveImages(_images, sightingRef);
                        }

  //                      _showMyDialog ( productId );


  //                      Navigator.push ( context, MaterialPageRoute ( builder: (context) => HomeScreen ( ) ) );

                      } catch (onError) {
                        _showMyDialog ( 'Error fatal:' + onError.toString ( ) );
                      }
                    }
                  },
                      child: Text (
                        'Ingresar', style: TextStyle ( color: Colors.white ), ) ),
                )

              ],
            ),
          ),
        ),
    ])
    );
  }

  Widget _uploadImage() {
    if(countImage == false) {
      return Container(child:
      Row(
          children: <Widget>[
            Expanded(child:
            Text(
              "Cargar imagen",
              style: TextStyle(
                  fontSize: 18.0, fontFamily: 'Poppins'),
            ),
            ),
            Expanded(child:
            TextButton(
              child: Icon(
                Icons.photo_album,
                size: 40,
//                  color: Colors.blueAccent,
              ),
              onPressed: () async {
                try {
                  countImage = true;
                  _image = await getImage(true);
                }
                catch (onError) {
                  _showMyDialog('Error: ' + onError.toString());
//                    ErrorsPage( onError.toString(), 'Agregar Imagen desde Galeria');
                }
              },
            ),
            ),
            Text(
              " ó ",
              style: TextStyle(
                  fontSize: 18.0, fontFamily: 'Poppins'),
            ),
            Expanded(child:
            TextButton(
              child: Icon(
                Icons.add_a_photo,
                size: 40,
                color: Colors.blueAccent,
              ),
              onPressed: () async {
                try {
                  countImage = true;
                  _image = await getImage(false);
                }
                catch (onError) {
                  _showMyDialog('Error: ' + onError.toString());
                  //                  ErrorsPage(
                  //                      onError.toString(),
                  //                      'Agregar Imagen desde camara');
                }
              },
            ),
            ),
            SizedBox(height: 10.0 * 2),
          ]
      ),
      );
    } else {
      //Agregar otra imagen
      return Container(
          child: ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: <Widget> [
              Text(
                "Imagen Cargada",
                style: TextStyle(
                    fontSize: 18.0, fontFamily: 'Poppins'),
              ),
              SizedBox(height: 10.0 * 2),
              Image.file(_image,width: 90, height: 90,)
            ],
          )
      );
    }
  }

  Future<File> getImage(bool gallery) async {

    ImagePicker picker = ImagePicker();
    PickedFile pickedFile;

    if(gallery) {
      pickedFile = await picker.getImage(
        source: ImageSource.gallery,);
    }
    else{
      pickedFile = await picker.getImage(
        source: ImageSource.camera,);
    }

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path); // Use if you only need a single picture
        _showMyDialog('Imagen cargada exitosamente');
        return _image;
      } else {
        print('No image selected.');
      }
    });
  }


//  Widget _uploadImage () {
//    if (countImage==false) {
//      return Container ( child:
//        Row (
//          children: <Widget>[
//            Expanded ( child:
//              TextButton (
//                child: Icon (
//                  Icons.photo_album,
//                  size: 40,
//                  color: GPTextColor,
//                ),
//                onPressed: () async {
//                  try {
//                    _showMyDialog('inicio ' + countImage.toString());
//
//                    pickedFile = await picker.getImage ( source: ImageSource.gallery, );
//
//                    _showMyDialog('Imagen cargada exitosamente ' + pickedFile.path);
//
//                    if (pickedFile != null) {
//                      _showMyDialog('sdf');
//                      setState ( () {
//                        _image = File ( pickedFile.path );
//                        countImage = true;
//                      } );
//                    } else {
//                      _showMyDialog('No image selected ' + pickedFile.path + countImage.toString() + _image.path);
//                    }
//                  }
//                  catch (onError) {
//                    _showMyDialog ( 'Upload1: ' + onError.toString ( ) + ' countImage: ' + countImage.toString ( ) );
//                  }
//                },
//              ),
//            ),
////            Text (
////              " ó ",
////              style: TextStyle (
////                  fontSize: 20
////              ),
////            ),
////            Expanded ( child:
////              TextButton (
////                child: Icon (
////                  Icons.add_a_photo,
////                  size: 40,
////                  color: GPTextColor,
////                ),
////                onPressed: () async {
////                  try {
////                    _image = await getImage ( false );
////                  }
////                  catch (onError) {
////                    _showMyDialog (
////                        'Upload2: ' + onError.toString ( ) + ' countImage: ' +
////                            countImage.toString ( ) );
////                    print ( 'upimg: ' + onError.toString ( ) );
////                  }
////                },
////              ),
////            ),
////            SizedBox ( height: GPDefaultPaddin * 2 ),
//          ]
//      ),
//      );
//    } else {
//      return Container (
//          child: ListView (
//            scrollDirection: Axis.vertical,
//            shrinkWrap: true,
//            children: <Widget>[
//              Text (
//                "Imagen Cargada",
//                style: TextStyle ( fontSize: 20 ),
//              ),
//              SizedBox ( height: GPDefaultPaddin * 2 ),
//              Image.file ( _image, width: 90, height: 90, ),
////              _existImage()
//            ],
//          )
//      );
//    }
//  }

//  _existImage () {
//    if(countImage) {
//      return Image.file ( _image, width: 90, height: 90, );
//    } else {
//      return Text('Error');
//    }
//  }

//  Future<File> getImage(bool gallery) async {
//    print('2');
//    try {
//
//      if (gallery) {
//        print('3');
//        pickedFile = await picker.getImage ( source: ImageSource.gallery, );
//        print('4');
//      }
//      else {
//        pickedFile = await picker.getImage ( source: ImageSource.camera, );
//      }
//
//      _showMyDialog('Imagen cargada exitosament');
//      print('5');
//      if (pickedFile != null) {
//        print('6');
//        setState ( () {
//          print('7');
//          _image = File ( pickedFile.path );
//          countImage = true;
//          return _image;
//        } );
//      } else {
//        print ( 'No image selected.' );
//      }
//
//    }
//    catch(onError) {_showMyDialog('getIma: ' + onError.toString() + ' countImage: ' + countImage.toString());}
//  }

//  Future<void> saveImages(List<File> _images, DocumentReference ref) async {
//    try {
//      _images.forEach((image) async {
//          String imageURL = await uploadFile(image, ref.path.toString());
//          ref.updateData({"image": imageURL});});
//    } catch (onError){
//        _showMyDialog('Error save: ' + onError.toString());
//    }
//  }

//  Future<String> uploadFile(File _image,String pathFBStorage) async {
//    try {
//      StorageReference storageReference = FirebaseStorage.instance.ref().child(pathFBStorage + '/imageOrder');
//      StorageUploadTask uploadTask = storageReference.putFile(_image);
//      await uploadTask.onComplete;
//      String returnURL;
//      await storageReference.getDownloadURL().then((fileURL) {
//        returnURL = fileURL;
//      });
//      return returnURL;
//    }
//    catch (onError) {
//      _showMyDialog('Error upload: ' + onError.toString());
//    }
//  }

  Future<void> saveImages(List<File> _images, DocumentReference ref) async {

    _images.forEach((image) async {
      try {
        String imageURL = await uploadFile(image, ref.path.toString());
//        ref.updateData({"addimageURL": FieldValue.arrayUnion([imageURL])});
        ref.update({"image": imageURL});
      }
      catch (onError){
        _showMyDialog('Error1: ' + onError.toString());
//        Navigator.push(context,MaterialPageRoute(builder: (context) => ErrorsPage(onError.toString(),'Guardar imagen')));
//        ErrorsPage(onError.toString(),'Guardar imagen');
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
      _showMyDialog('Error2: ' + onError.toString());
//      Navigator.push(context,MaterialPageRoute(builder: (context) => ErrorsPage(onError.toString(),'Cargar imagen')));
//      ErrorsPage(onError.toString(),'Cargar imagen');
    }
  }

  Future<void> _showMyDialog(string) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('GoPits App:'),
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

}