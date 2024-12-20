import 'package:flutter/material.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
      'Iam a rijan',
      style: TextStyle(fontFamily: 'Montserrat Italic', fontSize: 30),
    ));
  }
}
