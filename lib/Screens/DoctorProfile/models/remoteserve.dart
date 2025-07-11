import 'package:dio/dio.dart';
import 'doctor_model.dart';
import 'package:get_storage/get_storage.dart';

Future<List<DoctorModel>> fetchDoctors() async {
  final dio = Dio();
  final box=GetStorage();
  final response = await dio.get('https://booking-project-carp.vercel.app/api/getDoctorswithsc/${box.read('docprof')}');

  if (response.statusCode == 200) {
    List data = response.data;
    return data.map((json) => DoctorModel.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load doctors');
  }
}
