import 'package:autopartes_mall/constants/Theme.dart';
import 'package:flutter/material.dart';

class successAddedMarca extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _successAddedMarcaState();
}

class _successAddedMarcaState extends State<successAddedMarca> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              Image(image: AssetImage("assets/img/succesvector.png"), height: 250,),

              Align(
                alignment: Alignment.center,
                child: Text("Marca agregada con éxito",
                    style: TextStyle(fontSize: 30, color: Colors.black)),
              ),
              SizedBox(height: 30,),
              Padding(
                padding:
                const EdgeInsets.only(left: 34.0, right: 34.0, top: 8),
                child: RaisedButton(
                  textColor: ArgonColors.white,
                  color: ArgonColors.primary,
                  onPressed: () {

                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/admin', (Route<dynamic> route) => false);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Padding(
                      padding: EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 12, bottom: 12),
                      child: Text("ENTENDIDO",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16.0))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
