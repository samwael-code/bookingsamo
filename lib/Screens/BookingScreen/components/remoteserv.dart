import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

import 'model.dart';
import 'package:http/http.dart'as http;

class remoteServices{
  final dio=Dio();
  Future<List<booking>?>getEvents(ph)async{

  // var client = http.C
var uri='https://booking-project-carp.vercel.app/api/getappoint/'+ph;
var response =await dio.get(uri);
if(response.statusCode==200){
 // var json = response.data;
  return (response.data as List)
      .map((x) => booking.fromJson(x))
      .toList();
}
  }
}