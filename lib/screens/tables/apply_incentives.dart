import 'dart:convert';
import 'package:achievement_view/achievement_view.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:ohana/constants/api.dart';
import 'package:ohana/constants/app_colors.dart';
import 'package:ohana/services/http.service.dart';
import 'package:ohana/services/local_storage.dart';
import 'package:ohana/widgets/custom_text.dart';

class ApplyIncentives extends StatefulWidget {
  const ApplyIncentives({Key? key}) : super(key: key);

  @override
  State<ApplyIncentives> createState() => _ApplyIncentivesState();
}

class _ApplyIncentivesState extends State<ApplyIncentives> {
  List? tableDatas;
  String? username;

  getData() async {
    username = await LocalStorage().getString("username");
    final table =
        await HttpService.post(Api.incentives, {"username": username});
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
              text: "Apply Incentives",
              size: 16,
              color: Colors.white,
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
                DataColumn2(
                    label: Text('No',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    size: ColumnSize.S),
                DataColumn(
                  label: Text('Incentive Name',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
                DataColumn(
                  label: Text('PV',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
                DataColumn(
                  label: Text('Action',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
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
                            DataCell(Text(
                                "${tableDatas![index]["Incentive Name"]}",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold))),
                            DataCell(Text("${tableDatas![index]["PV"]}",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold))),
                            DataCell(InkWell(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: appColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                                padding: EdgeInsets.all(8),
                                child: Text("Apply",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16)),
                              ),
                              onTap: () {
                                apply(tableDatas![index]["ID"]);
                              },
                            )),
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

  apply(id) async {
    try {
      final res = await HttpService.post(
          Api.applyIncentives, {"username": username, "id": id});
      final result = jsonDecode(res.data);
      if (result["Status"] == "succcess") {
        AchievementView(
          color: appColor,
          icon: Icon(
            Icons.check,
            color: Colors.white,
          ),
          title: "Success!",
          elevation: 20,
          subTitle: "Your request to apply for the incentive was successfull",
          isCircle: true,
        ).show(context);
      } else {
        AchievementView(
          color: Colors.red,
          icon: Icon(
            Icons.bug_report,
            color: Colors.white,
          ),
          title: "Failed!",
          elevation: 20,
          subTitle: "Request failed",
          isCircle: true,
        ).show(context);
      }
    } catch (e) {
      AchievementView(
        color: Colors.red,
        icon: Icon(
          Icons.bug_report,
          color: Colors.white,
        ),
        title: "Error!",
        elevation: 20,
        subTitle: "Something went wrong",
        isCircle: true,
      ).show(context);
    }
  }
}
