import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:ohana/constants/app_colors.dart';
import 'package:ohana/controller/app_provider.dart';
import 'package:ohana/helpers/common.dart';
import 'package:ohana/screens/payment/withdraw_funds.dart';
import 'package:ohana/screens/tables/earning_history.dart';
import 'package:ohana/screens/tables/incentives_applied.dart';
import 'package:ohana/screens/view_properties.dart';
import 'package:ohana/widgets/custom_text.dart';
import 'package:ohana/widgets/menu.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  final String username;
  Home({required this.username, super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  late AppProvider appProvider;
  List imgList = [
    "assets/ohana-topbanner1.png",
    "assets/ohana-topbanner2.png",
    "assets/ohana-topbanner3.png"
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.getRefLink(widget.username);
    appProvider.getWallet(widget.username);
    appProvider.getImage(widget.username);
    appProvider.getProFileDetails(widget.username);
    appProvider.getMemberType(widget.username);
    appProvider.getTotalPV(widget.username);
    appProvider.getTotalProperties();
    appProvider.getTotalWithdrawn(widget.username);
    appProvider.getEarningHistory(widget.username);
    appProvider.getPayToAccount();
  }

  @override
  Widget build(BuildContext context) {
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    String Function(Match) mathFunc = (Match match) => '${match[1]},';
    appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.blueGrey.withOpacity(0.1),
        appBar: AppBar(
          leading: Container(),
          toolbarHeight: 90,
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.transparent,
          flexibleSpace: Row(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        autoPlay: true,
                        viewportFraction: 1,
                        height: 90,
                      ),
                      items: imgList
                          .map(
                            (item) => Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      opacity: 1.0,
                                      image: AssetImage(item),
                                      fit: BoxFit.cover)),
                            ),
                          )
                          .toList(),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: InkWell(
                        onTap: () {
                          _scaffoldKey.currentState!.openDrawer();
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 15, top: 15),
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50 / 2),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 10,
                                    color: Colors.grey,
                                    offset: Offset(2, 2))
                              ]),
                          child: Center(
                            child: Icon(
                              Icons.menu,
                              color: appColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        drawer: Menu(
          username: widget.username,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SizedBox(
                height: 8,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xff009688),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.wallet,
                          size: 50,
                          color: Colors.orange,
                        ),
                        Spacer(),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: "Earning Amount",
                                color: Colors.white,
                                /*fontFamily:
                                    GoogleFonts.roboto().fontFamily,*/
                                size: 16,
                              ),
                              CustomText(
                                text: "\u20A6${appProvider.walletBalance}"
                                    .replaceAllMapped(reg, mathFunc),
                                color: Colors.white,
                                weight: FontWeight.bold,
                                /*fontFamily:
                                    GoogleFonts.roboto().fontFamily,*/
                                size: 30,
                              ),
                            ]),
                        Spacer(),
                        PopupMenuButton<String>(
                          //color: Color(0xff17a2b8),
                          color: Colors.white,
                          onSelected: (String result) {
                            // Handle the selected menu item
                            //print('Selected: $result');
                            if (result == "0") {
                              Clipboard.setData(
                                      ClipboardData(text: appProvider.link))
                                  .then((_) => ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Link copied to clipboard",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        backgroundColor: Colors.green[400],
                                      )));
                            }
                          },
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<String>>[
                            PopupMenuItem<String>(
                              value: '0',
                              child: CustomText(
                                text: 'Copy Referral Link',
                                size: 16,
                                color: Colors.green,
                                weight: FontWeight.bold,
                              ),
                            ),
                          ],
                          child: Icon(
                            Icons.more_horiz,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              changeScreen(context, IncentivesApplied());
                            },
                            child: Container(
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                //border: Border.all(),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                children: [
                                  Image.asset("assets/fund.png"),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  CustomText(text: "Incentives")
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              changeScreen(context, ViewProperties());
                            },
                            child: Container(
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                //border: Border.all(),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: Color(0xff921006)
                                                  .withOpacity(0.25),
                                              width: 1.8)),
                                      child: Icon(
                                        Icons.home_outlined,
                                        size: 28,
                                        color: Color(0xff921006),
                                      )),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  CustomText(text: "Properties")
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          topRight: Radius.circular(30))),
                                  builder: (BuildContext ctx) {
                                    return WithdrawFund();
                                  });
                            },
                            child: Container(
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                //border: Border.all(),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                children: [
                                  Image.asset("assets/withdraw.png"),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  CustomText(text: "Withdraw")
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              height: 100,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  // border: Border.all(color: Color(0xFF072A6C)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        blurRadius: 10,
                                        offset: Offset(2, 2))
                                  ]),
                              padding: EdgeInsets.all(15),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: CustomText(
                                            text: "Member Type",
                                            size: 16,
                                          ),
                                        ),
                                        Icon(
                                          Icons.groups_3_outlined,
                                          color: Color(0xff009688),
                                          size: 30,
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Expanded(
                                        child: CustomText(
                                      text: appProvider.mType,
                                      size: 18,
                                      weight: FontWeight.bold,
                                    )),
                                  ]),
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Container(
                              height: 100,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  //border: Border.all(color: Color(0xFF072A6C)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        blurRadius: 10,
                                        offset: Offset(2, 2))
                                  ]),
                              padding: EdgeInsets.all(15),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: CustomText(
                                            text: "Total PV",
                                            size: 16,
                                          ),
                                        ),
                                        Icon(
                                          Icons.file_copy_outlined,
                                          size: 30,
                                          color: Color(0xffffc107),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Expanded(
                                        child: CustomText(
                                      text: appProvider.totalPV["pv"]
                                              ?.replaceAllMapped(
                                                  reg, mathFunc) ??
                                          "",
                                      size: 18,
                                      weight: FontWeight.bold,
                                    )),
                                  ]),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              height: 110,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  // border: Border.all(color: Color(0xFF072A6C)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        blurRadius: 10,
                                        offset: Offset(2, 2))
                                  ]),
                              padding: EdgeInsets.all(15),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: CustomText(
                                            text: "Total Properties",
                                            size: 16,
                                          ),
                                        ),
                                        Icon(
                                          Icons.home_outlined,
                                          size: 30,
                                          color: Color(0xffdc3545),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Expanded(
                                        child: CustomText(
                                      text: appProvider.totalProperties,
                                      size: 18,
                                      weight: FontWeight.bold,
                                    )),
                                  ]),
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Container(
                              height: 110,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  //border: Border.all(color: Color(0xFF072A6C)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        blurRadius: 10,
                                        offset: Offset(2, 2))
                                  ]),
                              padding: EdgeInsets.all(15),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: CustomText(
                                            text: "Total Withdrawn",
                                            size: 16,
                                          ),
                                        ),
                                        Icon(
                                          Icons.thumb_up_outlined,
                                          color: Color(0xff17a2b8),
                                          size: 30,
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Expanded(
                                        child: CustomText(
                                      text: appProvider.totalWithdrawn
                                          .replaceAllMapped(reg, mathFunc),
                                      size: 18,
                                      weight: FontWeight.bold,
                                    )),
                                  ]),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Earning History",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: appColor,
                                      fontWeight: FontWeight.bold)),
                              InkWell(
                                onTap: () {
                                  changeScreen(context, EarningHistory());
                                },
                                child: Icon(
                                  Icons.more_horiz,
                                  color: appColor,
                                ),
                              )
                            ],
                          ),
                          Divider(
                            height: 30,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                                headingRowColor:
                                    MaterialStateProperty.resolveWith<Color?>(
                                        (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.hovered))
                                    return Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(0.08);
                                  return appColor; // Use the default value.
                                }),
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
                                        appProvider.earningHistory!
                                            .take(3)
                                            .length,
                                        (index) => DataRow(cells: [
                                              DataCell(Text("${index + 1}",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold))),
                                              DataCell(Text(
                                                  "\u20A6${appProvider.earningHistory![index]["amount"].replaceAllMapped(reg, mathFunc)}",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold))),
                                              DataCell(Text(
                                                  "${appProvider.earningHistory![index]["date"]}",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold))),
                                              DataCell(Text(
                                                  "${appProvider.earningHistory![index]["reason"]}",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold))),
                                              DataCell(Text(
                                                  "${appProvider.earningHistory![index]["downliner"]}",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold))),
                                            ]))
                                    : []),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  /*fundAccountBottomSheet() {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        builder: (BuildContext ctx) {
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
                      text: "Select funding method",
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
                //Pay using payment gateway
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30))),
                        builder: (BuildContext ctx) {
                          return SingleChildScrollView(child: AddFundOnline());
                        });
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "Card",
                          size: 16,
                          color: appColor,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomText(
                          text: "Fund your account with your card details",
                          size: 16,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                //Bank transfer
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30))),
                        builder: (BuildContext ctx) {
                          return AddFund();
                        });
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "Bank Transfer",
                          size: 16,
                          color: appColor,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomText(
                          text:
                              "Fund your account through your other bank apps",
                          size: 16,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }*/
}
