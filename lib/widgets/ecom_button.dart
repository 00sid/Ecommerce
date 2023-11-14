import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EcomButton extends StatelessWidget {
  EcomButton(
      {super.key,
      required this.child,
      required this.ontap,
      this.loading = false,
      this.isOutlined = false});
  // ignore: prefer_typing_uninitialized_variables
  final ontap;
  final String child;
  bool loading = false;
  bool isOutlined;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 12),
        // decoration: const ShapeDecoration(
        //   shape: RoundedRectangleBorder(

        //     borderRadius: BorderRadius.all(
        //       Radius.circular(4),

        //     ),

        //   ),
        //   color: Colors.grey,
        // ),
        decoration: BoxDecoration(
          border: isOutlined ? Border.all(width: 2, color: Colors.black) : null,
          borderRadius: BorderRadius.circular(4),
          color: isOutlined ? Colors.white : Colors.grey,
        ),

        child: loading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : Text(
                child,
                style: TextStyle(
                  color: isOutlined ? Colors.black : Colors.white,
                ),
              ),
      ),
    );
  }
}
