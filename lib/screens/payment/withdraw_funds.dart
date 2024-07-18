import 'dart:convert';
import 'package:flutter/material.dart';
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

class WithdrawFund extends StatefulWidget {
  const WithdrawFund({Key? key}) : super(key: key);

  @override
  State<WithdrawFund> createState() => _WithdrawFundState();
}

class _WithdrawFundState extends State<WithdrawFund> {
  TextEditingController amtController = TextEditingController(text: '');
  FocusNode focusNode = FocusNode();
  double height = 260;
  late AppProvider appProvider;
  String? username;

  getusername() async {
    username = await LocalStorage().getString("username");
  }

  bool loading = false;
  withdrawFund() async {
    loading = true;
    setState(() {});
    final res = await HttpService.post(Api.withdrawFunds,
        {"username": username, "amount": amtController.text});
    final result = jsonDecode(res.data);
    print(result);
    if (result["Status"] == "succcess") {
      showDialog(
          context: context,
          builder: (ctx) => ShowDialogWidget(
                image: "assets/hand_up.png",
                titleText: result["Report"],
                subText: "",
              ));
      amtController.text = "";
      appProvider.getWallet(username!);
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
    appProvider = Provider.of<AppProvider>(context, listen: false);
    getusername();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        height: focusNode.hasFocus ? 450 : height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: "Withdraw",
                  size: 18,
                  color: appColor,
                  weight: FontWeight.bold,
                ),
                Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black45),
                        borderRadius: BorderRadius.circular(8)),
                    child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.close, color: Colors.red)))
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Container(
                child: CustomText(
              text: "Amount",
              color: Colors.black,
              size: 16,
              weight: FontWeight.bold,
            )),
            SizedBox(
              height: 8,
            ),
            CurvedTextField(
              hint: "\u20A6  100",
              controller: amtController,
              focusNode: focusNode,
              type: TextInputType.number,
            ),
            SizedBox(
              height: 30,
            ),
            loading
                ? Center(child: CircularProgressIndicator())
                : GradientButton(
                    title: "Withdraw",
                    clrs: [appColor, appColor],
                    onpressed: () async {
                      focusNode.unfocus();
                      withdrawFund();
                    }),
            SizedBox(
              height: 15,
            )
          ],
        ),
      ),
    );
  }
}
