import 'package:apmall_web/login/reg_page.dart';
import 'package:apmall_web/on_boarding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:apmall_web/global_variables.dart' as Globals;

class LogginPage extends StatefulWidget {

  const LogginPage({Key? key}) : super(key: key);

  @override
  State<LogginPage> createState() => LogginState();
}

class LogginState extends State<LogginPage> {

  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscureText = true;

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
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.30,
                      height: MediaQuery.of(context).size.height * 0.30,
                      child: Image.asset('assets/img/logo_am.png')
                    ),

                    const SizedBox(height: 10,),

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

                    const SizedBox(height: 10,),

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

                    const SizedBox(height: 15,),

                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.25,
                      height: MediaQuery.of(context).size.height * 0.07,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                        Expanded(child: GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return RegisterPage();
                            }));
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.all(Radius.circular(40.0)),
                            ),
                            child: const Center(child: Text('Registrar', style: TextStyle(color: Colors.white),)),
                          ),
                        )),

                        SizedBox(width: MediaQuery.of(context).size.width * 0.03,),

                        Expanded(child: GestureDetector(
                          onTap: () {

                            FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                email: _userController.text, password: _passwordController.text)
                                .then((result) {
                                  Globals.logged = true;
                                  Navigator.of(context)
                                      .pushNamedAndRemoveUntil(
                                      '/onboarding', (Route<
                                      dynamic> route) => false);
                                  // Navigator.pushReplacement(
                                  //   context,
                                  //   MaterialPageRoute(builder: (context) => OnBoarding(uid: )),
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

                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.all(Radius.circular(40.0)),
                            ),
                            child: const Center(child: Text('Iniciar sesión', style: TextStyle(color: Colors.white),)),
                          ),
                        )),

                      ],),
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