import 'package:shared_preferences/shared_preferences.dart';

class LocalData {

  static List<String> savedClients = [];

  static getClients() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    savedClients = prefs.getStringList('savedClients') ?? [];
  }

  static void setClients(clients) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('savedClients', clients);
  }
}