import 'dart:convert' as JSON;

import 'package:flutter/material.dart';

import '../service/Client_Get.dart';
import '../data/Client.dart';

class ClientView extends StatefulWidget {
  @override
  ClientViewState createState() => ClientViewState();
}

class ClientViewState extends State<ClientView> {
  
  Map clients = {};
  List clientList = [];
  int clientListLength = 0;
  final TextStyle _cFontSize = const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold);

  ClientViewState() {
    getClientFromJson().then((val) => setState(() {
      clients = JSON.jsonDecode(val);
    }));
  }

  @override
  Widget build(BuildContext context){
    
    // Pre check to make sure the defualt value is Zero, not Null
    if(clients.isNotEmpty){
      clientList = clients['clients'];
      clientListLength = clientList.length;
      if (clientListLength!= null){
        // print('TEST:  ${clientList.length}');
        return ListView.builder(
          padding: const EdgeInsets.all(10.0),
          itemCount: clientListLength,
          itemBuilder: (BuildContext context, int i) {
            Client c = new Client.fromJson(clientList[i]);
            return clientRow(c);
          },
        );
      }
    }
    else {
      return Text('Shit...');
    }
  }

  Widget clientRow(Client c){
    
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(c.clientImg)
      ),
      title: Text(
        c.clientName,
        style: _cFontSize  
      ),
      subtitle: Text(
        c.location.street
      ),
      onTap: (){
        tempOnTap(c.clientName);
      },
    );
  }

  tempOnTap(str) {
    print(str);
  }
  
}