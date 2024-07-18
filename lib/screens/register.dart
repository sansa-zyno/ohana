import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:ohana/constants/api.dart';
import 'package:ohana/constants/app_colors.dart';
import 'package:ohana/helpers/common.dart';
import 'package:ohana/helpers/style.dart';
import 'package:ohana/modals/alert.dart';
import 'package:ohana/screens/login.dart';
import 'package:ohana/screens/welcome.dart';
import 'package:ohana/services/http.service.dart';
import 'package:ohana/services/local_storage.dart';
import 'package:ohana/widgets/curved_textfield.dart';
import 'package:ohana/widgets/custom_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController occupationController = TextEditingController();
  TextEditingController nationalityController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController employerNameController = TextEditingController();
  TextEditingController centerNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cpasswordController = TextEditingController();
  TextEditingController nokNameController = TextEditingController();
  TextEditingController nokAddressController = TextEditingController();
  TextEditingController nokPhoneController = TextEditingController();
  TextEditingController nokEmailController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  TextEditingController accountNameController = TextEditingController();
  TextEditingController accountNoController = TextEditingController();

  bool obscurePass1 = false;
  bool obscurePass2 = false;

  bool loading = false;

  String dte = "Choose Date";

  int maritalStatusIndex = -1;
  bool showMaritalStatus = false;
  String selectedMaritalStatus = "Marital Status";
  List maritalStatus = [
    {"text": "Marital Status", "val": "-1"},
    {"text": "Single", "val": "0"},
    {"text": "Married", "val": "1"},
  ];

  int genderIndex = -1;
  bool showGender = false;
  String selectedGender = "Gender";
  List genders = [
    {"text": "Gender", "val": "-1"},
    {"text": "Male", "val": "0"},
    {"text": "Female", "val": "1"},
  ];

  int placementIndex = -1;
  bool showPlacement = false;
  String selectedPlacement = "Placement";
  List placements = [
    {"text": "Placement", "val": "-1"},
    {"text": "Right", "val": "0"},
    {"text": "Left", "val": "1"},
  ];

  int nMaritalStatusIndex = -1;
  bool showNMaritalStatus = false;
  String selectedNMaritalStatus = "Marital Status";
  List nMaritalStatus = [
    {"text": "Marital Status", "val": "-1"},
    {"text": "Single", "val": "0"},
    {"text": "Married", "val": "1"},
  ];

  PlatformFile? file;
  Future getFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      file = result.files.single;
      setState(() {});
    } else {
      // User canceled the picker
    }
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
            text: "Create an Account",
            color: Colors.white,
            size: 16,
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
                    color: appColor,
                    weight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  CurvedTextField(
                    hint: "Username",
                    controller: usernameController,
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
                    text: "Passport Pics",
                    size: 16,
                    color: appColor,
                    weight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    InkWell(
                      onTap: () {
                        getFile();
                      },
                      child: Container(
                        height: 50,
                        width: 150,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black45),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            bottomLeft: Radius.circular(8.0),
                          ),
                        ),
                        child: Text(
                          "Choose File",
                          style: TextStyle(
                            color: Colors.black45,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 50,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black45),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8.0),
                            bottomRight: Radius.circular(8.0),
                          ),
                        ),
                        child: Text(
                          "${file != null ? file!.name.split("/").last : "No file chosen"}",
                          style: TextStyle(
                              color: file != null ? black : Colors.black45,
                              fontSize: 16),
                        ),
                      ),
                    ),
                  ]),
                  SizedBox(
                    height: 15,
                  ),
                  CustomText(
                    text: "First name",
                    size: 16,
                    color: appColor,
                    weight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  CurvedTextField(
                    hint: "First name",
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
                    text: "Last name",
                    size: 16,
                    color: appColor,
                    weight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  CurvedTextField(
                    hint: "Last name",
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
                    height: 15,
                  ),
                  CustomText(
                    text: "Phone number",
                    size: 16,
                    color: appColor,
                    weight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  CurvedTextField(
                    hint: "Phone number",
                    controller: phoneController,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomText(
                    text: "Address",
                    size: 16,
                    color: appColor,
                    weight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  CurvedTextField(
                    hint: "Address",
                    controller: addressController,
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
                    text: "Occupation",
                    size: 16,
                    color: appColor,
                    weight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  CurvedTextField(
                    hint: "Occupation",
                    controller: occupationController,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomText(
                    text: "Marital Status",
                    size: 16,
                    color: appColor,
                    weight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  InkWell(
                    onTap: () {
                      showMaritalStatus = !showMaritalStatus;
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
                            text: selectedMaritalStatus,
                            size: 16,
                            color: selectedMaritalStatus == "Marital Status"
                                ? Colors.black45
                                : black,
                          )
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                      visible: showMaritalStatus,
                      child: Card(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: ListView.separated(
                                shrinkWrap: true,
                                itemCount: maritalStatus.length,
                                itemBuilder: (ctx, index) => InkWell(
                                  onTap: () {
                                    maritalStatusIndex = index;
                                    showMaritalStatus = false;
                                    selectedMaritalStatus =
                                        maritalStatus[index]["text"];
                                    setState(() {});
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: maritalStatusIndex == index
                                            ? appColor
                                            : Colors.transparent),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 10),
                                    child: Row(
                                      children: [
                                        Text(maritalStatus[index]["text"],
                                            style: TextStyle(
                                                color:
                                                    maritalStatusIndex == index
                                                        ? Colors.white
                                                        : Colors.black,
                                                fontSize: 16)),
                                      ],
                                    ),
                                  ),
                                ),
                                separatorBuilder: (ctx, index) => Divider(
                                  height: 0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                  SizedBox(
                    height: 15,
                  ),
                  CustomText(
                    text: "Gender",
                    size: 16,
                    color: appColor,
                    weight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  InkWell(
                    onTap: () {
                      showGender = !showGender;
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
                            text: selectedGender,
                            size: 16,
                            color: selectedGender == "Gender"
                                ? Colors.black45
                                : black,
                          )
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                      visible: showGender,
                      child: Card(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: ListView.separated(
                                shrinkWrap: true,
                                itemCount: genders.length,
                                itemBuilder: (ctx, index) => InkWell(
                                  onTap: () {
                                    genderIndex = index;
                                    showGender = false;
                                    selectedGender = genders[index]["text"];
                                    setState(() {});
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: genderIndex == index
                                            ? appColor
                                            : Colors.transparent),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 10),
                                    child: Row(
                                      children: [
                                        Text(genders[index]["text"],
                                            style: TextStyle(
                                                color: genderIndex == index
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontSize: 16)),
                                      ],
                                    ),
                                  ),
                                ),
                                separatorBuilder: (ctx, index) => Divider(
                                  height: 0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                  SizedBox(
                    height: 15,
                  ),
                  CustomText(
                    text: "Nationality",
                    size: 16,
                    color: appColor,
                    weight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  CurvedTextField(
                    hint: "Nationality",
                    controller: nationalityController,
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
                    text: "Date Of Birth",
                    size: 16,
                    color: appColor,
                    weight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  InkWell(
                      onTap: () async {
                        DateTime? date = await showDatePicker(
                            context: context,
                            initialDate: DateTime(1950),
                            firstDate: DateTime(1950),
                            lastDate: DateTime.now());
                        if (date != null) {
                          dte = "${date.year}-${date.month}-${date.day}";
                          setState(() {});
                        }
                      },
                      child: Container(
                        height: 50,
                        width: 450,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          border: Border.all(color: Colors.black45),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Text("$dte",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: dte == "Choose Date"
                                        ? Colors.black45
                                        : black))),
                      )),
                  SizedBox(
                    height: 15,
                  ),
                  CustomText(
                    text: "Designation",
                    size: 16,
                    color: appColor,
                    weight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  CurvedTextField(
                    hint: "Designation",
                    controller: designationController,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomText(
                    text: "Employer's Name",
                    size: 16,
                    color: appColor,
                    weight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  CurvedTextField(
                    hint: "Employer's Name",
                    controller: employerNameController,
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
                    text: "Placement",
                    size: 16,
                    color: appColor,
                    weight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  InkWell(
                    onTap: () {
                      showPlacement = !showPlacement;
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
                            text: selectedPlacement,
                            size: 16,
                            color: selectedPlacement == "Placement"
                                ? Colors.black45
                                : black,
                          )
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                      visible: showPlacement,
                      child: Card(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: ListView.separated(
                                shrinkWrap: true,
                                itemCount: placements.length,
                                itemBuilder: (ctx, index) => InkWell(
                                  onTap: () {
                                    placementIndex = index;
                                    showPlacement = false;
                                    selectedPlacement =
                                        placements[index]["text"];
                                    setState(() {});
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: placementIndex == index
                                            ? appColor
                                            : Colors.transparent),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 10),
                                    child: Row(
                                      children: [
                                        Text(placements[index]["text"],
                                            style: TextStyle(
                                                color: placementIndex == index
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontSize: 16)),
                                      ],
                                    ),
                                  ),
                                ),
                                separatorBuilder: (ctx, index) => Divider(
                                  height: 0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                  SizedBox(
                    height: 15,
                  ),
                  CustomText(
                    text: "Center Number",
                    size: 16,
                    color: appColor,
                    weight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  CurvedTextField(
                    hint: "Center Number",
                    controller: centerNumberController,
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
                    text: "Password",
                    size: 16,
                    color: appColor,
                    weight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  CurvedTextField(
                    hint: "Password",
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
                  SizedBox(
                    height: 15,
                  ),
                  CustomText(
                    text: "Confirm Password",
                    size: 16,
                    color: appColor,
                    weight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  CurvedTextField(
                    hint: "Confirm Password",
                    obscureText: obscurePass2,
                    maxlines: 1,
                    controller: cpasswordController,
                    suffixIcon: IconButton(
                        onPressed: () {
                          obscurePass2 = !obscurePass2;
                          setState(() {});
                        },
                        icon: !obscurePass2
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
                  SizedBox(
                    height: 30,
                  ),
                  CustomText(
                    text: "NEXT OF KIN",
                    size: 16,
                    weight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomText(
                    text: "Name",
                    size: 16,
                    color: appColor,
                    weight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  CurvedTextField(
                    hint: "Name",
                    controller: nokNameController,
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
                    text: "Address",
                    size: 16,
                    color: appColor,
                    weight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  CurvedTextField(
                    hint: "Address",
                    controller: nokAddressController,
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
                    text: "Phone Number",
                    size: 16,
                    color: appColor,
                    weight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  CurvedTextField(
                    hint: "Phone Number",
                    controller: nokPhoneController,
                  ),
                  SizedBox(
                    height: 15,
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
                    controller: nokEmailController,
                    validator: (value) {
                      return validateEmail(nokEmailController.text)
                          ? null
                          : "Enter a valid email address";
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomText(
                    text: "Relationship",
                    size: 16,
                    color: appColor,
                    weight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  InkWell(
                    onTap: () {
                      showNMaritalStatus = !showNMaritalStatus;
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
                            text: selectedNMaritalStatus,
                            size: 16,
                            color: selectedNMaritalStatus == "Marital Status"
                                ? Colors.black45
                                : black,
                          )
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                      visible: showNMaritalStatus,
                      child: Card(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: ListView.separated(
                                shrinkWrap: true,
                                itemCount: nMaritalStatus.length,
                                itemBuilder: (ctx, index) => InkWell(
                                  onTap: () {
                                    nMaritalStatusIndex = index;
                                    showNMaritalStatus = false;
                                    selectedNMaritalStatus =
                                        nMaritalStatus[index]["text"];
                                    setState(() {});
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: nMaritalStatusIndex == index
                                            ? appColor
                                            : Colors.transparent),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 10),
                                    child: Row(
                                      children: [
                                        Text(nMaritalStatus[index]["text"],
                                            style: TextStyle(
                                                color:
                                                    nMaritalStatusIndex == index
                                                        ? Colors.white
                                                        : Colors.black,
                                                fontSize: 16)),
                                      ],
                                    ),
                                  ),
                                ),
                                separatorBuilder: (ctx, index) => Divider(
                                  height: 0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                  SizedBox(
                    height: 30,
                  ),
                  CustomText(
                    text: "YOUR BANK ACCOUNT INFORMATION",
                    size: 16,
                    weight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomText(
                    text: "Bank Name",
                    size: 16,
                    color: appColor,
                    weight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  CurvedTextField(
                    hint: "Bank Name",
                    controller: bankNameController,
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
                    color: appColor,
                    weight: FontWeight.bold,
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
                    color: appColor,
                    weight: FontWeight.bold,
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
                    height: 50,
                  ),
                  /* Row(
                    children: [
                      Checkbox(
                          fillColor: MaterialStateProperty.all(appColor),
                          value: true,
                          onChanged: (val) {
                            val = !val!;
                          }),
                      SizedBox(
                        width: 15,
                      ),
                      RichText(
                          text: TextSpan(
                              style: TextStyle(color: black, fontSize: 16),
                              children: [
                            TextSpan(text: "I Agree to the\n"),
                            TextSpan(
                                style: TextStyle(
                                  color: appColor,
                                ),
                                text: "terms and conditions")
                          ]))
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  CustomText(
                      text:
                          "You are adviced to read the terms and conditions"),
                  SizedBox(
                    height: 15,
                  ),*/
                  loading
                      ? Center(child: CircularProgressIndicator())
                      : InkWell(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              if (file == null) {
                                showDialog(
                                    context: context,
                                    builder: (ctx) => ShowDialogWidget(
                                          titleText:
                                              "Please choose a file for the Passport",
                                          subText: "",
                                        ));
                              } else if (selectedMaritalStatus ==
                                  "Marital Status") {
                                showDialog(
                                    context: context,
                                    builder: (ctx) => ShowDialogWidget(
                                          titleText:
                                              "Please select Marital Status",
                                          subText: "",
                                        ));
                              } else if (selectedGender == "Gender") {
                                showDialog(
                                    context: context,
                                    builder: (ctx) => ShowDialogWidget(
                                          titleText: "Please select Gender",
                                          subText: "",
                                        ));
                              } else if (selectedPlacement == "Placement") {
                                showDialog(
                                    context: context,
                                    builder: (ctx) => ShowDialogWidget(
                                          titleText: "Please select Placement",
                                          subText: "",
                                        ));
                              } else if (selectedNMaritalStatus ==
                                  "Marital Status") {
                                showDialog(
                                    context: context,
                                    builder: (ctx) => ShowDialogWidget(
                                          titleText:
                                              "Please select Next Of Kin Marital Status",
                                          subText: "",
                                        ));
                              } else {
                                signup();
                              }
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
                                  text: "Proceed",
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        ),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            style: TextStyle(color: Colors.black, fontSize: 16),
                            children: [
                              TextSpan(text: "Already have an account? "),
                              TextSpan(
                                  style: TextStyle(color: Color(0xff921006)),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap =
                                        () => changeScreen(context, Login()),
                                  text: "Log in")
                            ])),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  signup() async {
    loading = true;
    setState(() {});
    try {
      final apiResult = await HttpService.postWithFiles(
        Api.register,
        {
          "username": usernameController.text,
          "firstName": firstnameController.text,
          "lastName": lastnameController.text,
          "passport": MultipartFile.fromBytes(
              File(file!.path!).readAsBytesSync(),
              filename: file!.name),
          "email": emailController.text,
          "phone": phoneController.text,
          "address": addressController.text,
          "occupation": occupationController.text,
          "mstatus": selectedMaritalStatus,
          "gender": selectedGender,
          "country": nationalityController.text,
          "dob": dte,
          "designation": designationController.text,
          "empname": employerNameController.text,
          "placement": selectedPlacement,
          "cnum": centerNumberController.text,
          "kname": nokNameController.text,
          "kaddress": nokAddressController.text,
          "kphone": nokPhoneController.text,
          "kemail": nokEmailController.text,
          "kmstatus": selectedNMaritalStatus,
          "bname": bankNameController.text,
          "aname": accountNameController.text,
          "anum": accountNoController.text,
          "password": passwordController.text,
          "cpassword": cpasswordController.text
        },
      );
      final result = jsonDecode(apiResult.data);
      log(result.toString());
      if (result["Status"] == "succcess") {
        LocalStorage().setString("username", usernameController.text);
        Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeft,
                duration: Duration(milliseconds: 200),
                curve: Curves.easeIn,
                child: Welcome(
                  username: usernameController.text,
                )),
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
