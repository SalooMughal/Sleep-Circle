import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

import '../../Widgets/App_Font.dart';
import '../../Widgets/Widgets.dart';
import 'OnBoarding_Screen3.dart';
import 'OnBoarding_Screen4.dart';

class Oboarding_Screen2 extends StatefulWidget {
  const Oboarding_Screen2({super.key});

  @override
  State<Oboarding_Screen2> createState() => _Oboarding_Screen2State();
}

class _Oboarding_Screen2State extends State<Oboarding_Screen2> {
  RxBool iscontinoue=false.obs;
  int? selectedIndex;
  String? SelectedValue;
  List<String> items = [
    'I sleep pretty well',
    'I get decent sleep',
    "I don't get enough sleep",
    'I have trouble sleeping',
    "I'm not really sure",
  ];

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
                      padding:  const EdgeInsets.all(18),
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
                                Get.to(const Oboarding_Screen3());

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
                    SizedBox(
                      width: Get.width * 0.6,
                      child: const Text(
                        "What's a usual night for you?",
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
                    SizedBox(
                      height: Get.height * 0.05,
                    ),
                    SizedBox(
                      height: Get.height * 0.5,
                      width: Get.width * 0.93,
                      child: ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {

                                if (selectedIndex == index) {
                                  selectedIndex = null;
                                  iscontinoue.value=false;
                                } else {

                                  selectedIndex = index;
                                  iscontinoue.value=true;
                                }
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                alignment: Alignment.center,
                                height: Get.height * 0.07,
                                width: Get.width * 0.9,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF2A2C58),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    selectedIndex == index
                                        ? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                          alignment: Alignment.center,
                                          width: 30,
                                          height: 30,
                                          decoration: ShapeDecoration(
                                            color: const Color(0xFF2A2C58),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(18),
                                            ),
                                          ),
                                          child: SvgPicture.asset('assets/images/Check.svg',)
                                      ),
                                    )
                                        : Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: 30,
                                        height: 30,
                                        decoration: ShapeDecoration(
                                          color: const Color(0xFF2A2C58),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(18),
                                          ),
                                        ),

                                      ),
                                    ),
                                    SizedBox(width: Get.width*0.01),

                                    Text(
                                      items[index],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: selectedIndex == index
                                            ? Colors.white
                                            : const Color(0xFF636598),
                                        fontSize: 14,
                                        fontFamily: AppFonts.fontFamily,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: Get.height*0.006,),
              Obx(()=>
                  GestureDetector(
                      onTap: (){

                        if(iscontinoue.value==true){
                          if(selectedIndex==1||selectedIndex==0){
                            Get.to(const Oboarding_Screen4());
                          }else{
                            Get.to(const Oboarding_Screen3());
                          }

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

