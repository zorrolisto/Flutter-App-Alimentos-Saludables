import 'dart:async';
import 'dart:convert';

import 'package:flutter_app3/entities/ComidaSaludable.dart';
import 'package:http/http.dart' as http;

Future<ComidaSaludable> fetchComidaSaludable() async {
  final response =
  await http.get('https://api.spoonacular.com/recipes/random?apiKey=bb48a07851fd49908a50bb96c8eede07&limitLicense=true&number=1');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return ComidaSaludable.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load comida Saludable');
  }
}