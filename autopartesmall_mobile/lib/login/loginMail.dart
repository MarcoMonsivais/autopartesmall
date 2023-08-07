import 'package:autopartes_mall/constants/Theme.dart';
import 'package:autopartes_mall/widgets/drawer.dart';
import 'package:autopartes_mall/widgets/navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailLogIn extends StatefulWidget {
  @override
  _EmailLogInState createState() => _EmailLogInState();
}

class _EmailLogInState extends State<EmailLogIn> {

  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Navbar(transparent: true, title: ""),
        extendBodyBehindAppBar: true,
        drawer: ArgonDrawer(currentPage: "Account"),
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
                  padding: const EdgeInsets.only(
                      top: 16, left: 24.0, right: 24.0, bottom: 32),
                  child: Card(
                      elevation: 5,
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Container(
                        height: 450,
                        child: Container(
                            height: MediaQuery.of(context).size.height * 0.20,
                            decoration: BoxDecoration(
                                color: ArgonColors.white,
                                border: Border(
                                    bottom: BorderSide(
                                        width: 0.5,
                                        color: ArgonColors.muted))),
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: TextFormField(
                                    controller: emailController,
                                    decoration: InputDecoration(
                                      labelText: "Enter Email Address",
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                    ),
                                    // The validator receives the text that the user has entered.
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Enter Email Address';
                                      } else if (!value.contains('@')) {
                                        return 'Please enter a valid email address!';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: TextFormField(
                                    obscureText: true,
                                    controller: passwordController,
                                    decoration: InputDecoration(
                                      labelText: "Enter Password",
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                    ),
                                    // The validator receives the text that the user has entered.
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Enter Password';
                                      } else if (value.length < 6) {
                                        return 'Password must be atleast 6 characters!';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: isLoading
                                      ? CircularProgressIndicator()
                                      : ElevatedButton(
                                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue)),
                                    onPressed: () {
                                      if (_formKey.currentState.validate()) {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        logInToFb();
                                      }
                                    },
                                    child: Text('Submit'),
                                  ),
                                )
                              ],
                            )
                        ),
                      )),
                ),
              ]),
            )
          ],
        ));
  }

  void logInToFb() {

    print('mail: ' + emailController.text);
    print('pass: ' + passwordController.text);

    // print(FirebaseAuth.instance.currentUser.uid);

    FirebaseAuth.instance
        .signInWithEmailAndPassword(
        email: emailController.text, password: passwordController.text)
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
