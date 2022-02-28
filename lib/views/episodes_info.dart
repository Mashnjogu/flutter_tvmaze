import 'package:flutter/material.dart';
import 'package:flutter_tvmaze/Model/EpisodeInfoModel.dart';
import 'package:flutter_tvmaze/Model/showModel2.dart';
import 'package:flutter_tvmaze/components/episodeCard.dart';
import 'package:flutter_tvmaze/components/singleShowDesc.dart';
import 'package:flutter_tvmaze/helper/shows2.dart';
import 'package:flutter_tvmaze/helper/showsEpisode.dart';
import 'package:flutter_html/flutter_html.dart';

class EpisodesInfo extends StatefulWidget {
  int id;
  String imgUrl, name, summary;

  EpisodesInfo(
      {required this.id,
      required this.imgUrl,
      required this.name,
      required this.summary});

  @override
  _EpisodesInfoState createState() => _EpisodesInfoState();
}

class _EpisodesInfoState extends State<EpisodesInfo> {
  late Future<List<EpisodeInfoModel>> futureEpisode;
  bool _loading = true;
  final _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEpisodeInfo();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          !_loading) {
        getEpisodeInfo();
      }
    });
  }

  void getEpisodeInfo() {
    futureEpisode = fetchEpisodeInfo(widget.id);
    _loading = false;
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movie App"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ShowImageDesc(imageUrl: widget.imgUrl),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(widget.name,
                  style: TextStyle(
                      fontFamily: 'FontsFree-Net-Segoe-UI',
                      letterSpacing: 1.0,
                      fontSize: 25,
                      fontWeight: FontWeight.w800)),
            ),
            Container(
              width: 305,
              margin: EdgeInsets.fromLTRB(8, 0, 6, 8),
              child: Html(
                data: widget.summary,
                style: {
                  "body": Style(
                      fontSize: FontSize(16.0),
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.8)
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 24),
              child: Text(
                "Episode information",
                style: TextStyle(
                    fontFamily: 'FontsFree-Net-Segoe-UI',
                    letterSpacing: 2.0,
                    fontSize: 20,
                    fontWeight: FontWeight.w800),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 7, right: 7),
              child: Card(
                child: FutureBuilder<List<EpisodeInfoModel>>(
                    future: futureEpisode,
                    builder: (context, snapshot) {
                      print(snapshot);

                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          return const Center(
                            child: Text("No data available"),
                          );
                        case ConnectionState.waiting:
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        case ConnectionState.active:
                          break;
                        case ConnectionState.done:
                          return Container(
                            child: ListView.builder(
                                controller: _scrollController,
                                shrinkWrap: true,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  return EpisodeCard(
                                    episodeImgUrl: snapshot
                                        .data![index].episodeImage.medium,
                                    episodeName:
                                        snapshot.data![index].episodeName,
                                    episodeSummary:
                                        snapshot.data![index].summary,
                                    seasonNumber:
                                        snapshot.data![index].seasonNumber,
                                    numberEpisode:
                                        snapshot.data![index].numberEpisode,
                                  );
                                }),
                          );
                      }
                      return Text("Connection not available");
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
