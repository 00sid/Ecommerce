import 'package:ecom/services/auth_services.dart';
import 'package:ecom/utils/style.dart';
import 'package:ecom/screens/login_screen.dart';
import 'package:ecom/utils/utils.dart';
import 'package:ecom/widgets/ecom_button.dart';
import 'package:ecom/widgets/ecom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  final TextEditingController _repassController = TextEditingController();
  final AuthServices _auth = AuthServices();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passController.dispose();
    _repassController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  "Hi\nCreate your account here",
                  style: EcomStyle.kBoldStyle,
                  textAlign: TextAlign.center,
                ),
              ),
              Column(
                children: [
                  EcomTextField(
                    isEmail: true,
                    isUsername: false,
                    isBio: false,
                    textEditingController: _emailController,
                    hintText: "Email",
                    isPass: false,
                    textInputType: TextInputType.emailAddress,
                  ),
                  EcomTextField(
                      isEmail: false,
                      isUsername: false,
                      isBio: false,
                      textEditingController: _passController,
                      hintText: "Password",
                      isPass: true,
                      textInputType: TextInputType.text),
                  EcomTextField(
                    isEmail: false,
                    isUsername: false,
                    isBio: false,
                    textEditingController: _repassController,
                    hintText: "Retype Password",
                    isPass: true,
                    textInputType: TextInputType.text,
                  ),
                ],
              ),
              Column(
                children: [
                  EcomButton(
                    child: "Signup",
                    ontap: () {
                      if (_formKey.currentState!.validate()) {
                        if (_passController.text != _repassController.text) {
                          showSnackBar("Rewrite password correctly", context);
                        } else {
                          signIn();
                        }
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop(PageTransition(
                          child: const LoginScreen(),
                          type: PageTransitionType.scale));
                    },
                    child: RichText(
                        text: const TextSpan(
                            text: "Alredy have an account?  ",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            children: <TextSpan>[
                          TextSpan(
                              text: "Login",
                              style: TextStyle(color: Colors.blue))
                        ])),
                  )
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }

  signIn() async {
    String res = await _auth.signIn(
        _emailController.text.toString(), _passController.text.toString());
    if (res == "success") {
      // ignore: use_build_context_synchronously
      showSnackBar("Signup successfully", context);
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop(
        PageTransition(
            child: const LoginScreen(), type: PageTransitionType.scale),
      );
    }
  }
}
