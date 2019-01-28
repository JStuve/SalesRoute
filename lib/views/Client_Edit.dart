import 'package:flutter/material.dart';

import '../data/Client.dart';

class ClientEdit extends StatelessWidget {

  Client client;
  String appBarTitle = "Edit Client";
  static GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Constructor
  ClientEdit({Key key, this.client, @required this.appBarTitle}): super(key: key);

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
          onPressed: () { 
            if(formKey.currentState.validate()){
              formKey.currentState.save();
              // print(formClientName.value);
              print(this.client.clientName);
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
            initialValue: this.client.clientName.isEmpty ? null : this.client.clientName,
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