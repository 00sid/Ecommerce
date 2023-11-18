import 'package:ecom/widgets/ecom_button.dart';
import 'package:flutter/material.dart';

class DialogueBox extends StatelessWidget {
  final String text;

  final String text2;
  final Function() action;
  const DialogueBox(
      {super.key,
      required this.text,
      required this.action,
      required this.text2});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(text),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                EcomButton(
                  child: "Cancel",
                  ontap: () {
                    Navigator.pop(context);
                  },
                  isSmallButton: true,
                  isCancel: true,
                ),
                const SizedBox(
                  width: 4,
                ),
                EcomButton(
                  child: text2,
                  ontap: () {
                    action();
                  },
                  isSmallButton: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
