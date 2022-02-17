import 'package:flutter/material.dart';

class ShowCard extends StatelessWidget {
  final String showImage, title;

  ShowCard({required this.showImage, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Column(
          children: [
            Image.network(
              showImage,
              fit: BoxFit.cover,
              width: 160,
              height: 80,
            ),
            Text(title),
            OutlinedButton(onPressed: () {}, child: Text("Visit official site"))
          ],
        ),
      ),
    );
  }
}
