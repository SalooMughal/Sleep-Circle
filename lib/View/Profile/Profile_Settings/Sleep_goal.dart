import 'package:demoapp/Controller/Common_Controller.dart';
import 'package:demoapp/View/Profile/Profile.dart';
import 'package:demoapp/Widgets/Widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vertical_weight_slider/vertical_weight_slider.dart';

import '../../../Widgets/App_Font.dart';

class Sleep_goal extends StatefulWidget {
  const Sleep_goal({super.key});

  @override
  State<Sleep_goal> createState() => _Sleep_goalState();
}

class _Sleep_goalState extends State<Sleep_goal> {
  CommonController commonController=Get.find<CommonController>();
   WeightSliderController? _controller;
  RxDouble Hours_Goals = 7.0.obs;
  @override
  void initState() {
    _controller = WeightSliderController(
      maxWeight: 24,
        initialWeight: Hours_Goals.value, minWeight: 0, interval: 0.1);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: (){
                      Get.back();
                    },
                      child: const Icon(Icons.arrow_back_ios_new_rounded))
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Lets set up your sleep goal',
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
              const SizedBox(
                height: 15,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'How many hours of sleep do you feel you',
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
              const SizedBox(
                height: 15,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'actually need?',
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
              const SizedBox(
                height: 100,
              ),
              Container(
                height: 100,
                width: 100,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/Ellipse.png')),
                  shape: BoxShape.circle
                ),
                child: Text(
                  '${Hours_Goals.toInt()}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14.91,
                    fontFamily: AppFonts.fontFamily,
                    fontWeight: FontWeight.w500,
                    height: 0.08,
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              const Text(
                'Hours',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.91,
                  fontFamily: AppFonts.fontFamily,
                  fontWeight: FontWeight.w500,
                  height: 0.08,
                ),
              ),
              const SizedBox(height: 30,),
              Transform.rotate(
                angle: -90 * 3.14 / 180,
                child: SizedBox(
                  height: 200,
                  width: 50,
                  child: VerticalWeightSlider(
                    controller: _controller!,
                    decoration: const PointerDecoration(
                      width: 150,
                      height: 4,
                      largeColor: Color(0xFF898989),
                      mediumColor: Color(0xFFC5C5C5),
                      smallColor: Color(0xFFF0F0F0),
                      gap: 70,
                    ),
                    onChanged: (double value) {
                      setState(() {
                        Hours_Goals.value = value;
                      });
                    },
                    indicator: Container(
                      height: 3,
                      width: 200,
                      alignment: Alignment.centerLeft,
                      color: const Color(0xFFD3FB8F),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
      const Column(
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Most people need ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontFamily: AppFonts.fontFamily,
                    fontWeight: FontWeight.w400,
                    height: 0.15,
                  ),
                ),
                TextSpan(
                  text: '7 to 9 hours',
                  style: TextStyle(
                    color: Color(0xFFD3FB8F),
                    fontSize: 13,
                    fontFamily: AppFonts.fontFamily,
                    fontWeight: FontWeight.w500,
                    height: 0.15,
                  ),
                ),
                TextSpan(
                  text: ' of sleep to feel rested.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontFamily: AppFonts.fontFamily,
                    fontWeight: FontWeight.w400,
                    height: 0.15,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
              const SizedBox(height: 40,),
              GestureDetector(
                onTap: (){
                  commonController.Goal_hours=Hours_Goals;
                 Get.to(const Profile());
                },
                  child: Application_Button('SAVE SETTINGS'))
            ],
          ),
        ),
      ),
    );
  }
}
