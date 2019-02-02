import 'package:flutter/material.dart';
import 'RandomWords_Page.dart';

import 'views/Home_View.dart';
import 'views/Client_View.dart';
import 'views/Profile_View.dart';
import 'service/SQL_Data.dart';


void main() => runApp(SalesRoute());

class SalesRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sales Route',
      theme: ThemeData(
        primaryColor: Colors.white
      ),
      home: SalesRouteWidget(),
    );
  }
}

class SalesRouteWidget extends StatefulWidget {
  @override
  SalesRouteHome createState() => SalesRouteHome();
}

class SalesRouteHome extends State<SalesRouteWidget>{

  int _selectedBottomTabIndex = 0;
  String appBarTitle = "Sales";

  final List<Widget> mainViews = [
    HomeView(),
    ClientView(),
    ProfileView()
  ];

  @override
  void initState() {
    super.initState();
    Data.db.getClients();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: mainViews[_selectedBottomTabIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem (
            icon: Icon (Icons.dashboard),
            title: Text ('Home')
          ),
          BottomNavigationBarItem (
            icon: Icon (Icons.people),
            title: Text ('Clients')
          ),
          BottomNavigationBarItem (
            icon: Icon (Icons.settings),
            title: Text ('Settings')
          ),
        ],
        currentIndex: _selectedBottomTabIndex,
        fixedColor: Colors.tealAccent[700],
        onTap: changeView,
      ), 
    );
  }
 
  // Set the selected page view
  Widget changeView ( int index){
    setState((){
      _selectedBottomTabIndex = index;
    });
    return new HomeView();
  }

  tempOnTap(str) {
    print(str);
  }
}


// Main Widget
class MyApp extends StatelessWidget {
  @override                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Gen',
      theme: new ThemeData(
        primaryColor: Colors.white
      ),
      home: new RandomWords()
    );
  }
}