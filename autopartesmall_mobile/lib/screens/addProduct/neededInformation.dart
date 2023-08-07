import 'package:autopartes_mall/constants/Theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../register.dart';

class NeededInfo extends StatefulWidget {

  final String productId;

  NeededInfo(this.productId);

  @override
  _NeededInfoState createState() => _NeededInfoState();

}

class _NeededInfoState extends State<NeededInfo> {

  final PageController pvController = PageController(initialPage: 1);
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _nameData = TextEditingController();
  final TextEditingController _emailData = TextEditingController();
  final TextEditingController _numberData = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
        body: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(height: 50,),
                  Text('¡Producto recibido!',
                    style: Theme.of(context).textTheme.headline4,),
                  Image.asset('assets/img/logo_am.png',height: 170.0,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.70,
                    child: Text('Hemos agregado tu producto y marcado como pendiente',
                        style: Theme.of(context).textTheme.headline6,
                        textAlign: TextAlign.center),
                  ),
                  SizedBox(height: 10,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.70,
                    child: Text('Guarda este token y buscalo en la app',
                        style: Theme.of(context).textTheme.subtitle1,
                        textAlign: TextAlign.center),
                  ),
                  SizedBox(height: 5,),
                  GestureDetector(
                    onTap: () {
                      Clipboard.setData(new ClipboardData(text: widget.productId));
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.all(Radius.circular(4.0)),
                            border: Border.all(color: Colors.grey)
                        ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SelectableText(widget.productId),
                      ))),
                  Expanded(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: PageView(
                        controller: pvController,
                        scrollDirection: Axis.horizontal,
                        children: [

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [

                              SizedBox(height: 20,),

                              TextFormField(
                                controller: _email,
                                autocorrect: false,
                                textCapitalization: TextCapitalization.sentences,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Correo Electronico',
                                ),
                              ),

                              SizedBox(height: 10,),

                              TextFormField(
                                controller: _password,
                                autocorrect: false,
                                textCapitalization: TextCapitalization.sentences,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Contraseña',
                                ),
                              ),

                              SizedBox(height: 15,),

                              Column(
                                children: [

                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push ( context,
                                          MaterialPageRoute ( builder: (context) {
                                            return Register (true);
                                          } ) );
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.55,
                                      decoration: BoxDecoration(
                                          color: ArgonColors.primary,
                                          borderRadius: BorderRadius.all(Radius.circular(4.0))
                                      ),
                                      child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 4.0,
                                              right: 4.0,
                                              top: 6,
                                              bottom: 2),
                                          child: Center(
                                            child: Text("REGISTRAR",
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.w600,
                                                    fontSize: 16.0,
                                                  color: Colors.white
                                                )),
                                          )),
                                    ),
                                  ),

                                  SizedBox(height: 10,),

                                  GestureDetector(
                                    onTap: () {

                                      FirebaseAuth.instance
                                          .signInWithEmailAndPassword(
                                          email: _email.text, password: _password.text)
                                          .then((result) async {

                                            await FirebaseFirestore.instance.collection ( 'products' ).doc(widget.productId).update({
                                              'status': 'active'
                                            });

                                            showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Text("Producto activado"),
                                                    content: Text('Ahora tu producto esta publicado'),
                                                    actions: [
                                                      ElevatedButton(
                                                        child: Text("Ok"),
                                                        onPressed: () {
                                                          Navigator.of(context).pop();
                                                        },
                                                      )
                                                    ],
                                                  );
                                                });

                                            Navigator.of(context)
                                                .pushNamedAndRemoveUntil(
                                                '/home', (Route<
                                                dynamic> route) => false);

                                      }).catchError((err) {
                                        print(err.message);
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text("Error"),
                                                content: Text(err.message),
                                                actions: [
                                                  ElevatedButton(
                                                    child: Text("Ok"),
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                  )
                                                ],
                                              );
                                            });
                                      });

                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.55,
                                      decoration: BoxDecoration(
                                          color: ArgonColors.primary,
                                          borderRadius: BorderRadius.all(Radius.circular(4.0))
                                      ),
                                      child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 4.0,
                                              right: 4.0,
                                              top: 6,
                                              bottom: 2),
                                          child: Center(
                                            child: Text("INICIA SESIÓN",
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.w600,
                                                    fontSize: 16.0,
                                                    color: Colors.white
                                                )),
                                          )),
                                    ),
                                  ),

                                ],
                              ),
                            ],
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [

                              SizedBox(height: 50,),

                              Center(
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.75,
                                  child: Text('Porfavor espera a que tu producto sea publicado o utiliza una de las siguientes opciones',
                                    style: Theme.of(context).textTheme.subtitle1,
                                    textAlign: TextAlign.center),
                                ),
                              ),

                              SizedBox(height: 15,),

                              Row(
                                children: [
                                  Expanded(child: GestureDetector(
                                    onTap: () {
                                      pvController.previousPage(duration: Duration(milliseconds: 500), curve: Curves.easeIn);
                                    },
                                    child: Container(
                                      height: 130,
                                      decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius: BorderRadius.all(Radius.circular(15.0))
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('Inicia sesión',
                                              style: Theme.of(context).textTheme.button,
                                              textAlign: TextAlign.center),
                                          SizedBox(height: 15,),
                                          Icon(
                                            Icons.person,
                                            // color: ArgonColors.primary,
                                          )
                                        ],
                                      ),
                                    ),
                                  )),

                                  Expanded(child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
                                    },
                                    child: SizedBox(
                                      child: Text('Aceptar',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: ArgonColors.primary
                                        ),
                                        // style: TextStyle(color: ArgonColors.primary),
                                      ),
                                    ),
                                  )),

                                  Expanded(child: GestureDetector(
                                    onTap: () {
                                      pvController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeIn);
                                    },
                                    child: Container(
                                      height: 130,
                                      decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius: BorderRadius.all(Radius.circular(15.0))
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('Contacto',
                                              style: Theme.of(context).textTheme.button,
                                              textAlign: TextAlign.center),
                                          SizedBox(height: 15,),
                                          Icon(
                                            Icons.accessibility,
                                            // color: ArgonColors.primary,
                                          )
                                        ],
                                      ),
                                    ),
                                  )),

                                ],
                              )
                            ],
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [

                              SizedBox(height: 20,),

                              TextFormField(
                                controller: _nameData,
                                autocorrect: false,
                                textCapitalization: TextCapitalization.sentences,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Nombre completo',
                                ),
                              ),

                              SizedBox(height: 10,),

                              TextFormField(
                                controller: _emailData,
                                autocorrect: false,
                                textCapitalization: TextCapitalization.sentences,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Correo Electronico',
                                ),
                              ),

                              SizedBox(height: 10,),

                              TextFormField(
                                controller: _numberData,
                                autocorrect: false,
                                textCapitalization: TextCapitalization.sentences,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Número telefonico',
                                ),
                              ),

                              SizedBox(height: 15,),

                              GestureDetector(
                                onTap: () async {

                                  await FirebaseFirestore.instance.collection ( 'products' ).doc(widget.productId).collection('contacto').add({
                                    'name': _nameData.text,
                                    'email': _emailData.text,
                                    'phone': _numberData.text
                                  });

                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("Información recibida"),
                                          content: Text('Nos pondremos en contacto en cuanto tu producto este publicado'),
                                          actions: [
                                            ElevatedButton(
                                              child: Text("Ok"),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            )
                                          ],
                                        );
                                      });

                                  Navigator.of(context)
                                      .pushNamedAndRemoveUntil(
                                      '/home', (Route<
                                      dynamic> route) => false);

                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.55,
                                  height: 35,
                                  decoration: BoxDecoration(
                                      color: ArgonColors.primary,
                                      borderRadius: BorderRadius.all(Radius.circular(4.0))
                                  ),
                                  child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 4.0,
                                          right: 4.0,
                                          top: 6,
                                          bottom: 2),
                                      child: Center(
                                        child: Text("REGISTRAR PRODUCTO",
                                            style: TextStyle(
                                                fontWeight:
                                                FontWeight.w600,
                                                fontSize: 16.0,
                                                color: Colors.white
                                            )),
                                      )),
                                ),
                              ),

                            ],
                          ),

                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

}