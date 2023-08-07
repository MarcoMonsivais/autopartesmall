import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:apmall_web/global_variables.dart' as Globals;
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterPage extends StatefulWidget {

  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => RegisternState();
}

class RegisternState extends State<RegisterPage> {

  final TextEditingController _userController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController = TextEditingController();

  bool _obscureText = true;
  bool _obscure2Text = true;
  Color _color = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [

            Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/img/profile-screen-bg.png"),
                        fit: BoxFit.cover))
            ),

            Center(
              child: Container(
                margin: const EdgeInsets.all(10.0),
                height: MediaQuery.of(context).size.height * 0.70,
                width: MediaQuery.of(context).size.width * 0.35,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(40.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.20,
                          height: MediaQuery.of(context).size.height * 0.20,
                          child: Image.asset('assets/img/logo_am.png')
                      ),

                      //Correo
                      const SizedBox(height: 5,),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: TextFormField(
                          controller: _userController,
                          decoration: InputDecoration(
                            hintText: 'Usuario',
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                                width: 2.0,
                              ),
                            ),
                          ),
                        ),
                      ),

                      //Nombre
                      const SizedBox(height: 5,),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            hintText: 'Nombre',
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                                width: 2.0,
                              ),
                            ),
                          ),
                        ),
                      ),

                      //Contraseña
                      const SizedBox(height: 5,),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: TextFormField(
                          controller: _passwordController,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            hintText: 'Contraseña',
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                                width: 2.0,
                              ),
                            ),
                            suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                                child: const Icon(Icons.remove_red_eye, color: Colors.black,)
                            ),
                          ),
                        ),
                      ),

                      //Confirmar Contraseña
                      const SizedBox(height: 5,),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: TextFormField(
                          controller: _passwordConfirmController,
                          obscureText: _obscure2Text,
                          onChanged: (string){
                            setState(() {
                              _color = Colors.blue;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: 'Confirma tu contraseña',
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                                width: 2.0,
                              ),
                            ),
                            suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _obscure2Text = !_obscure2Text;
                                  });
                                },
                                child: const Icon(Icons.remove_red_eye, color: Colors.black,)
                            ),
                          ),
                        ),
                      ),

                      //Registrar boton
                      const SizedBox(height: 10,),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                        height: MediaQuery.of(context).size.height * 0.07,
                        child: GestureDetector(
                          onTap: (){
                            try {
                              FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                  email: _userController.text,
                                  password: _passwordController.text)
                                  .then((result) async {
                                final _auth = FirebaseAuth.instance;
                                final newUser = await _auth.currentUser;
                                final FirebaseFirestore _db = FirebaseFirestore
                                    .instance;

                                Globals.useremail = _userController.text;
                                Globals.userid = newUser!.uid;

                                await _db.collection('users').doc(newUser.uid)
                                    .collection('perfil').add(
                                    {'email': _userController.text,})
                                    .then((value) =>
                                Globals.userprofileid = value.id);

                                DocumentReference ref = _db
                                    .collection('users').doc(
                                    newUser.uid);

                                ref.set({
                                  'userLastSeen': DateTime
                                      .now(),
                                  'userCreated': DateTime
                                      .now(),
                                  'userEmail': _userController.text,
                                  'userName': _nameController.text,
                                  'usercustomerid': '',
                                  'userprofileid': Globals.userprofileid,
                                  'register': '0'
                                }).then((value) {

                                  Globals.logged = true;

                                  Navigator.of(context)
                                      .pushNamedAndRemoveUntil(
                                      '/onboarding', (Route<
                                      dynamic> route) => false);
                                });
                              }).catchError((err) {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
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
                            } catch (onError){
                              print('Error');
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: _color,
                              borderRadius: const BorderRadius.all(Radius.circular(40.0)),
                            ),
                            child: const Center(child: Text('Registrar', style: TextStyle(color: Colors.white),)),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ],
        )
    );
  }

}