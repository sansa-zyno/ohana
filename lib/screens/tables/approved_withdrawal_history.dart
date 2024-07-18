import 'dart:convert';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:ohana/constants/api.dart';
import 'package:ohana/constants/app_colors.dart';
import 'package:ohana/services/http.service.dart';
import 'package:ohana/services/local_storage.dart';
import 'package:ohana/widgets/custom_text.dart';

class ApprovedHistory extends StatefulWidget {
  const ApprovedHistory({Key? key}) : super(key: key);

  @override
  State<ApprovedHistory> createState() => _ApprovedHistoryState();
}

class _ApprovedHistoryState extends State<ApprovedHistory> {
  List? tableDatas;

  getData() async {
    String username = await LocalStorage().getString("username");
    final table =
        await HttpService.post(Api.withdrawalHistory, {"username": username});
    tableDatas = jsonDecode(table.data);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    List approved = tableDatas != null
        ? tableDatas!.where((element) => element["status"] == "1").toList()
        : [];
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 50,
            centerTitle: true,
            backgroundColor: appColor,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 20,
              ),
            ),
            title: CustomText(
              text: "Approved Withdrawal",
              color: Colors.white,
              size: 16,
              weight: FontWeight.bold,
            ),
          ),
          body: /*tableDatas == null ?  Center(child: SpinKitDualRing(color: appColor))
            : */
              Padding(
            padding: const EdgeInsets.all(16),
            child: DataTable2(
              columnSpacing: 8,
              horizontalMargin: 8,
              minWidth: 600,
              smRatio: 0.5, //changed
              lmRatio: 1.2, //default
              headingTextStyle: TextStyle(color: Colors.white),
              headingRowColor: MaterialStateProperty.all(appColor),
              columns: [
                DataColumn2(
                  label: Text('NO',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  size: ColumnSize.S,
                ),
                DataColumn(
                  label: Text('AMOUNT',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
                DataColumn(
                  label: Text('DATE',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
                DataColumn(
                  label: Text('STATUS',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
              ],
              rows: approved.isNotEmpty
                  ? List<DataRow>.generate(
                      approved.length,
                      (index) => DataRow(cells: [
                        DataCell(Text("${index + 1}",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold))),
                        DataCell(Text("\u20A6${approved[index]["amt"]}",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold))),
                        DataCell(Text("${approved[index]["date"]}",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold))),
                        DataCell(Text("${approved[index]["status"]}",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold))),
                      ]),
                    )
                  : [],
              empty: tableDatas == null
                  ? Center(child: CircularProgressIndicator())
                  : Center(
                      child: CustomText(text: "No data to show", size: 16)),
            ),
          )),
    );
  }
}
