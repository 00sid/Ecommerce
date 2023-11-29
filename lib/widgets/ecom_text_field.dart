import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EcomTextField extends StatefulWidget {
  final bool isPass;
  final bool isEmail;
  final bool isUsername;
  final bool isBio;
  final String hintText;
  final TextInputType textInputType;
  final TextEditingController textEditingController;
  bool isDetail;
  bool isOther;
  EcomTextField(
      {super.key,
      this.isDetail = false,
      required this.isEmail,
      required this.isUsername,
      required this.isBio,
      required this.textEditingController,
      required this.hintText,
      required this.isPass,
      required this.textInputType,
      this.isOther = false});

  @override
  State<EcomTextField> createState() => _EcomTextFieldState();
}

class _EcomTextFieldState extends State<EcomTextField> {
  bool _isClicked = false;
  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return Padding(
      padding: const EdgeInsets.only(bottom: 18.0),
      child: TextFormField(
        controller: widget.textEditingController,
        decoration: InputDecoration(
          focusedBorder: inputBorder,
          enabledBorder: inputBorder,
          hintText: widget.hintText,
          suffixIcon: widget.isEmail
              ? const Icon(Icons.email)
              : widget.isPass
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          _isClicked = !_isClicked;
                        });
                      },
                      icon: _isClicked
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off),
                    )
                  : null,
          filled: true,
        ),
        obscureText: widget.isPass ? !_isClicked : false,
        keyboardType: widget.textInputType,
        maxLines: widget.isDetail ? 5 : 1,
        validator: (val) {
          if (widget.isPass) {
            if (val!.isEmpty) {
              return "Please enter password";
            } else if (val.length < 6) {
              return "Password can't be less than 6";
            }
            return null;
          } else if (widget.isEmail) {
            if (val!.isEmpty) {
              return "Please enter email";
            } else {
              return RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(val)
                  ? null
                  : "Please enter a valid email";
            }
          } else if (widget.isUsername) {
            if (val!.isEmpty) {
              return "Please enter username";
            }
          }
          if (widget.isBio) {
            if (val!.isEmpty) {
              return "Field cannot be left empty";
            }
          } else if (widget.isOther) {
            if (val!.isEmpty) {
              return "Field cannot be left empty";
            }
          }
          return null;
        },
      ),
    );
  }
}
