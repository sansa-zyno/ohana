import 'package:flutter/material.dart';
import 'package:ohana/constants/app_colors.dart';
import 'package:ohana/controller/on_boarding_provider.dart';
import 'package:ohana/screens/login.dart';
import 'package:ohana/services/local_storage.dart';
import 'package:ohana/widgets/GradientButton/GradientButton.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class OnBoarding extends StatefulWidget {
  OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  onboardingShown() async {
    await LocalStorage().setBool("onboarded", true);
  }

  @override
  Widget build(BuildContext context) {
    OnboardingProvider onboardingProvider =
        Provider.of<OnboardingProvider>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffFEFEFE),
        body: PageView.builder(
            controller: onboardingProvider.pageController,
            onPageChanged: (i) => onboardingProvider.setPage(i),
            itemCount: onboardingProvider.onBoardingList.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      onboardingProvider.selectedPageIndex == 2
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: InkWell(
                                onTap: () {
                                  onboardingProvider.pageController.jumpToPage(
                                      onboardingProvider.selectedPageIndex + 1);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: appColor,
                                      //border: Border.all(color: Colors.black38),
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 10.0,
                                            offset: Offset(2, 2),
                                            color: Colors.grey.withOpacity(0.2))
                                      ]),
                                  child: Text(
                                    "Skip",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      onboardingProvider.onBoardingList[index].title.toString(),
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 30),
                  Image.asset(
                    onboardingProvider.onBoardingList[index].imageAsset
                        .toString(),
                    height: 246,
                  ),
                  SizedBox(height: 100),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      onboardingProvider.onBoardingList[index].description
                          .toString(),
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      onboardingProvider.onBoardingList.length,
                      (index) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                              color:
                                  onboardingProvider.selectedPageIndex == index
                                      ? appColor
                                      : const Color(0xffD4D5E0),
                              shape: BoxShape.circle)),
                    ),
                  ),
                  SizedBox(height: 50),
                  onboardingProvider.selectedPageIndex == 2
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Container(
                            height: 50,
                            child: GradientButton(
                              title: "Continue",
                              clrs: [appColor, appColor],
                              onpressed: () {
                                onboardingShown();
                                Navigator.pushReplacement(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      duration: Duration(milliseconds: 200),
                                      curve: Curves.easeIn,
                                      child: Login()),
                                );
                              },
                            ),
                          ),
                        )
                      : Container()
                ],
              );
            }),
      ),
    );
  }
}
