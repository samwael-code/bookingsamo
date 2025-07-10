import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

import 'model.dart';
import 'package:http/http.dart'as http;

class remoteServices{
  final dio=Dio();
  Future<List<doctors>?>getEvents(address,day)async{

  // var client = http.C
var uri='https://booking-project-carp.vercel.app/api/getDoctors/'+address+'/'+day;
var response =await dio.get(uri);
if(response.statusCode==200){
 // var json = response.data;
  return (response.data as List)
      .map((x) => doctors.fromJson(x))
      .toList();
}
  }
}