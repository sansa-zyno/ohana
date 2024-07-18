/*import 'package:flutter/material.dart';
import 'package:ohana/constants/app_colors.dart';
import 'package:ohana/controller/app_provider.dart';
import 'package:ohana/widgets/custom_text.dart';
import 'package:provider/provider.dart';

class AddFund extends StatefulWidget {
  const AddFund({Key? key}) : super(key: key);

  @override
  State<AddFund> createState() => _AddFundState();
}

class _AddFundState extends State<AddFund> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: "Account Details",
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
          CustomText(
            text: "Make payment into the account below: ",
            size: 16,
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(15)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: "Bank Name",
                  size: 16,
                  color: appColor,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomText(
                  text:
                      "${appProvider.payTo != null ? appProvider.payTo!["bname"] : ""}",
                  size: 16,
                )
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(15)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: "Account Number",
                  size: 16,
                  color: appColor,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomText(
                  text:
                      "${appProvider.payTo != null ? appProvider.payTo!["anum"] : ""}",
                  size: 16,
                )
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(15)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: "Account Name",
                  size: 16,
                  color: appColor,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomText(
                  text:
                      "${appProvider.payTo != null ? appProvider.payTo!["aname"] : ""}",
                  size: 16,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}*/
