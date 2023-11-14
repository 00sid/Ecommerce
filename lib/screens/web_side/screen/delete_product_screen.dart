import 'package:flutter/material.dart';

class DeleteProductScreen extends StatelessWidget {
  static const String id = "deletescreen";
  const DeleteProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Deleteproduct"),
      ),
    );
  }
}
