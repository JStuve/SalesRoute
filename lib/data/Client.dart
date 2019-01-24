
class Client {

  final String clientName;
  final String accountName;
  final String location;
  final String dataSheet;
  final String clientImg;

  // Inializing class
  Client ({this.clientName, this.accountName, this.location, this.dataSheet, this.clientImg});

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      clientName: json['clientName'],
      accountName: json['accountName'],
      location: json['location'],
      dataSheet: json['dataSheet'],
      clientImg: json['clientImg']
    );
  }
}