import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart' as random;

import '../data/Client.dart';
import '../service/SQL_Data.dart';

class ClientEdit extends StatelessWidget {

  final Client client;
  final String appBarTitle = "Client Details";
  static GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final bool isNewClient;

  // Constructor
  ClientEdit({Key key, this.client, this.isNewClient = false}): super(key: key);

  @override
  Widget build(BuildContext context){

    // print(client.clientName);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          appBarTitle,
          style: TextStyle(
            fontWeight : FontWeight.bold,
            fontSize: 22,
            color: Colors.tealAccent[700]
          )
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: clientForm(),
      bottomNavigationBar: BottomAppBar(
        child: RaisedButton(
          child: Text(
            "Save",
            style: TextStyle(
              fontWeight : FontWeight.bold,
              fontSize: 18,
              color: Colors.white
            ) 
          ),
          color: Colors.tealAccent[700],
          padding: const EdgeInsets.all(18.0),
          onPressed: () async{ 
            if(formKey.currentState.validate()){
              formKey.currentState.save(); // Uncomment if you want the form to save if it closes
              // print(formClientName.value);
              if(isNewClient){
                this.client.id = random.randomAlphaNumeric(14).toString();
                await Data.db.newClient(client);
              }
              await Data.db.updateClient(client);
              Navigator.pop(context);
            }
          }
        ),
        color: Colors.transparent
        
      ),
    );
  }


  Widget clientForm(){

    return Form(
      key: formKey,
      child: ListView(
        padding: EdgeInsets.all(10.0),
        children: <Widget>[
          TextFormField(
            initialValue: this.client.clientName == null ? null : this.client.clientName,
            decoration: const InputDecoration(
              labelText: "Client Name",
              contentPadding: EdgeInsets.all(20.0)
            ),
            onSaved: (String value){
              this.client.clientName = value;
            },
            validator: (value){
              if (value.isEmpty) {
                return "Please enter client name";
              }
            },
          )
        ],
      )
    );
  }

  saveForm(){
    print("Savedd!");
  }
}