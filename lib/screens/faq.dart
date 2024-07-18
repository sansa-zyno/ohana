/*import 'package:flutter/material.dart';
import 'package:ohana/constants/app_colors.dart';

class FAQ extends StatefulWidget {
  const FAQ({Key? key}) : super(key: key);

  @override
  State<FAQ> createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool faq1 = false;
  bool faq2 = false;
  bool faq3 = false;
  bool faq4 = false;
  bool faq5 = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 20,
                      )),
                  Spacer(),
                  Text(
                    "FAQ",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  SizedBox(
                    width: 15,
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Here are few of the frequently asked questions",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Divider(),
                      ListTile(
                        title: Text(
                          "What is Lionstakers?",
                          style:
                              TextStyle(color: faq1 ? appColor : Colors.black),
                        ),
                        trailing: IconButton(
                            onPressed: () {
                              faq1 = !faq1;
                              faq2 = false;
                              faq3 = false;
                              faq4 = false;
                              faq5 = false;
                              setState(() {});
                            },
                            icon: Icon(Icons.arrow_drop_down)),
                        subtitle: Visibility(
                          visible: faq1,
                          child: Text(
                              "Lionstakers is a social platform whwere members share their betting predictions among one another for the benefit of all"),
                        ),
                      ),
                      Divider(),
                      ListTile(
                        title: Text(
                          "Is Lionstakers registration free?",
                          style:
                              TextStyle(color: faq2 ? appColor : Colors.black),
                        ),
                        trailing: IconButton(
                            onPressed: () {
                              faq1 = false;
                              faq2 = !faq2;
                              faq3 = false;
                              faq4 = false;
                              faq5 = false;
                              setState(() {});
                            },
                            icon: Icon(Icons.arrow_drop_down)),
                        subtitle: Visibility(
                          visible: faq2,
                          child: Text("Yes, it is"),
                        ),
                      ),
                      Divider(),
                      ListTile(
                        title: Text(
                          "Is there any prize for winning betting predictions?",
                          style:
                              TextStyle(color: faq3 ? appColor : Colors.black),
                        ),
                        trailing: IconButton(
                            onPressed: () {
                              faq1 = false;
                              faq2 = false;
                              faq3 = !faq3;
                              faq4 = false;
                              faq5 = false;
                              setState(() {});
                            },
                            icon: Icon(Icons.arrow_drop_down)),
                        subtitle: Visibility(
                          visible: faq3,
                          child: Text(
                              "Yes, there is a price to be won for each winning betting prediction and also for the member who has the highest rate of betting predictions"),
                        ),
                      ),
                      Divider(),
                      ListTile(
                        title: Text(
                          "Can a Point Value(PV) be transferred to a friend?",
                          style:
                              TextStyle(color: faq4 ? appColor : Colors.black),
                        ),
                        trailing: IconButton(
                            onPressed: () {
                              faq1 = false;
                              faq2 = false;
                              faq3 = false;
                              faq4 = !faq4;
                              faq5 = false;
                              setState(() {});
                            },
                            icon: Icon(Icons.arrow_drop_down)),
                        subtitle: Visibility(
                          visible: faq4,
                          child: Text("Yes, it can"),
                        ),
                      ),
                      Divider(),
                      ListTile(
                        title: Text(
                          "What is a Point Value(PV)?",
                          style:
                              TextStyle(color: faq5 ? appColor : Colors.black),
                        ),
                        trailing: IconButton(
                            onPressed: () {
                              faq1 = false;
                              faq2 = false;
                              faq3 = false;
                              faq4 = false;
                              faq5 = !faq5;
                              setState(() {});
                            },
                            icon: Icon(Icons.arrow_drop_down)),
                        subtitle: Visibility(
                          visible: faq5,
                          child: Text(
                              "A Point Value is a point to earned on the platform in other to perform to some specific activities on the platform"),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}*/
