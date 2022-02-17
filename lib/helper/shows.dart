import 'dart:convert';

import 'package:flutter_tvmaze/Model/ShowModel.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class Shows {
  List<ShowModel> shows = [];

  Future<void> getShows() async {
    String tvmazeUrl = "https://api.tvmaze.com/shows";
    var response = await http.get(Uri.parse(tvmazeUrl));

    Map mapResponse = jsonDecode(response.body);

    List<ShowModel> genres = [
      ShowModel(
          mapResponse['id'].toString(),
          mapResponse['url'].toString(),
          mapResponse['name'].toString(),
          mapResponse['officialSite'].toString(),
          mapResponse['image']['original'].toString())
    ];

    if (response.statusCode == 200) {
      String id = mapResponse['id'].toString();
      String image = mapResponse['image']['original'].toString();
      String name = mapResponse['name'].toString();
      String url = mapResponse['url'].toString();
      String urlToOfficialSite = mapResponse['officialSite'].toString();

      ShowModel showModel = ShowModel(id, url, name, urlToOfficialSite, image);
      shows.add(showModel);
    } else {
      throw Exception("Failed to load shows");
    }
  }
}

Future<List<ShowModel>> getShowTrial() async {
  String tvmazeUrl = "https://api.tvmaze.com/shows";
  var response = await http.get(Uri.parse(tvmazeUrl));
  Map mapResponse = jsonDecode(response.body);
  List<ShowModel> genres = [
    ShowModel(
        mapResponse['id'].toString(),
        mapResponse['url'].toString(),
        mapResponse['name'].toString(),
        mapResponse['officialSite'].toString(),
        mapResponse['image']['original'].toString())
  ];
  return genres.toList();
}
