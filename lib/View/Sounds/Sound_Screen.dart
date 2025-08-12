

import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:demoapp/models/Premium_music.dart';
import 'package:demoapp/models/Sound_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:just_audio/just_audio.dart'as package1;

import 'package:get/get_state_manager/get_state_manager.dart';
import '../../Controller/Common_Controller.dart';
import '../../Widgets/App_Font.dart';
import '../Home/HomeScreen.dart';
import 'Audio_Player.dart';
import 'Meditation_items.dart';
import 'Music_items.dart';
import 'Snooze_Items.dart';
import 'Stories_items.dart';
RxBool play_stop=false.obs;
class Sound_Screen extends StatefulWidget {
  String? origin;
  String? selectedcat='';
   Sound_Screen({super.key,  this.origin, this.selectedcat}) ;

  @override
  State<Sound_Screen> createState() => _Sound_ScreenState();
}

class _Sound_ScreenState extends State<Sound_Screen> {
  CommonController commonController=Get.find<CommonController>();
  late Map<String, bool> selectedCat = {
    'White Noise': false,
    'Music': false,
    'Medication': false,
  };

  @override
  void initState() {
    super.initState();
    if(widget.selectedcat=='Music'){
      selectedCat['Music'] = true;
    }else if(widget.selectedcat=='Medication'){
      selectedCat['Medication'] = true;
    }
    else if(widget.selectedcat=='Stories'){
      selectedCat['Stories'] = true;
    }
    else{
      selectedCat['White Noise'] = true;
    }

    if(widget.origin=='Music'){
      selectedCat['Music'] = true;
      selectedCat['White Noise'] = false;
    }else  if(widget.origin=='Medication'){
      selectedCat['Medication'] = true;
      selectedCat['White Noise'] = false;
    }else if(widget.origin=='Stories'){
    selectedCat['Stories'] = true;
    selectedCat['White Noise'] = false;
    }else if(widget.origin=='White Noise'){
      selectedCat['White Noise'] = true;
    }
  }

  void selectCategory(String category) {
    setState(() {
      selectedCat.updateAll((key, value) => selectedCat[key] = key == category);
    });
  }
  List Snooze_Categoires=[

    'Snooring',
    'Rain',
    'Thunder',
    'Nature',
    'Birds',
    'Nature',
    'ASMR',
    'City',
    'Special',

  ];
  List Music_Categoires=[
    'Healing Music',
    'Nature Melodies',
    'Beats'
  ];
  List Medication_Categoires=[
    'Sleeping Medication',
    'Guided Medication'
  ];
  List Stories_Categoires=[
    'All',
    'Trip',
    'Documentary',
    'Philosophy'
  ];
  List sounds_items=[
    Sound_Model(name: 'Sound 1', volume: 0.5),
    Sound_Model(name: 'Sound 2', volume: 0.5),
    Sound_Model(name: 'Sound 3', volume: 0.5),
    Sound_Model(name: 'Sound 4', volume: 0.5),
  ];
  List Snooze_categoires=[
    Premium_model(name: 'Rain', type: 'free'),
    Premium_model(name: 'Exhaust Fan', type: 'free'),
    Premium_model(name: 'Compfire', type: 'paid'),
    Premium_model(name: 'Waves', type: 'free'),
    Premium_model(name: 'Rain', type: 'free'),
    Premium_model(name: 'Sand', type: 'paid'),
    Premium_model(name: 'Cloud', type: 'free'),
    Premium_model(name: 'Fire', type: 'free'),
    Premium_model(name: 'Drum', type: 'paid'),
    Premium_model(name: 'Sticks', type: 'free'),
    Premium_model(name: 'Dhol', type: 'free'),
    Premium_model(name: 'Sticker', type: 'free'),
  ];
  List musics=['assets/rain.mp3'];

  double containerHeight = 80.0;
  bool isContainerExpanded = false;
  final double _minutes = 10.0;
  RxInt selectedIndex_Snooze = 0.obs;
  RxInt selectedIndex_Music = 0.obs;
  RxInt selectedIndex_Medication = 0.obs;
  RxInt selectedIndex_Stories = 0.obs;
  @override
  AudioPlayer audioPlayer = AudioPlayer();
  package1.AudioPlayer audioPlayer_duration = package1.AudioPlayer();

  Timer? _timer; // Timer instance

  void startTimer(Duration duration) {
    _timer?.cancel(); // Cancel any existing timer


    _timer = Timer(duration, () {
      play_stop.value = false; // Update the play/stop button state
    });
  }
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child:    GestureDetector(
                      onTap: (){
                        commonController.selectedIndex.value=0;

                      },
                      child: const Icon(Icons.arrow_back_ios_new_rounded)),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        for (var day in selectedCat.keys)
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: GestureDetector(
                              onTap: () => selectCategory(day),
                              child: SizedBox(
                                height: Get.height * 0.06,
                                child: Column(
                                  children: [
                                    Text(
                                      day,
                                      textAlign: TextAlign.center,
                                      style:  TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.5.sp,
                                        fontFamily: AppFonts.fontFamily,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                     SizedBox(height: 10.h),
                                    Visibility(
                                      visible: selectedCat[day]!,
                                      child: LayoutBuilder(
                                        builder: (context, constraints) {
                                          // Create a TextPainter to measure the text width
                                          TextPainter textPainter = TextPainter(
                                            text: TextSpan(
                                              text: day,
                                              style:  TextStyle(
                                                fontSize:18.5.sp,
                                                fontFamily: AppFonts.fontFamily,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            maxLines: 1,
                                            textDirection: TextDirection.ltr,
                                          )..layout(minWidth: 0, maxWidth: double.infinity);

                                          // Get the width of the text
                                          double textWidth = textPainter.size.width;

                                          return Container(
                                            width: textWidth,
                                            height: 2,
                                            decoration: const BoxDecoration(color: Color(0xFFD3FB8F)),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                      ],
                    )
                  ),
                ),
                selectedCat['Music']==true?Music_items(Music_Categoires,selectedIndex_Music):const SizedBox(),
                selectedCat['Medication']==true?Medication_items(Medication_Categoires,selectedIndex_Medication):const SizedBox(),
                selectedCat['White Noise']==true?Snooze_items(Snooze_Categoires,selectedIndex_Snooze,Snooze_categoires,commonController.mixes,musics):const SizedBox(),
              ],
                        ),
            ),


            selectedCat['White Noise']==true?Obx(()=> commonController.mixes.isNotEmpty?Positioned(
                top: Get.height / 1.4 - (120 - 80),
                child: TopMixes_Home_Player(context, commonController.playaudio.value, commonController.Audio_name.value,play_stop,volumes,commonController.soundsicons)
              ):const Text(''),
           ):const Text(''),
            selectedCat['Music']==true? Obx(()=>  commonController.isaudioplaying.value?Positioned(
              left: 10.sp,
                top: Get.height / 1.4 - (120 - 80),
                child: MusicCard()):SizedBox()):Text(''),
            selectedCat['Medication']==true? Obx(()=>  commonController.isaudioplaying.value?Positioned(
                left: 10.sp,
                top: Get.height / 1.4 - (120 - 80),
                child: MusicCard()):SizedBox()):Text('')
          ],
        ),
      ),
    );
  }
}
