// department_api.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'departement_model.dart';

Future<List<Department>> fetchDepartments() async {
  final response = await http.get(Uri.parse('https://adityauniversity.in:2001/api/get-department-data'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => Department.fromJson(data)).toList();
  } else {
    throw Exception('Failed to load departments');
  }
}