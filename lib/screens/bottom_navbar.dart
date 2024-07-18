import 'dart:io';
import 'package:ohana/constants/app_colors.dart';
import 'package:ohana/screens/home.dart';
import 'package:ohana/screens/profile/profile.dart';
import 'package:ohana/screens/support.dart';
import 'package:flutter/material.dart';
import 'package:upgrader/upgrader.dart';

class BottomNavbar extends StatefulWidget {
  final String username;
  final int pageIndex;
  BottomNavbar({Key? key, required this.username, required this.pageIndex})
      : super(key: key);

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  late int pageIndex;
  late Widget _showPage;
  late Home _home;
  //late AddFund _addFund;
  late Support _support;
  late Profile _profile;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  //navbar
  Widget _pageChooser(int page) {
    switch (page) {
      case 0:
        return _home;
      case 1:
        return _support;
      case 2:
        return _profile;

      default:
        return new Container(
            child: new Center(
          child: new Text(
            //'No Page found by page thrower',
            "This screen is still under development",
            style: new TextStyle(fontSize: 30),
            textAlign: TextAlign.center,
          ),
        ));
    }
  }

  /* bg() async {
    await Future.delayed(Duration(seconds: 30), () async {
      await AppbackgroundService().startBg();
    });
  }*/

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);

    _home = Home(
      username: widget.username,
    );
    //_addFund = AddFund();
    _support = Support();
    _profile = Profile();
    pageIndex = widget.pageIndex;
    _showPage = _pageChooser(pageIndex);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        //backgroundColor: Color(0xff0e6dfd),
        //drawer: Menu(),
        body: UpgradeAlert(
            upgrader: Upgrader(
              dialogStyle: Platform.isIOS
                  ? UpgradeDialogStyle.cupertino
                  : UpgradeDialogStyle.material,
            ),
            child: _showPage),
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            elevation: 10,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.headphones),
                label: 'Support',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_3),
                label: 'Profile',
              ),
            ],
            showSelectedLabels: true,
            showUnselectedLabels: true,
            currentIndex: pageIndex,
            selectedItemColor: appColor,
            unselectedItemColor: Colors.black87,
            unselectedFontSize: 14,
            selectedFontSize: 14,
            onTap: (int tappedIndex) async {
              setState(() {
                pageIndex = tappedIndex;
                _showPage = _pageChooser(pageIndex);
              });
            }),
      ),
    );
  }
}
