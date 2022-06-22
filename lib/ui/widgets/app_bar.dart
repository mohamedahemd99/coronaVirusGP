import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

PreferredSizeWidget buildAppBar() {
  return AppBar(
    elevation: 0,
    flexibleSpace: Container(decoration: bgGradient),
    title: image,
    actions: [
      IconButton(
        icon: const Icon(Icons.settings, color: bg),
        onPressed: () {},
      ),
    ],
  );
}
