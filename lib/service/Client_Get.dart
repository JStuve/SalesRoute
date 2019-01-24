import 'dart:async' show Future;
import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
// import '../data/Client.dart';

Future<String> loadClientFromJson() async {
  return await rootBundle.loadString('assets/clients.json');
}

Future<Map> getClient() async{
  String clientString = await loadClientFromJson();
  final clientJson = json.decode(clientString);
  // final clients = new Client.fromJson(clientJson);

  return clientJson;
}