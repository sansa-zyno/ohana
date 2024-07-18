import 'dart:convert';
import 'package:ohana/constants/api.dart';
import 'package:ohana/constants/app_colors.dart';
import 'package:ohana/helpers/common.dart';
import 'package:ohana/modals/alert.dart';
import 'package:ohana/screens/bottom_navbar.dart';
import 'package:ohana/screens/forgot_password.dart';
import 'package:ohana/screens/register.dart';
import 'package:ohana/services/http.service.dart';
import 'package:ohana/services/local_storage.dart';
import 'package:ohana/widgets/GradientButton/GradientButton.dart';
import 'package:ohana/widgets/curved_textfield.dart';
import 'package:ohana/widgets/custom_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  // TextEditingController address = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool obscurePass1 = true;
  bool loading = false;
  bool remember = true;

  getRememberMe() async {
    remember = await LocalStorage().getBool("rememberMe") ?? true;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRememberMe();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Image.asset(
                    "assets/ohana-logo.png",
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomText(
                    text: "Sign In",
                    size: 28,
                    weight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomText(
                    text: "Welcome back!",
                    size: 16,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  CustomText(
                    text: "Username",
                    color: appColor,
                    size: 16,
                    weight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CurvedTextField(
                    hint: "Enter username",
                    controller: usernameController,
                    validator: (value) {
                      if (value == "") {
                        return "This field must not be empty";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  CustomText(
                    text: "Password",
                    color: appColor,
                    size: 16,
                    weight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CurvedTextField(
                    hint: "Enter password",
                    obscureText: obscurePass1,
                    maxlines: 1,
                    controller: passwordController,
                    suffixIcon: IconButton(
                        onPressed: () {
                          obscurePass1 = !obscurePass1;
                          setState(() {});
                        },
                        icon: !obscurePass1
                            ? Icon(
                                Icons.visibility_off,
                                color: appColor,
                              )
                            : Icon(
                                Icons.visibility,
                                color: appColor,
                              )),
                    validator: (value) {
                      if (value == "") {
                        return "This field must not be empty";
                      } else if (value!.length < 6) {
                        return "The password has to be at least 6 characters long";
                      }
                      return null;
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                              fillColor:
                                  MaterialStateProperty.all(Color(0xff921006)),
                              visualDensity: VisualDensity(horizontal: -4),
                              checkColor: Colors.white,
                              value: remember,
                              side: BorderSide.none,
                              onChanged: (val) {
                                if (val != null) {
                                  LocalStorage().setBool("rememberMe", val);
                                  remember = val;
                                  setState(() {});
                                }
                              }),
                          SizedBox(
                            width: 8,
                          ),
                          CustomText(
                            text: "Remember me",
                          )
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          changeScreen(context, ForgotPassword());
                        },
                        child: CustomText(
                          text: "Forgot Password?",
                          color: Color(0xff921006),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  loading
                      ? Center(child: CircularProgressIndicator())
                      : Center(
                          child: GradientButton(
                            title: "Submit",
                            textClr: Colors.white,
                            clrs: [appColor, appColor],
                            onpressed: () {
                              if (_formKey.currentState!.validate()) {
                                signin();
                              }
                            },
                          ),
                        ),
                  SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            style: TextStyle(color: Colors.black, fontSize: 16),
                            children: [
                              TextSpan(text: "Dont have an account ? "),
                              TextSpan(
                                  style: TextStyle(color: Color(0xff921006)),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap =
                                        () => changeScreen(context, Register()),
                                  text: "Register")
                            ])),
                  )
                  /*Container(
                      width: 283,
                      alignment: Alignment.center,
                      child: CustomText(
                        text: "Step 1 of 2",
                        color: appColor,
                      ))*/
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  signin() async {
    loading = true;
    setState(() {});
    try {
      final apiResult = await HttpService.post(
        Api.login,
        {
          "username": usernameController.text,
          "password": passwordController.text,
        },
      );
      print(apiResult.data);
      //Map<String, String> result = apiResult.data as Map<String, String>;
      final result = jsonDecode(apiResult.data);
      print(result);
      if (result["Status"] == "succcess") {
        LocalStorage().setString("username", usernameController.text);
        Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeft,
                duration: Duration(milliseconds: 200),
                curve: Curves.easeIn,
                child: BottomNavbar(
                    username: usernameController.text, pageIndex: 0)),
            (route) => false);
      } else {
        showDialog(
            context: context,
            builder: (ctx) => ShowDialogWidget(
                  titleText: result["Report"],
                  subText: "",
                ));
      }
    } catch (e) {
      showDialog(
          context: context,
          builder: (ctx) => ShowDialogWidget(
                titleText: e.toString(),
                subText: "",
              ));
    }
    loading = false;
    setState(() {});
  }
}

bool validateEmail(String value) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  return (!regex.hasMatch(value)) ? false : true;
}
