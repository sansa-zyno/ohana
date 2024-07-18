/*import 'package:ohana/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class TransactionHistory extends StatefulWidget {
  TransactionHistory();
  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  List transactions = ["", "", "", "", ""];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //transactions = widget.transactions;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 20,
                    ),
                  ),
                  Spacer(),
                  CustomText(
                    text: "Transaction History",
                    size: 18,
                    weight: FontWeight.bold,
                  ),
                  Spacer()
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            transactions.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: transactions.length,
                        padding: EdgeInsets.all(0),
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 0,
                            child: ListTile(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 8),
                                onTap: () async {},
                                leading: Image.asset("assets/fund.png"),
                                title: CustomText(
                                  text: "Credit",
                                  size: 16,
                                  weight: FontWeight.bold,
                                ),
                                subtitle: CustomText(
                                    text:
                                        "Your account was credited with \u20A620,000 by Bayo on Oct 26"),
                                trailing: CustomText(
                                    text: "+\u20A620,000",
                                    size: 16,
                                    weight: FontWeight.bold,
                                    color: Colors.green)),
                          );
                        }),
                  )
                : Container(
                    height: MediaQuery.of(context).size.height - 150,
                    alignment: Alignment.center,
                    child: CustomText(text: "No Transaction history to show"))
          ],
        ),
      ),
    );
  }
}*/
