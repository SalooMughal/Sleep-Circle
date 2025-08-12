import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:vertical_weight_slider/vertical_weight_slider.dart';

import '../../Controller/Common_Controller.dart';
import '../../Widgets/App_Font.dart';
import '../../Widgets/Widgets.dart';
import '../Home/HomeScreen.dart';
import 'Audio_Player.dart';
import 'Snooze_Items.dart';

class Top_Mixes_Details extends StatefulWidget {
  const Top_Mixes_Details({super.key});

  @override
  State<Top_Mixes_Details> createState() => _Top_Mixes_DetailsState();
}

class _Top_Mixes_DetailsState extends State<Top_Mixes_Details> {
  CommonController commonController=Get.find<CommonController>();

  Timer? _timer; // Timer instance
  AudioPlayer audioPlayer = AudioPlayer();
  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      body: SafeArea(child:
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children:[ Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20,),
          Row(
            children: [
              GestureDetector(
                  onTap: (){
                    Get.back();
                  },
                  child: const Icon(Icons.arrow_back_ios_new)),
              const SizedBox(
                width: 20,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Top Mixes',
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

           const SizedBox(height: 20,),
           StreamBuilder(
             stream: FirebaseFirestore.instance.collection('Top Mixes').snapshots(),
             builder: (context , snapshot){
               if(snapshot.hasData){
                 return Expanded(
                   child: ListView.builder(
                       itemCount: snapshot.data?.docs.length,

                       itemBuilder: (context, index){
                         return  InkWell(
                           onTap: ()async{
                             audioPlayer_for_music.stop();
                             commonController.isaudioplaying.value=false;
                             clearallmusic();
                             for(int i=0; i<snapshot.data?.docs[index]['items'].length; i++){
                               commonController.Detail_Playing_items.add(snapshot.data?.docs[index]['items'][i]);
                               commonController.Detail_Mixesname.add(snapshot.data?.docs[index]['Mixesname'][i]);
                               commonController.Detail_Volume.add(1.0);
                             }
                           },
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Row(
                                 children: [
                                   Padding(
                                     padding: const EdgeInsets.only(left: 10.0,top: 8),
                                     child: Container(
                                       height: 55.h,
                                       width: 120.w,
                                       decoration: BoxDecoration(
                                           color: const Color(0xFF2A2C58),
                                           borderRadius: BorderRadius.circular(20)
                                       ),
                                       child: Padding(
                                         padding:  EdgeInsets.only(top: 13.0.sp,left: 13.sp),
                                         child: Stack(
                                           children: [
                                             Padding(
                                               padding:  EdgeInsets.only(left: 8.0.sp),
                                               child: Container(
                                                 alignment: Alignment.center,
                                                 width: 35.68.w,
                                                 height: 32.68.h,
                                                 decoration: const ShapeDecoration(
                                                   color: Color(0x4C9AC1FF),
                                                   shape: OvalBorder(),
                                                 ),
                                                 child: SvgPicture.asset('assets/images/sea.svg'),
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
                                                 child: SvgPicture.asset('assets/images/waves.svg'),
                                               ),
                                             ),
                                             Padding(
                                               padding:  EdgeInsets.only(left: 50.0.sp),
                                               child: Container(
                                                 alignment: Alignment.center,
                                                 width: 35.68.w,
                                                 height: 32.68.h,
                                                 decoration: const ShapeDecoration(
                                                   color: Color(0x4C9AC1FF),
                                                   shape: OvalBorder(),
                                                 ),
                                                 child: SvgPicture.asset('assets/images/wind.svg'),
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
                                           '${snapshot.data?.docs[index]['Name']}',
                                           style: const TextStyle(
                                             color: Colors.white,
                                             fontSize: 12,
                                             fontFamily: AppFonts.fontFamily,
                                             fontWeight: FontWeight.w400,
                                             height: 0.15,
                                           ),
                                         ),
                                       ),
                                        Padding(
                                         padding: const EdgeInsets.all(8.0),
                                         child: Text(
                                           '${snapshot.data?.docs[index]['Mixesname'][0]}, ${snapshot.data?.docs[index]['Mixesname'][1]}, ${snapshot.data?.docs[index]['Mixesname'][2]}',
                                           style: TextStyle(
                                             color: const Color(0xFF636598),
                                             fontSize: 6.8.sp,
                                             fontFamily: AppFonts.fontFamily,
                                             fontWeight: FontWeight.w400,

                                           ),
                                         ),
                                       ),
                                     ],
                                   ),
                                 ],
                               ),
                               const Padding(
                                 padding: EdgeInsets.only(right: 0.0),
                                 child: Icon(Icons.arrow_forward_ios_outlined),
                               )
                             ],
                           ),
                         );
                       }),
                 );
               }else return const Center(child: CircularProgressIndicator());
             },
           )
          ],),

            Obx(()=>
            commonController.Detail_Playing_items.isEmpty?Container():Padding(
                padding:  EdgeInsets.only(top: 600.sp),
                child: TopMixes_Home_Player(context,commonController.Detail_Playing_items,commonController.Detail_Mixesname,commonController.Detail_play_stop,commonController.Detail_Volume,commonController.Top_Mixes_Details_Icons),
              ),
            )
        ]
        ),
      )),
    );
  }
}

