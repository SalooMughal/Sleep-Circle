import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';

import '../../Controller/Common_Controller.dart';
import '../../Widgets/App_Font.dart';
import '../../models/Music_model.dart';

class Recently_Details extends StatefulWidget {
  const Recently_Details({super.key});

  @override
  State<Recently_Details> createState() => _Recently_DetailsState();
}

class _Recently_DetailsState extends State<Recently_Details> {
  CommonController commonController=Get.find<CommonController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 10),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: const Icon(Icons.arrow_back_ios_new_rounded)),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Text(
                    'Recently Played',
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
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection('users').doc(commonController.uid.value).collection('Recently Played').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Padding(
                    padding:
                    const EdgeInsets.only(left: 20.0, right: 15, top: 20),
                    child: SizedBox(
                        height: Get.height * 0.7,
                        width: Get.width,
                        child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: snapshot.data?.docs.length,
                            itemBuilder: (context, index) {
                              RxBool isplaying = false.obs;
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
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                                borderRadius:
                                                BorderRadius.circular(10)),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  '${snapshot.data?.docs[index]['Name']}',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontFamily:
                                                    AppFonts.fontFamily,
                                                    fontWeight: FontWeight.w400,
                                                    height: 0.15,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      top: 15.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Container(
                                                        alignment:
                                                        Alignment.center,
                                                        width: 55.w,
                                                        height: 20.h,
                                                        decoration:
                                                        ShapeDecoration(
                                                          color: const Color(
                                                              0x4C9AC1FF),
                                                          shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  8)),
                                                        ),
                                                        child:  Text(
                                                          '${snapshot.data?.docs[index]['Duration']} min',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 8.sp,
                                                            fontFamily: AppFonts
                                                                .fontFamily,
                                                            fontWeight:
                                                            FontWeight.w400,
                                                            height: 0.22,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                        child: Container(
                                                          height: 5,
                                                          width: 5,
                                                          decoration:
                                                          const BoxDecoration(
                                                              color: Color(
                                                                  0x4C9AC1FF),
                                                              shape: BoxShape
                                                                  .circle),
                                                        ),
                                                      ),
                                                      const Text(
                                                        'Category',
                                                        style: TextStyle(
                                                          color:
                                                          Color(0xFF636598),
                                                          fontSize: 10,
                                                          fontFamily:
                                                          AppFonts.fontFamily,
                                                          fontWeight:
                                                          FontWeight.w400,
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
                                            : SvgPicture.asset('assets/icons/Subtract.svg',
                                              height: 40,
                                              width: 40,)
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            })),
                  );
                } else
                  return Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ),
      ),
    );
  }
}
