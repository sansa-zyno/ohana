import 'package:flutter/material.dart';
import 'package:ohana/models/onboarding_model.dart';

class OnboardingProvider extends ChangeNotifier {
  int selectedPageIndex = 0;
  //bool get isLastPage => selectedPageIndex.value == onBoardingList.length - 1;
  var pageController = PageController();
  List<OnboardingModel> onBoardingList = [
    OnboardingModel("assets/ohana-banner1.png", "Who We Are",
        "Ohana Pro are consultants who have been trained, empowered with requisite knowledge and operating their full-fledged real estate business in the Ohana Pro space. They are groomed into professionals who specialize in earning through real estate, and essentially acquire their own properties."),
    OnboardingModel("assets/ohana-banner2.png", "Our Vision",
        "To be the investor’s preferred destination as we offer real, profitable and secured investment portfolios."),
    OnboardingModel("assets/ohana-banner3.png", "Our Mission",
        "To create platforms that are transparent enough to make individuals and organizations see from onset that their investments are REAL, PROFITABLE, and SECURED."),
  ];

  setPage(int i) {
    selectedPageIndex = i;
    notifyListeners();
  }
}
