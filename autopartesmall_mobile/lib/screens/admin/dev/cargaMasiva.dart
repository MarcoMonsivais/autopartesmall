import 'package:autopartes_mall/constants/Theme.dart';
import 'package:autopartes_mall/widgets/card-horizontal.dart';
import 'package:autopartes_mall/widgets/drawer.dart';
import 'package:autopartes_mall/widgets/navbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dart:io';
import 'package:path/path.dart';
import 'package:excel/excel.dart';

class cargaMasiva extends StatefulWidget {

  @override
  _cargaMasivaState createState() => _cargaMasivaState();
}

class _cargaMasivaState extends State<cargaMasiva> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Navbar(
          title: "¡DevMode!",
        ),
        backgroundColor: ArgonColors.bgColorScreen,
        drawer: ArgonDrawer(currentPage: "Dev"),
        body: Container(
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            child: Column(children: [
                  Padding(
                    padding:
                    const EdgeInsets.only(left: 20.0, right: 15.0, top: 8),
                    child: RaisedButton(
                      textColor: ArgonColors.white,
                      color: ArgonColors.primary,
                      onPressed: () async {


                        cme();
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
                  )
                ]
            )
        )
    );
  }

  void cme() {
    var file = "/Users/kawal/Desktop/form.xlsx";
    var bytes = File(file).readAsBytesSync();
    var excel = Excel.createExcel();
    // or
    //var excel = Excel.decodeBytes(bytes);
    for (var table in excel.tables.keys) {
      print(table);
      print(excel.tables[table].maxCols);
      print(excel.tables[table].maxRows);
      for (var row in excel.tables[table].rows) {
        print("$row");
      }
    }

    CellStyle cellStyle = CellStyle(
      bold: true,
      italic: true,
      fontFamily: getFontFamily(FontFamily.Comic_Sans_MS),
    );

    var sheet = excel['mySheet'];

    var cell = sheet.cell(CellIndex.indexByString("A1"));
    cell.value = "Heya How are you I am fine ok goood night";
    cell.cellStyle = cellStyle;

    var cell2 = sheet.cell(CellIndex.indexByString("E5"));
    cell2.value = "Heya How night";
    cell2.cellStyle = cellStyle;

    /// printing cell-type
    print("CellType: " + cell.cellType.toString());

    /// Iterating and changing values to desired type
    for (int row = 0; row < sheet.maxRows; row++) {
      sheet.row(row).forEach((cell) {
        var val = cell.value; //  Value stored in the particular cell

        cell.value = ' My custom Value ';
      });
    }

    excel.rename("mySheet", "myRenamedNewSheet");

    // fromSheet should exist in order to sucessfully copy the contents
    excel.copy('myRenamedNewSheet', 'toSheet');

    excel.rename('oldSheetName', 'newSheetName');

    excel.delete('Sheet1');

    excel.unLink('sheet1');

    sheet = excel['sheet'];

    /// appending rows
    List<List<String>> list = List.generate(
        6000, (index) => List.generate(20, (index1) => '$index $index1'));

    Stopwatch stopwatch = new Stopwatch()..start();
    list.forEach((row) {
      sheet.appendRow(row);
    });

    print('doSomething() executed in ${stopwatch.elapsed}');

    sheet.appendRow([8]);
    excel.setDefaultSheet(sheet.sheetName).then((isSet) {
      // isSet is bool which tells that whether the setting of default sheet is successful or not.
      if (isSet) {
        print("${sheet.sheetName} is set to default sheet.");
      } else {
        print("Unable to set ${sheet.sheetName} to default sheet.");
      }
    });

    // Saving the file

    String outputFile = "/Users/kawal/Desktop/form1.xlsx";
    excel.encode().then((onValue) {
      File(join(outputFile))
        ..createSync(recursive: true)
        ..writeAsBytesSync(onValue);
    });
  }

}
