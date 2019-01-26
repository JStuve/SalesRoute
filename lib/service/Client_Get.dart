
import 'dart:async' show Future;
import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import '../data/Client.dart';

Future<String> getClientFromJson() async{
  return await rootBundle.loadString('assets/clients.json');
}
