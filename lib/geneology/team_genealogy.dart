import 'package:flutter/material.dart';
import 'package:ohana/constants/app_strings.dart';
import 'package:ohana/widgets/custom_text.dart';
import 'package:ohana/widgets/custom_webview.page.dart';
import 'package:ohana/services/local_storage.dart';

class TeamGenealogy extends StatefulWidget {
  const TeamGenealogy({Key? key}) : super(key: key);

  @override
  State<TeamGenealogy> createState() => _TeamGenealogyState();
}

class _TeamGenealogyState extends State<TeamGenealogy> {
  String? username;
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
              text: "Team Genealogy",
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
                            "$appurl/viewtg.php?username=${snapshot.data}")
                    : Container();
              })),
    );
  }
}
