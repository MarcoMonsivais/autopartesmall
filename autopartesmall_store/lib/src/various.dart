import 'dart:ui' as ui;
import 'package:apmall_web/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:apmall_web/on_boarding.dart';
import 'package:apmall_web/product_details.dart';
import 'package:apmall_web/login/log_page.dart';
import 'package:apmall_web/login/reg_page.dart';
import 'package:apmall_web/global_variables.dart' as Globals;
import 'package:firebase_auth/firebase_auth.dart';

class variousDetails extends StatefulWidget {

  final String parte;

  variousDetails(this.parte);

  @override
  State<variousDetails> createState() => variousDetailsState();

}

class variousDetailsState extends State<variousDetails> {

  final TextEditingController _nameinstructionsTextController = TextEditingController();
  double? filterSize = 13.0;
  late String name = '' , vehicle = '', userName = '', userUid = '';

  late bool isTablet;
  late bool isPhone;

  bool filterMarca = true;

  final double devicePixelRatio = ui.window.devicePixelRatio;
  final ui.Size size = ui.window.physicalSize;
  late final double width;
  late final double height;

  int limitFilter = 4;

  String ima = 'assets/img/puerta_demo.png';

  late var qry;

  Color clrs = Colors.black;

  List<String> ids = [];

  bool controlador = false;

  late List<Product> lproducts = [];

  late Product prd;

  @override
  void initState() {
    _checkDevice();
    _Query();
    _filter();
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
                                      textCapitalization: TextCapitalization.words,
                                      onEditingComplete: () {

                                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                                          return variousDetails(_nameinstructionsTextController.text);
                                        }));

                                      },
                                      style: const TextStyle(
                                          fontSize: 15.0, color: Colors.white),
                                      decoration: InputDecoration(
                                        hintText: 'Busqueda para ' + widget.parte,
                                        contentPadding: const EdgeInsets.symmetric(
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
                  child: Stack(
                      children: [

                        // TextButton(onPressed: () {
                        //   setState(() {
                        //
                        //   });
                        // }, child: Text('refresh')),

                        controlador ?
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                          child: Scrollbar(
                            isAlwaysShown: true,
                            child: SingleChildScrollView(
                              child: GridView.builder(
                                  shrinkWrap: true,
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 5,
                                    crossAxisSpacing: 3.0,
                                    mainAxisSpacing: 3.0,
                                    childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height * 2.8),
                                  ),
                                  itemCount: lproducts.length,
                                  itemBuilder: (context, index) {

                                    // print(lproducts.elementAt(index).pname);

                                    return GestureDetector(
                                      child: Card(
                                        elevation: 5,
                                        semanticContainer: true,
                                        clipBehavior: Clip.antiAliasWithSaveLayer,
                                        margin: const EdgeInsets.all(6),
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(6.0)),
                                        ),
                                        child: Column(
                                          children: [
                                            // Text(lproducts.elementAt(index).pname),

                                            Expanded(
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                        const BorderRadius.only(
                                                            topLeft: Radius.circular(6.0),
                                                            bottomLeft: Radius.circular(6.0)),
                                                      image:
                                                        DecorationImage(
                                                          image: NetworkImage(lproducts.elementAt(index).pimg),
                                                          fit: BoxFit.fitHeight,
                                                        )
                                                  )
                                              ),
                                            ),
                                            const Divider(
                                              thickness: 1.0,
                                              color: Colors.grey,
                                            ),
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 15.0, right: 10.0),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 5.0),
                                                      child: Text(
                                                          '\$' + lproducts.elementAt(index).pprice,
                                                          style: const TextStyle(
                                                              color: Color.fromRGBO(82, 95, 127, 1.0),
                                                              fontSize: 15.0,
                                                              fontWeight: FontWeight.bold)
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 5.0),
                                                      child: Text(
                                                          lproducts.elementAt(index).pname,
                                                          overflow:
                                                          TextOverflow.clip,
                                                          maxLines: 1,
                                                          style: const TextStyle(
                                                              color: Color.fromRGBO(82, 95, 127, 1.0),
                                                              fontSize: 10.0,
                                                              fontWeight: FontWeight.normal)
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 10.0),
                                                      child: Text(
                                                          lproducts.elementAt(index).pstore,
                                                          style: const TextStyle(
                                                              color: Color.fromRGBO(94, 114, 228, 1.0),
                                                              fontSize: 12,
                                                              fontWeight: FontWeight.normal)
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 5.0),
                                                      child: Text(
                                                          lproducts.elementAt(index).prate,
                                                          style: const TextStyle(
                                                              color: Color.fromRGBO(82, 95, 127, 1.0),
                                                              fontSize: 15.0,
                                                              fontWeight: FontWeight.bold)
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),

                                          ],
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                                          return productDetails(lproducts.elementAt(index).pid, lproducts.elementAt(index).pname, lproducts.elementAt(index).pparte);
                                        }));
                                      },
                                    );

                                  }
                              ),
                            ),
                          ),
                        )
                        : Container(
                          color: Colors.white,
                          width: double.infinity,
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                "assets/img/ProductNotFound.png",
                                width: 200,),
                              const SizedBox(height: 10),
                              const Text(
                                "Sin productos registrados",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins'),
                              ),
                              const Center(
                                child: Text(
                                  "No hay productos relacionados al filtro seleccionado",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Poppins'),
                                ),
                              )
                            ],
                          ),
                        ),

                        Align(
                          alignment: Alignment.bottomRight,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.max,
                            children: [

                              GestureDetector(
                                child: Container(
                                  child: Image.asset(
                                      'assets/img/wpp.png'),
                                  height: 80.0,
                                  width: 80.0,),
                                onTap: () {
                                  _launchURL('https://api.whatsapp.com/send?phone=5218115778979&text=Hola%20me%20interesa%20tener%20apoyo%20con%20respecto%20a%20la%20p%C3%A1gina');
                                },
                              ),

                            ],
                          ),
                        ),

                      ]
                  )
              )

            ],
          ));
    }
  }

  _logged() {

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

  _filter(){

    FirebaseFirestore.instance
        .collection('products')
        .where('status', isEqualTo: 'active')
        .orderBy('date', descending: true)
        .snapshots().forEach((element) {

          for (var i = 0; i < element.docs.length; ++i) {

            if(element.docs[i].data()['description'].toString().contains(widget.parte)){

              try {

                // print('id: ' + element.docs[i].id);
                // print('name: ' + element.docs[i].data()['name']);
                // print('iterator: ' + i.toString());

                lproducts.add(
                  Product(
                    pid: element.docs[i].id,
                    pimg: element.docs[i].data()['image'],
                    pname: element.docs[i].data()['name'],
                    pprice: element.docs[i].data()['price'],
                    prate: element.docs[i].data()['rate'],
                    pstore: element.docs[i].data()['store'],
                    pparte: element.docs[i].data()['parte']
                  )
                );

              }
              catch (onerror) {
                print('Fatal error: ' + onerror.toString() + ' en posicion ' + i.toString());
              }
            }

            // print('proceso set finalizado');

          }

          // print('Leng: ' + lproducts.length.toString());

          if(lproducts.isNotEmpty) {
            setState(() {
              controlador = true;
            });
          }


    });

  }

  _Query(){

    if(name.isEmpty){
      if(vehicle.isEmpty){
        // print('qry 1');
        qry = FirebaseFirestore.instance
            .collection('products')
            .where('status', isEqualTo: 'active')
            .orderBy('date', descending: true).snapshots();
      } else {
        // print('qry 2');
        qry = FirebaseFirestore.instance
            .collection('products')
            .where('status', isEqualTo: 'active')
            .where('type', isEqualTo: vehicle)
            .orderBy('date', descending: true).snapshots();
      }
    } else {
      if(vehicle.isEmpty){
        // print('qry 3');
        qry = FirebaseFirestore.instance
            .collection('products')
            .where('status', isEqualTo: 'active')
            .where('marca', isEqualTo: name)
            .orderBy('date', descending: true).snapshots();
      } else {
        // print('qry 4');
        qry = FirebaseFirestore.instance
            .collection('products')
            .where('status', isEqualTo: 'active')
            .where('marca', isEqualTo: name)
            .where('type', isEqualTo: vehicle)
            .orderBy('date', descending: true).snapshots();
      }
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

  _noOrdersOnboarding() {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            "assets/img/ProductNotFound.png",
            width: 200,),
          const SizedBox(height: 10),
          const Text(
            "Sin productos registrados",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins'),
          ),
          const Center(
            child: Text(
              "No hay productos relacionados al filtro seleccionado",
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
        children: const <Widget>[

          Text(
            ":(",
            style: TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins'),
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
              "Refresca la página.",
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

  _verMarca(){
    if(filterMarca) {
      return GestureDetector(
        child: const Padding(
          padding: EdgeInsets.only(
              top: 5.0),
          child: Text('Ver mas...',
            style: TextStyle(fontSize: 13.0,
                fontWeight: FontWeight
                    .normal,
                color: Colors.blue),),
        ),
        onTap: () {
          setState(() {
            limitFilter = 100;
            filterMarca = false;
          });
        },
      );
    } else {
      return GestureDetector(
        child: const Padding(
          padding: EdgeInsets.only(
              top: 5.0),
          child: Text('Ver menos...',
            style: TextStyle(fontSize: 13.0,
                fontWeight: FontWeight
                    .normal,
                color: Colors.blue),),
        ),
        onTap: () {
          setState(() {
            limitFilter = 4;
            filterMarca = true;
          });
        },
      );
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

}
