import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/retry.dart';

class CrewCard extends StatelessWidget {
  String? crewType, crewName, crewImgUrl;

  CrewCard({this.crewType, required this.crewName, required this.crewImgUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 12, right: 12, top: 6, bottom: 6),
      child: Card(
        elevation: 20,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.only(left: 12, top: 18, bottom: 10),
                child: Text(
                  crewType.toString(),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                )),
            Container(
              margin: EdgeInsets.only(bottom: 14),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: FadeInImage(
                        width: 160,
                        height: 120,
                        placeholder:
                            AssetImage('assets/images/personPlaceHolder.png'),
                        image: NetworkImage(crewImgUrl.toString()),
                        imageErrorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/images/personPlaceHolder.png',
                            fit: BoxFit.contain,
                            width: 120,
                            height: 120,
                          );
                        },
                      ),
                    ),
                  ),
                  Text(
                    crewName.toString(),
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
