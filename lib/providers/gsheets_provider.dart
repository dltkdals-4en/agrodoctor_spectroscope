import 'package:ctgformanager/gsheets/agrodoctor_api_config.dart';
import 'package:flutter/material.dart';
import 'package:gsheets/gsheets.dart';

class GsheetsProvider with ChangeNotifier {
  GSheets gSheets = AgrodoctorApiConfig.AgrodoctorGSheets;
  String gSheetsId = AgrodoctorApiConfig.gsheetsId;
  Spreadsheet? spreadsheet;
  Worksheet? worksheet;

  Future<void> init() async {
    spreadsheet ??= await gSheets.spreadsheet(gSheetsId);
    worksheet ??= await spreadsheet!.worksheetByTitle('test_sheet');
  }

  Future<void> insertData(String inputText, String outputText) async {
    await init();

    worksheet!.values.map.insertRowByKey(DateTime.now(), {
      "입력 데이터": inputText,
      "출력 데이터": outputText,
    });
  }
}
