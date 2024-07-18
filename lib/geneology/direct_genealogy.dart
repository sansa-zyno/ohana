import 'package:flutter/material.dart';
import 'package:ohana/constants/app_strings.dart';
import 'package:ohana/widgets/custom_text.dart';
import 'package:ohana/widgets/custom_webview.page.dart';
import 'package:ohana/services/local_storage.dart';

class DirectGenealogy extends StatefulWidget {
  const DirectGenealogy({Key? key}) : super(key: key);

  @override
  State<DirectGenealogy> createState() => _DirectGenealogyState();
}

class _DirectGenealogyState extends State<DirectGenealogy> {
  Future getusername() async {
    String username = await LocalStorage().getString("username");
    return username;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: CustomText(
              text: "Direct Referral Genealogy",
              size: 16,
              weight: FontWeight.bold,
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
          ),
          body: FutureBuilder(
              future: getusername(),
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? CustomWebviewPage(
                        selectedUrl:
                            "$appurl/directg.php?username=${snapshot.data}")
                    : Container();
              })),
    );
  }
}
