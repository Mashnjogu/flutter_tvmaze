import 'package:flutter/material.dart';
import 'package:flutter_tvmaze/Model/ShowModel.dart';
import 'package:flutter_tvmaze/components/showCard.dart';
import 'package:flutter_tvmaze/helper/shows.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<ShowModel> shows = [];
  bool _loading = true;
  late Future<List<ShowModel>> userData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTVMazeShows();
    userData = getShowTrial();
  }

  getTVMazeShows() async {
    Shows showClass = Shows();
    showClass.getShows();
    shows = showClass.shows;

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MovieInfo"),
      ),
      body: _loading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          : Column(
              children: [
                Container(
                  child: Card(
                    child: FutureBuilder<List<ShowModel>>(
                      future: userData,
                      builder: (context, snapshot) {
                        ListView.builder(
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, index) {
                              return ShowCard(
                                  showImage: snapshot.data![index].image,
                                  title: snapshot.data![index].name);
                            });
                        return CircularProgressIndicator();
                      },
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
