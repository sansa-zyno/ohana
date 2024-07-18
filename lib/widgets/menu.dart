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
import 'package:ohana/screens/activate.dart';
import 'package:ohana/screens/bottom_navbar.dart';
import 'package:ohana/screens/login.dart';
import 'package:ohana/screens/profile/change_password.dart';
import 'package:ohana/screens/tables/apply_incentives.dart';
import 'package:ohana/screens/tables/approved_earning_history.dart';
import 'package:ohana/screens/tables/approved_withdrawal_history.dart';
import 'package:ohana/screens/tables/incentives_applied.dart';
import 'package:ohana/screens/tables/pending_earning_history.dart';
import 'package:ohana/screens/tables/pending_withdrawal_history.dart';
import 'package:ohana/screens/tables/rejected_sales_history.dart';
import 'package:ohana/screens/tables/team_table.dart';
import 'package:ohana/screens/tables/view_messages.dart';
import 'package:ohana/screens/upgrade.dart';
import 'package:ohana/screens/view_properties.dart';
import 'package:ohana/services/http.service.dart';
import 'package:ohana/services/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:provider/provider.dart';

class Menu extends StatefulWidget {
  final String username;
  Menu({required this.username});
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  XFile? image;
  late AppProvider appProvider;

  bool profile = false;
  bool activation = false;
  bool incentives = false;
  bool earnings = false;
  bool withdrawal = false;
  bool properties = false;
  bool extras = false;
  bool genealogy = false;

  uploadImage(BuildContext context) async {
    appProvider = Provider.of<AppProvider>(context, listen: false);
    image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      Response res = await HttpService.postWithFiles(Api.changeProfilePics, {
        "username": widget.username,
        "image": MultipartFile.fromBytes(File(image!.path).readAsBytesSync(),
            filename: image!.name)
      });
      final result = jsonDecode(res.data);
      if (result["Status"] == "succcess") {
        appProvider.getImage(widget.username);
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
    //getUserData();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 0.5),
      child: Drawer(
        width: 240,
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: appColor,
                ),
                currentAccountPicture: CircularProfileAvatar("",
                    backgroundColor: Color(0xffDCf0EF),
                    initialsText: Text(
                      "+",
                      textScaleFactor: 1,
                      style: TextStyle(
                          fontFamily: "Nunito",
                          fontWeight: FontWeight.w900,
                          fontSize: 21,
                          color: Colors.white),
                    ),
                    borderWidth: 2,
                    elevation: 10,
                    radius: 50, onTap: () {
                  uploadImage(context);
                  //log(appProvider.imageUrl);
                },
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
                accountName: Text(widget.username,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white)),
                accountEmail: Container(
                  height: 8,
                ) /*Text(
                    "${appProvider.profileDetails != null ? appProvider.profileDetails!["email"] : ""}",
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white))*/
                ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(0),
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.home,
                      color: appColor,
                    ),
                    title: Text("Dashboard",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            duration: Duration(milliseconds: 200),
                            curve: Curves.easeIn,
                            child: BottomNavbar(
                                username: widget.username, pageIndex: 0)),
                      );
                    },
                  ),
                  ListTile(
                      leading: Icon(
                        Icons.edit,
                        color: appColor,
                      ),
                      title: Text("Profile",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      trailing: IconButton(
                        icon: Icon(Icons.keyboard_arrow_left),
                        onPressed: () {
                          profile = !profile;
                          setState(() {});
                        },
                      )),
                  Visibility(
                      visible: profile,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Column(
                          children: [
                            ListTile(
                              leading: Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 15,
                                color: Colors.black45,
                              ),
                              title: Text("See Profile",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      duration: Duration(milliseconds: 200),
                                      curve: Curves.easeIn,
                                      child: BottomNavbar(
                                          username: widget.username,
                                          pageIndex: 2)),
                                );
                              },
                            ),
                            ListTile(
                              leading: Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 15,
                                color: Colors.black45,
                              ),
                              title: Text("Change Password",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      duration: Duration(milliseconds: 200),
                                      curve: Curves.easeIn,
                                      child: ChangePassword()),
                                );
                              },
                            ),
                          ],
                        ),
                      )),
                  ListTile(
                      leading: Icon(
                        Icons.list,
                        color: appColor,
                      ),
                      title: Text("Properties",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      trailing: IconButton(
                        icon: Icon(Icons.keyboard_arrow_left),
                        onPressed: () {
                          properties = !properties;
                          setState(() {});
                        },
                      )),
                  Visibility(
                      visible: properties,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 15,
                                color: Colors.black45,
                              ),
                              title: Text("View Properties",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                              onTap: () {
                                changeScreen(context, ViewProperties());
                              },
                            ),
                          ],
                        ),
                      )),
                  ListTile(
                      leading: Icon(
                        Icons.payment,
                        color: appColor,
                      ),
                      title: Text("Activation",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      trailing: IconButton(
                        icon: Icon(Icons.keyboard_arrow_left),
                        onPressed: () {
                          activation = !activation;
                          setState(() {});
                        },
                      )),
                  Visibility(
                      visible: activation,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Column(
                          children: [
                            ListTile(
                              leading: Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 15,
                                color: Colors.black45,
                              ),
                              title: Text("Activate Account",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                              onTap: () {
                                changeScreen(context, Activate());
                              },
                            ),
                            ListTile(
                              leading: Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 15,
                                color: Colors.black45,
                              ),
                              title: Text("Upgrade Account",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                              onTap: () {
                                changeScreen(context, Upgrade());
                              },
                            )
                          ],
                        ),
                      )),
                  ListTile(
                      leading: Icon(
                        Icons.shop,
                        color: appColor,
                      ),
                      title: Text("Incentives",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      trailing: IconButton(
                        icon: Icon(Icons.keyboard_arrow_left),
                        onPressed: () {
                          incentives = !incentives;
                          setState(() {});
                        },
                      )),
                  Visibility(
                      visible: incentives,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Column(
                          children: [
                            ListTile(
                              leading: Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 15,
                                color: Colors.black45,
                              ),
                              title: Text("Incentives",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                              onTap: () {
                                changeScreen(context, ApplyIncentives());
                              },
                            ),
                            ListTile(
                              leading: Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 15,
                                color: Colors.black45,
                              ),
                              title: Text("Incentives Apply",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                              onTap: () {
                                changeScreen(context, IncentivesApplied());
                              },
                            )
                          ],
                        ),
                      )),
                  ListTile(
                      leading: Icon(
                        Icons.account_balance,
                        color: appColor,
                      ),
                      title: Text("Earnings",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      trailing: IconButton(
                        icon: Icon(Icons.keyboard_arrow_left),
                        onPressed: () {
                          earnings = !earnings;
                          setState(() {});
                        },
                      )),
                  Visibility(
                      visible: earnings,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Column(
                          children: [
                            ListTile(
                              leading: Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 15,
                                color: Colors.black45,
                              ),
                              title: Text("Pending Earning",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                              onTap: () {
                                changeScreen(context, PendingEarning());
                              },
                            ),
                            ListTile(
                              leading: Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 15,
                                color: Colors.black45,
                              ),
                              title: Text("Approved Earning",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                              onTap: () {
                                changeScreen(context, ApprovedEarning());
                              },
                            ),
                            ListTile(
                              leading: Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 15,
                                color: Colors.black45,
                              ),
                              title: Text("Rejected Sales",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                              onTap: () {
                                changeScreen(context, RejectedSales());
                              },
                            )
                          ],
                        ),
                      )),
                  ListTile(
                      leading: Icon(
                        Icons.group,
                        color: appColor,
                      ),
                      title: Text("Genealogy",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      trailing: IconButton(
                        icon: Icon(Icons.keyboard_arrow_left),
                        onPressed: () {
                          genealogy = !genealogy;
                          setState(() {});
                        },
                      )),
                  Visibility(
                      visible: genealogy,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Column(
                          children: [
                            /*ListTile(
                              leading: Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 15,
                                color: Colors.black45,
                              ),
                              title: Text("My Genealogy",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                              onTap: () {},
                            ),*/
                            /*ListTile(
                              leading: Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 15,
                                color: Colors.black45,
                              ),
                              title: Text("Tabular Genealogy",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                              onTap: () {
                                
                              },
                            ),*/
                            ListTile(
                              leading: Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 15,
                                color: Colors.black45,
                              ),
                              title: Text("Team Table",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                              onTap: () {
                                changeScreen(context, TeamTable());
                              },
                            )
                          ],
                        ),
                      )),
                  ListTile(
                      leading: Icon(
                        Icons.wallet,
                        color: appColor,
                      ),
                      title: Text("Withdrawal",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      trailing: IconButton(
                        icon: Icon(Icons.keyboard_arrow_left),
                        onPressed: () {
                          withdrawal = !withdrawal;
                          setState(() {});
                        },
                      )),
                  Visibility(
                      visible: withdrawal,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Column(
                          children: [
                            /* ListTile(
                              leading: Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 15,
                                color: Colors.black45,
                              ),
                              title: Text("Withdraw Funds",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                              onTap: () {
                                changeScreen(context, WithdrawFund());
                              },
                            ),*/
                            ListTile(
                              leading: Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 15,
                                color: Colors.black45,
                              ),
                              title: Text("Pending Funds",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                              onTap: () {
                                changeScreen(context, PendingHistory());
                              },
                            ),
                            ListTile(
                              leading: Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 15,
                                color: Colors.black45,
                              ),
                              title: Text("Approved Funds",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                              onTap: () {
                                changeScreen(context, ApprovedHistory());
                              },
                            )
                          ],
                        ),
                      )),
                  ListTile(
                      leading: Icon(
                        Icons.miscellaneous_services,
                        color: appColor,
                      ),
                      title: Text("Extras",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      trailing: IconButton(
                        icon: Icon(Icons.keyboard_arrow_left),
                        onPressed: () {
                          extras = !extras;
                          setState(() {});
                        },
                      )),
                  Visibility(
                      visible: extras,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Column(
                          children: [
                            ListTile(
                              leading: Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 15,
                                color: Colors.black45,
                              ),
                              title: Text("Contact Support",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                              onTap: () {
                                changeScreen(
                                    context,
                                    BottomNavbar(
                                        username: widget.username,
                                        pageIndex: 1));
                              },
                            ),
                            ListTile(
                              leading: Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 15,
                                color: Colors.black45,
                              ),
                              title: Text("View Support Requests",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                              onTap: () {
                                changeScreen(context, ViewMessages());
                              },
                            ),
                          ],
                        ),
                      )),
                  ListTile(
                    leading: Icon(
                      Icons.logout,
                      color: appColor,
                    ),
                    title: Text("Logout",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    onTap: () {
                      LocalStorage().setString("username", "");
                      appProvider.removeUser();
                      changeScreenRemoveUntill(context, Login());
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
