import 'package:ecom/screens/web_side/web_login.dart';
import 'package:ecom/services/auth_state.dart';
import 'package:flutter/material.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.minWidth > 600) {
          return const WebLoginScreen();
        } else {
          return const AuthState();
        }
      },
    );
  }
}
