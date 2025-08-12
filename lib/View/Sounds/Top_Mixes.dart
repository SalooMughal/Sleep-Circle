import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demoapp/View/Sounds/Snooze_Items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../Controller/Common_Controller.dart';
import '../../Widgets/App_Font.dart';
import '../Home/HomeScreen.dart';
import 'Audio_Player.dart';

Widget Top_Mixes(){
  CommonController commonController=Get.find<CommonController>();
  return Column(
    children: [
      SizedBox(
        height: Get.height*0.01,
      ),
      StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Top Mixes').snapshots(),
          builder: (context, snapshot){
            if(snapshot.hasData){
              return Container(
                height: 200.h,
                width: Get.width,
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: 3,
                    itemBuilder: (context, index){
                    return  InkWell(
                      onTap: ()async{
                        audioPlayer_for_music.stop();
                        commonController.isaudioplaying.value=false;
                        clearallmusic();
                        for(int i=0; i<snapshot.data?.docs[index]['items'].length; i++){
                          commonController.Playing_items.add(snapshot.data?.docs[index]['items'][i]);
                          commonController.TopMixes_name.add(snapshot.data?.docs[index]['Mixesname'][i]);
                          commonController.Home_Volume.add(1.0);
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 25.0,top: 8,right: 0),
                                child: Container(
                                  height: 55.h,
                                  width: 120.w,
                                  decoration: BoxDecoration(
                                      color: const Color(0xFF2A2C58),
                                      borderRadius: BorderRadius.circular(20)
                                  ),
                                  child: Padding(
                                    padding:  EdgeInsets.only(top: 13.0.sp,left: 13.sp),
                                    child: Stack(
                                      children: [
                                        Padding(
                                          padding:  EdgeInsets.only(left: 8.0.sp),
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: 35.68.w,
                                            height: 32.68.h,
                                            decoration: const ShapeDecoration(
                                              color: Color(0x4C9AC1FF),
                                              shape: OvalBorder(),
                                            ),
                                            child: SvgPicture.asset('assets/images/sea.svg'),
                                          ),
                                        ),
                                        Padding(
                                          padding:  EdgeInsets.only(left: 30.0.sp),
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: 35.68.w,
                                            height: 32.68.h,
                                            decoration: const ShapeDecoration(
                                              color: Color(0x4C9AC1FF),
                                              shape: OvalBorder(),
                                            ),
                                            child: SvgPicture.asset('assets/images/waves.svg'),
                                          ),
                                        ),
                                        Padding(
                                          padding:  EdgeInsets.only(left: 50.0.sp),
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: 35.68.w,
                                            height: 32.68.h,
                                            decoration: const ShapeDecoration(
                                              color: Color(0x4C9AC1FF),
                                              shape: OvalBorder(),
                                            ),
                                            child: SvgPicture.asset('assets/images/wind.svg'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                               Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      '${snapshot.data?.docs[index]['Name']}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontFamily: AppFonts.fontFamily,
                                        fontWeight: FontWeight.w400,
                                        height: 0.15,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      '${snapshot.data?.docs[index]['Mixesname'][0]}, ${snapshot.data?.docs[index]['Mixesname'][1]}, ${snapshot.data?.docs[index]['Mixesname'][2]}',
                                      style: TextStyle(
                                        color: Color(0xFF636598),
                                        fontSize: 7.3.sp,
                                        fontFamily: AppFonts.fontFamily,
                                        fontWeight: FontWeight.w400,
                                        height: 0.22,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                           Padding(
                            padding: EdgeInsets.only(right: 15.0.sp),
                            child: Icon(Icons.arrow_forward_ios_outlined),
                          )
                        ],
                      ),
                    );
                    }
                    ),
              );
            }else return Center(child: CircularProgressIndicator());
          })

    ],
  );
}
