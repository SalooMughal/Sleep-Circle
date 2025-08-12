import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../Controller/Common_Controller.dart';
import '../../Utlis/theme.dart';
import '../../Widgets/App_Font.dart';
import 'Audio_Player.dart';
import 'Sound_Screen.dart';


Widget Sleeping_Medication(){
  CommonController commonController=Get.find<CommonController>();

  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(
            left: 25.0, right: 20, top: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Sleeping Medication',
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
                    commonController.selectedIndex.value=2;
                    commonController.Selectedcat.value='Medication';},
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
        stream: FirebaseFirestore.instance.collection('Sleep Medication').snapshots(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Row(
                  children: [
                    SizedBox(
                      height: Get.height * 0.25,
                      width: Get.width,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: ()async{
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
                                Get.bottomSheet(
                                    isScrollControlled: true,
                                    Audio_Player(musics:snapshot.data?.docs,name:snapshot.data?.docs[index]['Name'],url: snapshot.data?.docs[index]['music'],image: snapshot.data?.docs[index]['Icon'],)
                                );
                              },
                              child: SizedBox(
                                height: Get.height * 0.25,
                                width: Get.width * 0.4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          height: Get.height * 0.19,
                                          width: Get.width * 0.37,
                                          child: SvgPicture.network('${snapshot.data?.docs[index]['Icon']}'),
                                        ),
                                        Container(
                                        alignment: Alignment.bottomLeft,
                                        height: Get.height * 0.19,
                                        width: Get.width * 0.37,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(20),
                                        ),
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.all(8.0),
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
                                                const Text(
                                                  '30 min',
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
                                        ),
                                      ),
                                    ]),
                                    const Padding(
                                      padding: EdgeInsets.only(
                                          left: 8.0, top: 4),
                                      child: Text('Keep on moving',
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
                                          left: 8.0, top: 7),
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
                            );
                          }),
                    )
                  ],
                ),
              ),
            );
          }else return Center(child: CircularProgressIndicator());
        },

      ),
    ],
  );
}