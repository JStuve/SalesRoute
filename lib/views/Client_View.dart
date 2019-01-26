import 'dart:async' show Future;
import 'package:flutter/material.dart';

import '../service/Client_Get.dart';
import '../data/Client.dart';

class ClientView extends StatefulWidget {
  @override
  ClientViewState createState() => ClientViewState();
}

class ClientViewState extends State<ClientView> {
  
  String clients = "";
  ClientViewState() {
    getClientFromJson().then((val) => setState(() {
      clients = val;
    }));
  }

  @override
  Widget build(BuildContext context){
    
    print(clients);

    return ListView.builder(
      padding: EdgeInsets.all(8.0),
      itemBuilder: (BuildContext context, int i) {

        return Text('Index $i');
      },
    );
  }

  Widget clientRow(Client c){
    
    return ListTile(
      title: Text("Test")
    );
  }

  
}