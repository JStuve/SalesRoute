import 'package:shared_preferences/shared_preferences.dart';


class LocalData {


  loadLocal() async{
      SharedPreferences _local = await SharedPreferences.getInstance();
      return _local;
  }
}