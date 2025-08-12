import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demoapp/models/Music_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../Controller/Common_Controller.dart';
import '../../Widgets/App_Font.dart';
import 'Daily_Picks_details.dart';

Widget Daily_Picks(){
  CommonController commonController=Get.find<CommonController>();
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(
            left: 25.0, right: 20, top: 35),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Daily Picks',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: AppFonts.fontFamily,
                fontWeight: FontWeight.w500,
                height: 0,
              ),
            ),
            Row(
              children: [
                GestureDetector(
                  onTap:(){
                    Get.to(const Daily_Picks_Detail());
  },
                  child: const Text(
                    'See All',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: AppFonts.fontFamily,
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
                const Icon((Icons.navigate_next))
              ],
            )
          ],
        ),
      ),
      SizedBox(
        height: Get.height*0.01,
      ),
      StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Daily Picks Sound').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15),
              child: SizedBox(
                height: Get.height * 0.31,
                width: Get.width,
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async{

                        Music tappedMusic = Music(
                          Icon: snapshot.data?.docs[index]['Icon'],
                          name: snapshot.data?.docs[index]['Name'],
                          url: snapshot.data?.docs[index]['music'],
                          isplaying: true, duration: snapshot.data?.docs[index]['duration'],
                        );

                        commonController.toggleMusic(tappedMusic);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 60,
                                  width: 60,
                                  child: SvgPicture.network(
                                    '${snapshot.data?.docs[index]['Icon']}',
                                    fit: BoxFit.scaleDown,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF2A2C58),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${snapshot.data?.docs[index]['Name']}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontFamily: AppFonts.fontFamily,
                                          fontWeight: FontWeight.w400,
                                          height: 0.15,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 15.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              width: 55.w,
                                              height: 20.h,
                                              decoration: ShapeDecoration(
                                                color: const Color(0x4C9AC1FF),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                              ),
                                              child: Text(
                                                '${snapshot.data?.docs[index]['duration']} min',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 8.sp,
                                                  fontFamily: AppFonts.fontFamily,
                                                  fontWeight: FontWeight.w400,
                                                  height: 0.22,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Container(
                                                height: 5,
                                                width: 5,
                                                decoration: const BoxDecoration(
                                                  color: Color(0x4C9AC1FF),
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                            ),
                                            const Text(
                                              'Category',
                                              style: TextStyle(
                                                color: Color(0xFF636598),
                                                fontSize: 10,
                                                fontFamily: AppFonts.fontFamily,
                                                fontWeight: FontWeight.w400,
                                                height: 0.22,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Obx(
                                  () => commonController.currentlyPlaying.value?.url ==
                                  snapshot.data?.docs[index]['music'] &&
                                  commonController.currentlyPlaying.value!.isplaying
                                  ? SvgPicture.asset(
                                'assets/icons/play button.svg',
                                height: 40,
                                width: 40,
                              )
                                  :SvgPicture.asset('assets/icons/Subtract.svg',
                                    height: 40,
                                    width: 40,)
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),





    ],
  );
}
