import 'package:autopartes_mall/screens/account/account.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:autopartes_mall/constants/Theme.dart';
import 'package:autopartes_mall/widgets/drawer-tile.dart';

class ArgonDrawer extends StatelessWidget {

  final String currentPage;
  final String uid;
  final bool isAdmin;

  ArgonDrawer({this.currentPage, this.uid, this.isAdmin});

  final TextEditingController _confirmationController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
        color: ArgonColors.white,
        child: Column(children: [
          Container(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width * 0.85,
              child: SafeArea(
                bottom: false,
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 120,top: 15),
                    child: Image.asset("assets/img/autopartes.png"),
                  ),
                ),
              )),
          Expanded(
            flex: 2,
            child: ListView(
              padding: EdgeInsets.only(top: 24, left: 16, right: 16),
              children: [
                DrawerTile(
                    icon: Icons.home,
                    onTap: () {
                      if (currentPage != "Home")
                        Navigator.pushReplacementNamed(context, '/home');
                    },
                    iconColor: ArgonColors.primary,
                    title: "Inicio",
                    isSelected: currentPage == "Home" ? true : false),
                DrawerTile(
                    icon: Icons.account_circle,
                    onTap: () {
                      if(uid.isNotEmpty) {

                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return Account(uid);
                        }));

                      } else {
                        if (currentPage != "Account") Navigator.pushReplacementNamed(context, '/account');
                      }
                    },
                    iconColor: ArgonColors.info,
                    title: "Cuenta",
                    isSelected: currentPage == "Account" ? true : false),
//                 DrawerTile(
//                     icon: Icons.store,
//                     onTap: () {
//                       _showMyDialog('¡Estamos trabajando en esta sección!', context);
// //                      if (currentPage != "storeDetail")
// //                        Navigator.pushReplacementNamed(context, '/elements');
//                     },
//                     iconColor: ArgonColors.error,
//                     title: "Mi tienda",
//                     isSelected: currentPage == "storeDetail" ? true : false),
//                 DrawerTile(
//                     icon: Icons.history,
//                     onTap: () {
//                       _showMyDialog('¡Estamos trabajando en esta sección!', context);
// //                      if (currentPage != "productsPage")
// //                        Navigator.pushReplacementNamed(context, '/products/');
//                     },
//                     iconColor: ArgonColors.primary,
//                     title: "Mis Compras",
//                     isSelected: currentPage == "productsPage" ? true : false),

              isAdmin ?
                DrawerTile(
                    icon: Icons.admin_panel_settings,
                    onTap: () {
                      _Confirmation(context);
                    },
                    iconColor: Colors.yellow,
                    title: "Admin",
                    isSelected: currentPage == "admin" ? true : false) : Container(),

//                DrawerTile(
//                    icon: Icons.history,
//                    onTap: () {
//                      if (currentPage != "articles")
//                        Navigator.pushReplacementNamed(context, '/articles');
//                    },
//                    iconColor: ArgonColors.primary,
//                    title: "Articles",
//                    isSelected: currentPage == "articles" ? true : false),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
                padding: EdgeInsets.only(left: 8, right: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(height: 4, thickness: 0, color: ArgonColors.muted),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 16.0, left: 16, bottom: 8),
                      child: Text("Vende un producto",
                          style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 0.5),
                            fontSize: 15,
                          )),
                    ),
                    DrawerTile(
                        icon: Icons.monetization_on_rounded,
                        onTap: (){
                          Navigator.pushReplacementNamed(context, '/addProduct/');
                        },
                        iconColor: ArgonColors.muted,
                        title: "Vender",
                        isSelected:
                            currentPage == "Getting started" ? true : false),
                    _cerrarSesion(context),
                  ],
                )),
          ),
        ]),
    ));
  }

  _cerrarSesion(context){
    bool control = false;

    try{
      control = uid.isNotEmpty;
    } catch (onError) {
      print('sesión no iniciada');
    }

    if(control) {
      return DrawerTile(
          icon: Icons.logout,
          onTap: () {
            FirebaseAuth.instance.signOut().whenComplete(() =>
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(
                    '/home', (Route<dynamic> route) => false));
          },
          iconColor: ArgonColors.info,
          title: "Cerrar sesión",
          isSelected: currentPage == "sesion" ? true : false);
    } else {
      return DrawerTile(
          icon: Icons.account_circle,
          onTap: () {
            if (currentPage != "Account") Navigator.pushReplacementNamed(context, '/account');
          },
          iconColor: ArgonColors.info,
          title: "Iniciar Sesión",
          isSelected: currentPage == "iniciar" ? true : false);
    }
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

  Future<void> _Confirmation(context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Escribe la contraseña'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextFormField(
                  controller: _confirmationController,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Container(child:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  TextButton(
                    child: Text('Cancelar'),
                    onPressed: () {

                      Navigator.of(context).pop();
                    },
                  ),


                  TextButton(
                    child: Text('Aceptar'),
                    onPressed: () {
                      if(_confirmationController.text == 'P@SSAP'){
                       if (currentPage != "admin")
                         Navigator.pushReplacementNamed(context, '/admin/');
                      }
                      else {
                        _showMyDialog('Contraseña incorrecta', context);
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
