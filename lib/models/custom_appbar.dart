import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color? backgroundColor;
  // final Widget? flexibleSpace;
  final List<Widget> actions;

  const CustomAppBar({
    super.key,
    required this.title,
    this.backgroundColor,
    // this.flexibleSpace,
    this.actions = const [],
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      backgroundColor: Colors.transparent,
      // flexibleSpace: Center(
      //   child: Container(
      //     width: MediaQuery.of(context).size.width * 0.4,
      //     decoration: const BoxDecoration(
      //       borderRadius: BorderRadius.only(
      //         bottomLeft: Radius.circular(200),
      //         bottomRight: Radius.circular(200),
      //       ),
      //       gradient: LinearGradient(
      //         begin: Alignment.topCenter,
      //         end: Alignment.bottomCenter,
      //         colors: [
      //           Colors.indigo,
      //           Colors.black,
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
