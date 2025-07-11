import 'schedule_model.dart';

class DoctorModel {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? mobile;
  final String? email;
  final String? address;
  final String? dateOfBirth;
  final String? doctorDepartment;
  final String? specialist;
  final String? doctorImage;
  final String? nid;
  final String? nidPhoto;
  final String? shortBiography;
  final String? gender;
  final String? password;
  final bool? isAdmin;
  final bool? isActive;
  final double? rate;
  final ScheduleModel? schedual;

  DoctorModel({
    this.id,
    this.firstName,
    this.lastName,
    this.mobile,
    this.email,
    this.address,
    this.dateOfBirth,
    this.doctorDepartment,
    this.specialist,
    this.doctorImage,
    this.nid,
    this.nidPhoto,
    this.shortBiography,
    this.gender,
    this.password,
    this.isAdmin,
    this.isActive,
    this.rate,
    this.schedual,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      mobile: json['mobile'],
      email: json['email'],
      address: json['address'],
      dateOfBirth: json['dateOfBirth'],
      doctorDepartment: json['doctorDepartment'],
      specialist: json['specialist'],
      doctorImage: json['doctorImage'],
      nid: json['Nid'],
      nidPhoto: json['NidPhoto'],
      shortBiography: json['shortBiography'],
      gender: json['gender'],
      password: json['password'],
      isAdmin: json['isadmin'],
      isActive: json['isactive'],
      rate: (json['rate'] != null) ? double.tryParse(json['rate'].toString()) ?? 0.0 : 0.0,
      schedual: json['schedual'] != null ? ScheduleModel.fromJson(json['schedual']) : null,
    );
  }
}
