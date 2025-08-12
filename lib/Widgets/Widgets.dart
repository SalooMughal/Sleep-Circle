import 'dart:async';

import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/route_manager.dart';
import 'package:get/utils.dart';

import '../Utlis/theme.dart';
import '../View/Home/HomeScreen.dart';
import '../models/Icons_model.dart';
import 'App_Font.dart';
Widget? Create_new_bottom_sheet() {
  TextEditingController name=TextEditingController();
  Get.bottomSheet(
    Container(
      height: Get.height * 0.45,
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
                'Create New Tag',
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 50,
                height: 50,
                alignment: Alignment.center,
                decoration:
                const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF636598),
                ),
                child: SvgPicture.asset(
                  'assets/Sleep_notes_icons/star.svg',
                  color: Colors.white,
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
                controller: name,
                decoration: const InputDecoration(
                    hintStyle: TextStyle(
                      color: Color(0xFF636598),
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      height: 0.09,
                    ),
                    hintText: 'Enter the nme of the tag'),
              )),
          SizedBox(
            height: Get.height * 0.08,
          ),
          GestureDetector(
              onTap: () {
                commonController.add_new.add(Icons_model(title: '${name.text.toString()}',images: 'assets/Sleep_notes_icons/star.svg'));
                Get.back();
              },
              child: Application_Button('SAVE'))
        ],
      ),
    ),
    backgroundColor: Colors.transparent,
  );
}
Widget? Sleep_notes_bottom_sheet( RxInt selectedindex_feelnow, RxInt selectedindex_sleepactivities, RxInt selectedindex_environement, RxBool isquit, Future<void> Function() stop,  StreamSubscription<AlarmSettings>? subscription, context) {
  List feelnow=[];
  List PreActivities=[];
  List Enviornment=[];
  Get.bottomSheet(
    isScrollControlled: true,
    Container(
      height: Get.height * 0.9, // Adjust height as needed
      decoration: BoxDecoration(
        color: const Color(0xFF2A2C58),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0,right: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: Get.height * 0.05,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Add Sleep Note',
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
              const Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text(
                  'How do you feel now?',
                  style: TextStyle(
                    color: Color(0xFFE1E2F7),
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    height: 0.09,
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              SizedBox(
                height: Get.height * 0.22,
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(0.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, // Number of columns
                    mainAxisSpacing: 0.0, // Spacing between rows
                    // Spacing between columns
                    childAspectRatio: 0.85, // Adjust as needed
                  ),
                  itemCount: feel_now.length, // Number of items in the grid
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap:(){
                            feelnow.clear();
                            feelnow.add(Icons_model(title: feel_now[index].title,images: feel_now[index].images));
                            selectedindex_feelnow.value=index;
                          },
                          child: Obx(()=>
                              Container(
                                width: 62,
                                height: 62,
                                alignment: Alignment.center,
                                decoration:selectedindex_feelnow.value==index
                                    ? const ShapeDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment(0.81, -0.59),
                                    end: Alignment(-0.81, 0.59),
                                    colors: [
                                      Color(0xFFEFFFD5),
                                      Color(0xFFE0FFAC),
                                      Color(0xFFBEFF51),
                                      Color(0xFF7D9554)
                                    ],
                                  ),
                                  shape: OvalBorder(),
                                )
                                    : const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF636598),
                                ),
                                child: SvgPicture.asset(
                                  '${feel_now[index].images}',
                                  color: selectedindex_feelnow.value==index ? Colors.black : Colors.white,
                                ),
                              ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Text(
                            '${feel_now[index].title}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              height: 0.29,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text(
                  'Pre-sleep Activities',
                  style: TextStyle(
                    color: Color(0xFFE1E2F7),
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    height: 0.09,
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              SizedBox(
                height: Get.height * 0.37,
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(0.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, // Number of columns
                    mainAxisSpacing: 0.0, // Spacing between rows
                    crossAxisSpacing: 10.0, // Spacing between columns
                    childAspectRatio: 0.85, // Adjust as needed
                  ),
                  itemCount: Pre_sleep_Activites.length, // Number of items in the grid
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap:(){
                            PreActivities.clear();
                            PreActivities.add(Icons_model(images:Pre_sleep_Activites[index].images,title: Pre_sleep_Activites[index].title ));

                            selectedindex_sleepactivities.value=index;
                          },
                          child: Obx(()=>
                              Container(
                                width: 62,
                                height: 62,
                                alignment: Alignment.center,
                                decoration: selectedindex_sleepactivities.value==index
                                    ? const ShapeDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment(0.81, -0.59),
                                    end: Alignment(-0.81, 0.59),
                                    colors: [
                                      Color(0xFFEFFFD5),
                                      Color(0xFFE0FFAC),
                                      Color(0xFFBEFF51),
                                      Color(0xFF7D9554)
                                    ],
                                  ),
                                  shape: OvalBorder(),
                                )
                                    : const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF636598),
                                ),
                                child: SvgPicture.asset(
                                  '${Pre_sleep_Activites[index].images}',
                                  color:   selectedindex_sleepactivities.value==index ? Colors.black : Colors.white,
                                ),
                              ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Text(
                            '${Pre_sleep_Activites[index].title}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              height: 0.29,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              const Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text(
                  'Environment',
                  style: TextStyle(
                    color: Color(0xFFE1E2F7),
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    height: 0.09,
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              SizedBox(
                height: Get.height * 0.1,
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),

                  padding: const EdgeInsets.all(0.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, // Number of columns
                    mainAxisSpacing: 0.0, // Spacing between rows
                    crossAxisSpacing: 10.0, // Spacing between columns
                    childAspectRatio: 0.85, // Adjust as needed
                  ),
                  itemCount: Enivornment.length, // Number of items in the grid
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap:(){
                            Enviornment.add(Icons_model(images:Enivornment[index].images,title: Enivornment[index].title ));
                            selectedindex_environement.value=index;
                          },
                          child: Obx(()=>
                              Container(
                                width: 62,
                                height: 62,
                                alignment: Alignment.center,
                                decoration:  selectedindex_environement.value==index
                                    ? const ShapeDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment(0.81, -0.59),
                                    end: Alignment(-0.81, 0.59),
                                    colors: [
                                      Color(0xFFEFFFD5),
                                      Color(0xFFE0FFAC),
                                      Color(0xFFBEFF51),
                                      Color(0xFF7D9554)
                                    ],
                                  ),
                                  shape: OvalBorder(),
                                )
                                    : const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF636598),
                                ),
                                child: SvgPicture.asset(
                                  '${Enivornment[index].images}',
                                  color:  selectedindex_environement.value==index ? Colors.black : Colors.white,
                                ),
                              ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Text(
                            '${Enivornment[index].title}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              height: 0.29,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text(
                  "Today's",
                  style: TextStyle(
                    color: Color(0xFFE1E2F7),
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    height: 0.09,
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              // SizedBox(
              //   height: Get.height * 0.1,
              //   child: GridView.builder(
              //     physics: const NeverScrollableScrollPhysics(),
              //
              //     padding: const EdgeInsets.all(0.0),
              //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //       crossAxisCount: 4, // Number of columns
              //       mainAxisSpacing: 0.0, // Spacing between rows
              //       crossAxisSpacing: 10.0, // Spacing between columns
              //       childAspectRatio: 0.85, // Adjust as needed
              //     ),
              //     itemCount:Todays.length, // Number of items in the grid
              //     itemBuilder: (context, index) {
              //       return Column(
              //         children: [
              //           Container(
              //             width: 62,
              //             height: 62,
              //             alignment: Alignment.center,
              //             decoration: index == 0
              //                 ? const ShapeDecoration(
              //               gradient: LinearGradient(
              //                 begin: Alignment(0.81, -0.59),
              //                 end: Alignment(-0.81, 0.59),
              //                 colors: [
              //                   Color(0xFFEFFFD5),
              //                   Color(0xFFE0FFAC),
              //                   Color(0xFFBEFF51),
              //                   Color(0xFF7D9554)
              //                 ],
              //               ),
              //               shape: OvalBorder(),
              //             )
              //                 : const BoxDecoration(
              //               shape: BoxShape.circle,
              //               color: Color(0xFF636598),
              //             ),
              //             child: SvgPicture.asset(
              //               '${Todays[index].images}',
              //               color: index == 0 ? Colors.black : Colors.white,
              //             ),
              //           ),
              //           Padding(
              //             padding: const EdgeInsets.only(top: 15.0),
              //             child: Text(
              //               '${Todays[index].title}',
              //               textAlign: TextAlign.center,
              //               style: const TextStyle(
              //                 color: Colors.white,
              //                 fontSize: 10,
              //                 fontFamily: 'Poppins',
              //                 fontWeight: FontWeight.w400,
              //                 height: 0.29,
              //               ),
              //             ),
              //           ),
              //         ],
              //       );
              //     },
              //   ),
              // ),
              // SizedBox(
              //   height: Get.height * 0.03,
              // ),
              // const Padding(
              //   padding: EdgeInsets.only(left: 15.0),
              //   child: Text(
              //     "Today's",
              //     style: TextStyle(
              //       color: Color(0xFFE1E2F7),
              //       fontSize: 16,
              //       fontFamily: 'Poppins',
              //       fontWeight: FontWeight.w500,
              //       height: 0.09,
              //     ),
              //   ),
              // ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              Obx(()=>
                 Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                        if(Todays[0].title=='Add'){
                          Create_new_bottom_sheet();
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 15.0,right: 20,left: 20),
                        child: Column(
                          children: [
                            Container(
                              width: 62,
                              height: 62,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFF636598),
                              ),
                              child: SvgPicture.asset(
                                '${Todays[0].images}',
                                color: Colors.black,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: Text(
                                '${ Todays[0].title}',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  height: 0.29,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                       SizedBox(
                        height: Get.height * 0.1,
                        width: Get.width*0.6,
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(0.0),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4, // Number of columns
                            mainAxisSpacing: 0.0, // Spacing between rows
                            crossAxisSpacing: 10.0, // Spacing between columns
                            childAspectRatio: 0.85, // Adjust as needed
                          ),
                          itemCount: commonController.add_new.length, // Number of items in the grid
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Container(
                                  width: 62,
                                  height: 52,
                                  alignment: Alignment.center,
                                  decoration: ShapeDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment(0.81, -0.59),
                                      end: Alignment(-0.81, 0.59),
                                      colors: [
                                        Color(0xFFEFFFD5),
                                        Color(0xFFE0FFAC),
                                        Color(0xFFBEFF51),
                                        Color(0xFF7D9554)
                                      ],
                                    ),
                                    shape: OvalBorder(),
                                  ),
                                  child: SvgPicture.asset(
                                    '${commonController.add_new[index].images}',
                                    color: Colors.black,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 15.0),
                                  child: Text(
                                    '${ commonController.add_new[index].title}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      height: 0.29,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),

                  ],
                ),
              ),


              SizedBox(
                height: Get.height * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap:()async{
                        print(Enivornment[0].images);
                        isquit.value=true;
                        WidgetsBinding.instance.addPostFrameCallback((_) async{
                          await stop().then((value) {
                            isquit.value=false;
                            Alarm.ringStream.close();
                            subscription?.cancel();
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                          });
                        });
                      },
                      child: Obx(()=> isquit.value?const Center(child: CircularProgressIndicator(
                        color: AppColor.themeColor,
                      )):Application_Button('DONE'))),
                ],
              ),
              SizedBox(
                height: Get.height * 0.05,
              ),
            ],
          ),
        ),
      ),
    ),
    backgroundColor: Colors.transparent,
  );
}

Widget Application_Button(String title){
  return Container(
    alignment: Alignment.center,
    height: Get.height*0.065,
    width: Get.width*0.87,
    decoration: ShapeDecoration(
      color: Color(0xFFD3FB8F),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(80),
      ),
    ),
    child: Text(
      '$title',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.black,
        fontSize: 14,
        fontFamily: AppFonts.fontFamily,
        fontWeight: FontWeight.w700,
        height: 0,
      ),
    )
  );
}
Widget BackArrow(){
  return Column(
    children: [
      GestureDetector(
          onTap: (){
            Get.back();
          },
          child: const Icon(Icons.arrow_back_ios_new_rounded)),
    ],
  );
}