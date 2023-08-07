import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:autopartes_mall/constants/Theme.dart';
import 'package:autopartes_mall/widgets/navbar.dart';
import 'package:autopartes_mall/widgets/input.dart';
import 'package:autopartes_mall/widgets/drawer.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart' as gsin;
import 'package:autopartes_mall/src/globalVariables.dart' as Global;

class Register extends StatefulWidget {

  final bool onlyRegister;

  Register(this.onlyRegister);

  @override
  _RegisterState createState() => _RegisterState();

}

class _RegisterState extends State<Register> {

  final double height = window.physicalSize.height;
  final PageController _controller = PageController(initialPage: 0);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final gsin.GoogleSignIn _googleSignIn = gsin.GoogleSignIn();

  TextEditingController nameController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController mailController2 = TextEditingController();
  TextEditingController passwordController2 = TextEditingController();

  bool _obscureText = true;
  bool _obscureTextRegister = true;
  int passSegure = 0;
  String _category = 'débil';
  Color _colorCategory = Colors.redAccent;
  bool isLoading = false;
  bool _checkboxValue = false;

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(const Duration(milliseconds: 500), () {
      if(widget.onlyRegister)
        _controller.animateToPage(2,
            duration: Duration(
                milliseconds: 400),
            curve: Curves.easeIn);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Navbar(transparent: true, title: ""),
        extendBodyBehindAppBar: true,
        drawer: ArgonDrawer(currentPage: "iniciar"),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/img/register-bg.png"),
                      fit: BoxFit.cover)),
            ),
            SafeArea(
              child: ListView(children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16, left: 24.0, right: 24.0, bottom: 32),
                  child: Card(
                      elevation: 5,
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Container(
                        height: 450,
                        child: PageView(
                            scrollDirection: Axis.horizontal,
                            controller: _controller,
                            children: [
                              //Iniciar sesión
                              Container(
                                  height: MediaQuery.of(context).size.height * 0.20,
                                  color: Color.fromRGBO(244, 245, 247, 1),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
                                      Center(
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 8.0),
                                            child: Text("INICIA SESIÓN",
                                                style: TextStyle(
                                                    color: ArgonColors.text,
                                                    fontSize: 16.0)),
                                          )
                                      ),
                                      /*Padding(
                                        padding: const EdgeInsets.only(bottom: 8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                          children: [
                                            Container(
                                              // width: 0,
                                              height: 36,
                                              child: RaisedButton(
                                                  textColor: ArgonColors.primary,
                                                  color: ArgonColors.secondary,
                                                  onPressed: () async {
                                                    try {
                                                      print('1');
                                                      final gsin.GoogleSignInAccount googleSignInAccount =
                                                          await _googleSignIn.signIn();
                                                      print('2');
                                                      final gsin.GoogleSignInAuthentication googleSignInAuthentication =
                                                          await googleSignInAccount.authentication;
                                                      print('3');
                                                      final AuthCredential credential = GoogleAuthProvider.credential(
                                                        accessToken: googleSignInAuthentication.accessToken,
                                                        idToken: googleSignInAuthentication.idToken,
                                                      );
                                                      print('4');
                                                      await _auth.signInWithCredential(credential);

                                                      print('finis: ' + _auth.currentUser.uid);
                                                      // Navigator.push ( context,
                                                      //     MaterialPageRoute ( builder: (context) {
                                                      //       return GoogleSignIn ( );
                                                      //     } ) );

                                                    } catch(e){
                                                      _showMyDialog(e.toString(), context);
                                                      if(e is FirebaseAuthException){
                                                        _showMyDialog(e.toString(), context);
                                                      }
                                                    }
                                                  },
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(4)),
                                                  child: Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10,
                                                          top: 10,
                                                          left: 14,
                                                          right: 14),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                        children: [
                                                          Icon(
                                                              FontAwesomeIcons
                                                                  .google,
                                                              size: 13),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text("GOOGLE",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                                  fontSize: 13))
                                                        ],
                                                      ))),
                                            ),
                                            GestureDetector(
                                              onTap: (){

                                              },
                                              child: Container(
                                                height: 36,
                                                child: RaisedButton(
                                                    textColor: ArgonColors.primary,
                                                    color: ArgonColors.secondary,
                                                    onPressed: () {},
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(4)),
                                                    child: Padding(
                                                        padding: EdgeInsets.only(
                                                            bottom: 10,
                                                            top: 10,
                                                            left: 8,
                                                            right: 8),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                          children: [
                                                            Icon(
                                                                FontAwesomeIcons
                                                                    .apple,
                                                                size: 13),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            Text("APPLE",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                    fontSize: 13))
                                                          ],
                                                        ))),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(),
                                      Center(
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 8.0),
                                            child: Text("O CON TU CORREO",
                                                style: TextStyle(
                                                    color: ArgonColors.text,
                                                    fontSize: 16.0)),
                                          )
                                      ),*/
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Input(
                                            controller: mailController,
                                            placeholder: "Correo",
                                            prefixIcon: Icon(Icons.email)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Input(
                                            controller: passwordController,
                                            suffixIcon: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _obscureText = !_obscureText;
                                                });
                                              },
                                              child: Icon(Icons.remove_red_eye)
                                            ),
                                            obscureText: _obscureText,
                                            placeholder: "Contraseña",
                                            prefixIcon: Icon(Icons.lock)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Center(
                                          child: FlatButton(
                                            textColor: ArgonColors.white,
                                            color: ArgonColors.primary,
                                            onPressed: () {
                                              logInToFb();
                                            },
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(4.0),
                                            ),
                                            child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 16.0,
                                                    right: 16.0,
                                                    top: 6,
                                                    bottom: 2),
                                                child: Text("INICIAR SESIÓN",
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.w600,
                                                        fontSize: 16.0))),
                                          ),
                                        ),
                                      ),
                                      Divider(),
                                      GestureDetector(onTap: (){
                                          _controller.animateToPage(2,
                                              duration: Duration(
                                                  milliseconds: 400),
                                              curve: Curves.easeIn);
                                        },
                                        child: Text(
                                            "O REGISTRATE AQUÍ...",
                                            style: TextStyle(
                                                color: ArgonColors.primary,
                                                fontWeight: FontWeight.w200,
                                                fontSize: 16)),
                                      )
                                    ],
                                  )
                              ),
                              //Registrar
                              Container(
                                  height: MediaQuery.of(context).size.height * 0.63,
                                  color: Color.fromRGBO(244, 245, 247, 1),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10.0, bottom: 10.0),
                                            child: Center(
                                              child: GestureDetector(onTap: (){
                                                _controller.animateToPage(0,
                                                    duration: Duration(
                                                        milliseconds: 400),
                                                    curve: Curves.easeIn);
                                              },
                                                child: Text(
                                                    "O VUELVE PARA INICIAR SESIÓN...",
                                                    style: TextStyle(
                                                        color: ArgonColors.text,
                                                        fontWeight: FontWeight.w200,
                                                        fontSize: 16)),
                                              )
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Input(
                                                  controller: nameController,
                                                  placeholder: "Nombre",
                                                  prefixIcon: Icon(Icons.person),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Input(
                                                    controller: mailController2,
                                                    placeholder: "Correo",
                                                    prefixIcon: Icon(Icons.email)),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: TextFormField(
                                                    cursorColor: ArgonColors.muted,
                                                    onChanged: (value){
                                                      if(passwordController2.text.length>3){
                                                        if(passwordController2.text.length>6){
                                                          if(passwordController2.text.length>=11){

                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                                SnackBar(content: Text('La contraseña es demasiado larga'))
                                                            );
                                                          } else {
                                                            setState(() {
                                                              _category = 'fuerte';
                                                              _colorCategory = Colors.green;
                                                              passSegure = passwordController2.text.length;
                                                            });
                                                          }
                                                        } else {
                                                          setState(() {
                                                            _category = 'normal';
                                                            _colorCategory = Colors.yellow;
                                                            passSegure = passwordController2.text.length;
                                                          });
                                                        }
                                                      }
                                                    },
                                                    controller: passwordController2,
                                                    obscureText: _obscureTextRegister,
                                                    inputFormatters: [LengthLimitingTextInputFormatter(11),],
                                                    style: TextStyle(height: 0.85, fontSize: 14.0, color: ArgonColors.initial),
                                                    textAlignVertical: TextAlignVertical(y: 0.6),
                                                    decoration: InputDecoration(
                                                        filled: true,
                                                        fillColor: ArgonColors.white,
                                                        hintStyle: TextStyle(
                                                          color: ArgonColors.muted,
                                                        ),
                                                        suffixIcon: GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                _obscureTextRegister = !_obscureTextRegister;
                                                              });
                                                            },
                                                            child: Icon(Icons.remove_red_eye)
                                                        ),
                                                        prefixIcon: Icon(Icons.lock),
                                                        enabledBorder: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(4.0),
                                                            borderSide: BorderSide(
                                                                color: ArgonColors.border, width: 1.0, style: BorderStyle.solid)),
                                                        focusedBorder: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(4.0),
                                                            borderSide: BorderSide(
                                                                color: ArgonColors.border, width: 1.0, style: BorderStyle.solid)),
                                                        hintText: "Contraseña")),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 24.0),
                                                child: RichText(
                                                    text: TextSpan(
                                                        text: "Seguridad de contraseña: ",
                                                        style: TextStyle(
                                                            color:
                                                            ArgonColors.muted),
                                                        children: [

                                                          TextSpan(
                                                              text: _category,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight.w600,
                                                                  color: _colorCategory))
                                                        ])),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0, top: 0, bottom: 16),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: [
                                                Checkbox(
                                                    activeColor:
                                                    ArgonColors.primary,
                                                    onChanged: (bool newValue) =>
                                                        setState(() =>
                                                        _checkboxValue =
                                                            newValue),
                                                    value: _checkboxValue),
                                                Text("Terminos y condiciones ",
                                                    style: TextStyle(
                                                        color: ArgonColors.muted,
                                                        fontWeight:
                                                        FontWeight.w200)),
                                                GestureDetector(
                                                    onTap: () {

                                                    },
                                                    child: Container(
                                                      margin:
                                                      EdgeInsets.only(left: 5),
                                                      child: Text("Politicas",
                                                          style: TextStyle(
                                                              color: ArgonColors
                                                                  .primary)),
                                                    )),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 5),
                                            child: Center(
                                              child: FlatButton(
                                                textColor: ArgonColors.white,
                                                color: ArgonColors.primary,
                                                onPressed: () {
                                                  //validar datos de correo
                                                  //validar datos de password

                                                  print(_checkboxValue);
                                                  print(passSegure.toString());

                                                  if(_checkboxValue&&passSegure>5) {
                                                    FirebaseAuth.instance
                                                        .createUserWithEmailAndPassword(
                                                        email: mailController2.text,
                                                        password: passwordController2.text)
                                                        .then((result) async {

                                                      final _auth = FirebaseAuth.instance;
                                                      final newUser = await _auth.currentUser;
                                                      final FirebaseFirestore _db = FirebaseFirestore.instance;

                                                      Global.useremail = mailController2.text;
                                                      Global.userid = newUser.uid;

                                                      await _db.collection('users').doc(newUser.uid).collection('perfil').add({'email': mailController2.text,}).then((value) => Global.userprofileid = value.id);

                                                      DocumentReference ref = _db
                                                          .collection('users').doc(
                                                          newUser.uid);

                                                      ref.set({
                                                        'userLastSeen': DateTime
                                                            .now(),
                                                        'userCreated': DateTime
                                                            .now(),
                                                        'userEmail': mailController2.text,
                                                        'userName': nameController.text,
                                                        'usercustomerid': '',
                                                        'userprofileid': Global.userprofileid,
                                                        'register': '0'
                                                      }).then((value) {
                                                        isLoading = false;

                                                        Navigator.of(context)
                                                            .pushNamedAndRemoveUntil(
                                                            '/home', (Route<
                                                            dynamic> route) => false);
                                                      });
                                                    }).catchError((err) {
                                                      showDialog(
                                                          context: context,
                                                          builder: (
                                                              BuildContext context) {
                                                            return AlertDialog(
                                                              title: Text("Error"),
                                                              content: Text(err
                                                                  .message),
                                                              actions: [
                                                                TextButton(
                                                                  child: Text("Ok"),
                                                                  onPressed: () {
                                                                    Navigator.of(
                                                                        context)
                                                                        .pop();
                                                                  },
                                                                )
                                                              ],
                                                            );
                                                          });
                                                    });
                                                  }
                                                  else{
                                                    _showMyDialog('Debes aceptar los términos y condiciones de la aplicación para registrarte', context);
                                                  }
                                                },
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(4.0),
                                                ),
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 16.0,
                                                        right: 16.0,
                                                        top: 6,
                                                        bottom: 2),
                                                    child: Text("REGISTRAR",
                                                        style: TextStyle(
                                                            fontWeight:
                                                            FontWeight.w600,
                                                            fontSize: 16.0))),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ))
                            ]
                        ),
                      )),
                ),
              ]),
            )
          ],
        ));
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

  void logInToFb() {

    print('mail: ' + mailController.text);
    print('pass: ' + passwordController.text);

    // print(FirebaseAuth.instance.currentUser.uid);

    FirebaseAuth.instance
        .signInWithEmailAndPassword(
        email: mailController.text, password: passwordController.text)
        .then((result) {
      isLoading = false;
      Navigator.of(context)
          .pushNamedAndRemoveUntil(
          '/home', (Route<
          dynamic> route) => false);
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => Home(uid: result.user!.uid)),
      // );
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
  }

}
