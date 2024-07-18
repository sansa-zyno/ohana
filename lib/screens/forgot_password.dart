import 'dart:convert';

import 'package:ohana/constants/api.dart';
import 'package:ohana/constants/app_colors.dart';
import 'package:ohana/modals/alert.dart';
import 'package:ohana/services/http.service.dart';
import 'package:ohana/widgets/curved_textfield.dart';
import 'package:ohana/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 50,
          centerTitle: true,
          backgroundColor: appColor,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 20,
            ),
          ),
          title: CustomText(
            text: "Forgot Password",
            color: Colors.white,
            size: 16,
            weight: FontWeight.bold,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15,
                ),
                CustomText(
                  text:
                      "Kindly enter your email address. We’ll send a link for you to reset your password.",
                  size: 16,
                ),
                SizedBox(
                  height: 30,
                ),
                CustomText(
                  text: "Email",
                  size: 16,
                  color: appColor,
                  weight: FontWeight.bold,
                ),
                SizedBox(
                  height: 8,
                ),
                CurvedTextField(
                    hint: "Email",
                    controller: emailController,
                    validator: (value) {
                      return validateEmail(emailController.text)
                          ? null
                          : "Enter a valid email address";
                    }),
                SizedBox(
                  height: 50,
                ),
                loading
                    ? Center(child: CircularProgressIndicator())
                    : InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            reset();
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: appColor,
                              borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                text: "Submit",
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  reset() async {
    loading = true;
    setState(() {});
    final res = await HttpService.post(
        Api.forgotPassword, {"email": emailController.text});
    final result = jsonDecode(res.data);
    print(result);
    if (result["Status"] == "succcess") {
      showDialog(
          context: context,
          builder: (ctx) => ShowDialogWidget(
                image: "assets/hand_up.png",
                titleText: result["Report"],
                subText: "",
              ));
    } else {
      showDialog(
          context: context,
          builder: (ctx) => ShowDialogWidget(
                titleText: result["Report"],
                subText:
                    "Please enter the email address associated with your account",
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
