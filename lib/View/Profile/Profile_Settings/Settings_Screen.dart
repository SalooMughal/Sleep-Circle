import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../Utlis/theme.dart';
import '../../../Widgets/App_Font.dart';
import 'Delete_Account_Screen.dart';

class Setting_Screen extends StatefulWidget {
  const Setting_Screen({super.key});

  @override
  State<Setting_Screen> createState() => _Setting_ScreenState();
}

class _Setting_ScreenState extends State<Setting_Screen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: (){
                  Get.back();
                },
                  child: Icon(Icons.arrow_back_ios_new_rounded)),
              SizedBox(height: Get.height*0.02,),
              Padding(
                padding: const EdgeInsets.only(top: 20.0,left: 20),
                child: Text(
                  'YOUR PLAN',
                  style: TextStyle(
                    color: Color(0xFF636598),
                    fontSize: 14,
                    fontFamily: AppFonts.fontFamily,
                    fontWeight: FontWeight.w400,
                    height: 0.11,
                  ),
                ),
              ),
              SizedBox(height: Get.height*0.02,),
              Container(
                height: Get.height*0.2,
                width: Get.width*0.95,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/Rectangle 795.png',),
                    fit: BoxFit.cover
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 200,
                          alignment: Alignment.center,
                          height: 30,
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: Color(0xFF2A2C58),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(80),
                            ),
                          ),
                          child: Text(
                            'STARTTING WITH 50% OFF',
                            style: TextStyle(
                              color: Color(0xFFD3FB8F),
                              fontSize: 12,
                              fontFamily: AppFonts.fontFamily,
                              fontWeight: FontWeight.w600,
                              height: 0.22,
                            ),
                          )
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Container(
                            width: Get.width*0.3,
                            height: 50,
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              color: Color(0xFFD3FB8F),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(80),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'GET PREMIUM',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontFamily: AppFonts.fontFamily,
                                    fontWeight: FontWeight.w700,
                                    height: 0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: Text(
                        'Get SnoozeSage Premium',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: AppFonts.fontFamily,
                          fontWeight: FontWeight.w600,
                          height: 0.11,
                        ),
                      ),
                    ),
                  ],
                ),
                    SizedBox(height: Get.height*0.02,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 30.0),
                          child: Text(
                            '& Enjoy all Premium',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: AppFonts.fontFamily,
                              fontWeight: FontWeight.w600,
                              height: 0.11,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: Get.height*0.02,),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  'SETTINGS',
                  style: TextStyle(
                    color: Color(0xFF636598),
                    fontSize: 14,
                    fontFamily: AppFonts.fontFamily,
                    fontWeight: FontWeight.w400,
                    height: 0.11,
                  ),
                ),
              ),
              SizedBox(height: Get.height*0.02,),
              Container(
                width: Get.width*0.95,
                height: Get.height*0.07,
                decoration: ShapeDecoration(
                  color: Color(0xFF2A2C58),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: SvgPicture.asset('assets/images/language.svg'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            'Change Language',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: AppFonts.fontFamily,
                              fontWeight: FontWeight.w400,
                              height: 0.11,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                        Container(
                        width: 55,
                        height: 13,
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: Color(0xFFD3FB8F),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'COMING SOON',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 6,
                                fontFamily: AppFonts.fontFamily,
                                fontWeight: FontWeight.w600,
                                height: 0.61,
                              ),
                            ),
                        ],
                      )
                        )],
                                      ),
                    ),


            ],
          ),
        ),
              SizedBox(height: Get.height*0.02,),
              GestureDetector(
                onTap: (){
                  _showBottomSheet_for_clear(context);
                },
                child: Container(
                  width: Get.width*0.95,
                  height: Get.height*0.07,
                  decoration: ShapeDecoration(
                    color: Color(0xFF2A2C58),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: SvgPicture.asset('assets/images/delete (2).svg'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Text(
                              'Clear Downloads',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: AppFonts.fontFamily,
                                fontWeight: FontWeight.w400,
                                height: 0.11,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.arrow_forward_ios_outlined,
                                size: 20,
                                color: Color(0xFF9698BF,))
                           ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: Get.height*0.32,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/images/delete-account.svg'),
                  InkWell(
                    onTap: (){
                      _showBottomSheet(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Text(
                        'Delete my account',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: AppFonts.fontFamily,
                          fontWeight: FontWeight.w400,
                          height: 0.11,
                        ),
                      ),
                    ),
                  ),
                ],
              )
      ]))),
    );

  }
  void _showBottomSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        height: Get.height*0.35,

        decoration: BoxDecoration(
            color: Color(0xFF2A2C58),
          borderRadius: BorderRadius.circular(25)
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: Get.height*0.05,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Delete My Account',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFD3FB8F),
                  fontSize: 20,
                  fontFamily: AppFonts.fontFamily,
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
              ),
            ],
          ),
            SizedBox(height: Get.height*0.05,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Are you sure you want to delete your',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: AppFonts.fontFamily,
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Account?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: AppFonts.fontFamily,
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ],
            ),
           SizedBox(height: Get.height*0.03,),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 GestureDetector(
                   onTap:(){
                     Get.back();
                   },
                   child: Container(
                     width: Get.width*0.4,
                     height: Get.height*0.06,
                     clipBehavior: Clip.antiAlias,
                     decoration: ShapeDecoration(
                       color: Color(0xFF2A2C58),
                       shape: RoundedRectangleBorder(
                         side: BorderSide(width: 1, color: Color(0xFFD3FB8F)),
                         borderRadius: BorderRadius.circular(80),
                       ),
                     ),
                     child: Row(
                       mainAxisSize: MainAxisSize.min,
                       mainAxisAlignment: MainAxisAlignment.center,
                       crossAxisAlignment: CrossAxisAlignment.center,
                       children: [
                         Text(
                           'CANCEL',
                           textAlign: TextAlign.center,
                           style: TextStyle(
                             color: Color(0xFFD3FB8F),
                             fontSize: 14,
                             fontFamily: AppFonts.fontFamily,
                             fontWeight: FontWeight.w700,
                             height: 0,
                           ),
                         ),
                       ],
                     ),
                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: GestureDetector(
                     onTap: (){
                       Get.to(Delete_Account());
                     },
                     child: Container(
                       width: Get.width*0.4,
                       height: Get.height*0.06,

                       clipBehavior: Clip.antiAlias,
                       decoration: ShapeDecoration(
                         color: Color(0xFFD3FB8F),
                         shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(80),
                         ),
                       ),
                       child: Row(
                         mainAxisSize: MainAxisSize.min,
                         mainAxisAlignment: MainAxisAlignment.center,
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: [
                           Text(
                             'DELETE',
                             textAlign: TextAlign.center,
                             style: TextStyle(
                               color: Colors.black,
                               fontSize: 14,
                               fontFamily: AppFonts.fontFamily,
                               fontWeight: FontWeight.w700,
                               height: 0,
                             ),
                           ),
                         ],
                       ),
                     ),
                   ),
                 ),
               ],
             ),
           )
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
    );
  }
  void _showBottomSheet_for_clear(BuildContext context) {
    Get.bottomSheet(
      Container(
        height: Get.height*0.35,

        decoration: BoxDecoration(
            color: Color(0xFF2A2C58),
            borderRadius: BorderRadius.circular(25)
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: Get.height*0.05,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Delete downloaded content?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFD3FB8F),
                    fontSize: 20,
                    fontFamily: AppFonts.fontFamily,
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
              ],
            ),
            SizedBox(height: Get.height*0.03,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Are you sure you want to delete all',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: AppFonts.fontFamily,
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'downloaded content. Restore',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: AppFonts.fontFamily,
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Available for Free',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: AppFonts.fontFamily,
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ],
            ),
            SizedBox(height: Get.height*0.02,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap:(){
                      Get.back();
                    },
                    child: Container(
                      width: Get.width*0.4,
                      height: Get.height*0.06,
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: Color(0xFF2A2C58),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 1, color: Color(0xFFD3FB8F)),
                          borderRadius: BorderRadius.circular(80),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'CANCEL',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFFD3FB8F),
                              fontSize: 14,
                              fontFamily: AppFonts.fontFamily,
                              fontWeight: FontWeight.w700,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: (){
                        Get.to(Delete_Account());
                      },
                      child: Container(
                        width: Get.width*0.4,
                        height: Get.height*0.06,

                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: Color(0xFFD3FB8F),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'CLEAR',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: AppFonts.fontFamily,
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
    );
  }
}

