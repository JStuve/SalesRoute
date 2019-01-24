import 'package:flutter/material.dart';

import '../service/Client_Get.dart';

class ClientView extends StatefulWidget {
  @override
  ClientViewState createState() => ClientViewState();
}

class ClientViewState extends State<ClientView> {

  @override
  Widget build(BuildContext context){
    return Text('Client');
  }

  final tempC = getClient();
}