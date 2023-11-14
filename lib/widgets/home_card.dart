import 'package:flutter/material.dart';

import '../utils/style.dart';

class HomeCard extends StatelessWidget {
  final String title;
  const HomeCard({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(colors: [
              Colors.blueAccent.withOpacity(0.8),
              Colors.red.withOpacity(0.8)
            ])),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            title,
            style: EcomStyle.kBoldStyle.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
