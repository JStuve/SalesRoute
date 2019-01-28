import 'package:shared_preferences/shared_preferences.dart';

class LocalData {

  static List<String> savedClients = [];

  static getSavedClients() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    savedClients = prefs.getStringList('savedClients') ?? [];
  }

  static void setSavedClients(clients) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('savedClients', clients);
  }
}