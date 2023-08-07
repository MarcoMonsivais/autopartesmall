import 'dart:io' as i;
import 'dart:html' as h;
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:apmall_web/global_variables.dart';
import 'package:apmall_web/src/various.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:apmall_web/on_boarding.dart';
import 'package:apmall_web/login/log_page.dart';
import 'package:apmall_web/login/reg_page.dart';
import 'package:apmall_web/global_variables.dart' as Globals;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dropdownfield2/dropdownfield2.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddProduct extends StatefulWidget {

  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => AddProductState();
}

class AddProductState extends State<AddProduct> {

  final TextEditingController _nameinstructionsTextController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  late String name = '' , vehicle = '', userName = '', userUid = '', ima = 'assets/img/puerta_demo.png', nameProduct = 'Nombre de producto asignado';

  final double devicePixelRatio = ui.window.devicePixelRatio;
  final ui.Size size = ui.window.physicalSize;
  late final double width;
  late final double height;

  int limitFilter = 4;
  double? filterSize = 13.0;

  double padTop = 20.0, padSide = 15.0;

  late var qry;

  Color clrs = Colors.black;
  late Product prd;

  late List<Product> lproducts = [];
  List<String> ids = [];

  final typeController = TextEditingController();
  final transmisionController = TextEditingController();
  final marcaController = TextEditingController();
  List<String> typeList = [];
  List<String> marcaList = [];
  List<String> transmisionList = [];

  bool controlador = false;
  bool filterMarca = true;
  late bool isTablet;
  late bool isPhone;
  bool showImage = false;

  // late i.File _image;
  // late h.File _image;
  // late Image imageWidget;
  late i.File _image;
  Uint8List? bytesFromPicker;
  String productId = '';

  // Registrar get registrar => null;

  @override
  void initState() {
    _checkDevice();
    _getMarcaList();
    _getTypeList();
    _getTransmisionList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    if(isPhone){
      return Container(
        color: Colors.white,
        width: double.infinity,
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/img/logo_am_completo.png",
              width: 200,),
            const SizedBox(height: 10),
            const Text(
              "¡Oops!",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins'),
            ),
            const Center(
              child: Text(
                "Estas visitando nuestra versión de escritorio desde un dispositivo móvil y la experencia de usuario puede ser diferente. Te recomendamos descargar nuestra aplicación en cualquiera de las dos plataformas.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Poppins'),
              ),
            ),

            GestureDetector(
              child: Image.asset(
                "assets/img/logo-android.png",
                width: 100,
                color: Colors.green,),
              onTap: () {
                _launchURL('https://play.google.com/store/apps/details?id=com.gopitts.autopartes_mall');
              },
            ),

            GestureDetector(
              child: Image.asset(
                "assets/img/logo-ios.png",
                width: 100,
                color: Colors.black,),
              onTap: () {
                _launchURL('https://apps.apple.com/app/id1594052679?fbclid=IwAR1lsCShvvLJAI3VpjZBAbS1Wrzcw6WMo1qLAFi0h4amV7W-BYqwrL4L6m4');
              },
            ),

          ],
        ),
      );
    } else {
      return Scaffold(
          body: Column(
            children: [

              //Encabezado de página
              Container(
                width: MediaQuery.of(context).size.width,
                height: 70,
                child: Column(
                  children: [

                    Container(
                      color: Colors.black87,
                      height: 70,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                        child: Row(
                          children: [

                            SizedBox(
                              width: 270,
                              child:
                              GestureDetector(
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "assets/img/autopartes.png", height: 60,
                                      width: 50,),
                                    Expanded(child:
                                    Row(
                                      children: const [
                                        Text(' AUTOPARTES ', style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0),),
                                        Expanded(child: Text('MALL',
                                          style: TextStyle(color: Colors.red,
                                              fontSize: 20.0),)),
                                      ],
                                    )
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                    return const OnBoarding();
                                  }));
                                },
                              ),
                            ),

                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 80.0),
                                child: Container(
                                  color: Colors.grey,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: TextFormField(
                                      controller: _nameinstructionsTextController,
                                      autocorrect: true,
                                      keyboardType: TextInputType.name,
                                      textCapitalization: TextCapitalization
                                          .words,
                                      onEditingComplete: () {

                                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                                          return variousDetails(_nameinstructionsTextController.text);
                                        }));

                                      },
                                      style: const TextStyle(
                                          fontSize: 15.0, color: Colors.white),
                                      decoration: const InputDecoration(
                                        hintText: 'Buscar producto',
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 25.0, horizontal: 10.0),
                                        // border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: _logged()
                            )

                          ],),
                      ),
                    ),

                  ],
                ),
              ),

              // Cuerpo
              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 270.0, right: 270.0, top: 30.0, bottom: 50.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 2,
                        ),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            bottomLeft: Radius.circular(8.0),
                            topRight: Radius.circular(8.0),
                            bottomRight: Radius.circular(8.0)
                        ),
                      ),
                      child: Row(
                          children: [

                            Expanded(
                              child: GestureDetector(
                                onTap: () async {
                                  try {

                                    bytesFromPicker = (await ImagePickerWeb.getImageAsBytes())!;
                                    _image = i.File.fromRawPath(bytesFromPicker!);
                                    showImage = true;

                                    // setState(() {
                                    //
                                    // });
                                  } catch (onError){
                                    print(onError);
                                  }
                                },
                                child: SizedBox(
                                    width: 600.0,
                                    child: showImage ?
                                      // imageWidget :
                                      Image.memory(bytesFromPicker!) :
                                      Image.asset('assets/img/addImages.png'),
                                ),
                              ),
                            ),

                            Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      Padding(
                                          padding: const EdgeInsets.only(top: 5.0),
                                          child: Text(
                                            nameProduct,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold
                                            ),
                                          )
                                      ),

                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          
                                          Padding(
                                            padding: const EdgeInsets.only(top: 10.0),
                                            child: Text(
                                                userName,
                                                style: const TextStyle(
                                                    color: Color.fromRGBO(94, 114, 228, 1.0),
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.normal)
                                            ),
                                          ),

                                          const SizedBox(width: 30,),

                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                Expanded(
                                                  child: GestureDetector(
                                                    onTap: () async {

                                                      int validation = 0;

                                                      if(typeController.text!=''){validation++;}
                                                      if(marcaController.text!=''){validation++;}
                                                      if(_priceController.text!=''){validation++;}
                                                      if(_descriptionController.text!=''){validation++;}

                                                      marcaList.forEach((element) {
                                                        if(element == marcaController.text){
                                                          validation++;
                                                        }
                                                      });

                                                      if(validation == 5) {
                                                        try {

                                                          FirebaseFirestore _db = FirebaseFirestore.instance;
                                                          //
                                                          // await _db.collection ( 'products' ).add ( {
                                                          //   'date': DateTime.now ( ).toString ( ),
                                                          //   'description': _descriptionController.text,
                                                          //   'name': nameProduct,
                                                          //   'image': '',
                                                          //   'price': _priceController.text,
                                                          //   'parte': '',//_p.text,
                                                          //   'rate': '',
                                                          //   'store': userName,
                                                          //   'user': Globals.userid,
                                                          //   'marca': marcaController.text,
                                                          //   'transmision': transmisionController.text,
                                                          //   'type': typeController.text,
                                                          //   'status': 'pendent'
                                                          // } ).then ( (value) {
                                                          //   productId = value.id;
                                                          // } );

                                                          // List<i.File> _images = [];
                                                          //
                                                          // _images.add ( _image );

                                                          productId = 'gmqDiBTkSwprbtolAMee';

                                                          List<i.File> _images = [];

                                                          // print('existe imagen: ' + _image.existsSync().toString());
                                                          print('0');
                                                          _images.add ( _image );
                                                          print('1');

                                                          if (_image != null) {
                                                            print('not null');
                                                            DocumentReference sightingRef = _db.collection ( 'products' ).doc (productId );
                                                            print ( sightingRef.path );
                                                            await saveImages ( _images, sightingRef );
                                                          }

                                                          // if(userid.isNotEmpty) {
                                                          //
                                                          //   await _db.collection ( 'products' ).doc(productId).update({
                                                          //     'status': 'active'
                                                          //   });
                                                          //   print('terminado');
                                                          //   // Navigator.push(context,
                                                          //   //     MaterialPageRoute(builder: (context) {
                                                          //   //       successAddedProduct();
                                                          //   //     }));
                                                          // } else {
                                                          //   print('Else');
                                                          //   // Navigator.push(context,
                                                          //   //     MaterialPageRoute(builder: (context) {
                                                          //   //       NeededInfo(productId);
                                                          //   //     }));
                                                          // }

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
                                                    child: Container(
                                                      width: MediaQuery.of(context).size.width * 0.12,
                                                      height: 20,
                                                      decoration: BoxDecoration(
                                                        color: Colors.blue,
                                                        borderRadius: BorderRadius.circular(6.0),
                                                      ),
                                                      child: const Center(
                                                        child: Text('Vender', style: TextStyle(color: Colors.white),),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 10,),
                                                Expanded(
                                                  child: GestureDetector(
                                                    onTap: () async {

                                                      nameProduct = 'Nombre de producto asignado';
                                                      _priceController.clear();
                                                      typeController.clear();
                                                      marcaController.clear();
                                                      transmisionController.clear();
                                                      _descriptionController.clear();
                                                      showImage = false;
                                                      setState(() {

                                                      });

                                                    },
                                                    child: Container(
                                                      width: MediaQuery.of(context).size.width * 0.12,
                                                      height: 20,
                                                      decoration: BoxDecoration(
                                                        color: Colors.blue,
                                                        borderRadius: BorderRadius.circular(6.0),
                                                      ),
                                                      child: const Center(
                                                        child: Text('Limpiar', style: TextStyle(color: Colors.white),),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                          
                                        ],
                                      ),
                                      
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10.0),
                                        child: TextFormField(
                                            controller: _priceController,
                                            keyboardType: TextInputType.number,
                                            decoration: const InputDecoration(
                                              hintText: 'Precio',
                                              prefixText: '\$',
                                              suffixText: ' M.N.',
                                              fillColor: Colors.white,
                                              border: InputBorder.none
                                            ),
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.normal)
                                        ),
                                      ),

                                      SizedBox(
                                        height: 210,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(left: padSide, right: padSide,),
                                                child: DropDownField(
                                                  hintText: 'Tipo de vehículo',
                                                  controller: typeController,
                                                  items: typeList,
                                                  enabled: true,
                                                  strict: true,
                                                  onValueChanged: (value) {
                                                    _defineName(value,0);
                                                  },
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(top: padTop / 2, left: padSide, right: padSide,),
                                                child: DropDownField(
                                                  controller: marcaController,
                                                  hintText: 'Marca',
                                                  items: marcaList,
                                                  enabled: true,
                                                  strict: true,
                                                  onValueChanged: (value) {
                                                    _defineName(value,1);
                                                  },
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(top: padTop / 2, left: padSide, right: padSide,),
                                                child: DropDownField(
                                                  controller: transmisionController,
                                                  hintText: 'Transmisión',
                                                  items: transmisionList,
                                                  enabled: true,
                                                  strict: true,
                                                  onValueChanged: (value) {
                                                    _defineName(value,2);
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      const Padding(
                                        padding: EdgeInsets.only(top: 10.0),
                                        child: Text(
                                            'Detalles',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold)
                                        ),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.only(top: 10.0),
                                        child: TextFormField(
                                            controller: _descriptionController,
                                            maxLines: 5,
                                            style: const TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.normal),
                                          decoration: const InputDecoration(
                                              hintText: 'Agrega la descripción de tu producto',
                                              fillColor: Colors.white,
                                              border: InputBorder.none
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                )
                            ),

                          ]
                      ),
                    ),
                  ),
              )

            ],
          ));
    }
  }

  Future<void> saveImages(List<i.File> _images, DocumentReference ref) async {
    print('-----------Save-------------');
    print('Values');
    // print('Image: ' + _images.isEmpty.toString());
    print('Referencia: ' + ref.path);

    _images.forEach((image) async {
      try {
        print('each1');
        String imageURL = await uploadFile(image, ref.path.toString());
        print('path to update save: ' + ref.path);
        ref.update({"image": imageURL});
      }
      catch (onError){
        print('saveImagesError: '+ onError.toString());
      }
    });

  }

  Future<String> uploadFile(i.File _image,String pathFBStorage) async {
    try {

      print('-----------Upload-------------');
      print('Values');
      // print('Image: ' + _image.path);
      print('Referencia: ' + pathFBStorage);

      print('1.1');
      Reference storageReference = FirebaseStorage.instance.ref().child(pathFBStorage + '/imageOrder');
      // Reference storageReference = FirebaseStorage.instance.ref().child(pathFBStorage + '/imageOrder');
      print('1.2');
      // Registrar registrar = Registrar(
      //
      // );
      UploadTask uploadTask2 = storageReference.putData(_image.readAsBytesSync());
      print('1.3.0');
      UploadTask uploadTask = storageReference.putFile(_image);
      print('1.3.1');
      // UploadTask uploadTask = storageReference.putFile(_image);
      // print('1.3');
      await uploadTask.whenComplete(() => null);
      print('1.4');
      String returnURL = '';
      // await storageReference.getDownloadURL().then((fileURL) {
      //   returnURL = fileURL;
      // });
      print('1.5');
      return returnURL;
    }
    catch (onError) {
      String returnURLError = '//';
      print('upload error: ' + onError.toString());
      return returnURLError;
    }
  }

  _defineName(String value, int op){

    String type = '', marca = '', transmision = '';

    switch(op){
      case 0:
        type = value;
        marca = marcaController.text;
        transmision = transmisionController.text;
        break;
      case 1:
        type = typeController.text;
        marca = value;
        transmision = transmisionController.text;
        break;
      case 2:
        type = typeController.text;
        marca = marcaController.text;
        transmision = value;
        break;
    }

    nameProduct = type + ' ' + marca + ' ' + transmision;

    setState(() {
      nameProduct;
    });

  }

  _logged() {

    try {
      Globals.logged = FirebaseAuth.instance.currentUser!.uid.isNotEmpty;
    } catch(onError){
      print('err ' + onError.toString());
    }

    if(!Globals.logged) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return RegisterPage();
                }));
              },
              child: const Text(
                '¡Crea tu cuenta!',
                style: TextStyle(color: Colors.white, fontSize: 10.0),
              )),
          GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LogginPage();
                }));
              },
              child: const Text(
                'INGRESA',
                style: TextStyle(color: Colors.white, fontSize: 12.0),
              ))
        ],
      );
    }
    else {

      FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get().then((value) {
        userName = value.data()!['userName'];
        userUid = value.id;
        setState(() {
          userName;
          userUid;
        });
      });

      return GestureDetector(
        onTap: (){
          FirebaseAuth.instance.signOut().whenComplete(() {
            setState(() {
              Globals.logged = false;
            });
            Navigator.of(context)
                .pushNamedAndRemoveUntil(
                '/onboarding', (Route<dynamic> route) => false);
          });
          print('perfil');
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('¡' + userName + ' bienvenido!', style: const TextStyle(color: Colors.white),),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width * 0.05,
              child: const CircleAvatar(
                backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'),
                radius: 65.0,
              ),
            ),
          ],
        ),
      );
    }

  }

  _checkDevice () {

    width = size.width;
    height = size.height;

    if(devicePixelRatio < 2 && (width >= 1000 || height >= 1000)) {
      isTablet = true;
      isPhone = false;
    }
    else if(devicePixelRatio == 2 && (width >= 1920 || height >= 1920)) {
      isTablet = true;
      isPhone = false;
    }
    else {
      isTablet = false;
      isPhone = true;
    }

  }

  _launchURL(String page) async {
    String url = page;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No puede abrirse el URL $url';
    }
  }

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

// Future<File> getImage(bool gallery) async {
//
//   ImagePicker picker = ImagePicker();
//   PickedFile pickedFile;
//
//   pickedFile = await picker.getImage(source: ImageSource.gallery,);
//
//   _image = File(pickedFile.path);
//   return _image;
//
// }

//----------------------------------------------LISTAS
  _getTypeList() async {

    final FirebaseFirestore _db = FirebaseFirestore.instance;

    await _db.collection('conf').doc('listas').collection('type').snapshots().forEach((element) {
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

}

