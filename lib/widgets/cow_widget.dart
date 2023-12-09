import 'package:flutter/material.dart';

class CowWidget extends StatelessWidget {
  const CowWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'images/cow.jpg',
          scale: .5,
        ),
      ],
    );
  }
}
