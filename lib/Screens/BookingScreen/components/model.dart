import 'dart:convert';

List<booking> eventsFromJson(String str ) => List<booking>.from(json.decode(str).map((x) => booking.fromJson(x)));

String eventsToJson(List<booking> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class booking {
  String? mobile;
  String? time;
  String? date;
  String? firstName;
  String? lastName;

  booking({this.mobile, this.time, this.date, this.firstName, this.lastName});

  booking.fromJson(Map<String, dynamic> json) {
    mobile = json['mobile'];
    time = json['time'];
    date = json['date'];
    firstName = json['firstName'];
    lastName = json['lastName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobile'] = this.mobile;
    data['time'] = this.time;
    data['date'] = this.date;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    return data;
  }
}

