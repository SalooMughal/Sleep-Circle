import 'dart:async';
import 'dart:ui';
import 'package:alarm/model/alarm_settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demoapp/Controller/Common_Controller.dart';
import 'package:demoapp/Utlis/theme.dart';
import 'package:demoapp/View/Library/Library_view.dart';
import 'package:demoapp/View/Profile/Profile.dart';
import 'package:demoapp/View/Reports/Reports_View.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:just_audio/just_audio.dart';
import 'package:share_plus/share_plus.dart';
import 'package:vertical_weight_slider/vertical_weight_slider.dart';
import '../../Widgets/App_Font.dart';
import '../../Widgets/Widgets.dart';
import '../Profile/Bedtime/SetBedtime.dart';
import '../Profile/Wakeup_alarm/Home.dart';
import '../Sounds/Audio_Player.dart';
import '../Sounds/Snooze_Items.dart';
import '../Sounds/Top_Mixes_Details.dart';
import '../Track_sleep/Connect_to_Charger.dart';
import '../Sounds/Create_Mix.dart';
import '../Sounds/Daily_Picks.dart';
import '../Sounds/Healing_Music.dart';
import '../Sounds/Recently_Played.dart';
import '../Sounds/Search.dart';
import '../Sounds/Sleeping_Medication.dart';
import '../Sounds/Sleeping_Stories.dart';
import '../Sounds/Sound_Screen.dart';
import '../Sounds/Top_Mixes.dart';
import '../Sounds/Top_Rated_Detail_Screen.dart';
import '../Sounds/Top_Rated_this_Week.dart';
CommonController commonController=Get.find<CommonController>();
AudioPlayer audioPlayer = AudioPlayer();

Timer? _timer; // Timer instance
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  void _onItemTapped(int index) {
    setState(() {
      commonController. selectedIndex.value = index;
    });
  }
  static StreamSubscription<AlarmSettings>? subscription;

  @override
  void initState() {
    commonController. selectedIndex.value=0;
    super.initState();
  }
  List Category_items_icon=[
    'assets/icons/Snooring_Icon.svg',
    'assets/icons/Music_Icon.svg',
    'assets/icons/Medications_Icon.svg',
    'assets/icons/Top Mixes.svg',
  ];
  List Category_items_name=[
    'White Noise',
    'Music',
    'Medication',
    'Top Mixes'
  ];

  @override
  Widget build(BuildContext context) {
    print(commonController.uid.value);
    return WillPopScope(
      onWillPop: ()async{
        return false;
      },
      child: Scaffold(
          bottomNavigationBar:Container(
            decoration: const BoxDecoration(
              border:   Border(
                top: BorderSide(
                  color: AppColor.themeColor, // Specify the color here
                  width: 0.25, // Specify the width here
                ),),),
            child: Obx(()=>
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: (){
                              commonController.selectedIndex.value=0;
                              setState(() {});
                            },
                            child: SvgPicture.asset(
                              'assets/images/Home.svg',
                              color:  commonController.selectedIndex.value == 0 ? AppColor.themeColor : Colors.grey,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              'Home',
                              style: TextStyle(
                                color:  commonController.selectedIndex.value == 0 ? AppColor.themeColor : Colors.grey,
                                fontSize: 8,
                                fontFamily: AppFonts.fontFamily,
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: (){
                              commonController.selectedIndex.value=1;
                              setState(() {});
                            },
                            child: SvgPicture.asset(
                              'assets/images/Home (1).svg',
                              color: commonController. selectedIndex == 1 ? AppColor.themeColor : Colors.grey,
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              'Reports',
                              style: TextStyle(
                                color:  commonController.selectedIndex == 1 ? AppColor.themeColor : Colors.grey,
                                fontSize: 8,
                                fontFamily: AppFonts.fontFamily,
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          Get.to(  const Connect_to_charger());
                        },
                        child: Container(
                          height: Get.height * 0.15,
                          width: Get.width * 0.2, // Adjust the width here
                          decoration: const ShapeDecoration(
                              shadows: [
                                BoxShadow(
                                  color: Color(0x33D3FB8F),
                                  blurRadius: 10.60,
                                  offset: Offset(0, 7),
                                  spreadRadius: -5,
                                )
                              ],
                              shape: CircleBorder()
                          ),

                          child: SvgPicture.asset(
                            'assets/images/navigation-bar.svg',
                            alignment: Alignment.center,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: (){
                              commonController.selectedIndex.value=2;
                              setState(() {});
                            },
                            child: SvgPicture.asset(
                              'assets/images/Search.svg',
                              color:  commonController.selectedIndex == 2 ? AppColor.themeColor: Colors.grey,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              'Sounds',
                              style: TextStyle(
                                color:  commonController.selectedIndex == 2 ? AppColor.themeColor : Colors.grey,
                                fontSize: 8,
                                fontFamily: AppFonts.fontFamily,
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: (){
                              commonController. selectedIndex.value=3;
                              setState(() {});
                            },
                            child: SvgPicture.asset(
                              'assets/images/profile.svg',
                              color: commonController. selectedIndex == 3 ? AppColor.themeColor: Colors.grey,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              'Library',
                              style: TextStyle(
                                color:  commonController.selectedIndex == 3 ? AppColor.themeColor : Colors.grey,
                                fontSize: 8,
                                fontFamily: AppFonts.fontFamily,
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
            ),

          ),
          body: Obx(()=>
          commonController.selectedIndex.value==0?SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
                children:[ SingleChildScrollView(

                    child: Stack(
                        children:[
                          Column(
                            children: [
                              Container(
                                height: Get.height * 0.3,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                        'assets/images/Illustration.png',
                                      ),
                                      fit: BoxFit.fitWidth
                                    // Add your content here
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:  EdgeInsets.only(top: 60.0.sp,right: 20,bottom: 10.sp),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          // GestureDetector(
                                          //   onTap:(){
                                          //     Get.to(const Search());
                                          //   },
                                          //   child: Container(
                                          //     height:30.h,
                                          //       width: 30.w,
                                          //       alignment: Alignment.center,
                                          //       decoration: BoxDecoration(
                                          //         color: const Color(0x4C9AC1FF),
                                          //         borderRadius: BorderRadius.circular(10)
                                          //       ),
                                          //       child: SvgPicture.asset('assets/images/search (1).svg',
                                          //         height: 22.h,)),
                                          // ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: GestureDetector(
                                              onTap: (){
                                                Get.to(const Profile());
                                              },
                                              child: Container(
                                                height:30.h,
                                                width: 30.w,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    color: const Color(0x4C9AC1FF),
                                                    borderRadius: BorderRadius.circular(10)
                                                ),
                                                child: SvgPicture.asset('assets/images/profile (1).svg',
                                                  height: 22.h,
                                                  fit: BoxFit.cover,),),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 25.0, top:10.sp),
                                          child:  Text(
                                            textAlign: TextAlign.start,
                                            'Welcome',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.sp,
                                              fontFamily: AppFonts.fontFamily,
                                              fontWeight: FontWeight.w600,
                                              height: 0,
                                            ),
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            Padding(
                                              padding:  EdgeInsets.only(right: 8.0.sp),
                                              child: GestureDetector(
                                                onTap: (){
                                                  Get.to(const ExampleAlarmHomeScreen());
                                                },
                                                child: Container(
                                                    width: 75.w,
                                                    height: 30.h,
                                                    alignment: Alignment.center,
                                                    clipBehavior: Clip.antiAlias,
                                                    decoration: ShapeDecoration(
                                                      color: const Color(0x4C9AC1FF),
                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      children: [
                                                        SvgPicture.asset('assets/images/clock.svg',
                                                          color: AppColor.themeColor,
                                                          height: 20,),
                                                        Text(
                                                          'Set Alarm',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 8.sp,
                                                            fontFamily: 'Poppins',
                                                            fontWeight: FontWeight.w500,
                                                            height: 0,
                                                          ),
                                                        )
                                                      ],
                                                    )),
                                              ),
                                            ),
                                            Padding(
                                              padding:  EdgeInsets.only(right: 20.0.sp,top: 10.sp),
                                              child: GestureDetector(
                                                onTap: (){
                                                  Get.to(const SetBedTime());
                                                },
                                                child: Container(
                                                    width: 90.w,
                                                    height: 30.h,

                                                    decoration: ShapeDecoration(
                                                      color: const Color(0x4C9AC1FF),
                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                                    ),
                                                    child:  Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      children: [
                                                        SvgPicture.asset('assets/icons/bed (4).svg',
                                                          color: AppColor.themeColor,
                                                          height: 20,),
                                                        Text(
                                                          '${commonController.Set_bedtime.isNotEmpty?commonController.Set_bedtime.value:'Set bedtime'}',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 8.sp,
                                                            fontFamily: 'Poppins',
                                                            fontWeight: FontWeight.w500,
                                                            height: 0,
                                                          ),
                                                        )
                                                      ],
                                                    )),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        height: Get.height * 0.13,
                                        width: Get.width,
                                        child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: Category_items_name.length,
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                onTap: (){
                                                    commonController.Selectedcat.value=Category_items_name[index];
                                                    print(commonController.Selectedcat.value);
                                                    if( commonController.Selectedcat.value=='Top Mixes'){
                                                        Get.to(const Top_Mixes_Details());
                                                    }else{
                                                        commonController.selectedIndex.value=2;

                                                    }
                                                  // if(commonController.Selectedcat.value=='Top Mixes'){
                                                  // }else{
                                                  //   commonController.Selectedcat.value=Category_items_name[index];
                                                  //   commonController.selectedIndex.value=2;
                                                  // }
                                                  // setState(() {});
                                                },
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      alignment:Alignment.center,
                                                      height: Get.height*0.085,
                                                      width: Get.width*0.25,
                                                      decoration: const BoxDecoration(
                                                          color: Color(0xFF2A2C58),
                                                          shape: BoxShape.circle),
                                                      child: SvgPicture.asset('${Category_items_icon[index]}'),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(12.0),
                                                      child: Text(
                                                        '${Category_items_name[index]}',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 9.sp,
                                                          fontFamily: AppFonts.fontFamily,
                                                          fontWeight: FontWeight.w400,
                                                          height: 0.15,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }),
                                      ),
                                    ],
                                  ),
                                ),

                              ),
                              Recently_Played(),
                              Daily_Picks(),
                              Healing_Music(),
                              Sleeping_Medication(),
                              // Sleeping_Stories(),
                              const SizedBox(
                                height: 40,
                              ),
                              //Create Card
                              const Create_Mix(),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 30.0, right: 20, top: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Top Mixes',
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
                                        Get.to(const Top_Mixes_Details());
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
                              Top_Mixes(),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 30.0, right: 20, top: 30),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Top Rated this week',
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
                                        Get.to(const Top_Rated_Detail_Screen());
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
                              const SizedBox(
                                height: 20,
                              ),
                              Top_Rated()
                            ],
                          ),

                        ])
                ),
                  // Obx(()=>
                  // commonController.Playing_items.isEmpty?Container():Positioned(
                  //   top: Get.height/1.38,
                  //   width: Get.width/1,
                  //   child: GestureDetector(
                  //     onTap: (){
                  //       Get.bottomSheet(
                  //           isScrollControlled: true,
                  //           Container_items(context,commonController.Playing_items.value,0.0)
                  //       );
                  //     },
                  //     child: SvgPicture.asset('assets/images/up.svg',
                  //       height: 13,),
                  //   ),
                  // ),
                  // ),

                  Obx(()=>  commonController.isaudioplaying.value?Positioned(
                      top: Get.height/1.34,
                      left: Get.width/35.5,
                      child: MusicCard()):SizedBox()),
                  Obx(()=>
                  commonController.Playing_items.isEmpty?Container():Positioned(
                      top: Get.height/1.34,
                      child: TopMixes_Home_Player(context,commonController.Playing_items,commonController.TopMixes_name,commonController.Home_play_stop,commonController.Home_Volume,commonController.TopMixes_icons)),
                  ),
                ]
            ),
          ): commonController.selectedIndex==2?Sound_Screen(selectedcat: commonController.Selectedcat.value,): commonController.selectedIndex==1?const Reports_View():commonController.selectedIndex==3?const Library_view():const SizedBox(),
          )),
    );
  }


}
Future<void> getLongestDurationAudio(List audioUrls) async {

  Duration longestDuration = Duration.zero;
  String longestUrl = '';

  for (String url in audioUrls) {
    try {
      await audioPlayer.setUrl(url).timeout(const Duration(seconds: 10));
      Duration? duration = await audioPlayer.durationFuture;
      if (duration != null && duration > longestDuration) {
        longestDuration = duration;
        longestUrl = url;
      }

    } catch (e) {
      print('Error getting duration for $url: $e');
    }
  }

  print('Longest audio URL: $longestUrl with duration: $longestDuration');

  if (longestUrl.isNotEmpty) {
    // Set the timer
    startTimer(longestDuration);
  }
}

void startTimer(Duration duration) {
  _timer?.cancel(); // Cancel any existing timer


  _timer = Timer(duration, () {
    commonController.Home_play_stop.value = false; // Update the play/stop button state
  });
}
Widget TopMixes_Home_Player(BuildContext context, List plaingitems, List playingnames, RxBool isplaying,RxList volume, RxList icons){
  return GestureDetector(
    onTap: (){
      Get.bottomSheet(
          isScrollControlled: true,
          Container_items(context,plaingitems,volume, playingnames,isplaying, icons)
      );

    },
    child: Dismissible(
      key: Key('unique_key'), // unique key for each item
      direction: DismissDirection.endToStart, // swipe from right to left
      onDismissed: (direction) {
        clearallmusic();

      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20.0),
        color: Colors.red,
        child: Icon(Icons.delete, color: Colors.white),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0,right: 12.0),
        child: Container(
          height: Get.height*0.1,
          width: Get.width*0.95,
          decoration: ShapeDecoration(
            color: Color(0xFF1B2050),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            shadows: [
              BoxShadow(
                color: Color(0x6615190F),
                blurRadius: 32.50,
                offset: Offset(0, 12),
                spreadRadius: 0,
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 80,
                    width: 140,
                    decoration: ShapeDecoration(
                      color: Color(0xFF1B2050),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      shadows: [
                        BoxShadow(
                          color: Color(0x6615190F),
                          blurRadius: 32.50,
                          offset: Offset(0, 12),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 20,
                          left: 30,
                          child: Container(
                            alignment: Alignment.center,
                            width: 40.68,
                            height: 40.68,
                            decoration: const ShapeDecoration(
                              color: Color(0x4C9AC1FF),
                              shape: OvalBorder(),
                            ),
                            child: SvgPicture.asset('assets/images/sea.svg'),
                          ),
                        ),
                        Positioned(
                          top: 20,
                          left: 60,
                          child: Container(
                            alignment: Alignment.center,
                            width: 40.68,
                            height: 40.68,
                            decoration: const ShapeDecoration(
                              color: Color(0x4C9AC1FF),
                              shape: OvalBorder(),
                            ),
                            child: SvgPicture.asset('assets/images/waves.svg'),
                          ),
                        ),
                        Positioned(
                          top: 20,
                          left: 90,
                          child: Container(
                            alignment: Alignment.center,
                            width: 40.68,
                            height: 40.68,
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Current Mixes',
                          style: TextStyle(
                            color: Color(0xFFCDFF78),
                            fontSize: 14,
                            fontFamily: AppFonts.fontFamily,
                            fontWeight: FontWeight.w400,
                            height: 0.15,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${plaingitems.length} Items',
                          style: const TextStyle(
                            color: Color(0xFFDFDFDF),
                            fontSize: 14,
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
              Obx(()=>
                  GestureDetector(
                    onTap: ()async{
                      commonController.stopMusic_for_dailypicks();
                      if(isplaying==false|| commonController.snoozeplaystop.value==false){
                        isplaying.value = true;
                        commonController.snoozeplaystop.value=true;
                        await  getLongestDurationAudio(plaingitems);
                        playMultipleMusic(plaingitems);
                      }else{
                        isplaying.value=false;
                        _timer?.cancel();
                        pauseAllMusic();

                        // Call the function to play/pause all music
                      }
                      // playMultipleMusic(playaudio);

                    },
                    child:Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: isplaying.value&& commonController.snoozeplaystop.value?SvgPicture.asset('assets/icons/pause-button.svg'):SvgPicture.asset('assets/icons/Playbutton.svg'),
                    ),
                  ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}
Future stopSingleMusic(int index, VoidCallback updateUI,List Playingitems, List Playingname, List volume, RxBool isplaying) async {
  CommonController commonController = Get.find<CommonController>();
  if(audioPlayers.isNotEmpty){
    if(commonController.mixes.isNotEmpty){
      commonController.Audio_name.removeAt(index);
      commonController.mixes.removeAt(index);
      await audioPlayers[index].stop();
      audioPlayers.removeAt(index);
      volume.removeAt(index);
      Playingitems.removeAt(index);
      updateUI();
    }else{
      isplaying.value=false;
      // Remove the corresponding volume
      await audioPlayers[index].stop();
      audioPlayers.removeAt(index);
      volume.removeAt(index);
      // Remove the corresponding audio path from the playaudio list
      Playingitems.removeAt(index);

      Playingname.removeAt(index);
      // Call the callback to update the UI
      updateUI();
    }

  }
  else{

    if(commonController.mixes.isNotEmpty){
      commonController.mixes.removeAt(index);
    }
    if(commonController.Audio_name.isNotEmpty){
      commonController.Audio_name.removeAt(index);
    }else{
      Playingname.removeAt(index);
    }
    Playingitems.removeAt(index);
    volume.removeAt(index);
    updateUI();
  }
}

Future clearall(VoidCallback updateUI,List Playingitems, List playingname, List volume, RxBool isplaying)async{
  for(int i=0; i<audioPlayers.length; i++){
    await audioPlayers[i].stop();
  }
  commonController.Audio_name.clear();
  audioPlayers.clear();
  playingname.clear();
  Playingitems.clear();
  volume.clear();
  isplaying.value=false;
  updateUI();
  commonController.mixes.clear();

}
Future clearallmusic()async{
  commonController.playaudiofav.clear();
  commonController.Audio_name_fav.clear();
  commonController.mixesfav.clear();
  commonController.volumes_fav.clear();
  commonController.playaudiofav.clear();
  commonController.Audio_name_fav.clear();
  commonController.mixesfav.clear();
  commonController.volumes_fav.clear();
  commonController.mixesfav.add(1);
  commonController.playaudiofav.clear();
  commonController.Play_Stop_fav.value=false;
  commonController.Audio_name_fav.clear();
  commonController.volumes_fav.clear();
  commonController.mixes.clear();
  commonController.playaudio.clear();
  commonController.Audio_name.clear();
  commonController.mixes.clear();
  volumes.clear();
  commonController.mixes.clear();
  commonController.Playing_items.clear();
  commonController.TopMixes_name.clear();
  commonController.Home_Volume.clear();
  commonController.play_stop.value=false;
  commonController.play_stop.value=false;
  commonController.Detail_Volume.clear();
  commonController.Detail_Mixesname.clear();
  commonController.Detail_play_stop.value=false;
  commonController.Home_play_stop.value=false;
  commonController.Detail_Playing_items.clear();
  for(int i=0; i<audioPlayers.length; i++){
    await audioPlayers[i].stop();
  }
  audioPlayers.clear();
}
Future clearallmusicforsnooze()async{
  commonController.playaudiofav.clear();
  commonController.Audio_name_fav.clear();
  commonController.mixesfav.clear();
  commonController.volumes_fav.clear();
  commonController.playaudiofav.clear();
  commonController.Audio_name_fav.clear();
  commonController.mixesfav.clear();
  commonController.volumes_fav.clear();
  commonController.mixesfav.add(1);
  commonController.playaudiofav.clear();
  commonController.Play_Stop_fav.value=false;
  commonController.volumes_fav.clear();
  commonController.Playing_items.clear();
  commonController.TopMixes_name.clear();
  commonController.Home_Volume.clear();
  commonController.play_stop.value=false;
  commonController.play_stop.value=false;
  commonController.Detail_Volume.clear();
  commonController.Detail_Mixesname.clear();
  commonController.Detail_play_stop.value=false;
  commonController.Home_play_stop.value=false;
  commonController.Detail_Playing_items.clear();
  for(int i=0; i<audioPlayers.length; i++){
    await audioPlayers[i].stop();
  }
  audioPlayers.clear();
}
Widget Container_items(BuildContext context, List soundsItems, List volume, List mixesname,RxBool isplaying, RxList icons) {

  WeightSliderController? controller;
  CommonController commonController=Get.find<CommonController>();

  return BackdropFilter(
    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
    child: Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: BoxDecoration(
        color: const Color(0xFF4B4FAC).withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(
                    Icons.keyboard_arrow_down_outlined,
                    size: 40,
                  ),
                ),
                Row(
                  children: [
    
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: ()async{
                          final RenderBox? box = context.findRenderObject() as RenderBox?;

                          await Share.share(
                            soundsItems.join('\n'),
                            subject: 'Sounds',
                            sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
                          );
                        },
                          child: SvgPicture.asset('assets/images/share.svg')),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
    
          const SizedBox(
            height: 20,
          ),
    
          StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 30.0),
                            child: Text(
                              'Snoozes',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: AppFonts.fontFamily,
                                fontWeight: FontWeight.w500,
                                height: 0,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              '(${soundsItems.length}/${soundsItems.length})',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontFamily: AppFonts.fontFamily,
                                fontWeight: FontWeight.w400,
                                height: 0.15,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 30.0),
                        child: TextButton(
                          onPressed: ()async{
                            await  clearall( () {
                              setState(() {});},soundsItems,mixesname,volume,isplaying);
                          },
                          child: const Text(
                            'Clear All',
                            style: TextStyle(
                              color: Color(0xFFE1E2F7),
                              fontSize: 14,
                              fontFamily: AppFonts.fontFamily,
                              fontWeight: FontWeight.w400,
                              height: 0.15,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.45,
                    child: ListView.builder(
                      itemCount: soundsItems.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 25.0, top: 25),
                              child: Container(
                                width: 65.21,
                                height: 65.21,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(colors: [Colors.pink, Colors.yellow]),
                                  shape: BoxShape.circle,
                                ),
                                child: Container(
                                  height: 60.21,
                                  alignment: Alignment.center,
                                  child: commonController.mixes.isEmpty?SvgPicture.asset('${commonController.Mixes_images[index]}'):SvgPicture.network(icons[index],
                                  fit: BoxFit.fill,),
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF2A2C58),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 40.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 28.0),
                                    child: Text(
                                      '${mixesname[index]}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontFamily: AppFonts.fontFamily,
                                        fontWeight: FontWeight.w400,
                                        height: 0.15,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50,
                                    width: Get.width * 0.6,
                                    child: Slider(
                                      activeColor: const Color(0xFF35CDFF),
                                      value: volume[index],
                                      onChanged: (val) {
                                        setState(() {
                                          volume[index] = val;
                                          audioPlayers[index].setVolume(val);
                                        });
                                      },
                                      min: 0,
                                      max: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0, top: 20),
                              child: GestureDetector(
                                onTap: () async {
                                  if(volumes.isEmpty){
                                    play_stop.value=false;
                                  }
                                  print(commonController.Playing_items);
                                  print('print ${index}');
    
                                  await stopSingleMusic(index, () {setState(() {});},soundsItems,mixesname,volume,isplaying);
                                },
                                child: SvgPicture.asset('assets/images/delete.svg'),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Divider(
            color: Color(0xFF636699),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                  onTap: ()async{
                    Text('===');
                    TextEditingController namecontroller=TextEditingController();
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
                                  controller: namecontroller,
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
                                onTap: () async{
                                  if(commonController.uid.value=='abc'){
                                    Get.snackbar('Error', 'Please login first!');
    
                                  }
                                  if(commonController.playaudio.isNotEmpty){
                                    if(commonController.playaudio.length<2){
                                      Get.snackbar(
                                        'Error',
                                        'Please add minimum 2 mixes to save it',
                                        snackPosition: SnackPosition.TOP,
                                      );
                                    }
                                    else{
                                      Map<String, dynamic> body={
                                        'Category':'Mixes',
                                        'Audio_url':soundsItems,
                                        'Audio_name':mixesname,
                                        'Mixes_Name':'${namecontroller.text.toString()}'

                                      };
                                      DocumentReference docRef = FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(commonController.uid.value)
                                          .collection('Favourites')
                                          .doc();
                                      body['uid'] = docRef.id;

                                      await docRef.set(body).then((value) {
                                        // Show a snackbar on successful addition
                                        Get.snackbar(
                                          'Added Successfully',
                                          'Mixes added successfully',
                                          snackPosition: SnackPosition.TOP,
                                        );
                                      }).catchError((error) {
                                        // Handle any errors
                                        Get.snackbar(
                                          'Error',
                                          'Failed to add mixes: $error',
                                          snackPosition: SnackPosition.TOP,
                                        );
                                      });
                                      Navigator.of(context).pop();
                                    }
                                  }
                                  else{
                                    Map<String, dynamic> body={
                                      'Category':'Mixes',
                                      'Icons':icons,
                                      'Audio_url':soundsItems,
                                      'Audio_name':mixesname,
                                      'Mixes_Name':'${namecontroller.text.toString()}'

                                    };
                                    DocumentReference docRef = FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(commonController.uid.value)
                                        .collection('Favourites')
                                        .doc();
                                    body['uid'] = docRef.id;

                                    await docRef.set(body).then((value) {
                                      // Show a snackbar on successful addition
                                      Get.snackbar(
                                        'Added Successfully',
                                        'Mixes added successfully',
                                        snackPosition: SnackPosition.TOP,
                                      );
                                    }).catchError((error) {
                                      // Handle any errors
                                      Get.snackbar(
                                        'Error',
                                        'Failed to add mixes: $error',
                                        snackPosition: SnackPosition.TOP,
                                      );
                                    });
                                    Navigator.of(context).pop();
                                  }
    
    
                                },
                                child: Application_Button('SAVE'))
                          ],
                        ),
                      ),
                      backgroundColor: Colors.transparent,
                    );
    
                    // Navigate back after snackbar is shown
                  },
                  child:    Container(
                    width: 317,
                    height: 59,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: SvgPicture.asset('assets/images/favorite_border.svg'),
                        ),
                        Text(
                          'SAVE MIX',
                          style: TextStyle(
                            color: Color(0xFFD3FB8F),
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            height: 0,
                          ),
                        ),
                      ],
                    ),
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: Color(0xFFD3FB8F)),
                        borderRadius: BorderRadius.circular(80),
                      ),
                    ),)
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
