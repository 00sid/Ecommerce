import 'package:ecom/screens/home_screen.dart';
import 'package:ecom/services/auth_services.dart';
import 'package:ecom/utils/style.dart';
import 'package:ecom/screens/signup_screen.dart';
import 'package:ecom/widgets/ecom_button.dart';
import 'package:ecom/widgets/ecom_image_container.dart';
import 'package:ecom/widgets/ecom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final AuthServices _authServices = AuthServices();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passController.dispose();
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
                  "Welcome\nPlease Login First",
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
                  // TextButton(
                  //   onPressed: () {},
                  //   child: Text(
                  //     "Forget Password",
                  //     style: TextStyle(fontWeight: FontWeight.bold),
                  //   ),
                  // ),
                  const Text("or continue with"),
                  const Divider(
                      color: Colors.grey,
                      indent: 50,
                      endIndent: 50,
                      thickness: 1),
                  const SizedBox(
                    height: 5,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ImageContainer(
                        url:
                            "https://www.freepnglogos.com/uploads/google-logo-png/google-logo-png-webinar-optimizing-for-success-google-business-webinar-13.png",
                      ),
                      ImageContainer(
                        url:
                            "https://static.vecteezy.com/system/resources/previews/018/930/702/original/facebook-logo-facebook-icon-transparent-free-png.png",
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("or with"),
                      TextButton(
                        onPressed: () {},
                        child: Text("phone number"),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  EcomButton(
                      child: "Login",
                      ontap: () {
                        if (_formKey.currentState!.validate()) {
                          login();
                        }
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(PageTransition(
                        child: SignupScreen(),
                        type: PageTransitionType.fade,
                      ));
                    },
                    child: RichText(
                        text: const TextSpan(
                            text: "Don't have an account?  ",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            children: <TextSpan>[
                          TextSpan(
                            text: "Signup",
                            style: TextStyle(color: Colors.blue),
                          )
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

  login() async {
    String res = await _authServices.login(
      _emailController.text.toString(),
      _passController.text.toString(),
    );
    if (res == "success") {
      Navigator.of(context).push(PageTransition(
          child: const HomeScreen(), type: PageTransitionType.fade));
    }
  }
}
