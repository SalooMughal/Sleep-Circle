import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demoapp/Firebase_interface/Firebase_interface.dart';
import 'package:demoapp/Utlis/theme.dart';
import 'package:demoapp/View/Auth/Auth.dart';
import 'package:demoapp/View/Profile/Profile_Settings/Settings_Screen.dart';
import 'package:demoapp/View/Profile/Profile_Settings/Sleep_goal.dart';
import 'package:demoapp/Widgets/Widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';

import '../../Controller/Common_Controller.dart';
import '../../Widgets/App_Font.dart';
import '../Home/HomeScreen.dart';
import '../Oboarding/OnBoarding_Screen6.dart';
import 'Bedtime/SetBedtime.dart';
import 'Wakeup_alarm/Edit_page.dart';
import 'Wakeup_alarm/Home.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  CommonController commonController = Get.find<CommonController>();

  @override
  final Uri Android_url = Uri.parse('https://docs.google.com/document/d/1nigCbf_DwXYgwko_T4hs8zduRE0o_CgvkYDqONIIs3E/edit');
  final Uri Ios_url = Uri.parse('https://docs.google.com/document/d/1YG4fMret9kLOH_wrbuCO7Myc9shrBSRQJ8sALrDJLh0/edit');

  void Confirmtation_for_logout_account(BuildContext context) {
    Get.bottomSheet(
      Container(
        height: Get.height*0.4,
        decoration: BoxDecoration(
            color: Color(0xFF1D2046),
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
                  'Log out',
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
                  'Are you sure you want to logout',
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: (){
                        Get.back();
                      },
                      child: Container(
                        width: Get.width*0.85,
                        height: Get.height*0.065,

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
                              'STAY LOGGED IN',
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
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: GestureDetector(
                      onTap:()async{
                        await Firebase_intefacee().signOut();
                        commonController.uid.value = '';
                        commonController.checkin?.value = '';
                        final box = await Hive.openBox('Credentials');
                        final box2 = await Hive.openBox('uid');
                        box2.clear();
                        box.clear();
                        Get.to(Auth_Screen());
                        Get.put(CommonController());
                        clearallmusic();
                      },
                      child: Container(
                        width: Get.width*0.85,
                        height: Get.height*0.065,
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
                              'LOGOUT',
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
  void Confirmtation_for_delete_account() {
    Get.bottomSheet(
      Container(
        height: Get.height*0.5,
        decoration: BoxDecoration(
            color: Color(0xFF1D2046),
            borderRadius: BorderRadius.circular(25)
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: Get.height*0.05,),
            SvgPicture.asset('assets/icons/alert.svg'),

            SizedBox(height: Get.height*0.03,),
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
                  'account? This action can be',
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
                  'undone.',
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: ()async{
                        await  Firebase_intefacee().deleteFirebaseAccount(commonController.uid.value).then((value) {
                          Get.to(Auth_Screen());
                        });
                      },
                      child: Container(
                        width: Get.width*0.85,
                        height: Get.height*0.065,

                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: Color(0xFFEF6183),
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
                              'DELETE ACCOUNT',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
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
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: GestureDetector(
                      onTap:()async{
                        Get.back();
                      },
                      child: Container(
                        width: Get.width*0.85,
                        height: Get.height*0.065,
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: Color(0xFF2A2C58),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1, color:Colors.white),
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
                                color: Colors.white,
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


  Widget build(BuildContext context) {
    print(commonController.checkin.value);
    return Scaffold(
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(Icons.arrow_back_ios_new_rounded)),
              InkWell(
                  onTap: () async{
                    Confirmtation_for_logout_account(context);

                  },
                  child: commonController.checkin.isNotEmpty?Row(children:[ Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: SvgPicture.asset('assets/icons/log-out.svg'),
                  ),
                    Text(
                      'Log out',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        height: 0.22,
                      ),
                    ),
                  ]
                  ):Text(''))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          Column(
          children: [
          Container(
          height: Get.height*0.1,
            width: Get.width * 0.2,
            decoration: const BoxDecoration(
                shape: BoxShape.circle
            ),
            child: SvgPicture.asset(
                'assets/images/profile (2).svg', fit: BoxFit.cover),
          ),
          SizedBox(
            height: Get.height*0.02,
          ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StreamBuilder(stream: FirebaseFirestore.instance.collection('users').doc(commonController.uid.value).snapshots(),
                    builder: (context, snapshot){
                  if(snapshot.hasData){
                    return  Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Text(
                        '${snapshot.data?['name']}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontFamily: AppFonts.fontFamily,
                          fontWeight: FontWeight.w400,
                          height: 0.11,
                        ),
                      ),
                    );
                  }else return CircularProgressIndicator();
                    }),
              ],
            ),
            commonController.checkin.isEmpty? GestureDetector(
            onTap: (){
              Get.to(Auth_Screen());
            },
            child: Container(
                alignment: Alignment.center,
                height: Get.height * 0.045,
                width: Get.width * 0.3,
                decoration: ShapeDecoration(
                  color: Color(0xFFD3FB8F),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80),
                  ),
                ),
                child: Text(
                  'LOGIN',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: AppFonts.fontFamily,
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                )
            ),
          ):Text('')
          ],
        ),

        ],
      ),
        SizedBox(
          height: Get.height * 0.02,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 15.0),
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
        SizedBox(height: Get.height * 0.02,),
        Container(
          height: Get.height * 0.14,
          width: Get.width,
          decoration: BoxDecoration(
              color: const Color(0xFF2A2C58),
              borderRadius: BorderRadius.circular(15)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Padding(
              //   padding: const EdgeInsets.only(left: 20.0,top: 20,right: 10),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //    Row(
              //      children: [
              //        SvgPicture.asset('assets/images/sleep.svg'),
              //        const Padding(
              //          padding: EdgeInsets.all(8.0),
              //          child: Text(
              //            'Sleep Goal',
              //            style: TextStyle(
              //              color: Colors.white,
              //              fontSize: 14,
              //              fontFamily: AppFonts.fontFamily,
              //              fontWeight: FontWeight.w400,
              //              height: 0.11,
              //            ),
              //          ),
              //        ),
              //      ],
              //    ),
              //      GestureDetector(
              //         onTap: (){
              //           Get.to(const Sleep_goal());
              //         },
              //         child:  commonController.Goal_hours.value==0.0?Container(
              //           height: 20,
              //           width: 50,
              //           alignment: Alignment.center,
              //           decoration: BoxDecoration(
              //             color: AppColor.themeColor,
              //             borderRadius: BorderRadius.circular(30)
              //           ),
              //           child: const Text(
              //             'ADD',
              //             style: TextStyle(
              //               color: AppColor.themeColor,
              //               fontSize: 10,
              //               fontFamily: AppFonts.fontFamily,
              //               fontWeight: FontWeight.w600,
              //               height: 0.22,
              //             ),
              //           ),
              //         ):Row(
              //           children: [
              //             Text(
              //               '${commonController.Goal_hours.value.toInt()}h',
              //               textAlign: TextAlign.right,
              //               style: const TextStyle(
              //                 color: Color(0xFF9698BF),
              //                 fontSize: 15,
              //                 fontFamily: AppFonts.fontFamily,
              //                 fontWeight: FontWeight.w400,
              //                 height: 0.15,
              //               ),
              //             ),
              //             const Padding(
              //               padding: EdgeInsets.all(5.0),
              //               child: Icon(Icons.arrow_forward_ios_outlined,
              //                 size: 15,
              //                 color: Color(0xFF9698BF),),
              //             )
              //           ],
              //         ),
              //       )
              //     ],
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset('assets/images/bed.svg'),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Set Bedtime',
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
                    GestureDetector(
                      onTap: () {
                        Get.to(const SetBedTime());
                      },
                      child: commonController.Bedtime.isEmpty ? Container(
                        height: 20,
                        width: 50.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: AppColor.themeColor,
                            borderRadius: BorderRadius.circular(30)
                        ),
                        child:  Obx(()=>
                           Text(
                            '${commonController.Set_bedtime.isNotEmpty?commonController.Set_bedtime.value:'ADD'}',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontFamily: AppFonts.fontFamily,
                              fontWeight: FontWeight.w600,
                              height: 0.22,
                            ),
                          ),
                        ),
                      ) : Row(
                        children: [
                          Text(
                            commonController.Bedtime.value,
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              color: Color(0xFF9698BF),
                              fontSize: 12,
                              fontFamily: AppFonts.fontFamily,
                              fontWeight: FontWeight.w400,
                              height: 0.15,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Icon(Icons.arrow_forward_ios_outlined,
                              color: Color(0xFF9698BF),
                              size: 15,),
                          )
                        ],
                      ),
                    ),

                  ],
                ),
              ),
              SvgPicture.asset('assets/images/Vector 215.svg',
                  width: Get.width * 0.82),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset('assets/images/alarm.svg'),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Wake-up Alarm',
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
                    GestureDetector(
                      onTap: () {
                        Get.to(ExampleAlarmHomeScreen());
                      },
                      child: Container(
                        height: 20,
                        width: 50.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: AppColor.themeColor,
                            borderRadius: BorderRadius.circular(30)
                        ),
                        child: const Text(
                          'SET',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontFamily: AppFonts.fontFamily,
                            fontWeight: FontWeight.w600,
                            height: 0.22,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20,),
        const Padding(
          padding: EdgeInsets.only(left: 15.0),
          child: Text(
            'OTHERS',
            style: TextStyle(
              color: Color(0xFF636598),
              fontSize: 14,
              fontFamily: AppFonts.fontFamily,
              fontWeight: FontWeight.w400,
              height: 0.11,
            ),
          ),
        ),
        const SizedBox(height: 20,),
        Container(
          height: Get.height * 0.25,
          width: Get.width,

          decoration: BoxDecoration(
              color: const Color(0xFF2A2C58),
              borderRadius: BorderRadius.circular(15)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset('assets/images/feedback.svg'),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Feedback',
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
                  ],
                ),
              ),
              SizedBox(height: Get.height * 0.015,),
              SvgPicture.asset('assets/images/Vector 215.svg',
                width: Get.width * 0.82,),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 20, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () async {
                        if(Platform.isAndroid){
                          if (!await launchUrl(Android_url)) {
                        throw Exception('Could not launch $Android_url');
                        }
                        }else if(Platform.isIOS){
                          if (!await launchUrl(Ios_url)) {
                            throw Exception('Could not launch $Ios_url');
                          }
                        }
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/images/privacy-policy.svg'),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Privacy Policy',
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
                    ),

                  ],
                ),
              ),
              SizedBox(height: Get.height * 0.015,),
              SvgPicture.asset('assets/images/Vector 215.svg',
                width: Get.width * 0.82,),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 20, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset('assets/images/rating.svg'),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Rate Us',
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

                  ],
                ),
              ),
              SizedBox(height: Get.height * 0.015,),
              SvgPicture.asset('assets/images/Vector 215.svg',
                width: Get.width * 0.82,),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 20, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset('assets/images/share (1).svg'),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Share Sleep Circle',
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

                  ],
                ),
              ),

            ],
          ),
        ),
              SizedBox(height: Get.height * 0.02,),
              commonController.checkin.isEmpty?SizedBox():Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: (){
                      Confirmtation_for_delete_account();

                    },
                    child: Text('Delete Account',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      height: 0.11,
                    ),
                  ),
                                    )],
              ),

              SizedBox(height: Get.height * 0.02,),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Padding(
        //       padding: const EdgeInsets.all(8.0),
        //       child: SvgPicture.asset('assets/images/twitter.svg'),
        //     ),
        //     Padding(
        //       padding: const EdgeInsets.all(8.0),
        //       child: SvgPicture.asset('assets/images/instagram.svg'),
        //     ),
        //   ],
        // ),
        // const Padding(
        //   padding: EdgeInsets.all(8.0),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Text(
        //         'Follow us',
        //         textAlign: TextAlign.center,
        //         style: TextStyle(
        //           color: Colors.white,
        //           fontSize: 10,
        //           fontFamily: AppFonts.fontFamily,
        //           fontWeight: FontWeight.w400,
        //           height: 0.14,
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        const Padding(
          padding: EdgeInsets.only(top: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Sleep Circle ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontFamily: AppFonts.fontFamily,
                        fontWeight: FontWeight.w400,
                        height: 0.15,
                      ),
                    ),
                    TextSpan(
                      text: 'Version 1.0.0',
                      style: TextStyle(
                        color: Color(0xFFD3FB8F),
                        fontSize: 12,
                        fontFamily: AppFonts.fontFamily,
                        fontWeight: FontWeight.w400,
                        height: 0.15,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
        ],
      ),
    ),)
    )
    ,
    );
  }
}
