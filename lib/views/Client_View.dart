import 'dart:convert' as JSON;

import 'package:flutter/material.dart';

import '../views/Client_Edit.dart';
import '../service/Client_Get.dart';
import '../data/Client.dart';

class ClientView extends StatefulWidget {
  @override
  ClientViewState createState() => ClientViewState();
}

class ClientViewState extends State<ClientView> {
  
  Map clients = {};
  List clientList = [];
  Set<int> savedClients = new Set<int>();
  int clientListLength = 0;
  Client emptyClient =  Client();
  final TextStyle _cFontSize = const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold);

  ClientViewState() {
    getClientFromJson().then((val) => setState(() {
      clients = JSON.jsonDecode(val);
    }));
  }

  @override
  Widget build(BuildContext context){
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Clients",
          style: TextStyle(
            fontWeight : FontWeight.bold,
            fontSize: 22,
            color: Colors.tealAccent[700]
          )
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.tealAccent[700],
        elevation: 2.0,
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ClientEdit(client: Client(), appBarTitle: "New Client"))
          );
        },
      ),
      body: clientListView()
    );
  }

  Widget clientListView(){
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
  }

  Widget clientRow(Client c){
    
    final bool isSaved = savedClients.contains(c.id);

    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(c.clientImg, scale: 2.0),
        radius: 30.0,
      ),
      title: Text(
        c.clientName,
        style: _cFontSize  
      ),
      subtitle: Text(
        c.location.street
      ),
      trailing: Icon(
        isSaved ? Icons.bookmark : Icons.bookmark_border,
        color: Colors.tealAccent[700]),
      onTap: () {
        print(savedClients);

        setState(() {
          if(isSaved){
            savedClients.remove(c.id);
          } else {
            savedClients.add(c.id);
          }
        });
      },
      onLongPress: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ClientEdit(client: c, appBarTitle: "Edit Client",))
        );
      },
    );
  }

  void savedClientsList(){

  }

  tempOnTap(str) {
    print(str);
  }
  
}