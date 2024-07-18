import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:ohana/constants/api.dart';
import 'package:ohana/constants/app_colors.dart';
import 'package:ohana/controller/app_provider.dart';
import 'package:ohana/modals/alert.dart';
import 'package:ohana/services/http.service.dart';
import 'package:ohana/services/local_storage.dart';
import 'package:dio/dio.dart' as dio;
import 'package:ohana/widgets/GradientButton/GradientButton.dart';
import 'package:ohana/widgets/custom_text.dart';
import 'package:provider/provider.dart';

class Upgrade extends StatefulWidget {
  const Upgrade({Key? key}) : super(key: key);

  @override
  State<Upgrade> createState() => _UpgradeState();
}

class _UpgradeState extends State<Upgrade> {
  ///Text Editing Controllers
  TextEditingController amountController = TextEditingController(text: '');
  List packages = [];
  String selectedPackage = "50k Plan";
  String selectedPackageId = "";
  String dte = "Choose date";
  PlatformFile? file;

  String? username;
  getusername() async {
    username = await LocalStorage().getString("username");
  }

  Future getFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      file = result.files.single;
      setState(() {});
    } else {
      // User canceled the picker
    }
  }

  getPackages() async {
    final response = await HttpService.get(Api.upgradePackages);
    packages = jsonDecode(response.data);
    selectedPackage = packages[0]["planname"];
    selectedPackageId = packages[0]["id"];
    setState(() {});
  }

  bool loading = false;
  upgrade() async {
    loading = true;
    setState(() {});
    print(username);
    final res = await HttpService.postWithFiles(Api.upgrade, {
      "username": username,
      "date": dte,
      "amt": amountController.text,
      "image": dio.MultipartFile.fromBytes(File(file!.path!).readAsBytesSync(),
          filename: file!.name),
      "pid": selectedPackageId
    });
    final result = jsonDecode(res.data);
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
                subText: "",
              ));
    }
    loading = false;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getusername();
    getPackages();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
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
            text: "Upgrade Account",
            size: 16,
            color: Colors.white,
            weight: FontWeight.bold,
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(children: [
              SizedBox(
                height: 15,
              ),
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.orangeAccent,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Column(
                  children: [
                    Text(
                      "Pay To: ",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF072A6C)),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        SizedBox(
                          width: 130,
                          child: Text("Bank:",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF072A6C))),
                        ),
                        SizedBox(width: 70),
                        Expanded(
                          child: Text(
                            "${appProvider.payTo != null ? appProvider.payTo!["bname"] : ""}",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF072A6C)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        SizedBox(
                          width: 130,
                          child: Text("Account Name:",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF072A6C))),
                        ),
                        SizedBox(width: 70),
                        Expanded(
                          child: Text(
                            "${appProvider.payTo != null ? appProvider.payTo!["aname"] : ""}",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF072A6C)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        SizedBox(
                          width: 130,
                          child: Text("Account Number:",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF072A6C))),
                        ),
                        SizedBox(width: 70),
                        Expanded(
                          child: Text(
                            "${appProvider.payTo != null ? appProvider.payTo!["anum"] : ""}",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF072A6C)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              /*Row(
                children: [
                  Text(
                    "Payment Reason",
                    style: TextStyle(
                        fontSize: 16,
                        color: appColor,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Container(
                  height: 50,
                  width: 350,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      border: Border.all(color: appColor),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 10,
                            offset: Offset(2, 2))
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton<String>(
                        value: val,
                        underline: Container(),
                        style: TextStyle(color: Colors.black),
                        items: items
                            .map<DropdownMenuItem<String>>((value) =>
                                DropdownMenuItem(
                                    value: value, child: Text("$value")))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            val = value!;
                          });
                        }),
                  )),*/

              Row(
                children: [
                  Text(
                    "Select Proof of Payment",
                    style: TextStyle(
                        fontSize: 16,
                        color: appColor,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                InkWell(
                  onTap: () {
                    getFile();
                  },
                  child: Container(
                    height: 50,
                    width: 150,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black45),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5.0),
                        bottomLeft: Radius.circular(5.0),
                      ),
                    ),
                    child: Text(
                      "Choose File",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 50,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black45),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(5.0),
                        bottomRight: Radius.circular(5.0),
                      ),
                    ),
                    child: Text(
                      "${file != null ? file!.name.split("/").last : "No file chosen"}",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                ),
              ]),
              SizedBox(height: 25),
              Row(
                children: [
                  Text(
                    "Date of payment",
                    style: TextStyle(
                        fontSize: 16,
                        color: appColor,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 8),
              InkWell(
                  onTap: () async {
                    DateTime? date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
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
                        child: Text("$dte", style: TextStyle(fontSize: 16))),
                  )),
              SizedBox(height: 25),
              Row(
                children: [
                  Text(
                    "Select Package",
                    style: TextStyle(
                        fontSize: 16,
                        color: appColor,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Container(
                  height: 50,
                  width: 350,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    border: Border.all(color: Colors.black45),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton(
                        value: selectedPackage,
                        underline: Container(),
                        style: TextStyle(color: Colors.black),
                        items: packages
                            .map<DropdownMenuItem<String>>((value) =>
                                DropdownMenuItem(
                                    value: "${value["planname"]}",
                                    child: Text("${value["planname"]}")))
                            .toList(),
                        onChanged: (value) {
                          for (Map package in packages) {
                            if (package["planname"] == value) {
                              selectedPackage = package["planname"];
                              selectedPackageId = package["id"];
                              setState(() {});
                            }
                          }
                        }),
                  )),
              SizedBox(
                height: 50,
              ),
              loading
                  ? Center(child: CircularProgressIndicator())
                  : Container(
                      width: 250,
                      height: 50,
                      child: Hero(
                        tag: "Login",
                        child: GradientButton(
                          title: "Submit",
                          clrs: [appColor, appColor],
                          onpressed: () {
                            if (file != null) {
                              if (dte != "Choose date") {
                                if (selectedPackageId != "") {
                                  upgrade();
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (ctx) => ShowDialogWidget(
                                            titleText:
                                                "You need to select a package",
                                            subText: "",
                                          ));
                                }
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (ctx) => ShowDialogWidget(
                                          titleText: "Please select date",
                                          subText: "",
                                        ));
                              }
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (ctx) => ShowDialogWidget(
                                        titleText: "No proof of payment",
                                        subText: "",
                                      ));
                            }
                          },
                        ),
                      ),
                    ),
              SizedBox(
                height: 25,
              )
            ]),
          ),
        ),
      ),
    );
  }
}
