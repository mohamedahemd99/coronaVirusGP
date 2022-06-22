import 'package:flutter/material.dart';

class AppLoading extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const AppLoading();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
