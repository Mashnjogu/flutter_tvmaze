import 'package:flutter/material.dart';
import 'package:flutter_tvmaze/views/castInfo.dart';
import 'package:flutter_tvmaze/views/crewInfo.dart';
import 'package:flutter_tvmaze/views/episodes_info.dart';

class ShowCard extends StatelessWidget {
  final String showImage, title, imgUrl, summary;
  final int id;
  List<String> genres = [];

  ShowCard(
      {required this.showImage,
      required this.title,
      required this.id,
      required this.imgUrl,
      required this.summary});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 6, bottom: 6),
      child: Card(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                showImage,
                fit: BoxFit.fill,
                width: double.infinity,
                height: 300,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: EdgeInsets.fromLTRB(80, 8, 0, 16),
                    child: Text(
                      title,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    )),
                // SizedBox(
                //   width: 172,
                // ),
                Spacer(),
                IconButton(
                    onPressed: () {
                      displayBottomSheet(context, id, imgUrl, title, summary);
                    },
                    icon: Icon(Icons.more_vert)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

displayBottomSheet(
    BuildContext context, int id, String imgUrl, String name, String summary) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: Color(0xFF737373),
          child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(30),
                    topRight: const Radius.circular(30))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(Icons.info),
                  title: Text("Episodes and Info"),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EpisodesInfo(
                                  id: id,
                                  imgUrl: imgUrl,
                                  name: name,
                                  summary: summary,
                                ))).then((value) => Navigator.pop(context));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.recent_actors),
                  title: Text("Cast"),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CastInfo(
                                  id: id,
                                ))).then((value) => Navigator.pop(context));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.people_outline),
                  title: Text("Crew"),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CrewInfo(
                                  id: id,
                                ))).then((value) => Navigator.pop(context));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.movie_filter_rounded),
                  title: Text("Alternate Show"),
                ),
              ],
            ),
          ),
        );
      });
}
