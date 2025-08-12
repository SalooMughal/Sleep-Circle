

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demoapp/Controller/Common_Controller.dart';
import 'package:demoapp/Widgets/Widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../Widgets/App_Font.dart';
import '../../models/Music_model.dart';
import '../Home/HomeScreen.dart';
import '../Sounds/Snooze_Items.dart';

void add_to_playlist_sheet() {
  List Mixes_items = ['City Voices', 'Forest'];
  CommonController commonController = Get.find<CommonController>();
  Get.bottomSheet(
    Container(
      height: Get.height * 1.5,
      decoration: BoxDecoration(
          color: const Color(0xFF2A2C58),
          borderRadius: BorderRadius.circular(25)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: Get.height * 0.05,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: Color(0xFFE1E2F7),
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    height: 0.15,
                  ),
                ),
              ),
              const Text(
                'Add to Playlist',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFD3FB8F),
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
              ),
              const Icon(Icons.add)
            ],
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(commonController.uid.value)
                .collection('Favourites')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding:
                      const EdgeInsets.only(top: 20.0, left: 25.0, right: 20.0),
                  child: SizedBox(
                    height: Get.height * 0.2,
                    child: ListView.builder(
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (context, index) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {},
                                    child: Card(
                                      color: const Color(0xFF2A2C58),
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: Get.height * 0.08,
                                        width: Get.width * 0.33,
                                        decoration: ShapeDecoration(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                        ),
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Positioned(
                                              top: Get.height / 55,
                                              left: 20,
                                              child: Container(
                                                alignment: Alignment.center,
                                                width: 40.68,
                                                height: 40.68,
                                                decoration:
                                                    const ShapeDecoration(
                                                  color: Color(0x4C9AC1FF),
                                                  shape: OvalBorder(),
                                                ),
                                                child: SvgPicture.asset(
                                                    'assets/images/sea.svg'),
                                              ),
                                            ),
                                            Positioned(
                                              top: Get.height / 55,
                                              left: 50,
                                              child: Container(
                                                alignment: Alignment.center,
                                                width: 40.68,
                                                height: 40.68,
                                                decoration:
                                                    const ShapeDecoration(
                                                  color: Color(0x4C9AC1FF),
                                                  shape: OvalBorder(),
                                                ),
                                                child: SvgPicture.asset(
                                                    'assets/images/waves.svg'),
                                              ),
                                            ),
                                            Positioned(
                                              top: Get.height / 55,
                                              left: 80,
                                              child: Container(
                                                alignment: Alignment.center,
                                                width: 40.68,
                                                height: 40.68,
                                                decoration:
                                                    const ShapeDecoration(
                                                  color: Color(0x4C9AC1FF),
                                                  shape: OvalBorder(),
                                                ),
                                                child: SvgPicture.asset(
                                                    'assets/images/wind.svg'),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          '${Mixes_items[index]}',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontFamily: AppFonts.fontFamily,
                                            fontWeight: FontWeight.w400,
                                            height: 0.15,
                                          ),
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'Waves, Wind, Sea',
                                          style: TextStyle(
                                            color: Color(0xFF636598),
                                            fontSize: 10,
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
                            ],
                          );
                        }),
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          )
        ],
      ),
    ),
    backgroundColor: Colors.transparent,
  );
}
void share_sheet() {
  Get.bottomSheet(
      Container(
        height: Get.height * 1.5,
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
                  'Share',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFD3FB8F),
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Get.height * 0.05,
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(29.71),
              ),
              color: const Color(0xFF2A2C58),
              child: Container(
                alignment: Alignment.center,
                height: Get.height * 0.12,
                width: Get.width * 0.52,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(29.71),
                  ),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      top: Get.height / 55,
                      left: Get.width * 0.04,
                      child: Container(
                        alignment: Alignment.center,
                        width: Get.width * 0.18,
                        height: Get.height * 0.08,
                        decoration: const ShapeDecoration(
                          color: Color(0x4C9AC1FF),
                          shape: OvalBorder(),
                        ),
                        child: SvgPicture.asset(
                          'assets/images/sea.svg',
                          height: 50,
                        ),
                      ),
                    ),
                    Positioned(
                      top: Get.height / 55,
                      left: Get.width * 0.17,
                      child: Container(
                        alignment: Alignment.center,
                        width: Get.width * 0.18,
                        height: Get.height * 0.08,
                        decoration: const ShapeDecoration(
                          color: Color(0x4C9AC1FF),
                          shape: OvalBorder(),
                        ),
                        child: SvgPicture.asset(
                          'assets/images/waves.svg',
                          height: 50,
                        ),
                      ),
                    ),
                    Positioned(
                      top: Get.height / 55,
                      left: Get.width * 0.304,
                      child: Container(
                        alignment: Alignment.center,
                        width: Get.width * 0.18,
                        height: Get.height * 0.08,
                        decoration: const ShapeDecoration(
                          color: Color(0x4C9AC1FF),
                          shape: OvalBorder(),
                        ),
                        child: SvgPicture.asset(
                          'assets/images/wind.svg',
                          height: 50,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: Get.height * 0.05,
            ),
            SizedBox(
              height: Get.height * 0.1,
              width: Get.width * 0.65,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 54,
                    height: 54,
                    alignment: Alignment.center,
                    decoration: const ShapeDecoration(
                      color: Color(0x4C9AC1FF),
                      shape: OvalBorder(),
                    ),
                    child: SvgPicture.asset('assets/icons/Facebook.svg'),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 54,
                    height: 54,
                    decoration: const ShapeDecoration(
                      color: Color(0x4C9AC1FF),
                      shape: OvalBorder(),
                    ),
                    child: SvgPicture.asset('assets/icons/Whatsapp.svg'),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 54,
                    height: 54,
                    decoration: const ShapeDecoration(
                      color: Color(0x4C9AC1FF),
                      shape: OvalBorder(),
                    ),
                    child: SvgPicture.asset('assets/icons/Messenger.svg'),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Get.height * 0.07,
              width: Get.width * 0.65,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 54,
                    height: 54,
                    alignment: Alignment.center,
                    decoration: const ShapeDecoration(
                      color: Color(0x4C9AC1FF),
                      shape: OvalBorder(),
                    ),
                    child: SvgPicture.asset('assets/icons/mail.svg'),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 54,
                    height: 54,
                    decoration: const ShapeDecoration(
                      color: Color(0x4C9AC1FF),
                      shape: OvalBorder(),
                    ),
                    child: SvgPicture.asset('assets/icons/link.svg'),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 54,
                    height: 54,
                    decoration: const ShapeDecoration(
                      color: Color(0x4C9AC1FF),
                      shape: OvalBorder(),
                    ),
                    child: SvgPicture.asset('assets/icons/more_horiz.svg'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      backgroundColor: Colors.black);
}

void unlike_bottom_sheet(String uid, BuildContext context) {
  CommonController commonController = Get.find<CommonController>();

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
                'Delete Favourite Mix',
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
                'mix?',
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
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(commonController.uid.value)
                          .collection('Favourites')
                          .doc(uid)
                          .delete()
                          .then((value) {
                        Get.snackbar('Deleted', 'Favorite Mix deleted successfully',
                            snackPosition: SnackPosition.TOP);
                        commonController.playaudiofav.clear();

                      });
                      Navigator.of(context).pop(); // Navigate back after snackbar is shown

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

void rename_bottom_sheet(String uid) {
  TextEditingController renamecontroller=TextEditingController();
  CommonController commonController=Get.find<CommonController>();

  Get.bottomSheet(
    Container(
      height: Get.height * 0.4,
      decoration: BoxDecoration(
          color: const Color(0xFF2A2C58),
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
                'Name your snooze mix',
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
            height: Get.height * 0.02,
          ),
          SizedBox(
              width: Get.width * 0.85,
              child: TextFormField(
                controller: renamecontroller,
                decoration: const InputDecoration(
                    hintStyle: TextStyle(
                      color: Color(0xFF636598),
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      height: 0.09,
                    ),
                    hintText: 'SnoozeSage'),
              )),
          SizedBox(
            height: Get.height * 0.08,
          ),
          GestureDetector(
              onTap: () {
                Map<String , dynamic> body={
                  'Mixes_Name':renamecontroller.text.toString(),
                  'Audio_url':commonController.playaudiofav.value,
                  'Audio_name':commonController.Audio_name_fav.value,
                  'uid':uid,
                };
                FirebaseFirestore.instance.collection('users').doc(commonController.uid.value).collection('Favourites').doc(uid).update(body);
                Get.back();
              },
              child: Application_Button('SAVE'))
        ],
      ),
    ),
    backgroundColor: Colors.transparent,
  );
}

Widget Description_items(String title, String uid, BuildContext context) {
  return Container(
    height: Get.height * 0.4,
    decoration: BoxDecoration(
        color: const Color(0xFF1D2046),
        borderRadius: BorderRadius.circular(20)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFFD3FB8F),
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
              ),
              // SvgPicture.asset('assets/icons/close.svg')
            ],
          ),
        ),
        SizedBox(
          height: Get.height * 0.04,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  unlike_bottom_sheet( uid,context);
                },
                child: ListTile(
                  leading: SvgPicture.asset('assets/icons/favorite.svg'),
                  title: const Text(
                    'Unlike',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      height: 0.11,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  rename_bottom_sheet(uid);
                },
                child: ListTile(
                  leading: SvgPicture.asset(
                      'assets/icons/drive_file_rename_outline.svg'),
                  title: const Text(
                    'Rename',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      height: 0.11,
                    ),
                  ),
                ),
              ),
              // GestureDetector(
              //   onTap: () {
              //     add_to_playlist_sheet();
              //   },
              //   child: ListTile(
              //     leading: SvgPicture.asset('assets/icons/queue_music.svg'),
              //     title: const Text(
              //       'Add to Playlist',
              //       style: TextStyle(
              //         color: Colors.white,
              //         fontSize: 14,
              //         fontFamily: 'Poppins',
              //         fontWeight: FontWeight.w400,
              //         height: 0.11,
              //       ),
              //     ),
              //   ),
              // ),
              GestureDetector(
                onTap: () {
                  share_sheet();
                },
                child: ListTile(
                  leading: SvgPicture.asset('assets/icons/share (2).svg'),
                  title: const Text(
                    'Share',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      height: 0.11,
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    ),
  );
}

Widget Favourites(List Mixes_title, RxInt selectedindex) {
  print(selectedindex);
  CommonController commonController = Get.find<CommonController>();
  return Obx(()=>
    Column(
      children: [
        selectedindex.value==0?StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(commonController.uid.value)
              .collection('Favourites')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return snapshot.data!.docs.isEmpty?const Center(child: Column(
                children: [
                  Text(
                    'No Favourites yet',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF636598),
                      fontSize: 14,
                      fontFamily: AppFonts.fontFamily,
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ],
              ),):SizedBox(
                            height: Get.height ,
                            child: ListView.builder(
                                itemCount: snapshot.data?.docs.length,
                                itemBuilder: (context, index) {
                                  List items=[];
                                  if(snapshot.data?.docs[index]['Category']=='Music'){
                                    var duration = snapshot.data?.docs[index]['duration'];
                                    String minutes = duration.split('.').first;
                                    return GestureDetector(
                                      onTap: (){
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
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  height: 55.h,
                                                  width: 70.w,
                                                  child: ClipRRect(
                                                    borderRadius:  BorderRadius.circular(10),
                                                    child: SvgPicture.network(
                                                      '${snapshot.data?.docs[index]['Icon']}',
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  decoration: BoxDecoration(
                                                      color: const Color(0xFF2A2C58),
                                                      borderRadius:
                                                      BorderRadius.circular(20)),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(20),
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
                                                              width: 60.w,
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
                                                                '${minutes} min',
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
                                  }
                                  else {
                                    for(int i=0; i<snapshot.data?.docs[index]['Audio_name'].length; i++){
                                      items.add(snapshot.data?.docs[index]['Audio_name'][i]);
                                    }
                                    return SizedBox();
                                  }
                                }),
                          );
            } else {
              return const Center(child: SizedBox());
            }
          },
        ):SizedBox(),
        selectedindex.value==1?StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(commonController.uid.value)
              .collection('Favourites')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return snapshot.data!.docs.isEmpty?const Center(child: Column(
                children: [
                  Text(
                    'No Favourites yet',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF636598),
                      fontSize: 14,
                      fontFamily: AppFonts.fontFamily,
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ],
              ),):SizedBox(
                height: Get.height ,
                child: ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      List items=[];

                      if(snapshot.data?.docs[index]['Category']=='Music'){
                        return SizedBox();
                      }
                      else {
                        for(int i=0; i<snapshot.data?.docs[index]['Audio_name'].length; i++){
                          items.add(snapshot.data?.docs[index]['Audio_name'][i]);
                        }
                        return  InkWell(
                          onTap: ()async {
                            clearallmusic();
                            for (int i = 0; i < snapshot.data?.docs[index]['Audio_url'].length; i++) {
                              commonController.playaudiofav.add('${snapshot.data?.docs[index]['Audio_url'][i]}');
                              commonController.volumes_fav.add(1.0);
                            }
                            for (int i = 0; i < snapshot.data?.docs[index]['Audio_name'].length; i++) {
                              commonController.Audio_name_fav.add('${snapshot.data?.docs[index]['Audio_name'][i]}');
                              commonController.volumes_fav.add(1.0);
                            }

                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, top: 8, right: 10),
                                    child: Container(
                                      height: 55.h,
                                      width: 120.w,
                                      decoration: BoxDecoration(
                                          color: const Color(0xFF2A2C58),
                                          borderRadius: BorderRadius.circular(20)),
                                      child: Padding(
                                        padding:  EdgeInsets.only(top: 13.0.sp,left: 13.sp),
                                        child: Stack(
                                          children: [
                                            Padding(
                                              padding:  EdgeInsets.only(left: 8.0.sp),                                          child: Container(
                                              alignment: Alignment.center,
                                              width: 35.68.w,
                                              height: 32.68.h,
                                              decoration: const ShapeDecoration(
                                                color: Color(0x4C9AC1FF),
                                                shape: OvalBorder(),
                                              ),
                                              child: SvgPicture.asset(
                                                  'assets/images/sea.svg'),
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
                                                child: SvgPicture.asset(
                                                    'assets/images/waves.svg'),
                                              ),
                                            ),
                                            Padding(
                                              padding:  EdgeInsets.only(left: 50.0.sp),                                          child: Container(
                                              alignment: Alignment.center,
                                              width: 35.68.w,
                                              height: 32.68.h,
                                              decoration: const ShapeDecoration(
                                                color: Color(0x4C9AC1FF),
                                                shape: OvalBorder(),
                                              ),
                                              child: SvgPicture.asset(
                                                  'assets/images/wind.svg'),
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
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          '${snapshot.data?.docs[index]['Mixes_Name']}',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontFamily: AppFonts.fontFamily,
                                            fontWeight: FontWeight.w400,
                                            height: 0.15,
                                          ),
                                        ),
                                      ),
                                      SingleChildScrollView(
                                        scrollDirection:Axis.horizontal,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Container(
                                                height: 20,
                                                width:Get.width*0.45,
                                                child: ListView.builder(
                                                  scrollDirection: Axis.horizontal,
                                                  itemCount:  items.length,
                                                  itemBuilder: (BuildContext context, int index) {

                                                    return Padding(
                                                      padding: const EdgeInsets.only(top: 2.0),
                                                      child: Text(
                                                        '${items[index]}, ',
                                                        style: TextStyle(
                                                          color: Color(0xFF636598),
                                                          fontSize: 10.5.sp,
                                                          fontFamily: AppFonts.fontFamily,
                                                          fontWeight: FontWeight.w400,
                                                          height: 0.5,
                                                        ),
                                                      ),
                                                    );
                                                  },

                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  print('===');

                                  for (int i = 0; i < snapshot.data?.docs[index]['Audio_url'].length; i++) {
                                    commonController.playaudiofav.add('${snapshot.data?.docs[index]['Audio_url'][i]}');
                                    commonController.volumes_fav.add(1.0);
                                  }
                                  for (int i = 0; i < snapshot.data?.docs[index]['Audio_name'].length; i++) {
                                    commonController.Audio_name_fav.add('${snapshot.data?.docs[index]['Audio_name'][i]}');
                                    commonController.volumes_fav.add(1.0);
                                  }
                                  Get.bottomSheet(
                                      isScrollControlled: true,
                                      Description_items(snapshot.data?.docs[index]['Mixes_Name'], snapshot.data?.docs[index]['uid'],context));
                                },
                                child: Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: SvgPicture.asset(
                                        'assets/images/Vector (4).svg')),
                              )
                            ],
                          ),
                        );
                      }
                    }),
              );
            } else {
              return const Center(child: SizedBox());
            }
          },
        ):SizedBox(),
      ],
    ),
  );
}
