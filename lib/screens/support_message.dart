import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ohana/Widgets/GradientButton/GradientButton.dart';
import 'package:ohana/constants/api.dart';
import 'package:ohana/constants/app_colors.dart';
import 'package:ohana/modals/alert.dart';
import 'package:ohana/services/http.service.dart';
import 'package:ohana/services/local_storage.dart';
import 'package:ohana/widgets/curved_textfield.dart';
import 'package:ohana/widgets/custom_text.dart';

class SupportMessage extends StatefulWidget {
  @override
  State<SupportMessage> createState() => _SupportMessageState();
}

class _SupportMessageState extends State<SupportMessage> {
  TextEditingController subjectController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  String? username;

  getUserName() async {
    username = await LocalStorage().getString("username");
  }

  bool loading = false;
  contact() async {
    loading = true;
    setState(() {});
    print(username);
    final res = await HttpService.post(Api.contactSupport, {
      "username": username,
      "subject": subjectController.text,
      "comment": commentController.text
    });
    final result = jsonDecode(res.data);
    if (result["Status"] == "succcess") {
      showDialog(
          context: context,
          builder: (ctx) => ShowDialogWidget(
                image: "assets/hand_up.png",
                titleText: result["Report"],
                subText: "Message sent successfully",
              ));
    } else {
      showDialog(
          context: context,
          builder: (ctx) => ShowDialogWidget(
                titleText: result["Report"],
                subText: "Message not sent",
              ));
    }
    loading = false;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserName();
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
            text: "Send Message",
            color: Colors.white,
            size: 16,
            weight: FontWeight.bold,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: ListView(
            children: [
              SizedBox(height: 15),
              Row(
                children: [
                  Text(
                    "Subject",
                    style: TextStyle(
                        fontSize: 16,
                        color: appColor,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              CurvedTextField(
                controller: subjectController,
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Text(
                    "Enter Your Message",
                    style: TextStyle(
                        fontSize: 16,
                        color: appColor,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                height: 350,
                alignment: Alignment.topLeft,
                decoration: BoxDecoration(
                  color: Colors.white30,
                  border: Border.all(color: Colors.black45),
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(10),
                          hintText: "Leave a comment here"),
                      controller: commentController,
                      maxLines: 15,
                      maxLength: 450,
                    ))
                  ],
                ),
              ),
              SizedBox(height: 50),
              loading
                  ? Center(child: CircularProgressIndicator())
                  : GradientButton(
                      title: "Submit",
                      clrs: [appColor, appColor],
                      onpressed: () async {
                        contact();
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
