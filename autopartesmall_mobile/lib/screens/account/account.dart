import 'package:autopartes_mall/constants/Theme.dart';
import 'package:autopartes_mall/src/globalVariables.dart';
import 'package:autopartes_mall/widgets/drawer.dart';
import 'package:autopartes_mall/widgets/navbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:autopartes_mall/cons.dart';
import 'package:autopartes_mall/screens/comments/comments.dart';
import 'package:flutter/src/material/card.dart' as c;
import 'package:autopartes_mall/screens/account/accepted_customer.dart';

class Account extends StatefulWidget {

  final String uid;

  Account(this.uid);

  @override
  _accountState createState() => _accountState();

}

class _accountState extends State<Account> {

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _calle = TextEditingController();
  final TextEditingController _ciudad = TextEditingController();
  final TextEditingController _edo = TextEditingController();
  final TextEditingController _col = TextEditingController();
  final TextEditingController _numero = TextEditingController();
  final TextEditingController _cp = TextEditingController();
  final TextEditingController _numerodetarjeta = TextEditingController();
  final TextEditingController _rfc = TextEditingController();
  final TextEditingController _telephone = TextEditingController();

  @override
  Widget build(BuildContext context) {

    ThemeData theme = Theme.of(context);
    final PageController _controller = PageController(initialPage: 0);

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: Navbar(
          title: 'Cuenta',
          backButton: true,
          transparent: true,
        ),
        backgroundColor: ArgonColors.bgColorScreen,
        drawer: ArgonDrawer(currentPage: "account"),
        body: FutureBuilder(
          future: FirebaseFirestore.instance.collection('users')
              .doc(widget.uid)
              .get(),
          // ignore: missing_return
          builder: (context, snapshot) {

            //DocumentSnapshot
            DocumentSnapshot ds = snapshot.data;

            int rop = 0;

            try {
              rop = int.tryParse(ds['register']);
            } catch (onError) {
              print(onError);
            }

            if(rop==0) {
              return Stack(children: <Widget>[
                Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            alignment: Alignment.topCenter,
                            image: AssetImage(
                                "assets/img/profile-screen-bg.png"),
                            fit: BoxFit.fitWidth))),
                SafeArea(
                  child: ListView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      children: [
                        Padding(
                          padding:
                          const EdgeInsets.only(
                              left: 16.0, right: 16.0, top: 74.0),
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
                                        Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: c.Card(
                                      semanticContainer: true,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      elevation: .0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.all(
                                              Radius.circular(5.0))),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 85.0, bottom: 20.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                children: [

                                                  Container(
                                                    width: double.infinity,
                                                    padding: EdgeInsets.all(5),
                                                    child: ListView(
                                                      scrollDirection: Axis
                                                          .vertical,
                                                      physics: const NeverScrollableScrollPhysics(),
                                                      shrinkWrap: true,
                                                      children: [
                                                        FutureBuilder(
                                                            future: _db.collection('users').doc(widget.uid).collection('perfil').doc(ds['userprofileid']).get(),
                                                            builder: (context, snapshot2) {
                                                              DocumentSnapshot ds2 = snapshot2.data;

                                                              double hc = 50.0;

                                                              return Container(
                                                                width: MediaQuery.of(context).size.width,
                                                                height: MediaQuery.of(context).size.height,
                                                                child: Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                  children: [

                                                                    Center(child:
                                                                        Column(
                                                                          children: [
                                                                            Text('¡Bienvenido ' + ds['userName'] + '!', style: TextStyle(fontSize: 35.0),),
                                                                            SizedBox(height: 5.0,),
                                                                            Text('ID: ' + ds.id, style: TextStyle(fontSize: 15.0, color: Colors.grey),),
                                                                          ],
                                                                        )
                                                                    ),

                                                                    SizedBox(height: 20.0,),

                                                                    //PageView
                                                                    Container(
                                                                      height: 300,
                                                                      child: PageView(
                                                                        scrollDirection: Axis
                                                                            .horizontal,
                                                                        controller: _controller,
                                                                        children: [
                                                                          //personal
                                                                          Column(
                                                                            children: [
                                                                              TextFormField(
                                                                                controller: _name,
                                                                                autocorrect: false,
                                                                                textCapitalization: TextCapitalization.sentences,
                                                                                decoration: InputDecoration(
                                                                                  border: OutlineInputBorder(),
                                                                                  labelText: 'Nombre*',
                                                                                ),
                                                                              ),
                                                                              SizedBox(height: 10),
                                                                              TextFormField(
                                                                                controller: _email,
                                                                                autocorrect: false,
                                                                                textCapitalization: TextCapitalization.sentences,
                                                                                readOnly: true,
                                                                                decoration: InputDecoration(
                                                                                  border: OutlineInputBorder(),
                                                                                  labelText: ds2['email'],
                                                                                ),
                                                                              ),
                                                                              SizedBox(
                                                                                  height: 10),
                                                                              TextFormField(
                                                                                controller: _rfc,
                                                                                autocorrect: false,
                                                                                textCapitalization: TextCapitalization.characters,
                                                                                decoration: InputDecoration(
                                                                                    border: OutlineInputBorder(),
                                                                                    labelText: 'RFC'
                                                                                ),
                                                                              ),
                                                                              SizedBox(height: 10),
                                                                              TextFormField(
                                                                                controller: _telephone,
                                                                                keyboardType: TextInputType.number,
                                                                                autocorrect: false,
                                                                                decoration: InputDecoration(
                                                                                    border: OutlineInputBorder(),
                                                                                    labelText: 'Telefono'
                                                                                ),
                                                                              ),
                                                                            ],),

                                                                          //direccion
                                                                          Column(
                                                                            children: [
                                                                              Row(
                                                                                children: [
                                                                                  Expanded(
                                                                                    child:
                                                                                    Container(
                                                                                      child: TextFormField(
                                                                                        controller: _calle,
                                                                                        autocorrect: true,
                                                                                        textCapitalization: TextCapitalization.sentences,
                                                                                        decoration: InputDecoration(
                                                                                            border: OutlineInputBorder(),
                                                                                            labelText: 'Calle*'
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Expanded(
                                                                                    child:
                                                                                    TextFormField(
                                                                                      controller: _numero,
                                                                                      autocorrect: false,
                                                                                      keyboardType: TextInputType.number,
                                                                                      decoration: InputDecoration(
                                                                                          border: OutlineInputBorder(),
                                                                                          labelText: 'Numero*'
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              SizedBox(height: 10),
                                                                              TextFormField(
                                                                                controller: _col,
                                                                                autocorrect: true,
                                                                                textCapitalization: TextCapitalization.sentences,
                                                                                decoration: InputDecoration(
                                                                                    border: OutlineInputBorder(),
                                                                                    labelText: 'Colonia*'
                                                                                ),
                                                                              ),
                                                                              SizedBox(height: 10),
                                                                              TextFormField(
                                                                                controller: _ciudad,
                                                                                autocorrect: true,
                                                                                textCapitalization: TextCapitalization.sentences,
                                                                                decoration: InputDecoration(
                                                                                    border: OutlineInputBorder(),
                                                                                    labelText: 'Ciudad*'
                                                                                ),
                                                                              ),
                                                                              SizedBox(height: 10),
                                                                              Row(
                                                                                children: [
                                                                                  Expanded(
                                                                                    child:
                                                                                    Container(
                                                                                      child: TextFormField(
                                                                                        controller: _edo,
                                                                                        autocorrect: true,
                                                                                        textCapitalization: TextCapitalization.sentences,
                                                                                        decoration: InputDecoration(
                                                                                            border: OutlineInputBorder(),
                                                                                            labelText: 'Estado*'
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ],),

                                                                          //tarjeta
                                                                          Column(
                                                                            children: [
                                                                              TextFormField(
                                                                                controller: _numerodetarjeta,
                                                                                autocorrect: false,
                                                                                decoration: InputDecoration(
                                                                                    border: OutlineInputBorder(),
                                                                                    labelText: 'Tarjeta/Cuenta bancaria'
                                                                                ),
                                                                                inputFormatters: [
                                                                                  FilteringTextInputFormatter.digitsOnly,
                                                                                  new CustomInputFormatter()
                                                                                ],
                                                                              ),
                                                                            ],),

                                                                        ],
                                                                      ),
                                                                    ),

                                                                    // botones
                                                                    Row(
                                                                      children: [

                                                                        Expanded(child:
                                                                          GestureDetector(
                                                                              onTap: () {
                                                                                if (_controller.page == 0) {
                                                                                  _controller.animateToPage(2,
                                                                                      duration: Duration(milliseconds: 400),
                                                                                      curve: Curves.easeIn);
                                                                                } else {
                                                                                  _controller.animateToPage(_controller.page.round() - 1,
                                                                                      duration: Duration(milliseconds: 400),
                                                                                      curve: Curves.easeIn);
                                                                                }
                                                                              },
                                                                              child: Icon(Icons.keyboard_arrow_left)
                                                                          ),
                                                                        ),

                                                                        Expanded(
                                                                          child:
                                                                          GestureDetector(
                                                                            onTap: () async {

                                                                              print(!(_name.text.length < 0 && _calle.text.length < 0 && _numero.text.length < 0 && _col.text.length < 0 && _ciudad.text.length < 0 && _edo.text.length < 0));

                                                                              print('1: ' + _name.text.length.toString());
                                                                              print('2: ' + _calle.text.length.toString());
                                                                              print('3: ' + _numero.text.length.toString());
                                                                              print('4: ' + _col.text.length.toString());
                                                                              print('5: ' + _ciudad.text.length.toString());
                                                                              print('6: ' + _edo.text.length.toString());

                                                                              if (!(_name.text.length < 0 && _calle.text.length < 0 && _numero.text.length < 0 && _col.text.length < 0 && _ciudad.text.length < 0 && _edo.text.length < 0)) {
                                                                                try {
                                                                                  //_showMyDialog('Aceptado');

                                                                                  var datafirebase = {
                                                                                    'name': _name.text,
                                                                                    "email": useremail,
                                                                                    'phone': _telephone.text,
                                                                                    'cardnumber': _numerodetarjeta.text,
                                                                                    'rfc': _rfc.text,
                                                                                    'address': {
                                                                                      'address_number': _numero.text,
                                                                                      'address_street': _calle.text,
                                                                                      'address_col': _col.text,
                                                                                      'address_postal_code': _cp.text,
                                                                                      'address_city': _ciudad.text,
                                                                                      'address_state': _edo.text,
                                                                                      'address_country': 'MEX',
                                                                                    }
                                                                                  };

                                                                                  await _db
                                                                                      .collection('users')
                                                                                      .doc(ds.id)
                                                                                      .collection('perfil')
                                                                                      .doc(ds2.id)
                                                                                      .update(datafirebase);

                                                                                  await _db
                                                                                      .collection(
                                                                                      'users')
                                                                                      .doc(ds.id)
                                                                                      .update(
                                                                                      {
                                                                                        'register': '1'
                                                                                      });

                                                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => AcceptedCustomer()));

                                                                                } catch (err) {
                                                                                  print('err: ${err.toString()}');
                                                                                }
                                                                              } else {
                                                                                _showMyDialog(
                                                                                    'Rellena la información obligatoria');

                                                                                _controller.animateToPage(_controller.page.round() + 1,
                                                                                    duration: Duration(milliseconds: 400),
                                                                                    curve: Curves.easeIn);
                                                                              }
                                                                            },
                                                                            child: Container(
                                                                              width: MediaQuery.of(context).size.width,
                                                                              height: hc,
                                                                              decoration: BoxDecoration(
                                                                                color: Colors.blue[600],
                                                                                border: Border.all(
                                                                                  color: Colors.white,
                                                                                ),
                                                                              ),
                                                                              child: Center(child: Text('Guardar', style: TextStyle(color: Colors.white,))),
                                                                            ),
                                                                          ),
                                                                        ),

                                                                        Expanded(child:
                                                                          GestureDetector(
                                                                              onTap: () {
                                                                                if (_controller.page == 2) {
                                                                                  _controller.animateToPage(0,
                                                                                      duration: Duration(milliseconds: 400),
                                                                                      curve: Curves.easeIn);
                                                                                } else {
                                                                                  _controller
                                                                                      .animateToPage(
                                                                                      _controller.page.round() + 1,
                                                                                      duration: Duration(milliseconds: 400),
                                                                                      curve: Curves.easeIn);
                                                                                }
                                                                              },
                                                                              child: Icon(Icons.keyboard_arrow_right)
                                                                          ),
                                                                        ),

                                                                      ],
                                                                    ),

                                                                  ],
                                                                ),
                                                              );
                                                            }
                                                        )
                                                      ],
                                                    ),
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
                                        backgroundImage: NetworkImage(
                                            'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'),
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
            } else {
              return Stack(children: <Widget>[
                Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            alignment: Alignment.topCenter,
                            image: AssetImage(
                                "assets/img/profile-screen-bg.png"),
                            fit: BoxFit.fitWidth))),
                SafeArea(
                  child: ListView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      children: [
                        Padding(
                          padding:
                          const EdgeInsets.only(
                              left: 16.0, right: 16.0, top: 74.0),
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
                                        Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: c.Card(
                                      semanticContainer: true,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      elevation: .0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.all(
                                              Radius.circular(5.0))),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 85.0, bottom: 20.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                children: [

                                                  Container(
                                                    width: double.infinity,
                                                    padding: EdgeInsets.all(5),
                                                    child: ListView(
                                                      scrollDirection: Axis.vertical,
                                                      physics: const NeverScrollableScrollPhysics(),
                                                      shrinkWrap: true,
                                                      children: [
                                                        FutureBuilder(
                                                            future: _db.collection('users').doc(widget.uid).collection('perfil').doc(ds['userprofileid']).get(),
                                                            builder: (context, snapshot2) {

                                                              DocumentSnapshot ds2 = snapshot2.data;

                                                              double hc = 50.0;

                                                              String ciudad,calle, number, col, estado;

                                                              try {

                                                                Map<dynamic, dynamic> mapdetailAddress = ds2['address'];

                                                                ciudad = mapdetailAddress['address_city'];
                                                                  ciudad.isEmpty ? ciudad = 'Sin ciudad' : null;

                                                                calle = mapdetailAddress['address_street'];
                                                                  calle.isEmpty ? calle = 'Sin calle' : null;

                                                                number = mapdetailAddress['address_number'];
                                                                  number.isEmpty ? number = 'Sin número' : null;

                                                                col = mapdetailAddress['address_col'];
                                                                  col.isEmpty ? number = 'Sin colonia' : null;

                                                                estado = mapdetailAddress['address_state'];
                                                                  estado.isEmpty ? number = 'Sin estado' : null;

                                                              } catch(onEr) {

                                                                ciudad = _ciudad.text;
                                                                calle = _calle.text;
                                                                number = _numero.text;
                                                                col = _col.text;
                                                                estado = _edo.text;
                                                                print('er2: ' + onEr);

                                                              }

                                                              return Container(
                                                                width: MediaQuery.of(context).size.width,
                                                                height: MediaQuery.of(context).size.height,
                                                                child: Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                  children: [

                                                                    Center(child:
                                                                      Column(
                                                                        children: [
                                                                          Text('¡Bienvenido!', style: TextStyle(fontSize: 35.0),),
                                                                          SizedBox(height: 5.0,),
                                                                          Text('ID: ' + ds.id, style: TextStyle(fontSize: 15.0, color: Colors.grey),),
                                                                        ],
                                                                      )
                                                                    ),

                                                                    SizedBox(height: 20.0,),

                                                                    //PageView
                                                                    Container(
                                                                      height: 300,
                                                                      child: PageView(
                                                                        scrollDirection: Axis.horizontal,
                                                                        controller: _controller,
                                                                        children: [
                                                                          //personal
                                                                          Column(children: [
                                                                            TextFormField(
                                                                              controller: _name,
                                                                              autocorrect: false,
                                                                              textCapitalization: TextCapitalization.sentences,
                                                                              decoration: InputDecoration(
                                                                                  border: OutlineInputBorder(),
                                                                                  labelText: ds2['name'].length<=0?'Nombre*':ds2['name']
                                                                              ),
                                                                            ),
                                                                            SizedBox(height: 10),
                                                                            TextFormField(
                                                                              controller: _email,
                                                                              autocorrect: false,
                                                                              textCapitalization: TextCapitalization.sentences,
                                                                              readOnly: true,
                                                                              // initialValue: useremail,
                                                                              decoration: InputDecoration(
                                                                                  border: OutlineInputBorder(),
                                                                                  labelText: ds2['email'].length<=0?'Email*':ds2['email']
                                                                              ),
                                                                            ),
                                                                            SizedBox(height: 10),
                                                                            TextFormField(
                                                                              controller: _rfc,
                                                                              autocorrect: false,
                                                                              textCapitalization: TextCapitalization.characters,
                                                                              decoration: InputDecoration(
                                                                                  border: OutlineInputBorder(),
                                                                                  labelText: ds2['rfc'].length<=0?'RFC':ds2['rfc']
                                                                              ),
                                                                            ),
                                                                            SizedBox(height: 5),
                                                                            TextFormField(
                                                                              controller: _telephone,
                                                                              keyboardType: TextInputType.number,
                                                                              autocorrect: false,
                                                                              decoration: InputDecoration(
                                                                                  border: OutlineInputBorder(),
                                                                                  labelText: ds2['phone'].length<=0?'Telefono':ds2['phone']
                                                                              ),
                                                                            ),
                                                                          ],),

                                                                          //direccion
                                                                          Column(children: [
                                                                            Row(
                                                                              children: [
                                                                                Expanded(
                                                                                  child:
                                                                                  Container(
                                                                                    child: TextFormField(
                                                                                      controller: _calle,
                                                                                      autocorrect: true,
                                                                                      textCapitalization: TextCapitalization.sentences,
                                                                                      decoration: InputDecoration(
                                                                                          border: OutlineInputBorder(),
                                                                                          labelText: calle.length<=0?'Calle*':calle
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Expanded(
                                                                                  child:
                                                                                  TextFormField(
                                                                                    controller: _numero,
                                                                                    autocorrect: false,
                                                                                    keyboardType: TextInputType.number,
                                                                                    decoration: InputDecoration(
                                                                                        border: OutlineInputBorder(),
                                                                                        labelText: number.length<=0?'Numero*':number
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            SizedBox(height: 10),
                                                                            TextFormField(
                                                                              controller: _col,
                                                                              autocorrect: true,
                                                                              textCapitalization: TextCapitalization.sentences,
                                                                              decoration: InputDecoration(
                                                                                  border: OutlineInputBorder(),
                                                                                  labelText: col.length<=0?'Colonia*':col
                                                                              ),
                                                                            ),
                                                                            SizedBox(height: 10),
                                                                            TextFormField(
                                                                              controller: _ciudad,
                                                                              autocorrect: true,
                                                                              textCapitalization: TextCapitalization.sentences,
                                                                              decoration: InputDecoration(
                                                                                  border: OutlineInputBorder(),
                                                                                  labelText: ciudad.length<=0?'Ciudad*':ciudad
                                                                              ),
                                                                            ),
                                                                            SizedBox(height: 10),
                                                                            Row(
                                                                              children: [
                                                                                Expanded(
                                                                                  child:
                                                                                  Container(
                                                                                    child: TextFormField(
                                                                                      controller: _edo,
                                                                                      autocorrect: true,
                                                                                      textCapitalization: TextCapitalization.sentences,
                                                                                      decoration: InputDecoration(
                                                                                          border: OutlineInputBorder(),
                                                                                          labelText: estado.length<=0?'Estado*':estado
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ],),

                                                                          //tarjeta
                                                                          Column(children: [
                                                                            TextFormField(
                                                                              controller: _numerodetarjeta,
                                                                              autocorrect: false,
                                                                              decoration: InputDecoration(
                                                                                  border: OutlineInputBorder(),
                                                                                  labelText: 'Tarjeta/Cuenta bancaria'
                                                                              ),
                                                                              inputFormatters: [
                                                                                FilteringTextInputFormatter.digitsOnly,
                                                                                new CustomInputFormatter()
                                                                              ],
                                                                            ),
                                                                          ],),

                                                                        ],
                                                                      ),
                                                                    ),

                                                                    //botones
                                                                    Row(
                                                                      children: [

                                                                        Expanded(child:
                                                                          GestureDetector(
                                                                              onTap: () {
                                                                                if(_controller.page == 0) {
                                                                                  _controller.animateToPage(2,
                                                                                      duration: Duration(
                                                                                          milliseconds: 400),
                                                                                      curve: Curves.easeIn);
                                                                                } else {
                                                                                  _controller.animateToPage( _controller.page.round() - 1,
                                                                                      duration: Duration(
                                                                                          milliseconds: 400),
                                                                                      curve: Curves.easeIn);
                                                                                }
                                                                              },
                                                                              child: Icon(Icons.keyboard_arrow_left)
                                                                          ),
                                                                        ),

                                                                        Expanded(child:
                                                                          GestureDetector(
                                                                            onTap: () async {

                                                                              if(!(_name.text.length<0&&_calle.text.length<0&&_numero.text.length<0&&_col.text.length<0&&_ciudad.text.length<0&&_edo.text.length<0))
                                                                              {
                                                                                try {

                                                                                  Map<String, dynamic> datafirebase = {
                                                                                    'name': _name.text.isEmpty ? ds2['name'] : _name.text,
                                                                                    'cardnumber': _numerodetarjeta.text.isEmpty ? ds2['cardnumber'] : _numerodetarjeta.text,
                                                                                    'email': ds2['email'],
                                                                                    'phone': _telephone.text.isEmpty ? ds2['phone'] : _telephone.text,
                                                                                    'rfc': _rfc.text.isEmpty ? ds2['rfc'] : _rfc.text,
                                                                                    'address': {
                                                                                      'address_city': _ciudad.text.isEmpty ? ciudad : _ciudad.text,
                                                                                      'address_street': _calle.text.isEmpty ? calle : _calle.text,
                                                                                      'address_number': _numero.text.isEmpty ? number : _numero.text,
                                                                                      'address_col': _col.text.isEmpty ? col : _col.text,
                                                                                      'address_state': _edo.text.isEmpty ? estado : _edo.text,
                                                                                    }
                                                                                  };

                                                                                  await _db
                                                                                      .collection('users')
                                                                                      .doc(ds.id)
                                                                                      .collection('perfil')
                                                                                      .doc(ds2.id)
                                                                                      .update(datafirebase);

                                                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => AcceptedCustomer()));

                                                                                } catch (err) {
                                                                                  print('err: ${err.toString()}');
                                                                                }
                                                                              } else {
                                                                                _showMyDialog('Rellena la información obligatoria');
                                                                              }
                                                                            },
                                                                            child: Container(
                                                                              width: MediaQuery.of(context).size.width,
                                                                              height: hc,
                                                                              decoration: BoxDecoration(
                                                                                color: Colors.blue[600],
                                                                                border: Border.all(
                                                                                  color: Colors.white,
                                                                                ),
                                                                              ),
                                                                              child: Center(child: Text('Guardar', style: TextStyle(color: Colors.white,))),
                                                                            ),
                                                                          ),
                                                                        ),

                                                                        Expanded(child:
                                                                          GestureDetector(
                                                                              onTap: () {
                                                                                if(_controller.page == 2) {
                                                                                  _controller.animateToPage(0,
                                                                                      duration: Duration(
                                                                                          milliseconds: 400),
                                                                                      curve: Curves.easeIn);
                                                                                } else {
                                                                                  _controller.animateToPage( _controller.page.round() + 1,
                                                                                      duration: Duration(
                                                                                          milliseconds: 400),
                                                                                      curve: Curves.easeIn);
                                                                                }
                                                                              },
                                                                              child: Icon(Icons.keyboard_arrow_right)
                                                                          ),
                                                                        ),

                                                                      ],
                                                                    ),

                                                                  ],
                                                                ),
                                                              );
                                                            }
                                                        )

                                                      ],
                                                    ),
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
                                        backgroundImage: NetworkImage(
                                            'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'),
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
            }

          },
        )
    );

  }

  Future<void> _showMyDialog(string) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('AutopartesMall dice: '),
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

  _headerPhoto(String photoUrl) {
    if(photoUrl.length<=0) {
      return Image(image: AssetImage("assets/no_data.png"), height: 120);
    } else {
      return Image.network(photoUrl, height: 120,fit: BoxFit.fill);
    }
  }

  _noOrdersOnboarding() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "No hay comentarios para este producto",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins'),
          ),
          Center(
            child: Text(
              "Este producto no ha recibido comentarios.\n Crea uno en el botón de abajo",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Poppins'),
            ),
          )
        ],
      ),
    );
  }

  _ordersErrorOnboarding() {
    return Container(
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
          Center(
            child: Text(
              "Inténtalo de nuevo más tarde",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Poppins'),
            ),
          )
        ],
      ),
    );
  }

}

class CustomInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = new StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write(' '); // Replace this with anything you want to put after each 4 numbers
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: new TextSelection.collapsed(offset: string.length)
    );
  }
}