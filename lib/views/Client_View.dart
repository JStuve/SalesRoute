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

    Data.db.getClients();
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
            MaterialPageRoute(builder: (context) => ClientEdit(client: getEmptyClient(), isNewClient: true,))
          );
        },
      ),
      body: new Container (
        child: new FutureBuilder<List<Client>>(
          future: Data.db.getClients(),
          builder: (BuildContext context, AsyncSnapshot<List<Client>> snapshot) {
            if(snapshot.hasData){
              if(snapshot.data.isNotEmpty){
                return clientListView(snapshot);
              }
            }
            return Center(child: CircularProgressIndicator());
          })
      )
    );
  }

  Widget clientListView(AsyncSnapshot<List<Client>> clients){
    return ListView.builder(
      itemCount: clients.data.length,
      itemBuilder: (BuildContext context, int i){
        Client c = clients.data[i];
        return Dismissible(
          key: UniqueKey(),
          background: Container(color: Colors.red),
          direction: DismissDirection.horizontal,
          onDismissed: (direction){
            Data.db.deleteClient(c);
          },
          child: clientRow(c)
        );
      },
    );
  }

  Widget clientRow(Client c){
    
  //   final bool isSaved = savedClients.contains(c.id);

    return ListTile(
      contentPadding: const EdgeInsets.all(10.0),
      leading: CircleAvatar(
        // backgroundImage: NetworkImage(c.clientImg, scale: 2.0),
        radius: 30.0,
      ),
      title: Text(
        c.clientName,
        style: _cFontSize  
      ),
      subtitle: Text(
        c.lStreet
      ),
      trailing: Icon(
        c.saved == 1 ? Icons.bookmark : Icons.bookmark_border,
        color: Colors.tealAccent[700]),
      onTap: () {
        setState(() {
          if(c.saved == 0){
            print("Update DB to Saved");
          } else {
            print("Update DB to NOT Saved");
          }
          LocalData.setSavedClients(savedClients);
        });
      },
      onLongPress: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ClientEdit(client: c))
        );
      },
    );
  }

  Client getEmptyClient() {
    Client emptyClient = new Client(
      accountName: null, 
      clientName: null, 
      clientImg: null, 
      dataSheet: null, 
      id: null, 
      lCity: null,
      lState: null,
      lStreet: null,
      lZipcode: null);

    return emptyClient;
  }
}