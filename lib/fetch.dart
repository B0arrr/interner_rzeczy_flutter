import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:internet_rzeczy/data.dart';

Future<Data> fetchData() async {
  // final response = await http.get(Uri.parse('http://esp8266.local:8080/'));
  final response = await http.get(Uri.parse('http://192.168.184.160:8080/'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Data.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
