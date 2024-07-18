import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:ohana/constants/api.dart';
import 'package:ohana/constants/app_colors.dart';
import 'package:ohana/helpers/common.dart';
import 'package:ohana/screens/submit_sale.dart';
import 'package:ohana/services/http.service.dart';
import 'package:ohana/widgets/custom_text.dart';

class ViewProperties extends StatefulWidget {
  const ViewProperties({super.key});

  @override
  State<ViewProperties> createState() => _ViewPropertiesState();
}

class _ViewPropertiesState extends State<ViewProperties> {
  List? allProperties;

  getProperties() async {
    final response = await HttpService.get(Api.viewProperties);
    allProperties = jsonDecode(response.data);
    log(allProperties.toString());
    searchResult = allProperties ?? [];
    setState(() {});
  }

  List searchResult = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProperties();
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
            text: "View Properties",
            color: Colors.white,
            size: 16,
            weight: FontWeight.bold,
          ),
        ),
        body: allProperties == null
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      /*  Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      // border: Border.all(color: Color(0xFF072A6C)),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: 10,
                            offset: Offset(2, 2))
                      ]),
                  child: ListTile(
                    title: CustomText(
                      text: "All Categories",
                      size: 16,
                    ),
                    trailing: InkWell(
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        color: appColor,
                      ),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                                  insetPadding: EdgeInsets.all(0),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomText(
                                            text: "All Categories",
                                            size: 16,
                                          ),
                                          Radio(
                                              value: false,
                                              groupValue: 1,
                                              onChanged: (x) {})
                                        ],
                                      ),
                                      Divider(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomText(text: "Land"),
                                          Radio(
                                              value: false,
                                              groupValue: 1,
                                              onChanged: (x) {})
                                        ],
                                      ),
                                      Divider(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomText(text: "1 Bedroom Mansion"),
                                          Radio(
                                              value: false,
                                              groupValue: 1,
                                              onChanged: (x) {})
                                        ],
                                      ),
                                      Divider(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomText(text: "2 Bedroom Mansion"),
                                          Radio(
                                              value: false,
                                              groupValue: 1,
                                              onChanged: (x) {})
                                        ],
                                      ),
                                    ],
                                  ),
                                ));
                      },
                    ),
                  ),
                ),*/
                      SizedBox(
                        height: 15,
                      ),
                      /*  Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black45, width: 1.5),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: TextField(
                          onChanged: (text) {
                            if (text.isNotEmpty) {
                              searchResult = allProperties
                                      ?.where((element) =>
                                          element["Property Name"]
                                              .toString()
                                              .toLowerCase()
                                              .contains(text.toLowerCase()))
                                      .toList() ??
                                  [];
                              setState(() {});
                            } else {
                              searchResult = allProperties ?? [];
                              setState(() {});
                            }
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search Property",
                            prefixText: "  ",
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),*/
                      searchResult.isEmpty
                          ? Container(
                              height: MediaQuery.of(context).size.height - 200,
                              child: Center(
                                  child: CustomText(text: "No search result")))
                          : Container(
                              height: searchResult.length * 700,
                              child: ListView.builder(
                                  padding: EdgeInsets.all(0),
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: searchResult.length,
                                  itemBuilder: (ctx, index) => Container(
                                        margin: EdgeInsets.only(top: 8),
                                        padding: EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            // border: Border.all(color: Color(0xFF072A6C)),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8)),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.3),
                                                  blurRadius: 10,
                                                  offset: Offset(2, 2))
                                            ]),
                                        child: Column(
                                          children: [
                                            CustomText(
                                              text: searchResult[index]
                                                  ["Property Name"],
                                              size: 18,
                                              weight: FontWeight.bold,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.black45),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  child: Image.asset(
                                                    searchResult[index]
                                                        ["Property Image"],
                                                    height: 150,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    fit: BoxFit.cover,
                                                  ),
                                                )),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            CustomText(
                                              text:
                                                  "\u20a6${searchResult[index]["Property Amount"]}",
                                              size: 18,
                                              weight: FontWeight.bold,
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            CustomText(
                                              text: searchResult[index]
                                                  ["Property Description"],
                                              size: 16,
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                changeScreen(
                                                    context,
                                                    SubmitASale(
                                                        selectedProperty:
                                                            searchResult[
                                                                index]));
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: appColor,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(8)),
                                                ),
                                                padding: EdgeInsets.all(15),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "Buy Property",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            )
                                          ],
                                        ),
                                      )),
                            )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
