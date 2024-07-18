import 'package:ohana/constants/app_colors.dart';
import 'package:ohana/helpers/common.dart';
import 'package:ohana/screens/support_message.dart';
import 'package:ohana/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Support extends StatefulWidget {
  const Support({super.key});

  @override
  State<Support> createState() => _SupportState();
}

class _SupportState extends State<Support> {
  bool faq1 = false;
  bool faq2 = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 50,
          centerTitle: true,
          backgroundColor: appColor,
          leading: Container(),
          title: CustomText(
            text: "Support",
            color: Colors.white,
            size: 16,
            weight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blueGrey.withOpacity(0.1),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  CustomText(
                    text: "Call or Chat us",
                    size: 16,
                    weight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      launchCall();
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.call,
                          color: appColor,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        CustomText(
                          text: "+234 813-393-9320",
                          size: 16,
                        )
                      ],
                    ),
                  ),
                  Divider(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      changeScreen(context, SupportMessage());
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.chat,
                          color: appColor,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        CustomText(
                          text: "Send Message",
                          size: 16,
                        )
                      ],
                    ),
                  ),
                  Divider(
                    height: 30,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  CustomText(
                    text: "Email us",
                    size: 16,
                    weight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  GestureDetector(
                    onTap: () {
                      launchEmail();
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.inbox,
                          color: appColor,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        CustomText(
                          text: "ohanahomesltd@gmail.com",
                          size: 16,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Future launchEmail() async {
    final url = 'mailto:"ohanahomesltd@gmail.com"';
    await launchUrl(Uri.parse(url));
  }

  Future launchCall() async {
    final url = 'tel:"+2348133939320"';
    await launchUrl(Uri.parse(url));
  }
}
