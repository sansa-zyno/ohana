import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as dio;
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

class SubmitASale extends StatefulWidget {
  final Map selectedProperty;
  SubmitASale({Key? key, required this.selectedProperty}) : super(key: key);

  @override
  State<SubmitASale> createState() => _SubmitASaleState();
}

class _SubmitASaleState extends State<SubmitASale> {
  ///Text Editing Controllers
  TextEditingController noPropertyController = TextEditingController(text: '');
  TextEditingController amountController = TextEditingController(text: '');
  TextEditingController actualPriceController = TextEditingController(text: '');
  //String dte = "Choose date";
  PlatformFile? file;
  List allProperties = [];
  String selectedProperty = "";
  String selectedPropertyId = "";

  getProperties() async {
    final response = await HttpService.get(Api.viewProperties);
    allProperties = jsonDecode(response.data);
    setState(() {});
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

  String? username;
  getusername() async {
    username = await LocalStorage().getString("username");
  }

  bool loading = false;
  aktivate() async {
    loading = true;
    setState(() {});
    print(username);
    final res = await HttpService.postWithFiles(Api.submitSale, {
      "username": username,
      "plot": noPropertyController.text,
      "actualPrice": actualPriceController.text,
      "image": dio.MultipartFile.fromBytes(File(file!.path!).readAsBytesSync(),
          filename: file!.name),
      "property": selectedPropertyId
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
    getProperties();
    selectedProperty = widget.selectedProperty["Property Name"];
    selectedPropertyId = widget.selectedProperty["ID"];
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
            text: "Submit A Sale",
            color: Colors.white,
            size: 16,
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
                    "Select Property",
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
                    child: DropdownButton<String>(
                        value: selectedProperty,
                        underline: Container(),
                        style: TextStyle(color: Colors.black),
                        items: allProperties
                            .map<DropdownMenuItem<String>>((value) =>
                                DropdownMenuItem(
                                    value: value["Property Name"],
                                    child: Text("${value["Property Name"]}")))
                            .toList(),
                        onChanged: (value) {
                          for (Map property in allProperties) {
                            if (property["Property Name"] == value) {
                              selectedProperty = property["Property Name"];
                              selectedPropertyId = property["ID"];
                              setState(() {});
                            }
                          }
                        }),
                  )),
              SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  Text("Number Of Property Unit",
                      style: TextStyle(
                          fontSize: 16,
                          color: appColor,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: 8),
              CurvedTextField(
                hint: "Enter number of property unit",
                controller: noPropertyController,
                type: TextInputType.number,
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  Text("Amount",
                      style: TextStyle(
                          fontSize: 16,
                          color: appColor,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: 8),
              CurvedTextField(
                readOnly: true,
                hint: "Enter amount",
                controller: amountController,
                type: TextInputType.number,
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  Text("Actual Price",
                      style: TextStyle(
                          fontSize: 16,
                          color: appColor,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: 8),
              CurvedTextField(
                hint: "Enter Actual Purchase Price",
                controller: actualPriceController,
                type: TextInputType.number,
              ),
              SizedBox(
                height: 25,
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
                              aktivate();
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
