import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/route_manager.dart';

import '../../../Widgets/App_Font.dart';
import '../../../Widgets/Widgets.dart';

class OnBoarding8 extends StatefulWidget {
  const OnBoarding8({super.key});

  @override
  State<OnBoarding8> createState() => _OnBoarding8State();
}

class _OnBoarding8State extends State<OnBoarding8> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Rectangle 776.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: Get.height*0.03,
            ),
            GestureDetector(
              onTap: (){
                Get.back();
              },
              child: Row(
                children: [
                 Padding(
                   padding: const EdgeInsets.only(left: 30.0),
                   child: SvgPicture.asset('assets/images/Vector (1).svg'),
                 )
                ],
              ),
            ),
            SizedBox(
              height: Get.height*0.05,
            ),
            Text(
              'Try 7 days free trail',
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
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 70.0),
                  child: SvgPicture.asset('assets/images/done.svg'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '150+ sounds & music',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: AppFonts.fontFamily,
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 70.0),
                  child: SvgPicture.asset('assets/images/done.svg'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '300+ meditation & stories',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: AppFonts.fontFamily,
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 70.0),
                  child: SvgPicture.asset('assets/images/done.svg'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Sleep tracking',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: AppFonts.fontFamily,
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 70.0),
                  child: SvgPicture.asset('assets/images/done.svg'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Sleep recording with insights',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: AppFonts.fontFamily,
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Get.height*0.05,
            ),
        SizedBox(
          width: 282,
          child: Text(
            'Try 7 days free. Billed in just 50\$/month or  ',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontFamily: AppFonts.fontFamily,
              fontWeight: FontWeight.w400,
              height: 0.15,
            ),
          )),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: SizedBox(
                  width: 282,
                  child: Text(
                    '250\$/year. Cancel anytime within trail period. ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: AppFonts.fontFamily,
                      fontWeight: FontWeight.w400,
                      height: 0.15,
                    ),
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
                onTap: (){

                },
                child: Application_Button('Continue'))
          ],
        ),
      ),
    );
  }
}
