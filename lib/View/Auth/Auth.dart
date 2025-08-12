import 'package:demoapp/Firebase_interface/Firebase_interface.dart';
import 'package:demoapp/View/Auth/Signin.dart';
import 'package:demoapp/View/Auth/Signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../Controller/Common_Controller.dart';
import '../../Utlis/theme.dart';
import '../../Widgets/App_Font.dart';
import '../../Widgets/Widgets.dart';
import '../Home/HomeScreen.dart';

class Auth_Screen extends StatefulWidget {
  const Auth_Screen({super.key});

  @override
  State<Auth_Screen> createState() => _Auth_ScreenState();
}

class _Auth_ScreenState extends State<Auth_Screen> {
  CommonController commonController = Get.find<CommonController>();

  @override
  void initState() {
    checktoken();
    super.initState();
  }
  Future checktoken()async{
    final box2=await Hive.openBox('uid');
    if(box2.isNotEmpty){
      commonController.uid.value=box2.get('uid');
    }else{
      commonController.uid.value='abc';
    }
  }
  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop:()async{
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
            SizedBox(
              height: Get.height*0.558,
              child: Column(
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: GestureDetector(
                          onTap: (){
                            Get.to(HomeScreen());
                          },
                            child: SvgPicture.asset('assets/icons/close.svg'))
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height*0.3,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Login to Connect',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFFD3FB8F),
                          fontSize: 18,
                          fontFamily: AppFonts.fontFamily,
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                    ],

                  ),
                  const Padding(
                    padding: EdgeInsets.all(0.0),
                    child: Text(
                      'Let’s begin your journey to',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: AppFonts.fontFamily,
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ),
                  const Text(
                    'peaceful sleep',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: AppFonts.fontFamily,
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),


                ],
              ),
            ),
              GestureDetector(
                  onTap: (){
                    Get.to(const Signup());
                  },
                  child:Container(
                      alignment: Alignment.center,
                      height: Get.height*0.065,
                      width: Get.width*0.87,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFD3FB8F),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/images/Vector (2).svg'),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'CONTINUE WITH EMAIL',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: AppFonts.fontFamily,
                                fontWeight: FontWeight.bold,
                                height: 0,
                              ),
                            ),
                          ),
                        ],
                      )
                  )),
              SizedBox(
                height: Get.height*0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Have an account?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontFamily: AppFonts.fontFamily,
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),),
                  GestureDetector(
                    onTap: (){
                      Get.to(const Signin());
                    },
                    child: const Text(' Login',
                      style:TextStyle(
                        color: AppColor.themeColor,
                        fontSize: 13,
                        fontFamily: AppFonts.fontFamily_Bold,
                        height: 0,
                      ) ,),
                  )
                ],
              ),
              SizedBox(
                height: Get.height*0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset('assets/images/Line 3.svg'),
                  ),
                  const Text(
                    'other Login',
                    style: TextStyle(
                      color: Color(0xFF878999),
                      fontSize: 12,
                      fontFamily: AppFonts.fontFamily,
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset('assets/images/Line 3.svg'),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: GestureDetector(
                      onTap: ()async {
                        final user=await Firebase_intefacee().signInWithGoogle();
                        if(user!=null){
                          Get.to(const HomeScreen());
                        }

                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 60,
                        width: 60,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white
                        ),
                        child: SvgPicture.asset('assets/images/google.svg'),
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(15.0),
                  //   child: Container(
                  //     alignment: Alignment.center,
                  //     height: 60,
                  //     width: 60,
                  //     decoration: const BoxDecoration(
                  //         shape: BoxShape.circle,
                  //         color: Color(0xFF316FF6)
                  //     ),
                  //     child: SvgPicture.asset('assets/images/Frame.svg'),
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.all(15.0),
                  //   child: Container(
                  //     alignment: Alignment.center,
                  //     height: 60,
                  //     width: 60,
                  //     decoration: const BoxDecoration(
                  //         shape: BoxShape.circle,
                  //         color: Colors.white
                  //     ),
                  //     child: SvgPicture.asset('assets/images/apple.svg'),
                  //   ),
                  // ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
