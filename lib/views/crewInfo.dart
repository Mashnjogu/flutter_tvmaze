import 'package:flutter/material.dart';
import 'package:flutter_tvmaze/Model/CrewModel.dart';
import 'package:flutter_tvmaze/components/crewCard.dart';
import 'package:flutter_tvmaze/helper/crewHelper.dart';

class CrewInfo extends StatefulWidget {
  int id;

  CrewInfo({required this.id});

  @override
  _CrewInfoState createState() => _CrewInfoState();
}

class _CrewInfoState extends State<CrewInfo> {
  late Future<List<CrewModel>> futurecrewInfo;
  bool _loading = true;
  final _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCrewInfo();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          !_loading) {
        getCrewInfo();
      }
    });
  }

  void getCrewInfo() {
    futurecrewInfo = fetchCrewtData(widget.id);
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
        title: Text("Crew"),
      ),
      body: SingleChildScrollView(
          child: FutureBuilder<List<CrewModel>>(
        future: futurecrewInfo,
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
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    return CrewCard(
                        crewType: snapshot.data?[index].type,
                        crewName: snapshot.data?[index].person?.name,
                        crewImgUrl: snapshot.data?[index].person?.image?.medium
                            .toString());
                  });
          }
          return Text("${snapshot.error}");
        },
      )),
    );
  }
}
