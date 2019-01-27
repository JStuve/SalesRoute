import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeView extends StatefulWidget {
  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {

  var savedClients = [];

  @override
  void initState() {
    super.initState();
    loadSavedClients();
  }

  loadSavedClients() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      savedClients = (prefs.getStringList('savedClients') ?? savedClients);
    });
  }

  @override
  Widget build(BuildContext context){
    
    print("CLIENTS: ${savedClients}");

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sales Routes",
          style: TextStyle(
            fontWeight : FontWeight.bold,
            fontSize: 22,
            color: Colors.tealAccent[700]
          )
        ),
        centerTitle: true,
      ),
      body: savedClients.isEmpty ? Text('Nothing Saved') : Text("Clients Saved!")
    );
  }
}
