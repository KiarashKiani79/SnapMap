import 'package:flutter/material.dart';

class BackgroundContainer extends StatelessWidget {
  final Widget child; // The screen's content

  const BackgroundContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final appBarHeight = AppBar().preferredSize.height;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final bodyHeight = deviceSize.height - appBarHeight - statusBarHeight;
    final bodyWidth = deviceSize.width;

    return Container(
      height: bodyHeight,
      width: bodyWidth,
      decoration: const BoxDecoration(
        // Set your background image or color here
        image: DecorationImage(
          image: AssetImage('assets/images/background.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: child, // The screen's content goes here
    );
  }
}
