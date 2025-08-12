import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../Controller/Common_Controller.dart';
import '../../Widgets/App_Font.dart';
import '../../models/Music_model.dart';

Widget Recently_play_lib(){
  CommonController commonController=Get.find<CommonController>();
  return StreamBuilder(
    stream: FirebaseFirestore.instance
        .collection('users')
        .doc(commonController.uid.value)
        .collection('Recently Played')
        .snapshots(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      }

      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
        return Center(
          child: Text(
            'No musics yet',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF636598),
              fontSize: 14,
              fontFamily: AppFonts.fontFamily,
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
        );
      }

      return Column(
        children: [
          SizedBox(
            height: Get.height,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              physics: ScrollPhysics(),
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, index) {
                var doc = snapshot.data?.docs[index];
                var iconUrl = doc?['Icon'];
                var name = doc?['Name'];
                var duration = doc?['Duration'];
                // Extract minutes from duration (assuming duration is '0:00:55.968000')
                return GestureDetector(
                  onTap: (){
                    Music tappedMusic = Music(
                      Icon: snapshot.data?.docs[index]['Icon'],
                      name: snapshot.data?.docs[index]['Name'],
                      url: snapshot.data?.docs[index]['music'],
                      isplaying: true, duration: snapshot.data?.docs[index]['Duration'],
                    );

                    commonController.toggleMusic_forRecentlymusic(tappedMusic);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 60,
                              width: 60,
                              child: SvgPicture.network(iconUrl, fit: BoxFit.fill),
                              decoration: BoxDecoration(
                                color: const Color(0xFF2A2C58),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    name,
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
                                          width: 60.w,
                                          height: 22,
                                          decoration: ShapeDecoration(
                                            color: const Color(0x4C9AC1FF),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                          ),
                                          child: Text(
                                            '${duration} min',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
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
                                        Text(
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
                                  )
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
                              : Obx(
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
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      );
    },
  );
}