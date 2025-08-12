import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../Utlis/theme.dart';
import '../../Widgets/App_Font.dart';
import '../Home/HomeScreen.dart';
import 'Audio_Player.dart';

class Top_Rated_Detail_Screen extends StatefulWidget {
  const Top_Rated_Detail_Screen({super.key});

  @override
  State<Top_Rated_Detail_Screen> createState() => _Top_Rated_Detail_ScreenState();
}

class _Top_Rated_Detail_ScreenState extends State<Top_Rated_Detail_Screen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: (){
                      Get.back();
                    },
                      child: const Icon(Icons.arrow_back_ios_new_rounded)),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Top Rated this Week',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: AppFonts.fontFamily,
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection('Top rated Sound').snapshots(),
              builder: (context, snapshot){
                if(snapshot.hasData){
                  return Expanded(
                    child: Container(
                      width: Get.width*0.95,
                      child: ListView.builder(
                          itemCount: snapshot.data?.docs.length,
                          itemBuilder: (context, index){
                            return   Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: GestureDetector(
                                onTap: (){
                                  clearallmusic();
                                  Get.bottomSheet(
                                      isScrollControlled: true,
                                      Audio_Player(musics:snapshot.data?.docs,name:snapshot.data?.docs[index]['Name'],url: snapshot.data?.docs[index]['music'],image: snapshot.data?.docs[index]['Icon'],)
                                  );
                                },
                                child: Container(
                                  height: Get.height*0.15,
                                  width: Get.width*0.94,
                                  decoration: BoxDecoration(
                                      color: const Color(0xFF2A2C58),
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: 150.h,
                                          width: 150.w,
                                          child: ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: SvgPicture.network('${snapshot.data?.docs[index]['Icon']}',fit: BoxFit.fitWidth,)),
                                          decoration: BoxDecoration(
                                              color: const Color(0xFF343666),
                                              borderRadius: BorderRadius.circular(10)
                                          ),
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                           Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(top: 0.0),
                                                child: Text(
                                                  'Category',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Color(0xFF7181BA),
                                                    fontSize: 13,
                                                    fontFamily: AppFonts.fontFamily,
                                                    fontWeight: FontWeight.w400,
                                                    height: 0.34,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(top: 20.0),
                                                child: Text(
                                                  '${snapshot.data?.docs[index]["Name"]}',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 11.sp,
                                                    fontFamily: AppFonts.fontFamily,
                                                    fontWeight: FontWeight.w500,
                                                    height: 0.10,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),

                                          Container(
                                            height: 25,
                                            width: 70,
                                            decoration: BoxDecoration(
                                                color: const Color(0xFF9BC2FF)
                                                    .withOpacity(0.3),
                                                borderRadius:
                                                BorderRadius.circular(8)),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Container(
                                                  alignment: Alignment.center,
                                                  height: 15,
                                                  width: 15,
                                                  decoration: const BoxDecoration(
                                                      color: AppColor.themeColor,
                                                      shape: BoxShape.circle),
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
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  );
                }else return Center(child: CircularProgressIndicator());
              },
            )

          ],
        ),
      ),
    );
  }
}
