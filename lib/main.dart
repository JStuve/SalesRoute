import 'package:flutter/material.dart';

import 'RandomWords_Page.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sales",
          style: TextStyle(
            fontWeight : FontWeight.bold,
            fontSize: 28,
            color: Colors.tealAccent[700]
          )
        )
      ),
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
            title: Text ('Profile')
          ),
        ],
        currentIndex: _selectedBottomTabIndex,
        fixedColor: Colors.tealAccent[700],
        onTap: changeView,
      ), 
    );
  }
 
  // Set the selected page view
  void changeView ( int index){
  setState((){
    _selectedBottomTabIndex = index;
    print("Set view on index " + index.toString());
  });
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