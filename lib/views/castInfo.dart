import 'package:flutter/material.dart';
import 'package:flutter_tvmaze/Model/CastModel.dart';
import 'package:flutter_tvmaze/components/castDescCard.dart';
import 'package:flutter_tvmaze/helper/CastHelper.dart';

class CastInfo extends StatefulWidget {
  int id;

  CastInfo({required this.id});

  @override
  _CastInfoState createState() => _CastInfoState();
}

class _CastInfoState extends State<CastInfo> {
  late Future<List<CastModel>> futurecastInfo;
  bool _loading = true;
  final _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCastInfo();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          !_loading) {
        getCastInfo();
      }
    });
  }

  void getCastInfo() {
    futurecastInfo = fetchCastData(widget.id);
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
        title: Text("Cast Information"),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<List<CastModel>>(
          future: futurecastInfo,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Center(
                  child: Text("No data available"),
                );
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(),
                );
              case ConnectionState.active:
                break;
              case ConnectionState.done:
                return ListView.builder(
                    controller: _scrollController,
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return CastDescription(
                          actorName:
                              snapshot.data![index].person!.name.toString(),
                          characterName: snapshot
                              .data![index].character!.characterName
                              .toString(),
                          actorImageUrl: snapshot
                              .data![index].person!.image!.medium
                              .toString());
                    });
            }
            return Text("${snapshot.error}");
          },
        ),
      ),
    );
  }
}
