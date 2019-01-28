import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import 'dart:io';
import 'dart:async';
import 'dart:core';

import '../data/Client.dart';

class Data {

  Data._();
  static final Data db = Data._();
  static Database _d;

  Future<Database> get database async {
    if(_d == null){
      _d = await initDB();
    }
    return _d;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "SalesRoute.db");
    return await openDatabase(path, version: 1, onOpen: (db) {
    }, onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Clients ("
          "id STRING PRIMARY KEY,"
          "clientName TEXT,"
          "accountName TEXT,"
          "dataSheet TEXT,"
          "clientImg TEXT,"
          "lStreet TEXT,"
          "lCity TEXT,"
          "lState TEXT,"
          "lZipcode TEXT"
          ")");
    });
  }

  createClient(Client c) async {
    final db = await database;
    var res = await db.rawInsert(
      "INSERT Into Clients (id,clientName,accountName,dataSheet,clientImg, lStreet, lCity,lState,lZipcode) "
      "VALUES ('${c.id}', '${c.clientName}', '${c.accountName}', "
      "'${c.dataSheet}', '${c.clientImg}', '${c.location.street}', "
      "'${c.location.city}', '${c.location.state}','${c.location.zipcode}')"
    );
    return res;
  }
}