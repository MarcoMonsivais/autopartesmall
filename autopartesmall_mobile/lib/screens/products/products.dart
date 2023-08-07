import 'dart:convert';
import 'package:autopartes_mall/screens/products/succedBoughtProduct.dart';
import 'package:autopartes_mall/src/globalVariables.dart';
import 'package:http/http.dart' as http;
import 'package:autopartes_mall/constants/Theme.dart';
import 'package:autopartes_mall/widgets/drawer.dart';
import 'package:autopartes_mall/widgets/navbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:intl/intl.dart';
import 'package:flutter/src/material/card.dart' as c;
import 'package:stripe_platform_interface/src/models/payment_sheet.dart' as PS;

class productsPage extends StatefulWidget {

  final String documentId, nameProduct;

  productsPage(this.documentId, this.nameProduct);

  @override
  _productsPageState createState() => _productsPageState();

}

class _productsPageState extends State<productsPage> {

  Map<String, dynamic> paymentIntentData;
  String finalMonto;

  @override
  void initState() {

    super.initState();
    Stripe.publishableKey = PK_STRIPE;
    Stripe.merchantIdentifier = 'Autopartes Mall';
    Stripe.instance.applySettings();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: Navbar(
          title: widget.nameProduct,
          backButton: true,
          transparent: true,
        ),
        backgroundColor: ArgonColors.bgColorScreen,
        drawer: ArgonDrawer(currentPage: "products"),
        body: FutureBuilder(
          future: FirebaseFirestore.instance.collection('products')
              .doc(widget.documentId)
              .get(),
          // ignore: missing_return
          builder: (context, snapshot) {

            //DocumentSnapshot
            DocumentSnapshot ds = snapshot.data;

            return Stack(children: <Widget>[
                  Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              alignment: Alignment.topCenter,
                              image: AssetImage("assets/img/profile-screen-bg.png"),
                              fit: BoxFit.fitWidth))),
                  SafeArea(
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      children: [
                        Padding(
                        padding:
                        const EdgeInsets.only(left: 16.0, right: 16.0, top: 74.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Stack(children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.1),
                                      spreadRadius: 1,
                                      blurRadius: 7,
                                      offset:
                                      Offset(0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: c.Card(
                                    semanticContainer: true,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    elevation: .0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(5.0))),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 85.0, bottom: 20.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  children: [
                                                    GestureDetector(
                                                      onTap:(){
                                                        finalMonto = ds['price'].toString().replaceAll(',', '');
                                                        makePayment();
                                                      },
                                                      child:
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          color: ArgonColors.initial,
                                                          borderRadius:
                                                          BorderRadius.circular(3.0),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.grey
                                                                  .withOpacity(0.3),
                                                              spreadRadius: 1,
                                                              blurRadius: 7,
                                                              offset: Offset(0,
                                                                  3),// changes position of shadow
                                                            ),
                                                          ],
                                                        ),
                                                        child: Text(
                                                          "COMPRAR",
                                                          style: TextStyle(
                                                              color: ArgonColors.white,
                                                              fontSize: 12.0,
                                                              fontWeight:
                                                              FontWeight.bold),
                                                        ),
                                                        padding: EdgeInsets.symmetric(
                                                            horizontal: 8.0,
                                                            vertical: 8.0),
                                                      ),),
                                                    SizedBox(
                                                      width: 30.0,
                                                    ),
                                                    Text(ds['store'],
                                                        style: TextStyle(
                                                            color: Color.fromRGBO(
                                                                82, 95, 127, 1),
                                                            fontSize: 20.0,
                                                            fontWeight:
                                                            FontWeight.bold)),
                                                    /*GestureDetector(
                                                      onTap:(){
                                                        //agregar función de tienda
                                                      },
                                                      child:
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          color: ArgonColors.initial,
                                                          borderRadius:
                                                          BorderRadius.circular(3.0),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.grey
                                                                  .withOpacity(0.3),
                                                              spreadRadius: 1,
                                                              blurRadius: 7,
                                                              offset: Offset(0,
                                                                  3), // changes position of shadow
                                                            ),
                                                          ],
                                                        ),
                                                        child:
                                                          Text(
                                                            ds['store'],
                                                            style: TextStyle(
                                                                color: ArgonColors.white,
                                                                fontSize: 12.0,
                                                                fontWeight:
                                                                FontWeight.bold),
                                                          ),
                                                        padding: EdgeInsets.symmetric(
                                                            horizontal: 8.0,
                                                            vertical: 8.0),
                                                      ),)*/
                                                  ],
                                                ),
                                                SizedBox(height: 40.0),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Text(ds['marca'],
                                                            style: TextStyle(
                                                                color: Color.fromRGBO(
                                                                    82, 95, 127, 1),
                                                                fontSize: 20.0,
                                                                fontWeight:
                                                                FontWeight.bold)),
                                                        Text('Marca',
                                                            style: TextStyle(
                                                                color: Color.fromRGBO(
                                                                    50, 50, 93, 1),
                                                                fontSize: 12.0))
                                                      ],
                                                    ),
                                                    Column(
                                                      children: [
                                                        Text('\$' + ds['price'],
                                                            style: TextStyle(
                                                                color: Color.fromRGBO(
                                                                    82, 95, 127, 1),
                                                                fontSize: 20.0,
                                                                fontWeight:
                                                                FontWeight.bold)),
                                                        Text("Precio",
                                                            style: TextStyle(
                                                                color: Color.fromRGBO(
                                                                    50, 50, 93, 1),
                                                                fontSize: 12.0))
                                                      ],
                                                    ),
                                                    Column(
                                                      children: [
                                                        Text(ds['rate'].toString().isEmpty ? '-' : ds['rate'] ,
                                                            style: TextStyle(
                                                                color: Color.fromRGBO(
                                                                    82, 95, 127, 1),
                                                                fontSize: 20.0,
                                                                fontWeight:
                                                                FontWeight.bold)),
                                                        Text("RATE",
                                                            style: TextStyle(
                                                                color: Color.fromRGBO(
                                                                    50, 50, 93, 1),
                                                                fontSize: 12.0))
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                SizedBox(height: 40.0),
                                                Align(
                                                  child: Text(ds['name'],
                                                      style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              50, 50, 93, 1),
                                                          fontSize: 28.0)),
                                                ),
                                                SizedBox(height: 10.0),
                                                Align(
                                                  child: Text(
                                                      DateFormat('EEEE dd, MMM').format(DateTime.tryParse( ds['date'])).toString(),
                                                      style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              50, 50, 93, 1),
                                                          fontSize: 18.0,
                                                          fontWeight: FontWeight.w200)),
                                                ),
                                                Divider(
                                                  height: 40.0,
                                                  thickness: 1.5,
                                                  indent: 32.0,
                                                  endIndent: 32.0,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: 32.0, right: 32.0),
                                                  child: Align(
                                                    child: Text(
                                                        ds['description'],
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                            color: Color.fromRGBO(
                                                                82, 95, 127, 1),
                                                            fontSize: 17.0,
                                                            fontWeight:
                                                            FontWeight.w200)),
                                                  ),
                                                ),
                                                SizedBox(height: 25.0),
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      right: 25.0, left: 25.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(
                                                        ds['store'],
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 16.0,
                                                            color: ArgonColors.text),
                                                      ),
                                                      Text(
                                                        "Similares...",
                                                        style: TextStyle(
                                                            color: ArgonColors.primary,
                                                            fontSize: 13.0,
                                                            fontWeight:
                                                            FontWeight.w600),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                //display different images
                                                StreamBuilder(
                                                  stream: FirebaseFirestore.instance.collection('products').where('parte', isEqualTo: ds['parte'] ).orderBy('date', descending: true).limit(10).snapshots(),
                                                  // ignore: missing_return
                                                  builder: (context, snapshot2) {

                                                    if (snapshot2.hasData) {
                                                      if (snapshot2.data.docs.length < 1) {
                                                        return noOrdersOnboarding();
                                                      }

                                                      try {
                                                        return GridView.builder(
                                                            physics: NeverScrollableScrollPhysics(),
                                                            shrinkWrap: true,
                                                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                              crossAxisCount: 5,
                                                              crossAxisSpacing: 5.0,
                                                              mainAxisSpacing: 5.0,
                                                            ),
                                                            itemCount: 10,
                                                            itemBuilder: (context,
                                                                index) {
                                                              DocumentSnapshot ds2 = snapshot2
                                                                  .data
                                                                  .docs[index];

                                                              return GestureDetector(
                                                                  onTap: (){
                                                                    Navigator.push(context, MaterialPageRoute(builder: (context) => productsPage(ds2.id, ds2['name'])));
                                                                  },
                                                                  child:
                                                                  Container(
                                                                      height: 100,
                                                                      decoration: BoxDecoration(
                                                                        borderRadius:
                                                                        BorderRadius
                                                                            .all(
                                                                            Radius
                                                                                .circular(
                                                                                6.0)),
                                                                        image: DecorationImage(
                                                                            image: NetworkImage(
                                                                                ds2['image']),
                                                                            fit: BoxFit
                                                                                .cover),
                                                                      )));
                                                              });
                                                      }
                                                      catch (onError) {
                                                        print(onError
                                                            .toString());
                                                      }
                                                    } if (snapshot2.hasError) {
                                                      return _ordersErrorOnboarding();
                                                    } else {
                                                      return Container(
                                                        alignment: Alignment.center,
                                                        child: CircularProgressIndicator(),
                                                      );
                                                    }
                                                  }

                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                              FractionalTranslation(
                                  translation: Offset(0.0, -0.5),
                                  child: Align(
                                    alignment: FractionalOffset(0.5, 0.0),
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(ds['image']),
                                      radius: 65.0,
                                          // maxRadius: 200.0,
                                    ),
                                  )
                              )
                            ]),
                          ],
                        ),
                      ),
                    ]),
                  )
                ]);

          },
        )
      );

  }

  noOrdersOnboarding() {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Sin productos similares",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins'),
          ),

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
          Text(
            "Ha ocurrido un error",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins'),
          ),
        ],
      ),
    );
  }

  Future<void> makePayment() async {
    try {
      print('1');
      paymentIntentData =
      await createPaymentIntent(finalMonto, 'MXN');
      print('1.1');
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntentData['client_secret'],
              applePay: true,
              googlePay: true,
              style: ThemeMode.light,
              merchantCountryCode: 'MX',
              merchantDisplayName: 'Autopartes Mall'));

      print('1.2');
      displayPaymentSheet();
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet() async {
    try {
      print('2');
      await Stripe.instance.presentPaymentSheet(
          // parameters: PresentPaymentSheetParameters(
          //   clientSecret: paymentIntentData['client_secret'],
          //   confirmPayment: true
          //)
    );
      print('2.1');
      setState(() {
        paymentIntentData = null;
      });

      Navigator.push(context, MaterialPageRoute(builder: (context) => successBoughtProduct()));

    } on StripeException catch (e) {

      print(e);

      showDialog(
          context: context,
          builder: (_) => AlertDialog(
            content: Text("Pago cancelado"),
          ));
    } catch (e) {
      print('$e');
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      print('3');
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      print('3.1: '
          + SK_STRIPE + ' - '
          + PK_STRIPE + ' - '
          + amount + ' - '
          + currency + ' - '
          + calculateAmount(amount) + ' - '
      );
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
            'Bearer ' + SK_STRIPE,
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      print('3.2');
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount) * 100);
    return a.toString();
  }

}
