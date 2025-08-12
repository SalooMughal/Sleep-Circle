import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../Controller/Common_Controller.dart';
import '../../Utlis/theme.dart';
import '../../Widgets/App_Font.dart';
import 'Sound_Screen.dart';

class Create_Mix extends StatefulWidget {
  const Create_Mix({super.key});

  @override
  State<Create_Mix> createState() => _Create_MixState();
}

class _Create_MixState extends State<Create_Mix> {
  CommonController commonController=Get.find<CommonController>();

  @override
  Widget build(BuildContext context) {
    return   Container(
      height: Get.height*0.27,
      width: Get.width*0.89,
      child: Stack(
          children:[
            Padding(
              padding:  EdgeInsets.only(top: 18.0.sp),
              child: Container(
                height: Get.height*0.2,
                width: Get.width*0.96,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0xFF2A2C58)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0, top: 18),
                      child: Container(
                        alignment: Alignment.center,
                        height: 30,
                        width: 100,
                        decoration: BoxDecoration(
                            color: const Color(0xffffbee7ff),
                            borderRadius: BorderRadius.circular(30)
                        ),
                        child: const Text(
                          'Sleep Sounds',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontFamily: AppFonts.fontFamily,
                            fontWeight: FontWeight.w500,
                            height: 0,
                          ),
                        ),

                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 18.0, top: 18),
                      child: Text(
                        'Create your Mix',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: AppFonts.fontFamily,
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 18.0, top: 18),
                      child: Text(
                        "Select your preferred ambient",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontFamily: AppFonts.fontFamily,
                          fontWeight: FontWeight.w400,
                          height: 0.22,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 18.0, top: 18),
                      child: Text(
                        "sounds for a restful night's sleep",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontFamily: AppFonts.fontFamily,
                          fontWeight: FontWeight.w400,
                          height: 0.22,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(bottom: 0.sp,left: 190.sp),
                child: SvgPicture.asset('assets/images/music.svg',
                height: 120.h,)),
            Padding(
              padding:  EdgeInsets.only(top: 130.h,left: 180.sp),
              child: GestureDetector(
                onTap: (){
                  commonController.selectedIndex.value=2;
                  commonController.Selectedcat.value='Snooze';
                },
                child: Container(
                  height: 40.h,
                  width: 120.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)
                  ),
                  child: const Text(
                    'CREATE',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: AppFonts.fontFamily,
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                ),
              ),
            )
          ]
      ),
    );
  }
}
