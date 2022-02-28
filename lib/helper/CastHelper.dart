import 'package:flutter_tvmaze/Model/CastModel.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';

Future<List<CastModel>> fetchCastData(int id) async {
  String castUrl = "https://api.tvmaze.com/shows/$id/cast";
  final response = await http.get(Uri.parse(castUrl));

  if (response.statusCode == 200) {
    List castResponse = jsonDecode(response.body);
    return castResponse.map((e) => CastModel.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load show data');
  }
}
