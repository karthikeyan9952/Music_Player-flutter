import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PlayerAppbar extends AppBar {
  PlayerAppbar(
      {super.key,
      required BuildContext context,
      required String title,
      required Color bgColor})
      : super(
            leading: IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.expand_more, color: Colors.white)),
            title: Text(
              title,
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: bgColor,
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {},
                  icon:
                      const Icon(Icons.more_vert_rounded, color: Colors.white))
            ]);
}
