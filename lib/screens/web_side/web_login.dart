import 'package:ecom/screens/web_side/web_main.dart';
import 'package:ecom/services/auth_services.dart';
import 'package:ecom/utils/style.dart';
import 'package:ecom/utils/utils.dart';
import 'package:ecom/widgets/ecom_button.dart';
import 'package:ecom/widgets/ecom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class WebLoginScreen extends StatefulWidget {
  static const String id = "webLogin";
  const WebLoginScreen({super.key});

  @override
  State<WebLoginScreen> createState() => _WebLoginScreenState();
}

class _WebLoginScreenState extends State<WebLoginScreen> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _userNameController.dispose();
    _passController.dispose();
  }

  final AuthServices _authServices = AuthServices();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 5,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Welcome Admin\nLog in to your account",
                      style: EcomStyle.kBoldStyle,
                      textAlign: TextAlign.center,
                    ),
                    EcomTextField(
                        isEmail: false,
                        isUsername: true,
                        isBio: false,
                        textEditingController: _userNameController,
                        hintText: "User Name",
                        isPass: false,
                        textInputType: TextInputType.text),
                    EcomTextField(
                        isEmail: false,
                        isUsername: false,
                        isBio: false,
                        textEditingController: _passController,
                        hintText: "Password",
                        isPass: true,
                        textInputType: TextInputType.text),
                    EcomButton(
                        child: "Login",
                        ontap: () {
                          if (_formkey.currentState!.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            login();
                            setState(() {
                              isLoading = false;
                            });
                          }
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  login() async {
    await _authServices
        .signAdmin(_userNameController.text.toString())
        .then((value) async {
      if (value['username'] == _userNameController.text.toString() &&
          value["password"] == _passController.text.toString()) {
        try {
          UserCredential user = await FirebaseAuth.instance.signInAnonymously();
          if (user != null) {
            // ignore: use_build_context_synchronously
            Navigator.pushReplacementNamed(context, WebMain.id);
          }
          setState(() {
            isLoading = false;
          });
        } on FirebaseAuthException catch (e) {
          toastMessage(e.toString());
        }
      }
    });
  }
}
