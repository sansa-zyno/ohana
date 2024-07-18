import 'dart:convert';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:ohana/constants/api.dart';
import 'package:ohana/constants/app_colors.dart';
import 'package:ohana/services/http.service.dart';
import 'package:ohana/services/local_storage.dart';
import 'package:ohana/widgets/custom_text.dart';

class ApprovedEarning extends StatefulWidget {
  ApprovedEarning({Key? key}) : super(key: key);

  @override
  State<ApprovedEarning> createState() => _ApprovedEarningState();
}

class _ApprovedEarningState extends State<ApprovedEarning> {
  List? tableDatas;

  getData() async {
    String username = await LocalStorage().getString("username");
    final table =
        await HttpService.post(Api.approvedEarning, {"username": username});
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
              text: "Approved Earnings",
              color: Colors.white,
              size: 16,
              weight: FontWeight.bold,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: DataTable2(
              columnSpacing: 8,
              horizontalMargin: 8,
              minWidth: 1900,
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
                  label: Text('USERNAME',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
                DataColumn(
                  label: Text('PHONE NUMBER',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
                DataColumn(
                  label: Text('PROPERTY',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
                DataColumn2(
                    label: Text('UNIT',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    size: ColumnSize.S),
                DataColumn2(
                    label: Text('AMOUNT',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    size: ColumnSize.S),
                DataColumn(
                  label: Text('ACTUAL PURCHASE PRICE',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
                DataColumn(
                  label: Text('COMMISSION',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
                DataColumn(
                  label: Text('COMMISSION TYPE',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
                DataColumn2(
                    label: Text('DATE',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    size: ColumnSize.S),
                DataColumn2(
                  label: Text('STATUS',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  size: ColumnSize.S,
                ),
              ],
              rows: tableDatas != null && tableDatas!.isNotEmpty
                  ? List<DataRow>.generate(
                      tableDatas!.length,
                      (index) => DataRow(cells: [
                            DataCell(Text("${index + 1}",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold))),
                            DataCell(Text("${tableDatas![index]["Username"]}",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold))),
                            DataCell(Text(
                                "${tableDatas![index]["Phone Number"]}",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold))),
                            DataCell(Text(
                                "${tableDatas![index]["Property Name"]}",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold))),
                            DataCell(Text(
                                "${tableDatas![index]["Number of Plot"]}",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold))),
                            DataCell(Text(
                                "${tableDatas![index]["Property Amount"]}",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold))),
                            DataCell(Text(
                                "${tableDatas![index]["Property Actual Amount"]}",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold))),
                            DataCell(Text("${tableDatas![index]["Commission"]}",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold))),
                            DataCell(Text(
                                "${tableDatas![index]["Commission Type"]}",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold))),
                            DataCell(Text("${tableDatas![index]["Date"]}",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold))),
                            DataCell(Text("${tableDatas![index]["Status"]}",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold))),
                          ]))
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
