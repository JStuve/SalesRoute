import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../service/SQL_Data.dart';
import '../data/Client.dart';

class HomeView extends StatefulWidget {
  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {

  final TextStyle _cFontSize = const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold);
  Position pos;
  List<Placemark> place;
  Geolocator geo = new Geolocator();

  @override
  void initState() {
    super.initState();

    
    getLocation();
    // List<Placemark> place = geo.placemarkFromCoordinates(pos.latitude, pos.longitude);
  }

  getLocation() async {
    GeolocationStatus locStatus = await geo.checkGeolocationPermissionStatus();
    if(locStatus == GeolocationStatus.granted){
      pos = await geo.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
      place = await geo.placemarkFromCoordinates(pos.latitude, pos.longitude);
      print(place);
    }
    else {
      print("Still no status");
    }
  }

  @override
  Widget build(BuildContext context){
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
      body: new Container (
        child: new FutureBuilder<List<Client>>(
          future: Data.db.getSavedClients(),
          builder: (BuildContext context, AsyncSnapshot<List<Client>> snapshot) {
            if(snapshot.hasData){
              if(snapshot.data.isNotEmpty){
                return savedClientListView(snapshot);
              }
            }
            return Center(child: CircularProgressIndicator());
          })
      )
    );
  }

  Widget savedClientListView(AsyncSnapshot<List<Client>> clients){
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
          child: savedClientRow(c)
        );
      },
    );
  }

  Widget savedClientRow(Client c){
    
    return ListTile(
      contentPadding: const EdgeInsets.all(10.0),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(c.clientImg, scale: 2.0),
        radius: 30.0,
      ),
      title: Text(
        c.clientName,
        style: _cFontSize  
      ),
      subtitle: Text(
        c.lStreet
      ),
      onTap: (){
        print("TODO: No design for tap on home...");
      },
      onLongPress: (){
        print("TODO: Nothing planned for long pressed on home...");
      },
    );
  }
}
