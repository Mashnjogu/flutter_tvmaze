import 'package:flutter/material.dart';

class CastDescription extends StatelessWidget {
  String actorName, characterName, actorImageUrl;

  CastDescription(
      {required this.actorName,
      required this.characterName,
      required this.actorImageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 12, right: 12, top: 6, bottom: 6),
      child: Card(
        elevation: 20,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(top: 8, bottom: 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: FadeInImage(
                  width: 160,
                  height: 120,
                  placeholder:
                      AssetImage('assets/images/personPlaceHolder.png'),
                  image: NetworkImage(actorImageUrl),
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
            Column(
              children: [
                Text(
                  actorName,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                ),
                Text(
                  characterName,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
