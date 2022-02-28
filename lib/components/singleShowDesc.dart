import 'package:flutter/material.dart';

class ShowImageDesc extends StatelessWidget {
  String imageUrl;
  ShowImageDesc({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 12),
      child: Column(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imageUrl,
                fit: BoxFit.fill,
                width: 285,
                height: 355,
              ))
        ],
      ),
    );
  }
}
