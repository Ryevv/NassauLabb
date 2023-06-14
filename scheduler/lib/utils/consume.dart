import 'dart:convert';
import 'package:scheduler/utils/welcome.dart';
import 'package:http/http.dart' as http;

class consume{
  Future<Teacher> getTeacher(Welcome welcome) async {
  const url = "https://nassaulabapi-production-32e9.up.railway.app/v1/api/teachers-login";
  
  final response = await http.post(Uri.parse(url), body: welcome);



 if (response.statusCode == 200){
 return Teacher.fromJson(jsonDecode(response.body));
 } else{
  throw Exception("Login inválido");

 } 
 




}

}
