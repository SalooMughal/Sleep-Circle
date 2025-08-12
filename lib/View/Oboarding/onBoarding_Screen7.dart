import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../Widgets/App_Font.dart';
import '../../Widgets/Widgets.dart';
import '../Home/HomeScreen.dart';
import 'Slider_Screen/OnBoarding_Screen8.dart';

class OnBoarding7 extends StatefulWidget {
  const OnBoarding7({super.key});

  @override
  State<OnBoarding7> createState() => _OnBoarding7State();
}

class _OnBoarding7State extends State<OnBoarding7> {
  Future<void> requestNotificationPermission() async {
    var microphoneStatus = await Permission.microphone.status;

    if (microphoneStatus.isDenied) {
      // Request camera permission
      await Permission.microphone.request();
    }

  }
  @override
  void initState() {
    requestNotificationPermission();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.bottomSheet(
        const OnBoarding8(), // Your custom widget for the bottom sheet content
        isDismissible: true, // Optional: Set to true if you want to dismiss the bottom sheet by tapping on the overlay
        backgroundColor: Colors.transparent,
        enterBottomSheetDuration: Duration.zero, // Animation duration for bottom sheet entering
        exitBottomSheetDuration: Duration.zero, // Optional: Set the background color of the bottom sheet
      );
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body: SafeArea(child: Column(
        children: [
          SizedBox(
            height: Get.height*0.1,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Personalising',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: AppFonts.fontFamily,
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
              ),
            ],
          ),
         const Spacer(),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    alignment: Alignment.center,
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(
                      color: Color(0xFFD3FB8F),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      size: 15,
                      Icons.check,
                      color: Colors.black,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Calculating the basic intake for female',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: AppFonts.fontFamily,
                      fontWeight: FontWeight.w400,
                      height: 0.15,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    alignment: Alignment.center,
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(
                      color: Color(0xFFD3FB8F),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      size: 15,
                      Icons.check,
                      color: Colors.black,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Adjusting the goal based on your weight',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: AppFonts.fontFamily,
                      fontWeight: FontWeight.w400,
                      height: 0.15,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    alignment: Alignment.center,
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(
                      color: Color(0xFFD3FB8F),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      size: 15,
                      Icons.check,
                      color: Colors.black,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Analyzing your activity level',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: AppFonts.fontFamily,
                      fontWeight: FontWeight.w400,
                      height: 0.15,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: Get.height*0.02,),
          GestureDetector(
              onTap: (){
                Get.to(const HomeScreen());
              },
              child: Application_Button('Continue')),
          SizedBox(
            height: Get.height*0.05,
          ),
        ],
      )),
    );
  }
}
