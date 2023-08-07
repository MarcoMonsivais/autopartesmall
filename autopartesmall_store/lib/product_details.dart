import 'dart:convert';
import 'dart:ui' as ui;
import 'package:apmall_web/src/various.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:apmall_web/on_boarding.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:apmall_web/login/log_page.dart';
import 'package:apmall_web/login/reg_page.dart';
import 'package:apmall_web/global_variables.dart' as Globals;
import 'package:firebase_auth/firebase_auth.dart';

class productDetails extends StatefulWidget {

  final String documentId, name, parte;

  productDetails(this.documentId, this.name, this.parte);

  @override
  State<productDetails> createState() => productDetailsState();

}

class productDetailsState extends State<productDetails> {

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

  late Map<String, dynamic> paymentIntentData;
  late String finalMonto;

  Color clrs = Colors.black;

  @override
  void initState() {
    _checkDevice();
    _Query();

    // Stripe.publishableKey = 'pk_test_51JDmfWACFA40i9cpFuoHjoa1lTygoQ5pL3Yc0BATjiLcsIeUgWbDBMcIgz1glXDvNBjXlGUIJVG5hA6fYiQg6HB500Wn1P0yg5';
    // Stripe.merchantIdentifier = 'Autopartes Mall';
    // Stripe.instance.applySettings();

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
    }
    else {
      return Scaffold(
          body: Column(
            children: [
              //Encabezado de página
              Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: 180,
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
                                  // Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
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
                                      decoration: const InputDecoration(
                                        // icon: Icon(Icons.search),
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

                    Expanded(
                      child: Container(
                        color: Colors.black38,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 60.0, right: 120.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              const Text('Favoritos', style: TextStyle(
                                  color: Colors.white, fontSize: 20.0),),

                              Expanded(child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 90.0, right: 70.0, top: 10.0,),
                                  child: Container(
                                    height: 80.0,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [

                                        GestureDetector(
                                          child: Column(
                                            children: [
                                              Image.asset(
                                                'assets/img/puerta_demo2.png',
                                                height: 55.0,),
                                              const Padding(
                                                padding: EdgeInsets.only(top: 10.0),
                                                child: Text('Puerta',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 12.0),),
                                              ),
                                            ],
                                          ),
                                          onTap: (){

                                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                                              return variousDetails('Puerta');
                                            }));

                                            // qry = FirebaseFirestore.instance
                                            //     .collection('products')
                                            //     .where('status', isEqualTo: 'active')
                                            //     .where('parte', isEqualTo: 'Puerta')
                                            //     .orderBy('date', descending: true).snapshots();
                                            //
                                            // setState(() {
                                            //
                                            // });
                                          },
                                        ),
                                        const SizedBox(width: 70.0,),
                                        GestureDetector(
                                          child: Column(children: [
                                            Image.asset(
                                              'assets/img/espejo_demo.png',
                                              height: 55.0,),
                                            const Padding(
                                              padding: EdgeInsets.only(top: 10.0),
                                              child: Text('Espejo',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12.0),),
                                            ),
                                          ],),
                                          onTap: () {

                                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                                              return variousDetails('Espejo');
                                            }));

                                            // qry = FirebaseFirestore.instance
                                            //     .collection('products')
                                            //     .where('status', isEqualTo: 'active')
                                            //     .where('parte', isEqualTo: 'Espejo')
                                            //     .orderBy('date', descending: true).snapshots();
                                            //
                                            // setState(() {
                                            //
                                            // });
                                          },
                                        ),
                                        const SizedBox(width: 70.0,),
                                        GestureDetector(
                                          child: Column(children: [
                                            Image.asset(
                                              'assets/img/interior_demo.png',
                                              height: 55.0,),
                                            const Padding(
                                              padding: EdgeInsets.only(top: 10.0),
                                              child: Text('Interiores',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12.0),),
                                            ),
                                          ],),
                                          onTap: () {

                                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                                              return variousDetails('Interiores');
                                            }));

                                            // qry = FirebaseFirestore.instance
                                            //     .collection('products')
                                            //     .where('status', isEqualTo: 'active')
                                            //     .where('parte', isEqualTo: 'Interior')
                                            //     .orderBy('date', descending: true).snapshots();
                                            //
                                            // setState(() {
                                            //
                                            // });
                                          },
                                        ),
                                        const SizedBox(width: 70.0,),
                                        GestureDetector(
                                          child: Column(children: [
                                            Image.asset(
                                              'assets/img/motor_demo.png',
                                              height: 55.0,),
                                            const Padding(
                                              padding: EdgeInsets.only(top: 10.0),
                                              child: Text('Motor',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12.0),),
                                            ),
                                          ],),
                                          onTap: () {

                                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                                              return variousDetails('Motor');
                                            }));

                                            // qry = FirebaseFirestore.instance
                                            //     .collection('products')
                                            //     .where('status', isEqualTo: 'active')
                                            //     .where('parte', isEqualTo: 'Motor')
                                            //     .orderBy('date', descending: true).snapshots();
                                            //
                                            // setState(() {
                                            //
                                            // });
                                          },
                                        ),
                                        const SizedBox(width: 70.0,),
                                        GestureDetector(
                                          child: Column(children: [
                                            Image.asset(
                                              'assets/img/bujia_demo.png',
                                              height: 55.0,),
                                            const Padding(
                                              padding: EdgeInsets.only(top: 10.0),
                                              child: Text('Electrico',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12.0),),
                                            ),
                                          ],),
                                          onTap: () {

                                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                                              return variousDetails('Electrico');
                                            }));

                                            // qry = FirebaseFirestore.instance
                                            //     .collection('products')
                                            //     .where('status', isEqualTo: 'active')
                                            //     .where('parte', isEqualTo: 'Electrico')
                                            //     .orderBy('date', descending: true).snapshots();
                                            //
                                            // setState(() {
                                            //
                                            // });
                                          },
                                        ),
                                        const SizedBox(width: 70.0,),
                                        GestureDetector(
                                          child: Column(children: [
                                            Image.asset(
                                              'assets/img/car-png.png',
                                              height: 55.0,),
                                            const Padding(
                                              padding: EdgeInsets.only(top: 10.0),
                                              child: Text('Todos',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12.0),),
                                            ),
                                          ],),
                                          onTap: () {

                                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                                              return variousDetails('');
                                            }));

                                            // qry = FirebaseFirestore.instance
                                            //     .collection('products')
                                            //     .where('status', isEqualTo: 'active')
                                            //     .orderBy('date', descending: true).snapshots();
                                            //
                                            // setState(() {
                                            //
                                            // });
                                          },
                                        ),

                                      ],
                                    ),
                                  )
                              )
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),

              // Cuerpo
              Expanded(
                child: FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('products')
                      .doc(widget.documentId)
                      .get(),
                  builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {

                    //DocumentSnapshot
                    DocumentSnapshot<Object?>? ds = snapshot.data;

                    Map ds2 = ds!.data() as Map;

                    if(snapshot.hasData){
                      return Padding(
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
                                  child: Container(
                                      width: 600.0,
                                      decoration: BoxDecoration(
                                        // color: Colors.blue,
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(6.0),
                                              bottomLeft: Radius.circular(6.0)
                                          ),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                ds['image']),
                                            fit: BoxFit
                                                .fitHeight,
                                          )
                                      )
                                  ),
                                ),

                                Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          Padding(
                                            padding: const EdgeInsets.only(top: 5.0),
                                            child: Text(
                                                ds['name'],
                                                style: const TextStyle(
                                                    color: Color.fromRGBO(82, 95, 127, 1.0),
                                                    fontSize: 20.0,
                                                    fontWeight: FontWeight.bold
                                                )
                                            ),
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.only(top: 10.0),
                                            child: Text(
                                                ds['store'],
                                                style: const TextStyle(
                                                    color: Color.fromRGBO(94, 114, 228, 1.0),
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.normal)
                                            ),
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.only(top: 10.0),
                                            child: Text(
                                                '\$' + ds['price'],
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.normal)
                                            ),
                                          ),

                                          Row(
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 6.0),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.blue,
                                                      borderRadius: BorderRadius.circular(6.0),
                                                    ),
                                                    child: TextButton(
                                                        onPressed: () {

                                                          // _showMyDialog('Esta opción esta solo disponible en la aplicación', context);
                                                          finalMonto = ds['price'].toString().replaceAll(',', '');

                                                          // makePayment();
                                                        },
                                                        child: const Text('Comprar ahora',
                                                          style: TextStyle(color: Colors.white),
                                                        )
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 6.0),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                        color: Colors.blue,
                                                        width: 2,
                                                      ),
                                                      borderRadius: BorderRadius.circular(6.0),
                                                    ),
                                                    child: TextButton(
                                                        onPressed: () {
                                                          _showMyDialog('Estamos desarrollando esta sección', context);
                                                        },
                                                        child: const Text('Agregar al carrito',
                                                          style: TextStyle(color: Colors.blue),
                                                        )
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
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
                                            child: Text(
                                                ds['description'],
                                                style: const TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.normal)
                                            ),
                                          ),

                                        ],
                                      ),
                                    )
                                ),

                              ]
                          ),
                        ),
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }

                  },
                ),
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

  _Query(){

    // print('marca: ' + name);
    // print('vehiculo: ' + vehicle);

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

    // isPhone = true;
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

  // Future<void> makePayment() async {
  //   try {
  //     print('1');
  //     paymentIntentData =
  //     await createPaymentIntent(finalMonto, 'MXN');
  //     print('1.1');
  //     await Stripe.instance.initPaymentSheet(
  //         paymentSheetParameters: const SetupPaymentSheetParameters(
  //             paymentIntentClientSecret: 'sk_test_51JDmfWACFA40i9cplDBQ410LseMTz7cR24G7dHNUAC886feIScViSRtQ0CYs8Q5I8n2AwzSOOBMTV0KwwUlP5yTJ00Omvac8af',
  //             applePay: true,
  //             googlePay: true,
  //             style: ThemeMode.light,
  //             merchantCountryCode: 'MX',
  //             merchantDisplayName: 'Autopartes Mall'));
  //
  //     print('1.2');
  //     displayPaymentSheet();
  //   } catch (e, s) {
  //     print('exception:$e$s');
  //   }
  // }
  //
  // displayPaymentSheet() async {
  //   try {
  //     print('2');
  //     await Stripe.instance.presentPaymentSheet(
  //       // parameters: PresentPaymentSheetParameters(
  //       //   clientSecret: paymentIntentData['client_secret'],
  //       //   confirmPayment: true
  //       //)
  //     );
  //     print('2.1');
  //     setState(() {
  //       paymentIntentData = {'':''};
  //     });
  //
  //     // Navigator.push(context, MaterialPageRoute(builder: (context) => successBoughtProduct()));
  //
  //   } on StripeException catch (e) {
  //
  //     print(e);
  //
  //     showDialog(
  //         context: context,
  //         builder: (_) => AlertDialog(
  //           content: Text("Pago cancelado"),
  //         ));
  //   } catch (e) {
  //     print('$e');
  //   }
  // }
  //
  // createPaymentIntent(String amount, String currency) async {
  //   try {
  //     print('3');
  //     Map<String, dynamic> body = {
  //       'amount': calculateAmount(amount),
  //       'currency': currency,
  //       'payment_method_types[]': 'card'
  //     };
  //     // print('3.1: '
  //     //     + SK_STRIPE + ' - '
  //     //     + PK_STRIPE + ' - '
  //     //     + amount + ' - '
  //     //     + currency + ' - '
  //     //     + calculateAmount(amount) + ' - '
  //     // );
  //     var response = await http.post(
  //         Uri.parse('https://api.stripe.com/v1/payment_intents'),
  //         body: body,
  //         headers: {
  //           'Authorization':
  //           'Bearer ' + 'sk_test_51JDmfWACFA40i9cplDBQ410LseMTz7cR24G7dHNUAC886feIScViSRtQ0CYs8Q5I8n2AwzSOOBMTV0KwwUlP5yTJ00Omvac8af',
  //           'Content-Type': 'application/x-www-form-urlencoded'
  //         });
  //     print('3.2');
  //     return jsonDecode(response.body);
  //   } catch (err) {
  //     print('err charging user: ${err.toString()}');
  //   }
  // }
  //
  // calculateAmount(String amount) {
  //   final a = (int.parse(amount) * 100);
  //   return a.toString();
  // }

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

}
