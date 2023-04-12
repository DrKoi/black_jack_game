import 'package:flutter/material.dart';

class cardGrid extends StatelessWidget {
  const cardGrid({
    super.key,
    required this.cards,
  });

  final List<Image> cards;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 13.0),
      height: 200,
      child: GridView.builder(
        itemCount: cards.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, index) {
          return cards[index];
        },
      ),
    );
  }
}
