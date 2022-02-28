import 'dart:convert';

import 'package:flutter_tvmaze/Model/EpisodeInfoModel.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

Future<List<EpisodeInfoModel>> fetchEpisodeInfo(int id) async {
  String episodeUrl = "https://api.tvmaze.com/shows/$id/episodes";
  final response = await http.get(Uri.parse(episodeUrl));
  print(response.statusCode);

  if (response.statusCode == 200) {
    List episodeResponse = jsonDecode(response.body);
    return episodeResponse.map((e) => EpisodeInfoModel.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load show data');
  }
}
