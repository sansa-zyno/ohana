import 'dart:convert';
import 'package:achievement_view/achievement_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ohana/constants/api.dart';
import 'package:ohana/constants/app_colors.dart';
import 'package:ohana/controller/app_provider.dart';
import 'package:ohana/modals/alert.dart';
import 'package:ohana/services/http.service.dart';
import 'package:ohana/services/local_storage.dart';
import 'package:ohana/widgets/GradientButton/GradientButton.dart';
import 'package:ohana/widgets/curved_textfield.dart';
import 'package:ohana/widgets/custom_text.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  //bool showGenderOptions = false;
  //String selectedGender = "";
  //bool male = true;
  //bool female = false;
  final _formKey = GlobalKey<FormState>();
  late AppProvider appProvider;
  bool loading = false;
  late TextEditingController usernameController;
  late TextEditingController firstnameController;
  late TextEditingController lastnameController;
  late TextEditingController emailController;
  late TextEditingController phonenoController;
  late TextEditingController accountNameController;
  late TextEditingController accountNoController;
  late TextEditingController bankController;
  Future getUsername() async {
    usernameController = TextEditingController(text: "");
    String username = await LocalStorage().getString("username");
    usernameController = TextEditingController(text: username);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUsername();
    appProvider = Provider.of<AppProvider>(context, listen: false);
    firstnameController =
        TextEditingController(text: appProvider.profileDetails?["fisrtname"]);
    lastnameController =
        TextEditingController(text: appProvider.profileDetails?["lastname"]);
    emailController =
        TextEditingController(text: appProvider.profileDetails?["email"]);
    phonenoController =
        TextEditingController(text: appProvider.profileDetails?["phone"]);
    accountNameController =
        TextEditingController(text: appProvider.profileDetails?["accountname"]);
    accountNoController = TextEditingController(
        text: appProvider.profileDetails?["accountnumber"]);
    bankController =
        TextEditingController(text: appProvider.profileDetails?["bankname"]);
  }

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
            text: "Edit Profile",
            size: 16,
            color: Colors.white,
            weight: FontWeight.bold,
          ),
        ),
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
                  CustomText(
                    text: "Username",
                    size: 16,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  CurvedTextField(
                    hint: usernameController.text,
                    readOnly: true,
                    controller: usernameController,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomText(
                    text: "First Name",
                    size: 16,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  CurvedTextField(
                    hint: "First Name",
                    controller: firstnameController,
                    validator: (value) {
                      if (value == "") {
                        return "This field must not be empty";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomText(
                    text: "Last Name",
                    size: 16,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  CurvedTextField(
                    hint: "Last Name",
                    controller: lastnameController,
                    validator: (value) {
                      if (value == "") {
                        return "This field must not be empty";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomText(
                    text: "Email",
                    size: 16,
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
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomText(
                    text: "Phone Number",
                    size: 16,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  CurvedTextField(
                    hint: "Phone Number",
                    controller: phonenoController,
                    validator: (value) {
                      if (value == "") {
                        return "This field must not be empty";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomText(
                    text: "Account Name",
                    size: 16,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  CurvedTextField(
                    hint: "Account Name",
                    controller: accountNameController,
                    validator: (value) {
                      if (value == "") {
                        return "This field must not be empty";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomText(
                    text: "Account Number",
                    size: 16,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  CurvedTextField(
                    hint: "Account Number",
                    controller: accountNoController,
                    validator: (value) {
                      if (value == "") {
                        return "This field must not be empty";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomText(
                    text: "Bank",
                    size: 16,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  CurvedTextField(
                    hint: "Bank",
                    controller: bankController,
                    validator: (value) {
                      if (value == "") {
                        return "This field must not be empty";
                      }
                      return null;
                    },
                  ),
                  /* SizedBox(
                    height: 15,
                  ),
                  CustomText(
                    text: "Gender",
                    size: 16,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  InkWell(
                    onTap: () {
                      showGenderOptions = !showGenderOptions;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black45),
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        children: [
                          CustomText(
                            text:
                                "${selectedGender != "" ? selectedGender : "Male"}",
                            size: 16,
                          )
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                      visible: showGenderOptions,
                      child: Card(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 8,
                            ),
                            InkWell(
                              onTap: () {
                                male = true;
                                female = false;
                                selectedGender = "Male";
                                showGenderOptions = false;
                                setState(() {});
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: male
                                        ? appColor
                                        : Colors.transparent),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 8),
                                child: Row(
                                  children: [
                                    Text("Male",
                                        style: TextStyle(
                                            color: male
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: 16)),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            InkWell(
                              onTap: () {
                                male = false;
                                female = true;
                                selectedGender = "Female";
                                showGenderOptions = false;
                                setState(() {});
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: female
                                        ? appColor
                                        : Colors.transparent),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 8),
                                child: Row(
                                  children: [
                                    Text("Female",
                                        style: TextStyle(
                                            color: female
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: 16)),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )),
                  /* SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(text: "State"),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: CurvedTextField(
                                    hint: "",
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(text: "LGA"),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: CurvedTextField(
                                    hint: "",
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),*/
                  SizedBox(
                    height: 15,
                  ),
                  CustomText(
                    text: "Address",
                    size: 16,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CurvedTextField(
                          hint:
                              "No 59a housing estate iwopin ogun waterside",
                        ),
                      ),
                    ],
                  ),*/
                  SizedBox(
                    height: 30,
                  ),
                  loading
                      ? Center(child: CircularProgressIndicator())
                      : GradientButton(
                          title: "Continue",
                          clrs: [appColor, appColor],
                          onpressed: () {
                            if (_formKey.currentState!.validate()) {
                              updateProfile();
                            }
                          },
                        ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  updateProfile() async {
    loading = true;
    setState(() {});
    try {
      Response response = await HttpService.post(Api.editProfile, {
        "username": usernameController.text,
        "firstname": firstnameController.text,
        "lastname": lastnameController.text,
        "email": emailController.text,
        "phone": phonenoController.text,
        "accountname": accountNameController.text,
        "accountno": accountNoController.text,
        "bank": bankController.text
      });
      Map res = jsonDecode(response.data);
      if (res["Status"] == "succcess") {
        appProvider.getProFileDetails(usernameController.text);
        AchievementView(
          color: appColor,
          icon: Image.asset(
            "assets/hand_up.png",
          ),
          title: "Success!",
          elevation: 20,
          subTitle: "Profile uploaded successfully",
          isCircle: true,
        ).show(context);
        Navigator.pop(context);
      } else {
        showDialog(
            context: context,
            builder: (ctx) => ShowDialogWidget(
                  titleText: res["Report"],
                  subText:
                      "Please make sure you have input the datas correctly",
                ));
      }
    } catch (e) {
      showDialog(
          context: context,
          builder: (ctx) => ShowDialogWidget(
                titleText: "Error",
                subText: "Please check your internet connection and try again",
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
