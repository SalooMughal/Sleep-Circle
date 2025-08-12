
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../Controller/Common_Controller.dart';
import '../../Utlis/theme.dart';
import '../../Widgets/App_Font.dart';
import '../Home/HomeScreen.dart';
import 'Audio_Player.dart';

Widget Medication_items(List items, RxInt selectedIndex){
  CommonController commonController=Get.find<CommonController>();

  return Column(
    children: [
      SizedBox(
        height: 48.h,
        width: Get.width*0.94,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  selectedIndex.value = index;
                  print(selectedIndex);// Update the selected index
                },
                child: Obx(
                      () => IntrinsicWidth(
                    child: Container(
                      height: 48.h,
                      padding:  EdgeInsets.symmetric(horizontal: 7.5.sp),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: index == selectedIndex.value
                            ? const Color(0xFFD3FB8F)
                            : const Color(0x4C9AC1FF),
                        // Change color based on selection
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${items[index]}',
                        style: TextStyle(
                          color: index == selectedIndex.value
                              ? Colors.black
                              : Colors.white,
                          // Change color based on selection
                          fontSize:  13.5.sp,
                          fontFamily: AppFonts.fontFamily,
                          fontWeight: FontWeight.w500,
                          height: 1,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      Obx(()=>
         selectedIndex.value==0?StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Sleep Medication').snapshots(),
          builder: (context, snapshot){
            if(snapshot.hasData){
              return Padding(
                padding:  EdgeInsets.only(left: 15.0.sp,right: 15.0.sp),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 22.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap:()async{
                            if(commonController.uid.value!='abc'){
                              Map<String, dynamic> body={
                                'Icon':snapshot.data?.docs[0]['Icon'],
                                'Name':snapshot.data?.docs[0]['Name'],
                                'music':snapshot.data?.docs[0]['music'],
                                'Duration':snapshot.data?.docs[0]['duration'],
                              };
                              final response=await FirebaseFirestore.instance.collection('users').doc(commonController.uid.value).collection('Recently Played').doc();
                              response.set(body);
                            }
                              Get.bottomSheet(
                                  isScrollControlled: true,
                                  Audio_Player(musics:snapshot.data?.docs,name:snapshot.data?.docs[0]['Name'],url: snapshot.data?.docs[0]['music'],image: snapshot.data?.docs[0]['Icon'],)
                              );
                            },
                            child: Container(
                              height: Get.height * 0.2,
                              width: Get.width * 0.9,
                              decoration: BoxDecoration(

                                  borderRadius: BorderRadius.circular(10)),
                              child: Stack(
                                  children:[
                                    Container(
                                      height: Get.height * 0.2,
                                      width: Get.width * 0.9,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),  // Same as the container's borderRadius
                                        child: SvgPicture.network(
                                          '${snapshot.data?.docs[0]['Icon']}',  // Replace with your network URL for SVG
                                          fit: BoxFit.fitWidth,
                                        ),
                                      ),
                                    ),

                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Container(
                                                  width: 40,
                                                  height: 25,
                                                  alignment: Alignment.center,
                                                  padding: const EdgeInsets.symmetric(
                                                      horizontal: 8, vertical: 7),
                                                  clipBehavior: Clip.antiAlias,
                                                  decoration: ShapeDecoration(
                                                    color: const Color(0xFFD3FB8F),
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(6)),
                                                  ),
                                                  child: const Text(
                                                    'New',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 10,
                                                      fontFamily: AppFonts.fontFamily,
                                                      fontWeight: FontWeight.w500,
                                                      height: 0,
                                                    ),
                                                  )),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Container(
                                                height: 25,
                                                width: 70,
                                                decoration: BoxDecoration(
                                                    color: const Color(0xFF9BC2FF)
                                                        .withOpacity(0.3),
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        8)),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceEvenly,
                                                  children: [
                                                    Container(
                                                      alignment:
                                                      Alignment.center,
                                                      height: 15,
                                                      width: 15,
                                                      decoration: const BoxDecoration(
                                                          color: AppColor
                                                              .themeColor,
                                                          shape:
                                                          BoxShape.circle),
                                                      child: const Icon(
                                                        Icons.play_arrow,
                                                        color: Colors.black,
                                                        size: 10,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${snapshot.data?.docs[0]['duration']} min',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10,
                                                        fontFamily: AppFonts.fontFamily,
                                                        fontWeight:
                                                        FontWeight.w400,
                                                        height: 0.22,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ]
                              ),
                            ),
                          ),
                           Padding(
                            padding: EdgeInsets.only(top: 15.0),
                            child: Text(
                              '${snapshot.data?.docs[0]['Name']}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: AppFonts.fontFamily,
                                fontWeight: FontWeight.w400,
                                height: 0.15,
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 15.0),
                            child: Text(
                              'Music',
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
                    ),
                    SizedBox(
                      height: Get.height, // Adjust the height as needed
                      child: GridView.builder(
                        itemCount: snapshot.data?.docs.length, // Replace itemCount with your actual item count
                        gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 1,
                          childAspectRatio:0.80,
                          crossAxisCount: 2, // Replace crossAxisCount with your desired value
                          // Replace crossAxisSpacing with your desired value
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: GestureDetector(
                              onTap: () async{
                                if(commonController.uid.value!='abc'){
                                  Map<String, dynamic> body={
                                    'Icon':snapshot.data?.docs[index]['Icon'],
                                    'Name':snapshot.data?.docs[index]['Name'],
                                    'music':snapshot.data?.docs[index]['music'],
                                    'Duration':snapshot.data?.docs[index]['duration'],
                                  };
                                  final response=await FirebaseFirestore.instance.collection('users').doc(commonController.uid.value).collection('Recently Played').doc();
                                  response.set(body);
                                }
                                clearallmusic();
                                Get.bottomSheet(
                                    isScrollControlled: true,
                                    Audio_Player(musics:snapshot.data?.docs,name:snapshot.data?.docs[index]['Name'],url: snapshot.data?.docs[index]['music'],image: snapshot.data?.docs[index]['Icon'],)

                                );
                              },
                              child: SizedBox(
                                height: Get.height * 0.4, // Adjust the height as needed
                                width: Get.width * 0.44, // Adjust the width as needed
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: Get.height * 0.2, // Adjust the height as needed
                                          width: Get.width * 0.44, // Adjust the width as needed
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            color: const Color(0xFF2A2C58),
                                          ),
                                          child: Stack(
                                              children:[
                                                Container(
                                                  height: Get.height * 0.4, // Adjust the height as needed
                                                  width: Get.width * 0.44,
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(10),  // Same as the container's borderRadius
                                                    child: SvgPicture.network(
                                                      '${snapshot.data?.docs[index]['Icon']}',  // Replace with your network URL for SVG
                                                      fit: BoxFit.fitHeight,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 135.0,left: 5),
                                                  child: Container(
                                                    height: 25,
                                                    width: 70,
                                                    decoration: BoxDecoration(
                                                      color: const Color(0xFF9BC2FF).withOpacity(0.3),
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      children: [
                                                        Container(
                                                          alignment: Alignment.center,
                                                          height: 15,
                                                          width: 15,
                                                          decoration: const BoxDecoration(
                                                            color: AppColor.themeColor,
                                                            shape: BoxShape.circle,
                                                          ),
                                                          child: const Icon(
                                                            Icons.play_arrow,
                                                            color: Colors.black,
                                                            size: 10,
                                                          ),
                                                        ),
                                                        Text(
                                                          '${snapshot.data?.docs[index]['duration']} min',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 10,
                                                            fontFamily: AppFonts.fontFamily,
                                                            fontWeight: FontWeight.w400,
                                                            height: 0.22,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ]),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 8.0, top: 15),
                                      child: Text('${snapshot.data?.docs[index]['Name']}',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontFamily: AppFonts.fontFamily,
                                            fontWeight: FontWeight.w400,
                                            height: 0.15,
                                          )),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 8.0, top: 15),
                                      child: Text('Music',
                                          style: TextStyle(
                                            color: Color(0xFF636598),
                                            fontSize: 10,
                                            fontFamily: AppFonts.fontFamily,
                                            fontWeight: FontWeight.w400,
                                            height: 0.22,
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              );
            }else return Center(child: CircularProgressIndicator());
          },
        ):StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Guided Medication').snapshots(),
          builder: (context, snapshot){
            if(snapshot.hasData){
              return Padding(
                padding:  EdgeInsets.only(left: 15.0.sp,right: 15.0.sp),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 22.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap:()async{
                              Map<String, dynamic> body={
                                'Icon':snapshot.data?.docs[0]['Icon'],
                                'Name':snapshot.data?.docs[0]['Name'],
                                'music':snapshot.data?.docs[0]['music'],
                                'Duration':snapshot.data?.docs[0]['duration'],
                              };
                              final response=await FirebaseFirestore.instance.collection('users').doc(commonController.uid.value).collection('Recently Played').doc();
                              response.set(body);
                              Get.bottomSheet(
                                  isScrollControlled: true,
                                  Audio_Player(musics:snapshot.data?.docs,name:snapshot.data?.docs[0]['Name'],url: snapshot.data?.docs[0]['music'],image: snapshot.data?.docs[0]['Icon'],)
                              );
                            },
                            child: Container(
                              height: Get.height * 0.2,
                              width: Get.width * 0.9,
                              decoration: BoxDecoration(

                                  borderRadius: BorderRadius.circular(10)),
                              child: Stack(
                                  children:[
                                    Container(
                                      height: Get.height * 0.2,
                                      width: Get.width * 0.9,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),  // Same as the container's borderRadius
                                        child: SvgPicture.network(
                                          '${snapshot.data?.docs[0]['Icon']}',  // Replace with your network URL for SVG
                                          fit: BoxFit.fitWidth,
                                        ),
                                      ),
                                    ),

                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Container(
                                                  width: 40,
                                                  height: 25,
                                                  alignment: Alignment.center,
                                                  padding: const EdgeInsets.symmetric(
                                                      horizontal: 8, vertical: 7),
                                                  clipBehavior: Clip.antiAlias,
                                                  decoration: ShapeDecoration(
                                                    color: const Color(0xFFD3FB8F),
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(6)),
                                                  ),
                                                  child: const Text(
                                                    'New',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 10,
                                                      fontFamily: AppFonts.fontFamily,
                                                      fontWeight: FontWeight.w500,
                                                      height: 0,
                                                    ),
                                                  )),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Container(
                                                height: 25,
                                                width: 70,
                                                decoration: BoxDecoration(
                                                    color: const Color(0xFF9BC2FF)
                                                        .withOpacity(0.3),
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        8)),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceEvenly,
                                                  children: [
                                                    Container(
                                                      alignment:
                                                      Alignment.center,
                                                      height: 15,
                                                      width: 15,
                                                      decoration: const BoxDecoration(
                                                          color: AppColor
                                                              .themeColor,
                                                          shape:
                                                          BoxShape.circle),
                                                      child: const Icon(
                                                        Icons.play_arrow,
                                                        color: Colors.black,
                                                        size: 10,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${snapshot.data?.docs[0]['duration']} min',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10,
                                                        fontFamily: AppFonts.fontFamily,
                                                        fontWeight:
                                                        FontWeight.w400,
                                                        height: 0.22,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ]
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 15.0),
                            child: Text(
                              '${snapshot.data?.docs[0]['Name']}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: AppFonts.fontFamily,
                                fontWeight: FontWeight.w400,
                                height: 0.15,
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 15.0),
                            child: Text(
                              'Music',
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
                    ),
                    SizedBox(
                      height: Get.height, // Adjust the height as needed
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data?.docs.length, // Replace itemCount with your actual item count
                        gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 1,
                          childAspectRatio:0.80,
                          crossAxisCount: 2, // Replace crossAxisCount with your desired value
                          // Replace crossAxisSpacing with your desired value
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: GestureDetector(
                              onTap: () async{
                                Map<String, dynamic> body={
                                  'Icon':snapshot.data?.docs[index]['Icon'],
                                  'Name':snapshot.data?.docs[index]['Name'],
                                  'music':snapshot.data?.docs[index]['music'],
                                  'Duration':snapshot.data?.docs[index]['duration'],
                                };
                                final response=await FirebaseFirestore.instance.collection('users').doc(commonController.uid.value).collection('Recently Played').doc();
                                response.set(body);
                                clearallmusic();
                                Get.bottomSheet(
                                    isScrollControlled: true,
                                    Audio_Player(musics:snapshot.data?.docs,name:snapshot.data?.docs[index]['Name'],url: snapshot.data?.docs[index]['music'],image: snapshot.data?.docs[index]['Icon'],)

                                );
                              },
                              child: SizedBox(
                                height: Get.height * 0.4, // Adjust the height as needed
                                width: Get.width * 0.44, // Adjust the width as needed
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: Get.height * 0.2, // Adjust the height as needed
                                          width: Get.width * 0.44, // Adjust the width as needed
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            color: const Color(0xFF2A2C58),
                                          ),
                                          child: Stack(
                                              children:[
                                                Container(
                                                  height: Get.height * 0.4, // Adjust the height as needed
                                                  width: Get.width * 0.44,
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(10),  // Same as the container's borderRadius
                                                    child: SvgPicture.network(
                                                      '${snapshot.data?.docs[index]['Icon']}',  // Replace with your network URL for SVG
                                                      fit: BoxFit.fitHeight,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 135.0,left: 5),
                                                  child: Container(
                                                    height: 25,
                                                    width: 70,
                                                    decoration: BoxDecoration(
                                                      color: const Color(0xFF9BC2FF).withOpacity(0.3),
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      children: [
                                                        Container(
                                                          alignment: Alignment.center,
                                                          height: 15,
                                                          width: 15,
                                                          decoration: const BoxDecoration(
                                                            color: AppColor.themeColor,
                                                            shape: BoxShape.circle,
                                                          ),
                                                          child: const Icon(
                                                            Icons.play_arrow,
                                                            color: Colors.black,
                                                            size: 10,
                                                          ),
                                                        ),
                                                        Text(
                                                          '${snapshot.data?.docs[index]['duration']} min',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 10,
                                                            fontFamily: AppFonts.fontFamily,
                                                            fontWeight: FontWeight.w400,
                                                            height: 0.22,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ]),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 8.0, top: 15),
                                      child: Text('${snapshot.data?.docs[index]['Name']}',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontFamily: AppFonts.fontFamily,
                                            fontWeight: FontWeight.w400,
                                            height: 0.15,
                                          )),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 8.0, top: 15),
                                      child: Text('Music',
                                          style: TextStyle(
                                            color: Color(0xFF636598),
                                            fontSize: 10,
                                            fontFamily: AppFonts.fontFamily,
                                            fontWeight: FontWeight.w400,
                                            height: 0.22,
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              );
            }else return Center(child: CircularProgressIndicator());
          },
        ),
      )



    ],
  );

}