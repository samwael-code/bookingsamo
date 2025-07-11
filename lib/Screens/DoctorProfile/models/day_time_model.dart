class DayTimeModel {
  final String? startTime;
  final String? endTime;
  final String? id;

  DayTimeModel({
    this.startTime,
    this.endTime,
    this.id,
  });

  factory DayTimeModel.fromJson(Map<String, dynamic> json) {
    return DayTimeModel(
      startTime: json['startTime'],
      endTime: json['endTime'],
      id: json['_id'],
    );
  }
}
