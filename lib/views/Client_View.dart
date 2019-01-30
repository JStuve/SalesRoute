import 'dart:convert' as JSON;

import 'package:flutter/material.dart';

import '../views/Client_Edit.dart';
import '../service/Client_Get.dart';
import '../service/Local_Data.dart';
import '../data/Client.dart';
import '../service/SQL_Data.dart';

class ClientView extends StatefulWidget {
  @override
  ClientViewState createState() => ClientViewState();
}

class ClientViewState extends State<ClientView> {
  
  Map clients = {};
  List clientList = [];
  var savedClients;
  int clientListLength = 0;
  final TextStyle _cFontSize = const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold);

  @override
  void initState() {
    super.initState();
    
  }

  ClientViewState() {
    
    Data.db.addDemoClient();
    var dbClients = Data.db.getClients();
    print(dbClients);
    getClientFromJson().then((val) => setState(() {
      clients = JSON.jsonDecode(val);
    }));
  }

  @override
  Widget build(BuildContext context){
    // Pulls Saved data from local
    LocalData.getSavedClients();
    savedClients = LocalData.savedClients;

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
            MaterialPageRoute(builder: (context) => ClientEdit(client: getEmptyClient(), appBarTitle: "New Client", isNewClient: true,))
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
      if (clientListLength != null){
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
        setState(() {
          if(isSaved){
            savedClients.remove(c.id);
          } else {
            savedClients.add(c.id);
          }
          LocalData.setSavedClients(savedClients);
        });
      },
      onLongPress: (){
        print(savedClients);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ClientEdit(client: c, appBarTitle: "Edit Client",))
        );
      },
    );
  }

  Client getEmptyClient() {
    Location emptyLocation = new Location(city: null, state: null, street: null, zipcode: null);
    Client emptyClient = new Client(accountName: null, clientName: null, clientImg: null, dataSheet: null, id: null, location: emptyLocation);
    return emptyClient;
  }
}