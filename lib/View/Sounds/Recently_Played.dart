import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demoapp/Utlis/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../Controller/Common_Controller.dart';
import '../../Widgets/App_Font.dart';
import 'Audio_Player.dart';
import 'Daily_Picks_details.dart';
import 'Recently_Details.dart';

Widget Recently_Played(){
  CommonController commonController=Get.find<CommonController>();

  return StreamBuilder(
    stream: FirebaseFirestore.instance.collection('users').doc(commonController.uid.value).collection('Recently Played').snapshots(),
    builder: (context, snapshot){
      if(snapshot.hasData&&snapshot.data!.docs.length>0){
        return  Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 25.0, right: 20, top: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Recently Played',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: AppFonts.fontFamily,
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.to(const Recently_Details());
                    },
                    child: const Row(
                      children: [
                        Text(
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
                        Icon((Icons.navigate_next))
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: Get.height*0.01,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: [
                    SizedBox(
                      height: Get.height * 0.2,
                      width: Get.width,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data?.docs.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: (){
                                Get.bottomSheet(
                                    isScrollControlled: true,
                                    Audio_Player(musics:snapshot.data?.docs,name:snapshot.data?.docs[index]['Name'],url: snapshot.data?.docs[index]['music'],image: snapshot.data?.docs[index]['Icon'],)
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: Get.height * 0.2,
                                  width: Get.width * 0.35,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Stack(
                                        children:[
                                          Container(
                                            height: Get.height * 0.15,
                                            width: Get.width * 0.35,
                                            child: SvgPicture.network(snapshot.data?.docs[index]['Icon'],
                                            fit: BoxFit.fill,),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(20),
                                              color: const Color(0xFF2A2C58),
                                            ),
                                          ),
                                          Container(
                                          height: Get.height * 0.15,
                                          width: Get.width * 0.35,
                                          alignment: Alignment.bottomLeft,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(20),
                                          ),
                                          child:    Padding(
                                            padding: const EdgeInsets.only(bottom: 8.0,left: 8),
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: 25,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                  color: const Color(0x4C9AC1FF),
                                                  borderRadius: BorderRadius.circular(10)
                                              ),
                                              child: Container(
                                                height: 15,
                                                width: 25,
                                                alignment: Alignment.center,
                                                decoration: const BoxDecoration(
                                                    color: AppColor.themeColor,
                                                    shape: BoxShape.circle
                                                ),
                                                child: const Icon(Icons.play_arrow,
                                                  size: 12,
                                                  color: Colors.black,),
                                              ),
                                            ),
                                          ),
                                        )
                                        ],
                                      ),
                                       Padding(
                                        padding: EdgeInsets.only(
                                            left: 8.0),
                                        child: Text('${snapshot.data?.docs[index]['Name']}',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontFamily: AppFonts.fontFamily,
                                              fontWeight: FontWeight.w400,
                                              height: 0.15,
                                            )),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            left: 8.0),
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
                          }),
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      }else return SizedBox();
    },
  );
}
