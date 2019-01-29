class Client {

  String clientName = "";
  String accountName = "";
  Location location = Location();
  String dataSheet = "";
  String clientImg = "";
  String id = "";

  // Inializing class
  Client ({this.clientName, this.accountName, this.location, this.dataSheet, this.clientImg, this.id});

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      clientName: json['clientName'],
      accountName: json['accountName'],
      location: Location.fromJson(json['location']),
      dataSheet: json['dataSheet'],
      clientImg: json['clientImg'],
      id : json['_id']
    );
  }
}

class Location {
  
  String street = "";
  String city = "";
  String state = "";
  String zipcode = "";

  Location ({this.street, this.city, this.state, this.zipcode});

  factory Location.fromJson(Map<String, dynamic> json){
    return Location(
      street: json['street'],
      city: json['city'],
      state: json['state'],
      zipcode: json['zipcode']
    );
  }
}

// Client Class for DB, will remove above once stable

class LocationDB {
  
  String street = "";
  String city = "";
  String state = "";
  String zipcode = "";

  LocationDB ({this.street, this.city, this.state, this.zipcode});

  factory LocationDB.fromMap(Map<String, dynamic> json) => new LocationDB(
    street: json['street'],
    city: json['city'],
    state: json['state'],
    zipcode: json['zipcode']
  );
}

class ClientDB {

  String clientName = "";
  String accountName = "";
  String dataSheet = "";
  String clientImg = "";
  String id = "";
  LocationDB location = LocationDB(
    street: "",
    city: "",
    state: "",
    zipcode: ""
  );

  // Inializing class
  ClientDB ({this.clientName, this.accountName, this.location, this.dataSheet, this.clientImg, this.id});

  factory ClientDB.fromMap(Map<String, dynamic> json) => new ClientDB(
      clientName: json['clientName'],
      accountName: json['accountName'],
      location: LocationDB.fromMap(json['location']),
      dataSheet: json['dataSheet'],
      clientImg: json['clientImg'],
      id : json['_id']
    );
}