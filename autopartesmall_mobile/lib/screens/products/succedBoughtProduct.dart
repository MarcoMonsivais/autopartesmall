import 'package:autopartes_mall/constants/Theme.dart';
import 'package:flutter/material.dart';

class successBoughtProduct extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _successBoughtProductState();
}

class _successBoughtProductState extends State<successBoughtProduct> {
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
                child: Text("¡Compra realizada!",
                    style: TextStyle(fontSize: 30, color: Colors.black)),
              ),
              SizedBox(height: 5,),
              Align(
                alignment: Alignment.center,
                child: Text("Gracias por comprar con AutoPartesMall. En breve recibirás el seguimiento de tu compra.",
                    style: TextStyle(fontSize: 14, color: ArgonColors.muted,)),
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
                        .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
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
