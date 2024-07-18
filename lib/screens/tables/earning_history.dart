import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:ohana/constants/app_colors.dart';
import 'package:ohana/controller/app_provider.dart';
import 'package:ohana/widgets/custom_text.dart';
import 'package:provider/provider.dart';

class EarningHistory extends StatefulWidget {
  EarningHistory({Key? key}) : super(key: key);

  @override
  State<EarningHistory> createState() => _EarningHistoryState();
}

class _EarningHistoryState extends State<EarningHistory> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    String Function(Match) mathFunc = (Match match) => '${match[1]},';
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
              text: "Earning History",
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
              minWidth: 600,
              smRatio: 0.5, //changed
              lmRatio: 1.2, //default
              headingTextStyle: TextStyle(color: Colors.white),
              headingRowColor: MaterialStateProperty.all(appColor),
              columns: [
                DataColumn(
                    label: Text('NO',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white))),
                DataColumn(
                    label: Text("Amount",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white))),
                DataColumn(
                    label: Text("Date",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white))),
                DataColumn(
                    label: Text("Reason",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white))),
                DataColumn(
                    label: Text("Downline",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white))),
              ],
              rows: appProvider.earningHistory != null &&
                      appProvider.earningHistory!.isNotEmpty
                  ? List<DataRow>.generate(
                      appProvider.earningHistory!.length,
                      (index) => DataRow(cells: [
                            DataCell(Text("${index + 1}",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold))),
                            DataCell(Text(
                                "\u20A6${appProvider.earningHistory![index]["amount"].replaceAllMapped(reg, mathFunc)}",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold))),
                            DataCell(Text(
                                "${appProvider.earningHistory![index]["date"]}",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold))),
                            DataCell(Text(
                                "${appProvider.earningHistory![index]["reason"]}",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold))),
                            DataCell(Text(
                                "${appProvider.earningHistory![index]["downliner"]}",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold))),
                          ]))
                  : [],
              empty: appProvider.earningHistory == null
                  ? Center(child: CircularProgressIndicator())
                  : Center(
                      child: CustomText(text: "No data to show", size: 16)),
            ),
          )),
    );
  }
}
