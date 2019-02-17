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
      print("DB Recreated!");
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
          "lZipcode TEXT,"
          "saved TEXT,"
          "distance TEXT"
          ")");
    });
  }

  newClient(Client c) async {
    final db = await database;
    var res = await db.rawInsert(
      "INSERT Into Clients (id,clientName,accountName,dataSheet,clientImg, lStreet, lCity,lState,lZipcode, saved, distance) "
      "SELECT '${c.id}', '${c.clientName}', '${c.accountName}', "
      "'${c.dataSheet}', '${c.clientImg}', '${c.lStreet}', "
      "'${c.lCity}', '${c.lState}','${c.lZipcode}', '${c.saved}', '${c.distance}' "
      "WHERE NOT EXISTS (SELECT 1 FROM Clients WHERE id='${c.id}')"
    );
    return res;
  }

  updateClient(Client c) async {
    final db = await database;
    var res = await db.rawUpdate(
      "UPDATE Clients "
      "SET clientName='${c.clientName}', accountName='${c.accountName}', dataSheet='${c.dataSheet}', clientImg='${c.clientImg}', lStreet='${c.lStreet}', lCity='${c.lCity}', lState='${c.lState}', lZipcode='${c.lZipcode}', saved='${c.saved}', distance='${c.distance}' "
      "WHERE id='${c.id}'"
    );
    return res;
  }

  deleteClient(Client c) async {
    final db = await database;
    var res = await db.rawUpdate(
      "DELETE FROM Clients "
      "WHERE id='${c.id}'"
    );
    return res;
  }

  Future<List<Client>> getClients() async {
    final db = await database;
    var res = await db.rawQuery(
      "SELECT * FROM Clients;"
    );
    List<Client> cList = res.isNotEmpty ? res.map((c) => Client.fromMap(c)).toList() : [];
    return cList;
  }

  Future<List<Client>> getSavedClients() async {
    final db = await database;
    var res = await db.rawQuery(
      "SELECT * FROM Clients "
      "WHERE saved='Y'"
    );
    List<Client> sList = res.isNotEmpty ? res.map((c) => Client.fromMap(c)).toList() : [];
    return sList;
  }

  //Adds demo data 
  addDemoClient() async {
    Client c0 = Client(
      id : "zzbbBBshhs882",
      clientName: "Mark Zs",
      accountName: "Chevy Hillside",
      dataSheet: "https://docs.google.com/spreadsheets/d/12tJusL00ncZbd6JX5o30vISKZ7n6Jumxtcruqaw74eg/edit?usp=sharing",
      clientImg: "https://i.imgur.com/VuKnN5P.jpg",
      lCity: "San Jose",
      lState: "CA",
      lStreet: "355 Conestoga Way",
      lZipcode: "95123",
      saved: "N",
      distance: "0.0"
    );
    Client c1 = Client(
      id : "zzbbBBshhss82",
      clientName: "Daddy Zs",
      accountName: "Chevy Hillside",
      dataSheet: "https://docs.google.com/spreadsheets/d/12tJusL00ncZbd6JX5o30vISKZ7n6Jumxtcruqaw74eg/edit?usp=sharing",
      clientImg: "https://i.imgur.com/VuKnN5P.jpg",
      lCity: "Irving",
      lState: "TX",
      lStreet: "7112 Paluxy Dr",
      lZipcode: "75039",
      saved: "N",
      distance: "0.0"
    );
    Client c2 = Client(
      id : "zzbbBBshaahs882",
      clientName: "Zaddy Zs",
      accountName: "Chevy Hillside",
      dataSheet: "https://docs.google.com/spreadsheets/d/12tJusL00ncZbd6JX5o30vISKZ7n6Jumxtcruqaw74eg/edit?usp=sharing",
      clientImg: "https://i.imgur.com/VuKnN5P.jpg",
      lCity: "Irving",
      lState: "TX",
      lStreet: "315 San Marcos Dr",
      lZipcode: "75039",
      saved: "N",
      distance: "0.0"
    );

    
    final dbs = await database;
    var res = await dbs.rawDelete("DELETE FROM Clients");
    db.newClient(c0);
    db.newClient(c1);
    db.newClient(c2);
  }

  deleteTable(String tableName) async{
    final db = await database;
    var res = await db.rawQuery(
      "DELETE FROM $tableName"
    );
    print("TABLE [$tableName] DELETED!");
  }
}