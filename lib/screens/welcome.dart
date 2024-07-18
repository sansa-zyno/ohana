import 'package:flutter/material.dart';
import 'package:ohana/constants/app_colors.dart';
import 'package:ohana/helpers/common.dart';
import 'package:ohana/screens/bottom_navbar.dart';
import 'package:ohana/widgets/custom_text.dart';

class Welcome extends StatelessWidget {
  final String username;
  Welcome({required this.username, super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          CustomText(
            text: "Welcome To Ohana ",
            size: 22,
            color: appColor,
            weight: FontWeight.bold,
          ),
          Spacer(),
          Image.asset(
            "assets/ohana-banner1.png",
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: CustomText(
              text:
                  "Your account was created successfully, click \“Next\" to move to the homepage",
              size: 16,
              weight: FontWeight.bold,
              textAlign: TextAlign.center,
            ),
          ),
          Spacer(flex: 2),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  "assets/arrow.png",
                  width: 50,
                  color: appColor,
                ),
                InkWell(
                  onTap: () {
                    changeScreenReplacement(context,
                        BottomNavbar(username: username, pageIndex: 0));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                    decoration: BoxDecoration(
                        color: appColor,
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: CustomText(
                      text: "Next",
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
          Spacer(flex: 2)
        ],
      ),
    ));
  }
}
