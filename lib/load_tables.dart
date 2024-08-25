import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

import 'models/table.dart';

Future<List<Table>> loadTables() async {
  String jsonString = await rootBundle.loadString('assets/tables.json');

  List<dynamic> jsonList = json.decode(jsonString);

  List<Table> tables = jsonList.map((json) => Table.fromJson(json)).toList();

  return tables;
}
