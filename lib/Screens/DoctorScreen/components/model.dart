import 'dart:convert';

List<doctors> eventsFromJson(String str ) => List<doctors>.from(json.decode(str).map((x) => doctors.fromJson(x)));

String eventsToJson(List<doctors> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class doctors {
  String? sId;
  String? firstName;
  String? lastName;
  String ?mobile;
  String? email;
  String? address;
  String? dateOfBirth;
  String? doctorDepartment;
  String ?specialist;
  String? doctorImage;
  String? nid;
  String? nidPhoto;
  String ?shortBiography;
  String? gender;
  String? password;
  bool? isadmin;
  bool? isactive;
  int? rate;

  int ?iV;

  doctors(
      {required this.sId,
        required this.firstName,
        required this.lastName,
        required this.mobile,
        required this.email,
        required this.address,
        required this.dateOfBirth,
        required this.doctorDepartment,
        required this.specialist,
        required this.doctorImage,
        required this.nid,
        required this.nidPhoto,
        required this.shortBiography,
        required this.gender,
        required this.password,
        required this.isadmin,
        required this.isactive,
        required this.rate,

        required this.iV});

  doctors.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    mobile = json['mobile'];
    email = json['email'];
    address = json['address'];
    dateOfBirth = json['dateOfBirth'];
    doctorDepartment = json['doctorDepartment'];
    specialist = json['specialist'];
    doctorImage = json['doctorImage'];
    nid = json['Nid'];
    nidPhoto = json['NidPhoto'];
    shortBiography = json['shortBiography'];
    gender = json['gender'];
    password = json['password'];
    isadmin = json['isadmin'];
    isactive = json['isactive'];
    rate = json['rate'];

    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['address'] = this.address;
    data['dateOfBirth'] = this.dateOfBirth;
    data['doctorDepartment'] = this.doctorDepartment;
    data['specialist'] = this.specialist;
    data['doctorImage'] = this.doctorImage;
    data['Nid'] = this.nid;
    data['NidPhoto'] = this.nidPhoto;
    data['shortBiography'] = this.shortBiography;
    data['gender'] = this.gender;
    data['password'] = this.password;
    data['isadmin'] = this.isadmin;
    data['isactive'] = this.isactive;
    data['rate'] = this.rate;
    data['__v'] = this.iV;
    return data;
  }
}
