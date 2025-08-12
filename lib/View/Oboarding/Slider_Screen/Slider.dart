import 'package:demoapp/Widgets/Widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../Widgets/App_Font.dart';
import '../Onboarding_Screen1.dart';
import 'app_colors.dart';

class onBoarding_Slider extends StatefulWidget {
  const onBoarding_Slider({super.key, Key });
  @override
  _onBoarding_SliderState createState() => _onBoarding_SliderState();
}

class _onBoarding_SliderState extends State<onBoarding_Slider> {
  int currentPageValue = 0;
  String buttonText = 'NEXT';
  PageController? pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController?.dispose();
    super.dispose();
  }

  void getChangedPageAndMoveBar(int page) {
    if (page == 1) {
      setState(() {
        buttonText = 'GET STARTED';
      });
    } else {
      setState(() {
        buttonText = 'NEXT';
      });
    }
    setState(() {
      currentPageValue = page;
    });
  }
  void updateButtonText(int page) {
    setState(() {
      if (page == 1) {
        buttonText = 'GET STARTED';
      } else {
        buttonText = 'NEXT';
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: Get.height*0.77,
              child: Column(
                children: [
                  Flexible(
                    flex: 9,
                    child: PageView(
                      controller: pageController,
                      physics: const BouncingScrollPhysics(),
                      onPageChanged: (int page) {
                        updateButtonText(page);
                        getChangedPageAndMoveBar(page);
                      },
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: Get.height*0.14,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: Get.width*0.1,
                                ),
                                SizedBox(
                                  height: Get.height*0.3,
                                  width: Get.width*0.6,
                                  child: SvgPicture.asset('assets/images/Group (3).svg',fit: BoxFit.cover,),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: Get.height*0.05,
                            ),
                            const Text(
                              'Explore endless music',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: AppFonts.fontFamily,
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                            ),
                            SizedBox(
                              height: Get.height*0.05,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                              child: const Text(
                                'Dive into a vast library of tunes for any mood ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: AppFonts.fontFamily,
                                  fontWeight: FontWeight.w400,
                                  height: 0.11,
                                ),
                              ),
                            ),
                            const SizedBox(height: 15,),
                            const Text(
                              'or occasion.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: AppFonts.fontFamily,
                                fontWeight: FontWeight.w400,
                                height: 0.11,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: Get.height*0.13,
                            ),
                            SizedBox(
                              height: Get.height*0.3,
                              width: Get.width*0.6,
                              child: SvgPicture.asset('assets/images/Timer (1).svg',fit: BoxFit.cover,),
                            ),
                            SizedBox(
                              height: Get.height*0.05,
                            ),
                            const Text(
                              'Track your Sleep',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: AppFonts.fontFamily,
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                            ),
                            SizedBox(
                              height: Get.height*0.04,
                            ),
                            const Text(
                              'Monitor sleep patterns, journal thoughts, and  ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: AppFonts.fontFamily,
                                fontWeight: FontWeight.w400,
                                height: 0.11,
                              ),
                            ),
                            const SizedBox(height: 15,),
                            const Text(
                              'access detailed stats for better rest.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: AppFonts.fontFamily,
                                fontWeight: FontWeight.w400,
                                height: 0.11,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        for (int i = 0; i < 2; i++)
                          if (i == currentPageValue) ...[
                            pageIndicator(true)
                          ] else
                            pageIndicator(false),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: Get.height*0.006,),
            Padding(
              padding: const EdgeInsets.only(bottom: 0.0),
              child: GestureDetector(
                onTap: (){

                  if (currentPageValue == 1) {
                    Get.to(const Oboarding_Screen1());
                  } else {
                    // Move to the next page
                    pageController?.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                  child: Application_Button(buttonText)),
            ),
          ],
        ),
      ),
    );
  }
}

Widget pageIndicator(bool isActive) {
  return Container(
    height: Get.height*0.006,
    width: 30,
    margin: const EdgeInsets.only(left: 3, right: 3),
    child: DecoratedBox(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: isActive ? colorActive : const Color(0xFF2A2C58),
        borderRadius: const BorderRadius.all(
          Radius.elliptical(4, 4),
        ),
      ),
    ),
  );
}

Widget mainView(image, title) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(25, 10, 25, 20),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          image,
          fit: BoxFit.none,
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 14.0),
        ),
      ],
    ),
  );
}