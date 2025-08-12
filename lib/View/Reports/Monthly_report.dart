import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demoapp/Firebase_interface/Firebase_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


import '../../Controller/Common_Controller.dart';
import '../../Utlis/theme.dart';
import '../../Widgets/App_Font.dart';
import '../../Widgets/Percentage_indicator.dart';
Widget Monthly_Reports(String month, int month_no){
  final AudioPlayer audioPlayer = AudioPlayer();

  num duration=0;
  num Deep_sleep=0;
  num Average_sleep=0;
  num Restfulness_sleep=0;
  String formatDuration(num totalSeconds) {
    int hours = totalSeconds ~/ 3600;
    int minutes = (totalSeconds % 3600) ~/ 60;
    num seconds = totalSeconds % 60;

    String hoursStr = hours.toString().padLeft(2, '0');
    String minutesStr = minutes.toString().padLeft(2, '0');
    seconds.toString().padLeft(2, '0');

    return "$hoursStr:$minutesStr";
  }
  String formatDuration2(num totalSeconds) {
    num hours = totalSeconds ~/ 3600;
    num minutes = (totalSeconds % 3600) ~/ 60;
    num seconds = totalSeconds % 60;

    String hoursStr = hours.toString().padLeft(2, '0');
    String minutesStr = minutes.toString().padLeft(2, '0');
    seconds.toString().padLeft(2, '0');

    return "${hoursStr}hr ${minutesStr}min";
  }
  CommonController commonController = Get.find<CommonController>();
  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return '';
    }
  }
  List<String> formattedDates = [];

  List<String> getFormattedDatesOfMonth(int year, int month) {

    // Get the first day of the month
    // Get the last day of the month
    DateTime lastDayOfMonth = DateTime(year, month + 1, 0);

    // Iterate through the days of the month and format them
    for (int day = 1; day <= lastDayOfMonth.day; day++) {
      String formattedDate = '${_getMonthName(month_no)} $day, $year';
      formattedDates.add(formattedDate);
    }
    if(formattedDates.length==31){
      formattedDates.removeAt(30);
    }


    return formattedDates;
  }
   formattedDates = getFormattedDatesOfMonth(2024, month_no);
  List start_time=[];
  List end_time=[];
  if(commonController.uid.value.isEmpty){
    commonController.uid.value='mkdmk';
  }
  return StreamBuilder(
    stream: FirebaseFirestore.instance
        .collection('users')
        .doc(commonController.uid.value)
        .collection('Sleep_Audio')
        .where('Date', whereIn: formattedDates)
        .snapshots(),
    builder: (context, snapshot){
      if(snapshot.hasData){
        duration=0;
        Restfulness_sleep=0;
        Average_sleep=0;
        Deep_sleep=0;
        for(int i=0; i<snapshot.data!.docs.length; i++){
          duration=duration+snapshot.data?.docs[i]['Duration'];
          Deep_sleep = Deep_sleep + snapshot.data?.docs[i]['Deep'];
          Average_sleep = Average_sleep + snapshot.data?.docs[i]['Average'];
          Restfulness_sleep = Restfulness_sleep + snapshot.data?.docs[i]['Restfulness'];
          start_time.add(snapshot.data!.docs.isEmpty?'00:00    ':DateFormat('hh:mm a').format(snapshot.data?.docs[i]['start_time'].toDate()));
          end_time.add( snapshot.data!.docs.isEmpty?'00:00    ':DateFormat('hh:mm a').format(snapshot.data?.docs[i]['end_time'].toDate()));
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Get.height*0.02,),
            Container(
              height: Get.height*0.25,
              width: Get.width,
              decoration: ShapeDecoration(
                color: const Color(0x16636598),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Padding(
                  padding: const EdgeInsets.only(left: 20.0,top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '$month Month',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: AppFonts.fontFamily,
                                  fontWeight: FontWeight.w500,
                                  height: 0,
                                ),
                              ),
                              SizedBox(height: Get.height*0.005,),
                              const Text(
                                'Sleep Duration',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF636598),
                                  fontSize: 14,
                                  fontFamily: AppFonts.fontFamily,
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                              SizedBox(height: Get.height*0.04,),
                              Row(
                                  children: [
                                    Container(
                                      width: Get.width*0.09,
                                      height: Get.height*0.04,

                                      clipBehavior: Clip.antiAlias,
                                      decoration: ShapeDecoration(
                                        color:  Colors.transparent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(318.18),
                                        ),
                                      ),
                                      alignment: Alignment.center,
                                      child: SvgPicture.asset('assets/images/bed (1).svg',
                                      color: Colors.transparent,),
                                    ),
                                    SizedBox(
                                      width: Get.width*0.02,
                                    ),
                                    const Text('Bed Time:',
                                      style: TextStyle(
                                        color: Colors.transparent,
                                        fontSize: 12,
                                        fontFamily: AppFonts.fontFamily,
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                    SizedBox(
                                      width: Get.width*0.015,
                                    ),
                                    const Text('10:30 PM',
                                      style: TextStyle(
                                        color: Colors.transparent,
                                        fontSize: 12,
                                        fontFamily: AppFonts.fontFamily,
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    )
                                  ]
                              ),
                            ],
                          ),
                          Padding(
                              padding:  EdgeInsets.only(left: 24.0.sp),
                              child: Stack(children:[
                                Padding(
                                  padding:EdgeInsets.only(left: 37.sp,top: 50.sp),
                                  child:  Text(
                                    snapshot.data!.docs.isNotEmpty ? formatDuration(duration) : '00:00',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.34.sp,
                                      fontFamily: AppFonts.fontFamily,
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                    ),
                                  ),
                                ),
                                RoundedCircularPercentage(percentage1: 0.6,percentage2: 0.2,percentage3: 0.1, percentage4: 0.1,),

                              ]
                              )
                          )
                        ],
                      ),
                      SizedBox(height: Get.height*0.01,),
                      Row(
                          children: [
                            Container(
                              width: Get.width*0.09,
                              height: Get.height*0.04,
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                color:  Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(318.18),
                                ),
                              ),
                              alignment: Alignment.center,
                              child: SvgPicture.asset('assets/images/bed (1).svg',color: Colors.transparent,),
                            ),
                            SizedBox(
                              width: Get.width*0.02,
                            ),
                            const Text('Wakeup Time:',
                              style: TextStyle(
                                color: Colors.transparent,
                                fontSize: 12,
                                fontFamily: AppFonts.fontFamily,
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                            SizedBox(
                              width: Get.width*0.015,
                            ),
                            const Text('05:30 PM',
                              style: TextStyle(
                                color: Colors.transparent,
                                fontSize: 12,
                                fontFamily: AppFonts.fontFamily,
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            )
                          ]
                      ),
                    ],
                  )
              ),
            ),
            SizedBox(height: Get.height*0.02,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: Get.height*0.12,
                  width: Get.width*0.29,
                  decoration: ShapeDecoration(
                    color: const Color(0x16636598),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: const ShapeDecoration(
                          color: Color(0xFFC9AEFF),
                          shape: OvalBorder(),
                        ),
                      ),
                       Text(
                        formatDuration2(Deep_sleep),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontFamily: AppFonts.fontFamily,
                          fontWeight: FontWeight.w400,
                          height: 0.22,
                        ),
                      ),
                      const Text(
                        'DEEP SLEEP',
                        style: TextStyle(
                          color: Color(0xFFC9AEFF),
                          fontSize: 10,
                          fontFamily: AppFonts.fontFamily,
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: Get.height*0.12,
                  width: Get.width*0.29,
                  decoration: ShapeDecoration(
                    color: const Color(0x16636598),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: const ShapeDecoration(
                          color: Color(0xFF2B90F5),
                          shape: OvalBorder(),
                        ),
                      ),
                       Text(
                        formatDuration2(Average_sleep),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontFamily: AppFonts.fontFamily,
                          fontWeight: FontWeight.w400,
                          height: 0.22,
                        ),
                      ),
                      const Text(
                        'AVERAGE',
                        style: TextStyle(
                          color: Color(0xFF2B90F5),
                          fontSize: 10,
                          fontFamily: AppFonts.fontFamily,
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: Get.height*0.12,
                  width: Get.width*0.29,
                  decoration: ShapeDecoration(
                    color: const Color(0x16636598),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: const ShapeDecoration(
                          color: Color(0xFFD9FFD8),
                          shape: OvalBorder(),
                        ),
                      ),
                       Text(
                        formatDuration2(Restfulness_sleep),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontFamily: AppFonts.fontFamily,
                          fontWeight: FontWeight.w400,
                          height: 0.22,
                        ),
                      ),
                      const Text(
                        'RESTFULNESS',
                        style: TextStyle(
                          color: Color(0xFFD9FFD8),
                          fontSize: 10,
                          fontFamily: AppFonts.fontFamily,
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: Get.height*0.02,),
            const Text(
              'Sleep Recorder',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: AppFonts.fontFamily,
                fontWeight: FontWeight.w500,
                height: 0,
              ),
            ),
            SizedBox(height: Get.height*0.02,),
            snapshot.data!.docs.isNotEmpty?LimitedBox(
              maxHeight: 700,
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.5,// Number of columns
                  mainAxisSpacing: 5.0, // Spacing between rows
                  crossAxisSpacing: 5.0, // Spacing between columns
                ),
                itemCount: snapshot.data?.docs.length,
                shrinkWrap: true,// Replace itemCount with the number of items in your grid
                itemBuilder: (context, index) {
                  RxBool isPlaying=false.obs;
                  audioPlayer.onPlayerComplete.listen((event) {
                    isPlaying.value = false;
                  });
                  return Container(
                    width: 22.w,
                    height: 22.h,
                    decoration: ShapeDecoration(
                      color: const Color(0x16636598),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: GestureDetector(
                                onTap: ()async{
                                  if (isPlaying.value == false) {
                                    await audioPlayer.play(UrlSource('${snapshot.data!.docs[index]['Audio']}'));

                                    isPlaying.value = true;
                                  } else {
                                    await audioPlayer.stop();
                                    isPlaying.value = false;
                                  }
                                },
                                child: Container(
                                  height: Get.height*0.05,
                                  width: Get.width*0.05,
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                      color: Color(0xFF363869),
                                      shape: BoxShape.circle
                                  ),
                                  child: Obx(()=>
                                    isPlaying.value?const Icon(Icons.stop,
                                    size: 12,
                                    color: Colors.black,):const Icon(Icons.play_arrow,
                                      size: 12,
                                      color: Colors.black,),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 7.0),
                              child: Text(
                                '${snapshot.data?.docs[index]['Date']}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontFamily: AppFonts.fontFamily,
                                  fontWeight: FontWeight.w400,
                                  height: 0.22,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: SvgPicture.asset('assets/images/Small_Waves.svg',
                                width: Get.width*0.03,
                                height: Get.height*0.012,),
                            ),
                            GestureDetector(
                              onTap:()async{
                                Firebase_intefacee().deleteAudio(snapshot.data?.docs[index]['Audio'],snapshot.data?.docs[index]['item_id']);
                                await audioPlayer.stop();
                  },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 25.0),
                                child: SvgPicture.asset('assets/images/delete.svg',
                                  color: const Color(0xFF363869),
                                  width: Get.width*0.05,
                                  height: Get.height*0.02,),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ):const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    'No Recording yet',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF636598),
                      fontSize: 14,
                      fontFamily: AppFonts.fontFamily,
                      fontWeight: FontWeight.w400,
                      height: 0,
                    )),
              ],
            ),
            SizedBox(height: Get.height*0.02,),
            const Text(
              'Sleep Stages',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: AppFonts.fontFamily,
                fontWeight: FontWeight.w500,
                height: 0,
              ),
            ),
            SizedBox(height: Get.height*0.02,),
            Container(
              width: Get.width,
              height: Get.height*0.325,
              decoration: ShapeDecoration(
                color: const Color(0x16636598),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0,left: 25),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                            alignment: Alignment.center,
                            width: 35,
                            height: 33.41,
                            decoration: ShapeDecoration(
                              color: const Color(0xFF363869),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(318.18),
                              ),
                            ),
                            child: SvgPicture.asset('assets/images/Search_Color.svg')),
                        SizedBox(width: Get.width*0.03,),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Take a note of the following data ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontFamily: AppFonts.fontFamily,
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                            Text(
                              'on sub-health.',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontFamily: AppFonts.fontFamily,
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: Get.height*0.02,),
                    Row(
                      children: [
                        SizedBox(
                          height:  Get.height*0.03,

                          child: Row(
                            children: [
                              Container(
                                width: 12,
                                height: 31,
                                decoration: const BoxDecoration(color: Color(0xFFC9AEFF)),
                              ),
                              Container(
                                width: 12,
                                height: 31,
                                decoration: const BoxDecoration(color: Color(0xFFD9FFD8)),
                              ),
                              Container(
                                width: 26,
                                height: 31,
                                decoration: const BoxDecoration(color: Color(0xFF2B90F5)),
                              ),
                              Container(
                                width: 12,
                                height: 31,
                                decoration: const BoxDecoration(color: Color(0xFFD9FFD8)),
                              ),
                              Container(
                                width: 26,
                                height: 31,
                                decoration: const BoxDecoration(color: Color(0xFF2B90F5)),
                              ),
                              Container(
                                width: 12,
                                height: 31,
                                decoration: const BoxDecoration(color: Color(0xFFD9FFD8)),
                              ),
                              Container(
                                width: 12,
                                height: 31,
                                decoration: const BoxDecoration(color: Color(0xFFC9AEFF)),
                              ),
                              Container(
                                width: 12,
                                height: 31,
                                decoration: const BoxDecoration(color: Color(0xFFC9AEFF)),
                              ),
                              Container(
                                width: 12,
                                height: 31,
                                decoration: const BoxDecoration(color: Color(0xFFD9FFD8)),
                              ),
                              Container(
                                width: 26,
                                height: 31,
                                decoration: const BoxDecoration(color: Color(0xFF2B90F5)),
                              ),
                              Container(
                                width: 12,
                                height: 31,
                                decoration: const BoxDecoration(color: Color(0xFFD9FFD8)),
                              ),
                              Container(
                                width: 26,
                                height: 31,
                                decoration: const BoxDecoration(color: Color(0xFF2B90F5)),
                              ),
                              Container(
                                width: 12,
                                height: 31,
                                decoration: const BoxDecoration(color: Color(0xFFD9FFD8)),
                              ),
                              Container(
                                width: 12,
                                height: 31,
                                decoration: const BoxDecoration(color: Color(0xFFC9AEFF)),
                              ),
                              Container(
                                width: 12,
                                height: 31,
                                decoration: const BoxDecoration(color: Color(0xFFC9AEFF)),
                              ),
                              Container(
                                width: 12,
                                height: 31,
                                decoration: const BoxDecoration(color: Color(0xFFD9FFD8)),
                              ),
                              Container(
                                width: 26,
                                height: 31,
                                decoration: const BoxDecoration(color: Color(0xFF2B90F5)),
                              ),
                              Container(
                                width: 12,
                                height: 31,
                                decoration: const BoxDecoration(color: Color(0xFFD9FFD8)),
                              ),
                              Container(
                                width: 12,
                                height: 31,
                                decoration: const BoxDecoration(color: Color(0xFFC9AEFF)),
                              ),


                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: Get.height*0.02,),
                    Row(
                      children: [
                        Container(
                          width: Get.width*0.37,
                          height: 60,
                          decoration: ShapeDecoration(
                            color: const Color(0x16636598),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               Padding(
                                padding: const EdgeInsets.only(top: 15.0,left: 10),
                                child: Text(
                                  '  ${snapshot.data!.docs.isNotEmpty ? formatDuration2(Deep_sleep) : '00hr 00min'}',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontFamily: AppFonts.fontFamily,
                                    fontWeight: FontWeight.w400,
                                    height: 0.22,
                                  ),
                                ),
                              ),
                              SizedBox(height: Get.height*0.02,),
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 12,
                                      height: 12,
                                      decoration: const ShapeDecoration(
                                        color: Color(0xFFC9AEFF),
                                        shape: OvalBorder(),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        'DEEP SLEEP',
                                        style: TextStyle(
                                          color: Color(0xFFC9AEFF),
                                          fontSize: 10,
                                          fontFamily: AppFonts.fontFamily,
                                          fontWeight: FontWeight.w400,
                                          height: 0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(width: Get.width*0.02,),
                        Container(
                          width: Get.width*0.37,
                          height: 60,
                          decoration: ShapeDecoration(
                            color: const Color(0x16636598),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               Padding(
                                padding: const EdgeInsets.only(top: 15.0,left: 10),
                                child: Text(
                                  '  ${snapshot.data!.docs.isNotEmpty ? formatDuration2(Average_sleep) : '00hr 00min'}',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontFamily: AppFonts.fontFamily,
                                    fontWeight: FontWeight.w400,
                                    height: 0.22,
                                  ),
                                ),
                              ),
                              SizedBox(height: Get.height*0.02,),
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 12,
                                      height: 12,
                                      decoration: const ShapeDecoration(
                                        color:  Color(0xFF2B90F5),
                                        shape: OvalBorder(),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        'AVERAGE',
                                        style: TextStyle(
                                          color:  Color(0xFF2B90F5),
                                          fontSize: 10,
                                          fontFamily: AppFonts.fontFamily,
                                          fontWeight: FontWeight.w400,
                                          height: 0,
                                        ),
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
                    SizedBox(height: Get.height*0.02,),
                    Row(
                      children: [
                        Container(
                          width: Get.width*0.37,
                          height: 60,
                          decoration: ShapeDecoration(
                            color: const Color(0x16636598),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               Padding(
                                padding: const EdgeInsets.only(top: 15.0,left: 10),
                                child: Text(
                                  '  ${snapshot.data!.docs.isNotEmpty ? formatDuration2(Restfulness_sleep) : '00hr 00min'}',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontFamily: AppFonts.fontFamily,
                                    fontWeight: FontWeight.w400,
                                    height: 0.22,
                                  ),
                                ),
                              ),
                              SizedBox(height: Get.height*0.02,),
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 12,
                                      height: 12,
                                      decoration: const ShapeDecoration(
                                        color: Color(0xFFD9FFD8),
                                        shape: OvalBorder(),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        'RESTFULNESS',
                                        style: TextStyle(
                                          color: Color(0xFFD9FFD8),
                                          fontSize: 10,
                                          fontFamily: AppFonts.fontFamily,
                                          fontWeight: FontWeight.w400,
                                          height: 0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(width: Get.width*0.02,),
                        Container(
                          width: Get.width*0.37,
                          height: 60,
                          decoration: ShapeDecoration(
                            color: const Color(0x16636598),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 15.0,left: 10),
                                child: Text(
                                  'Avg 3hr 14min',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontFamily: AppFonts.fontFamily,
                                    fontWeight: FontWeight.w400,
                                    height: 0.22,
                                  ),
                                ),
                              ),
                              SizedBox(height: Get.height*0.02,),
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 12,
                                      height: 12,
                                      decoration: const ShapeDecoration(
                                        color:  Color(0xFF2BF5D0),
                                        shape: OvalBorder(),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        'WAKEUP TIME',
                                        style: TextStyle(
                                          color:  Color(0xFF2BF5D0),
                                          fontSize: 10,
                                          fontFamily: AppFonts.fontFamily,
                                          fontWeight: FontWeight.w400,
                                          height: 0,
                                        ),
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

                  ],
                ),
              ),
            ),
            SizedBox(height: Get.height*0.02,),
            const Text(
              'Sleep Notes',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: AppFonts.fontFamily,
                fontWeight: FontWeight.w500,
                height: 0,
              ),
            ),
            SizedBox(height: Get.height*0.02,),
            Container(
              width: Get.width,
              height: Get.height*0.15,
              decoration: ShapeDecoration(
                color: const Color(0x16636598),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: Get.width*0.15,
                        height: Get.height*0.07,
                        alignment: Alignment.center,
                        decoration: const ShapeDecoration(
                          gradient: LinearGradient(
                            begin: Alignment(0.81, -0.59),
                            end: Alignment(-0.81, 0.59),
                            colors: [Color(0xFFEFFFD5), Color(0xFFE0FFAC), Color(0xFFBEFF51), Color(0xFF7D9554)],
                          ),
                          shape: OvalBorder(),
                        ),
                        child: SvgPicture.asset('assets/images/briefcase.svg'),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(
                          'Work',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontFamily: AppFonts.fontFamily,
                            fontWeight: FontWeight.w400,
                            height: 0.29,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: Get.width*0.15,
                        height: Get.height*0.07,
                        alignment: Alignment.center,
                        decoration: const ShapeDecoration(
                          gradient: LinearGradient(
                            begin: Alignment(0.81, -0.59),
                            end: Alignment(-0.81, 0.59),
                            colors: [Color(0xFFEFFFD5), Color(0xFFE0FFAC), Color(0xFFBEFF51), Color(0xFF7D9554)],
                          ),
                          shape: OvalBorder(),
                        ),
                        child: SvgPicture.asset('assets/images/stressed.svg'),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(
                          'Stressed',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontFamily: AppFonts.fontFamily,
                            fontWeight: FontWeight.w400,
                            height: 0.29,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: Get.width*0.15,
                        height: Get.height*0.07,
                        alignment: Alignment.center,
                        decoration: const ShapeDecoration(
                          gradient: LinearGradient(
                            begin: Alignment(0.81, -0.59),
                            end: Alignment(-0.81, 0.59),
                            colors: [Color(0xFFEFFFD5), Color(0xFFE0FFAC), Color(0xFFBEFF51), Color(0xFF7D9554)],
                          ),
                          shape: OvalBorder(),
                        ),
                        child: SvgPicture.asset('assets/images/coffee-cup.svg'),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(
                          'Coffee',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontFamily: AppFonts.fontFamily,
                            fontWeight: FontWeight.w400,
                            height: 0.29,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: Get.width*0.15,
                        height: Get.height*0.07,
                        alignment: Alignment.center,
                        decoration: const ShapeDecoration(
                          gradient: LinearGradient(
                            begin: Alignment(0.81, -0.59),
                            end: Alignment(-0.81, 0.59),
                            colors: [Color(0xFFEFFFD5), Color(0xFFE0FFAC), Color(0xFFBEFF51), Color(0xFF7D9554)],
                          ),
                          shape: OvalBorder(),
                        ),
                        child: SvgPicture.asset('assets/images/cold.svg'),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(
                          'Cold',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontFamily: AppFonts.fontFamily,
                            fontWeight: FontWeight.w400,
                            height: 0.29,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: Get.height*0.02,),
            const Text(
              'Sleep Consistency',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: AppFonts.fontFamily,
                fontWeight: FontWeight.w500,
                height: 0,
              ),
            ),
            SizedBox(height: Get.height*0.02,),
            Container(
              width: Get.width,
              decoration: ShapeDecoration(
                color: const Color(0x16636598),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for(int i=0; i<snapshot.data!.docs.length; i++)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: Get.height*0.01,),
                       Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          '${snapshot.data?.docs[i]['Date']}',
                          style: const TextStyle(
                            color: Color(0xFFD3FB8F),
                            fontSize: 12,
                            fontFamily: AppFonts.fontFamily,
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ),
                      SizedBox(height: Get.height*0.01,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: Get.height*0.03,
                            width: Get.width*0.04,
                            decoration: BoxDecoration(
                                color: const Color(0xFF363869),
                                borderRadius: BorderRadius.circular(5)
                            ),
                          ),
                          Container(
                            height: Get.height*0.04,
                            width: Get.width*0.7,
                            decoration: BoxDecoration(
                              color: AppColor.themeColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 0.0,left: 6),
                                      child: SvgPicture.asset('assets/images/bed (2).svg',color: Colors.black,),
                                    ),
                                     Padding(
                                      padding: const EdgeInsets.only(left: 2.0,top: 0),
                                      child: Text(
                                        '${start_time[i]}',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 10,
                                          fontFamily: AppFonts.fontFamily,
                                          fontWeight: FontWeight.w500,
                                          height: 0.22,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 0.0,left: 6),
                                      child: SvgPicture.asset('assets/images/alarm (2).svg',color: Colors.black,),
                                    ),
                                     Padding(
                                      padding: const EdgeInsets.only(right: 5.0,top: 0),
                                      child: Text(
                                        ' ${end_time[i]}',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 10,
                                          fontFamily: AppFonts.fontFamily,
                                          fontWeight: FontWeight.w500,
                                          height: 0.22,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: Get.height*0.03,
                            width: Get.width*0.04,
                            decoration: BoxDecoration(
                                color: const Color(0xFF363869),
                                borderRadius: BorderRadius.circular(5)
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Get.height*0.02,),
                    ],
                  )



                ],
              ),
            ),
          ],
        );
      }else {
        return Center(child: const CircularProgressIndicator());
      }
    },
  );
}