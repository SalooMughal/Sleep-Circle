import 'package:demoapp/View/Auth/Auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:vertical_weight_slider/vertical_weight_slider.dart';

import '../../Widgets/App_Font.dart';
import '../../Widgets/Widgets.dart';
import 'OnBoarding_Screen6.dart';
import 'onBoarding_Screen7.dart';

class Oboarding_Screen5 extends StatefulWidget {
  const Oboarding_Screen5({super.key});

  @override
  State<Oboarding_Screen5> createState() => _Oboarding_Screen2State();
}

class _Oboarding_Screen2State extends State<Oboarding_Screen5> {
  int? selectedIndex;
  RxBool iscontinoue=false.obs;

  late WeightSliderController _controller;
  double _weight = 30.0;
  List<String> items = [
    'Less than 30 minutes',
    'Between 30 to 60 minutes',
    "More than 60 minutes",
    "I'm not sure",
  ];
  @override
  void initState() {
    _controller = WeightSliderController(
        initialWeight: _weight, minWeight: 0, interval: 0.1);
    super.initState();
  }
  bool men=false;
  bool women=false;
  bool other=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: Get.height*0.77,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: const Icon(Icons.arrow_back_ios_new),
                          ),
                          TextButton( // Changed from GestureDetector to TextButton
                              onPressed: (){
                                Get.to(const Auth_Screen());
                              },
                              child: const Text(
                                'SKIP',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: AppFonts.fontFamily,
                                  fontWeight: FontWeight.w400,
                                  height: 0.15,
                                ),
                              )),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(
                          width: Get.width * 0.5,
                          child: const Text(
                            'What’s your gender?',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: AppFonts.fontFamily,
                              fontWeight: FontWeight.w600,
                              height: 0,
                            ),
                          ),
                        ),
                        SizedBox(height: Get.height * 0.05),
                        const SizedBox(

                            child: Text(
                              'We’re committed to creating a welcoming experience ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontFamily: AppFonts.fontFamily,
                                fontWeight: FontWeight.w400,
                                height: 0.15,
                              ),
                            )),
                        const SizedBox(height: 20,),
                        const SizedBox(
                            width: 327,
                            child: Text(
                              'for members of all genders identities',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontFamily: AppFonts.fontFamily,
                                fontWeight: FontWeight.w400,
                                height: 0.15,
                              ),
                            )),
                        const SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: (){
                                men=true;
                                women=false;
                                other=false;
                                iscontinoue.value=true;
                                setState(() {

                                });
                              },
                              child: Container(
                                height: Get.height*0.18,
                                width: Get.width*0.27,
                                decoration: BoxDecoration(
                                    color: const Color(0xFF2A2C58),
                                    borderRadius: BorderRadius.circular(25)
                                ),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:
                                    [
                                      men?SvgPicture.asset('assets/images/man (1).svg',

                                        height: 50,
                                        width: 50,):SvgPicture.asset('assets/images/man.svg',
                                        height: 50,
                                        width: 50,),
                                      const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'Male',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Color(0xFF636598),
                                            fontSize: 14,
                                            fontFamily: AppFonts.fontFamily,
                                            fontWeight: FontWeight.w500,
                                            height: 0,
                                          ),
                                        ),
                                      ),
                                    ]),
                              ),
                            ),

                            GestureDetector(
                              onTap: (){
                                men=false;
                                women=true;
                                other=false;
                                iscontinoue.value=true;
                                setState(() {

                                });
                              },
                              child: Container(
                                height: Get.height*0.18,
                                width: Get.width*0.27,
                                decoration: BoxDecoration(
                                    color: const Color(0xFF2A2C58),
                                    borderRadius: BorderRadius.circular(25)
                                ),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:
                                    [
                                      women?SvgPicture.asset('assets/images/businesswoman (2).svg',

                                        height: 50,
                                        width: 50,):SvgPicture.asset('assets/images/businesswoman.svg',
                                        height: 50,
                                        width: 50,),
                                      const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'Female',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Color(0xFF636598),
                                            fontSize: 14,
                                            fontFamily: AppFonts.fontFamily,
                                            fontWeight: FontWeight.w500,
                                            height: 0,
                                          ),
                                        ),
                                      ),
                                    ]),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                women=false;
                                men=false;
                                other=true;
                                iscontinoue.value=true;
                                setState(() {

                                });
                              },
                              child: Container(
                                height: Get.height*0.18,
                                width: Get.width*0.27,
                                decoration: BoxDecoration(
                                    color: const Color(0xFF2A2C58),
                                    borderRadius: BorderRadius.circular(25)
                                ),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:
                                    [
                                      other?SvgPicture.asset('assets/images/gender (1).svg',
                                        height: 50,
                                        width: 50,):SvgPicture.asset('assets/images/gender.svg',
                                        height: 50,
                                        width: 50,),
                                      const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'Other',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Color(0xFF636598),
                                            fontSize: 14,
                                            fontFamily: AppFonts.fontFamily,
                                            fontWeight: FontWeight.w500,
                                            height: 0,
                                          ),
                                        ),
                                      ),
                                    ]),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Get.height*0.05,
                        ),
                        const Text(
                          'How old are you?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: AppFonts.fontFamily,
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                              height:Get.height*0.056,
                              alignment: Alignment.center,
                              child: Text(
                                "${_weight.toInt()} ",
                                style: const TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
                              ),
                            ),
                            Transform.rotate(
                              angle: -90 * 3.14 / 180,
                              child: SizedBox(
                                height: Get.height*0.16,
                                width: 50,
                                child: VerticalWeightSlider(
                                  controller: _controller,
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
                                      _weight = value;
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
                          ],
                        ),
                        SizedBox(
                          height: Get.height*0.02,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: Get.height*0.006,),
              Obx(()=>
                  GestureDetector(
                      onTap: (){
                        if(iscontinoue.value==true){
                          Get.to(const Auth_Screen());
                        }
                      },
                      child: Container(
                          alignment: Alignment.center,
                          height: Get.height*0.065,
                          width: Get.width*0.87,
                          decoration: ShapeDecoration(
                            color:iscontinoue.value? Color(0xFFD3FB8F):const Color(0xFF2A2C58),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(80),
                            ),
                          ),
                          child: Text(
                            'CONTINUE',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: iscontinoue.value?Colors.black:Color(0xFF636598),
                              fontSize: 14,
                              fontFamily: AppFonts.fontFamily,
                              fontWeight: FontWeight.w700,
                              height: 0,
                            ),
                          )
                      )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

