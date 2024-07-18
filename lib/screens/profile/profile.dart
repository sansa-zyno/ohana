import 'dart:convert';
import 'dart:io';

import 'package:achievement_view/achievement_view.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ohana/constants/api.dart';
import 'package:ohana/constants/app_colors.dart';
import 'package:ohana/constants/app_strings.dart';
import 'package:ohana/controller/app_provider.dart';
import 'package:ohana/helpers/common.dart';
import 'package:ohana/screens/profile/edit_profile.dart';
import 'package:ohana/services/http.service.dart';
import 'package:ohana/services/local_storage.dart';
import 'package:ohana/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String username = "";
  XFile? image;
  late AppProvider appProvider;
  Future getUsername() async {
    username = await LocalStorage().getString("username");
    setState(() {});
    return username;
  }

  uploadImage(BuildContext context) async {
    appProvider = Provider.of<AppProvider>(context, listen: false);
    image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      Response res = await HttpService.postWithFiles(Api.changeProfilePics, {
        "username": username,
        "image": MultipartFile.fromBytes(File(image!.path).readAsBytesSync(),
            filename: image!.name)
      });
      final result = jsonDecode(res.data);
      if (result["Status"] == "succcess") {
        appProvider.getImage(username);
        //setState(() {});
        AchievementView(
          color: appColor,
          icon: Image.asset("assets/hand_up.png"),
          title: "Success!",
          elevation: 20,
          subTitle: "Profile picture uploaded successfully",
          isCircle: true,
        ).show(context);
      } else {
        AchievementView(
          color: Colors.red,
          icon: Icon(
            Icons.bug_report,
            color: Colors.white,
          ),
          title: "Failed!",
          elevation: 20,
          subTitle: "Profile picture upload failed",
          isCircle: true,
        ).show(context);
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUsername();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 50,
          backgroundColor: appColor,
          leading: Container(),
          title: Row(
            children: [
              SizedBox(
                width: 15,
              ),
              Spacer(),
              CustomText(
                text: "Profile",
                size: 18,
                color: Colors.white,
                weight: FontWeight.bold,
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  changeScreen(context, EditProfile());
                },
                child: CustomText(
                  text: "Edit",
                  size: 16,
                  weight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 30,
              )
            ],
          ),
        ),
        backgroundColor: Colors.blueGrey.withOpacity(0.1),
        body: /* appProvider.profileDetails == null
            ? Center(child: CircularProgressIndicator())
            :*/
            SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    uploadImage(context);
                  },
                  child: CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.white,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(70),
                        child: appProvider.imageUrl == null
                            ? Center(child: CircularProgressIndicator())
                            : appProvider.imageUrl!.startsWith("https")
                                ? Image.network(
                                    appProvider.imageUrl!,
                                    height: 150,
                                    width: 150,
                                    fit: BoxFit.cover,
                                  )
                                : Image.network(
                                    "${appurl}/${appProvider.imageUrl}",
                                    height: 150,
                                    width: 150,
                                    fit: BoxFit.cover,
                                  )),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: "Username",
                      color: Colors.black54,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      size: 15,
                    ),
                    CustomText(
                      text: username,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      size: 16,
                    )
                  ],
                ),
                Divider(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: "First Name",
                      color: Colors.black54,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      size: 15,
                    ),
                    CustomText(
                      text: appProvider.profileDetails?["fisrtname"] ?? "",
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      size: 16,
                    )
                  ],
                ),
                Divider(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: "Last Name",
                      color: Colors.black54,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      size: 15,
                    ),
                    CustomText(
                      text: appProvider.profileDetails?["lastname"] ?? "",
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      size: 16,
                    )
                  ],
                ),
                Divider(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: "Email",
                      color: Colors.black54,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      size: 15,
                    ),
                    CustomText(
                      text: appProvider.profileDetails?["email"] ?? "",
                      fontFamily: GoogleFonts.dmSans().fontFamily,
                      size: 16,
                    )
                  ],
                ),
                Divider(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: "Phone Number",
                      color: Colors.black54,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      size: 15,
                    ),
                    CustomText(
                      text: appProvider.profileDetails?["phone"] ?? "",
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      size: 16,
                    )
                  ],
                ),
                Divider(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: "Account Name",
                      color: Colors.black54,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      size: 15,
                    ),
                    CustomText(
                      text: appProvider.profileDetails?["accountname"] ?? "",
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      size: 16,
                    )
                  ],
                ),
                Divider(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: "Account Number",
                      color: Colors.black54,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      size: 15,
                    ),
                    CustomText(
                      text: appProvider.profileDetails?["accountnumber"] ?? "",
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      size: 16,
                    )
                  ],
                ),
                Divider(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: "Bank",
                      color: Colors.black54,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      size: 15,
                    ),
                    CustomText(
                      text: appProvider.profileDetails?["bankname"] ?? "",
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      size: 16,
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
