import 'package:autopartes_mall/constants/Theme.dart';
import 'package:autopartes_mall/widgets/navbar.dart';
import 'package:autopartes_mall/screens/admin/adminMode.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class productsAdminPage extends StatefulWidget {

  final String documentId, nameProduct;

  productsAdminPage(this.documentId, this.nameProduct);

  @override
  _productsAdminPageState createState() => _productsAdminPageState();

}

class _productsAdminPageState extends State<productsAdminPage> {

  final TextEditingController _descripcionController = new TextEditingController();
  final TextEditingController _marcaController = new TextEditingController();
  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _priceController = new TextEditingController();
  final TextEditingController _parteController = new TextEditingController();
  final TextEditingController _rateController = new TextEditingController();
  final TextEditingController _statusController = new TextEditingController();
  final TextEditingController _storeController = new TextEditingController();
  
  @override
  Widget build(BuildContext context) {
      return Scaffold(
          appBar: Navbar(
            title: widget.nameProduct,
            backButton: true,
          ),
          backgroundColor: ArgonColors.bgColorScreen,
          // drawer: ArgonDrawer(currentPage: "productsAdmin"),
          body: Container(
              padding: EdgeInsets.only(right: 24, left: 24, bottom: 36),
              child: SingleChildScrollView(
                child: Column(
                  children: [

                    FutureBuilder(
                      future: FirebaseFirestore.instance.collection('products')
                          .doc(widget.documentId)
                          .get(),
                      // ignore: missing_return
                      builder: (context, snapshot) {

                        //DocumentSnapshot
                        DocumentSnapshot ds = snapshot.data;

                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(ds['image'], width: 140.0, height: 140.0),
                              SelectableText('Código de producto: ' + ds.id),
                              Text('Código de producto: ' + ds['date']),

                              Text('Descripcion: '),
                              TextFormField(
                                controller: _descripcionController,
                                decoration: InputDecoration(
                                  //icon: Icon(Icons.text_fields),
                                  labelText: ds['description'],
                                ),
                                keyboardType: TextInputType.text,
                                autocorrect: true,
                                textCapitalization: TextCapitalization.words,
                              ),

                              Text('Marca: '),
                              TextFormField(
                                controller: _marcaController,
                                decoration: InputDecoration(
                                  //icon: Icon(Icons.text_fields),
                                  labelText: ds['marca'],
                                ),
                                keyboardType: TextInputType.text,
                                autocorrect: true,
                                textCapitalization: TextCapitalization.words,
                              ),

                              Text('Nombre: '),
                              TextFormField(
                                controller: _nameController,
                                decoration: InputDecoration(
                                  //icon: Icon(Icons.text_fields),
                                  labelText: ds['name'],
                                ),
                                keyboardType: TextInputType.text,
                                autocorrect: true,
                                textCapitalization: TextCapitalization.words,
                              ),

                              Text('Precio: '),
                              TextFormField(
                                controller: _priceController,
                                decoration: InputDecoration(
                                  //icon: Icon(Icons.text_fields),
                                  labelText: ds['price'],
                                ),
                                keyboardType: TextInputType.text,
                                autocorrect: true,
                                textCapitalization: TextCapitalization.words,
                              ),

                              Text('Parte: '),
                              TextFormField(
                                controller: _parteController,
                                decoration: InputDecoration(
                                  //icon: Icon(Icons.text_fields),
                                  labelText: ds['parte'],
                                ),
                                keyboardType: TextInputType.text,
                                autocorrect: true,
                                textCapitalization: TextCapitalization.words,
                              ),

                              Text('Rate: '),
                              TextFormField(
                                controller: _rateController,
                                decoration: InputDecoration(
                                  //icon: Icon(Icons.text_fields),
                                  labelText: ds['rate'],
                                ),
                                keyboardType: TextInputType.text,
                                autocorrect: true,
                                textCapitalization: TextCapitalization.words,
                              ),

                              Text('Status: '),
                              TextFormField(
                                controller: _rateController,
                                decoration: InputDecoration(
                                  //icon: Icon(Icons.text_fields),
                                  labelText: ds['status'],
                                ),
                                keyboardType: TextInputType.text,
                                autocorrect: true,
                                textCapitalization: TextCapitalization.words,
                              ),

                              Text('Store: '),
                              TextFormField(
                                controller: _rateController,
                                decoration: InputDecoration(
                                  //icon: Icon(Icons.text_fields),
                                  labelText: ds['store'],
                                ),
                                keyboardType: TextInputType.text,
                                autocorrect: true,
                                textCapitalization: TextCapitalization.words,
                              ),

                              Text('Trans: ' + ds['transmision']),
                              Text('Type: ' + ds['type']),
                              Text('User: ' + ds['user']),

                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(left: 20.0, right: 15.0, top: 8),
                                    child: RaisedButton(
                                      textColor: ArgonColors.white,
                                      color: ArgonColors.primary,
                                      onPressed: () async {
                                        _Confirmation(context);
                                      },
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4.0),
                                      ),
                                      child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 16.0, right: 16.0, top: 12, bottom: 12),
                                          child: Text("Eliminar",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600, fontSize: 16.0))),
                                    ),
                                  ),
                                  // Expanded(child: SizedBox(height: 3.0,),),
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(left: 15.0, right: 20.0, top: 8),
                                    child: RaisedButton(
                                      textColor: ArgonColors.white,
                                      color: ArgonColors.primary,
                                      onPressed: () async {

                                        await FirebaseFirestore.instance.collection('products').doc(ds.id).update({
                                          // 'date': DateTime.now ( ).toString ( ),
                                          'description': _descripcionController.text.isEmpty ? ds['description'] : _descripcionController.text,
                                          'name': _nameController.text.isEmpty ? ds['name'] : _nameController.text,
                                          // 'image': '',
                                          'price': _priceController.text.isEmpty ? ds['price'] : _priceController.text,
                                          'parte': _parteController.text.isEmpty ? ds['parte'] : _parteController.text,
                                          'rate': _rateController.text.isEmpty ? ds['rate'] : _rateController.text,
                                          'store': _storeController.text.isEmpty ? ds['store'] : _storeController.text,
                                          // 'user': userid,
                                          'marca': _marcaController.text.isEmpty ? ds['marca'] : _marcaController.text,
                                          // 'transmision': transmisionController.text,
                                          // 'type': typeController.text,
                                          'status': 'active'
                                        });

                                        _showMyDialog('Producto actualizado', context);

                                        Navigator.push ( context,
                                            MaterialPageRoute ( builder: (context) {
                                              return AdminMode ( );
                                            } ) );

                                      },
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4.0),
                                      ),
                                      child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 16.0, right: 16.0, top: 12, bottom: 12),
                                          child: Text("Actualizar",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600, fontSize: 16.0))),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),


                  ],
                ),
              )));
  }

  Future<void> _Confirmation(context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('¿Deseas eliminar este producto? Las imagenes y referencias serían eliminadas si no han existido ventas de él'),
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

                      FirebaseFirestore.instance.collection('products').doc(widget.documentId).update({
                        'status': 'inactive'
                      });

                      Navigator.of(context)
                          .pushNamedAndRemoveUntil('/admin/', (Route<dynamic> route) => false);

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

}