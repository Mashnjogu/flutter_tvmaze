import 'package:flutter/material.dart';
import 'package:flutter_tvmaze/Model/EpisodeInfoModel.dart';
import 'package:flutter_tvmaze/Model/showModel2.dart';
import 'package:flutter_tvmaze/SearchImpl/Search.dart';
import 'package:flutter_tvmaze/components/showCard.dart';
import 'package:flutter_tvmaze/helper/showsEpisode.dart';
import 'package:flutter_tvmaze/helper/shows2.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<ShowModel2>> futureShow;
  bool _loading = true;
  final _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getShows();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          !_loading) {
        getShows();
      }
    });
  }

  getShows() async {
    futureShow = fetchShowData();
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
      appBar: AppBar(title: Text("MovieInfo"), actions: [
        IconButton(
            onPressed: () {
              showSearch(context: context, delegate: MovieSearch());
            },
            icon: Icon(Icons.search))
      ]),
      body: SingleChildScrollView(
        child: FutureBuilder<List<ShowModel2>>(
          future: futureShow,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: EdgeInsets.all(8.0),
                child: ListView.builder(
                    controller: _scrollController,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return ShowCard(
                        showImage: snapshot.data![index].image.medium,
                        title: snapshot.data![index].name,
                        id: snapshot.data![index].id,
                        imgUrl: snapshot.data![index].image.medium,
                        summary: snapshot.data![index].summary,
                      );
                    }),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
