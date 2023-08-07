import 'package:flutter/material.dart';
// import 'package:ming_pagos/src/util/primary_button.dart';
//
// import '../home_screen.dart';

class AcceptedCustomer extends StatefulWidget {
  AcceptedCustomer();


  @override
  AcceptedCustomerState createState() => AcceptedCustomerState();
}

class AcceptedCustomerState extends State<AcceptedCustomer> {
  final double heightText = 14.0;
  final double height = 0.10;
  final double padding = 50.00;
  final String font = "Poppins";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
//            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Image(image: AssetImage("assets/Pago-digital.jpg"), height: 250,),
              SizedBox(height: padding),
              Text(
                "¡Datos actualizados!",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: font, fontSize: heightText * 1.2, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: padding),
              Text(
                "Hemos actualizado la información de tu perfil.\n\n Cierra tu sesión y vuelve a ingresar para refrescar los datos.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: font, fontSize: heightText),
              ),
              SizedBox(height: padding ),
              TextButton(onPressed: (){
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(
                    '/home', (Route<
                    dynamic> route) => false);
              }, child: Text('Entendido')),
              // PrimaryButton(
              //   text: "ENTENDIDO",
              //   height: 50.0,
              //   width: double.infinity,
              //   onPressed: () {
              //     Navigator.push(context,MaterialPageRoute(builder: (context) => HomeScreen(name: null)));
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}