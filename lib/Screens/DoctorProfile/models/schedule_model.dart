import 'day_time_model.dart';

class ScheduleModel {
  final String? id;
  final String? doctorMobile;
  final bool? sat;
  final DayTimeModel? sattime;
  final bool? sun;
  final DayTimeModel? suntime;
  final bool? mon;
  final DayTimeModel? montime;
  final bool? tue;
  final DayTimeModel? tuetime;
  final bool? wen;
  final DayTimeModel? wentime;
  final bool? thu;
  final DayTimeModel? thutime;
  final bool? fri;
  final DayTimeModel? fritime;

  ScheduleModel({
    this.id,
    this.doctorMobile,
    this.sat,
    this.sattime,
    this.sun,
    this.suntime,
    this.mon,
    this.montime,
    this.tue,
    this.tuetime,
    this.wen,
    this.wentime,
    this.thu,
    this.thutime,
    this.fri,
    this.fritime,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
      id: json['_id'],
      doctorMobile: json['doctormobile'],
      sat: json['sat'],
      sattime: json['sattime'] != null ? DayTimeModel.fromJson(json['sattime']) : null,
      sun: json['sun'],
      suntime: json['suntime'] != null ? DayTimeModel.fromJson(json['suntime']) : null,
      mon: json['mon'],
      montime: json['montime'] != null ? DayTimeModel.fromJson(json['montime']) : null,
      tue: json['tue'],
      tuetime: json['tuetime'] != null ? DayTimeModel.fromJson(json['tuetime']) : null,
      wen: json['wen'],
      wentime: json['wentime'] != null ? DayTimeModel.fromJson(json['wentime']) : null,
      thu: json['thu'],
      thutime: json['thutime'] != null ? DayTimeModel.fromJson(json['thutime']) : null,
      fri: json['fri'],
      fritime: json['fritime'] != null ? DayTimeModel.fromJson(json['fritime']) : null,
    );
  }
}
