class Client {

  final String clientName;
  final String accountName;
  final Location location;
  final String dataSheet;
  final String clientImg;

  // Inializing class
  Client ({this.clientName, this.accountName, this.location, this.dataSheet, this.clientImg});

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      clientName: json['clientName'],
      accountName: json['accountName'],
      location: Location.fromJson(json['location']),
      dataSheet: json['dataSheet'],
      clientImg: json['clientImg']
    );
  }
}

class Location {
  
  final String street;
  final String city;
  final String state;
  final String zipcode;

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