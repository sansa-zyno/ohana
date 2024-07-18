/*import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:ohana/constants/api.dart';
import 'package:ohana/constants/app_colors.dart';
import 'package:ohana/constants/app_strings.dart';
import 'package:ohana/controller/app_provider.dart';
import 'package:ohana/modals/alert.dart';
import 'package:ohana/services/http.service.dart';
import 'package:ohana/services/local_storage.dart';
import 'package:ohana/widgets/GradientButton/GradientButton.dart';
import 'package:ohana/widgets/curved_textfield.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:ohana/widgets/custom_text.dart';

class AddFundOnline extends StatefulWidget {
  const AddFundOnline({Key? key}) : super(key: key);

  @override
  State<AddFundOnline> createState() => _AddFundOnlineState();
}

class _AddFundOnlineState extends State<AddFundOnline> {
  final plugin = PaystackPlugin();
  TextEditingController amtController = TextEditingController(text: '');
  FocusNode focusNode = FocusNode();
  double height = 260;
  String? username;

  Future getUsername() async {
    username = await LocalStorage().getString("username");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUsername();
    plugin.initialize(publicKey: pubKey);
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        height: focusNode.hasFocus ? 450 : height,
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: "Pay With Card",
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
            SizedBox(height: 15),
            Row(
              children: [
                Text("Amount",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: 8),
            CurvedTextField(
              controller: amtController,
              type: TextInputType.number,
              hint: "\u20A6  100",
              focusNode: focusNode,
            ),
            SizedBox(height: 25),
            GradientButton(
              title: "Proceed",
              clrs: [appColor, appColor],
              onpressed: () async {
                focusNode.unfocus();
                String reference = Uuid().v4();
                if (amtController.text.isNotEmpty) {
                  if (appProvider.profileDetails != null) {
                    int amount = int.parse(amtController.text);
                    //initialize txn from backend(optional)
                    // *pass accesscode only when you have initialized txn from backend, else pass reference
                    // *accesscode is only required if method is checkout.bank or checkout.selectable(default)
                    //recommended to verify checkoutresponse result on your backend
                    try {
                      Charge charge = Charge()
                        ..amount = amount * 100
                        ..reference = reference
                        ..email = appProvider.profileDetails!["email"];
                      CheckoutResponse response = await plugin.checkout(context,
                          method: CheckoutMethod.card,
                          charge: charge,
                          fullscreen: true);
                      Response result = await HttpService.post(Api.fundOnline, {
                        "username": username,
                        "txnid": response.reference,
                        "status": response.status ? "success" : "declined",
                        "amount": amount,
                        "date":
                            "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}",
                      });
                      Map res = jsonDecode(result.data);
                      if (res["Status"] == "succcess") {
                        log(res["Status"]);
                        log(username!);
                        showDialog(
                            context: context,
                            builder: (ctx) => ShowDialogWidget(
                                  image: "assets/hand_up.png",
                                  titleText: res["Report"],
                                  subText: "",
                                ));
                        appProvider.getWallet(username!);
                        //appProvider.getTransactions(username);
                      } else {
                        showDialog(
                            context: context,
                            builder: (ctx) => ShowDialogWidget(
                                  titleText: res["Report"],
                                  subText: "",
                                ));
                      }
                    } on PlatformException catch (e) {
                      log(e.toString());
                    } catch (e) {
                      showDialog(
                          context: context,
                          builder: (ctx) => ShowDialogWidget(
                                titleText: "Error",
                                subText: "An Error occured",
                              ));
                    }
                  } else {
                    showDialog(
                        context: context,
                        builder: (ctx) => ShowDialogWidget(
                              titleText: "Your profile data is incomplete",
                              subText:
                                  "Please upload your profile data and try again",
                            ));
                  }
                } else {
                  showDialog(
                      context: context,
                      builder: (ctx) => ShowDialogWidget(
                            titleText: "Amount cannot be empty",
                            subText: "Please enter an amount to fund",
                          ));
                }
              },
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}*/
