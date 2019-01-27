import 'package:flutter/material.dart';

class ClientEdit extends StatelessWidget {

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Clients",
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
          onPressed: () => print("Saved")
        ),
        color: Colors.transparent
        
      ),
    );
  }
}