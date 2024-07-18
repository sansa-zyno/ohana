import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ohana/constants/api.dart';
import '../services/http.service.dart';

class AppProvider extends ChangeNotifier {
  String? imageUrl;
  Map? profileDetails;
  String walletBalance = "";
  String mType = "";
  Map totalPV = {};
  String totalProperties = "";
  String totalWithdrawn = "";
  List? earningHistory;
  String link = "";
  Map? payTo;

  AppProvider() {}

  /*Future<String> getUsername() async {
    String username = await LocalStorage().getString("username");
    return username;
  }*/

  getImage(String username) async {
    try {
      Response res =
          await HttpService.post(Api.getProfilePics, {"username": username});
      imageUrl = jsonDecode(res.data)[0]["avatar"];
    } catch (e) {
      imageUrl = null;
    }
    notifyListeners();
  }

  getProFileDetails(String username) async {
    Response res = await HttpService.post(Api.loadData, {"username": username});
    profileDetails = jsonDecode(res.data)[0];
    notifyListeners();
  }

  Future getWallet(String username) async {
    Response res =
        await HttpService.post(Api.walletBalance, {"username": username});
    walletBalance = res.toString();
    notifyListeners();
  }

  getMemberType(username) async {
    Response response =
        await HttpService.post(Api.mType, {"username": username});
    mType = response.data;
    notifyListeners();
  }

  getTotalPV(username) async {
    Response response =
        await HttpService.post(Api.totalPV, {"username": username});
    totalPV = jsonDecode(response.data)[0];
    notifyListeners();
  }

  getTotalProperties() async {
    Response response = await HttpService.post(Api.totalProperties, {});
    totalProperties = response.data;
    notifyListeners();
  }

  getTotalWithdrawn(username) async {
    Response response =
        await HttpService.post(Api.totalWithdrwan, {"username": username});
    totalWithdrawn = response.data;
    notifyListeners();
  }

  getEarningHistory(username) async {
    final table =
        await HttpService.post(Api.earningHistory, {"username": username});
    earningHistory = jsonDecode(table.data);
    notifyListeners();
  }

  Future getRefLink(username) async {
    final ref = await HttpService.post(Api.refLink, {"username": username});
    link = ref.data;
    notifyListeners();
  }

  getPayToAccount() async {
    final response = await HttpService.get(Api.bankDetails);
    payTo = jsonDecode(response.data)[0];
    notifyListeners();
  }

  removeUser() {
    imageUrl = null;
    profileDetails = null;
    walletBalance = "";
    mType = "";
    totalPV = {};
    totalProperties = "";
    totalWithdrawn = "";
    earningHistory = null;
    link = "";
    payTo = null;
    notifyListeners();
  }
}
