import 'dart:convert';

class Client {

  String id = "";
  String clientName = "";
  String accountName = "";
  String dataSheet = "";
  String clientImg = "";
  int saved = 0;
  String lStreet = "";
  String lCity = "";
  String lState = "";
  String lZipcode = "";

  // Inializing class
  Client ({
    this.clientName, 
    this.accountName, 
    this.dataSheet, 
    this.clientImg, 
    this.id, 
    this.saved,
    this.lStreet,
    this.lCity,
    this.lState,
    this.lZipcode
  });

  factory Client.fromMap(Map<String, dynamic> json) => new Client(
    id: json["id"],
    clientName: json["clientName"],
    accountName: json["accountName"],
    clientImg: json["clientImg"],
    dataSheet: json["dataSheet"],
    lCity: json["lCity"],
    lState: json["lState"],
    lStreet: json["lStreet"],
    lZipcode: json["lZipcode"] 
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "clientName": clientName,
    "clientImg": clientImg,
    "accountName": accountName,
    "dataSheet": dataSheet,
    "lCity": lCity,
    "lState": lState,
    "lStreet": lStreet,
    "lZipcode": lZipcode
  };
}

Client clientFromJson(String str) {
  final jsonData = json.decode(str);
  return Client.fromMap(jsonData);
}

String clientToJson(Client data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}