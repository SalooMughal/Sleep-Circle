import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demoapp/View/Home/HomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../Controller/Common_Controller.dart';
import '../../Widgets/App_Font.dart';
import '../../models/Music_model.dart';
import '../Sounds/Audio_Player.dart';

Widget Playlist() {
  CommonController commonController = Get.find<CommonController>();

  return StreamBuilder(
    stream: FirebaseFirestore.instance
        .collection('users')
        .doc(commonController.uid.value)
        .collection('Playlist')
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
            height: Get.height * 0.6,
            child: ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (contextt, index) {
                var doc = snapshot.data?.docs[index];
                var iconUrl = doc?['Icon'];
                var name = doc?['Name'];
                var duration = doc?['duration'];
                String uid=doc?['uid'];

                // Extract minutes from duration (assuming duration is '0:00:55.968000')
                String minutes = duration.split('.').first;

                return GestureDetector(
                  onTap: (){
                    Get.bottomSheet(
                        isScrollControlled: true,
                        Audio_Player(musics:snapshot.data?.docs,name:snapshot.data?.docs[index]['Name'],url: snapshot.data?.docs[index]['music'],image: snapshot.data?.docs[index]['Icon'],)
                    );
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
                              width: 100.w,
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
                                            '${minutes} min',
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
                        GestureDetector(
                          onTap: (){
                            deleteplaylist(uid,context);
                          },
                          child: Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: SvgPicture.asset(
                                  'assets/images/Vector (4).svg')),
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

void deleteplaylist(String uid, BuildContext context){
    Get.bottomSheet(
    Container(
      height: Get.height * 0.4,
      decoration: BoxDecoration(
          color: const Color(0xFF1D2046),
          borderRadius: BorderRadius.circular(25)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: Get.height * 0.05,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Delete',
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
          SizedBox(
            height: Get.height * 0.05,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Are you sure you want to delete this',
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
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'from playlist mix?',
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
          SizedBox(
            height: Get.height * 0.03,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    width: Get.width * 0.4,
                    height: Get.height * 0.06,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF2A2C58),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            width: 1, color: Color(0xFFD3FB8F)),
                        borderRadius: BorderRadius.circular(80),
                      ),
                    ),
                    child: const Row(
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
                    onTap: () async {
                      await FirebaseFirestore.instance.collection('users').doc(commonController.uid.value).collection('Playlist').doc(uid).delete().then((value) {
                        Get.snackbar('Deleted', 'Music  deleted from playlist successfully',
                            snackPosition: SnackPosition.TOP);
                      }).onError((error, stackTrace) {
                        Get.snackbar('Error', '$error',
                            snackPosition: SnackPosition.TOP);
                      });
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: Get.width * 0.4,
                      height: Get.height * 0.06,
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFD3FB8F),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80),
                        ),
                      ),
                      child: const Row(
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