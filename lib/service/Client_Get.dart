import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

Future<String> getClientFromJson() async{
  return await rootBundle.loadString('assets/clients.json');
}
