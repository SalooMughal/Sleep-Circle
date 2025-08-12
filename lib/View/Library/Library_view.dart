import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demoapp/View/Library/Favourites.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:vertical_weight_slider/vertical_weight_slider.dart';

import '../../Controller/Common_Controller.dart';
import '../../Widgets/App_Font.dart';
import '../../Widgets/Widgets.dart';
import '../../models/Sound_model.dart';

import '../Home/HomeScreen.dart';
import '../Sounds/Snooze_Items.dart';
import 'Playlist.dart';
import 'Recent_play_lib.dart';

class Library_view extends StatefulWidget {
  const Library_view({super.key});

  @override
  State<Library_view> createState() => _Library_viewState();
}

class _Library_viewState extends State<Library_view> {
  int _selectindex=0;
  CommonController commonController=Get.find<CommonController>();
  List Mixes_title=['City Voices','Forest'];
  final double _minutes = 10.0;
  List sounds_items=[
    Sound_Model(name: 'Sound 1', volume: 0.5),
    Sound_Model(name: 'Sound 2', volume: 0.5),
    Sound_Model(name: 'Sound 3', volume: 0.5),
    Sound_Model(name: 'Sound 4', volume: 0.5),
  ];
  @override
  void initState() {
    selectedCat['Favourites'] = true;
   _selectindex=1;
    super.initState();
  }
  AudioPlayer audioPlayer = AudioPlayer();

  Timer? _timer; // Timer instance
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
      commonController.Play_Stop_fav.value = false; // Update the play/stop button state
    });
  }
  late Map<String, bool> selectedCat = {
    'Favourites': false,
    'Recently Played': false,
    'Playlist': false,
  };

  void selectCategory(String category) {
    setState(() {
      selectedCat.updateAll((key, value) => selectedCat[key] = key == category);
    });
  }
  List items=['Music','Mixes'];
  RxInt selectedIndex=0.obs;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                          onTap: (){
                            commonController.selectedIndex.value=2;
                            setState(() {
                            });
                          },
                          child: const Icon(Icons.arrow_back_ios_new_rounded)),
                      SizedBox(height: Get.height*0.02,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          for (var day in selectedCat.keys)
                            Padding(
                              padding: const EdgeInsets.only(left: 0.0),
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
                                          fontSize: 16.sp,
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
                                                  fontSize: 16.sp,
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
                      ),
                      selectedCat['Favourites']==true?SizedBox(
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
                                  // Update the selected index
                                },
                                child: Obx(
                                      () => IntrinsicWidth(
                                    child: Container(
                                      height: 48.h,
                                      width: 150.w,
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
                                          fontSize: 13.5.sp,
                                          fontFamily: AppFonts.fontFamily,
                                          fontWeight: FontWeight.w500,

                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ):SizedBox(),
                      SizedBox(
                        height: Get.height*0.02,
                      ),

                      selectedCat['Favourites']==true?Stack(children:[ Favourites(Mixes_title,selectedIndex),

                        Obx(()=>
                        commonController.playaudiofav.isNotEmpty&&selectedIndex==1?Padding(
                          padding: EdgeInsets.only(top: 300.h),
                          child: TopMixes_Home_Player(context,commonController.playaudiofav,commonController.Audio_name_fav,commonController.Play_Stop_fav,commonController.volumes_fav,commonController.FavouritesIcons)
                        ):const Text(''),
                        ),
                      ]): selectedCat['Recently Played']==true?Recently_play_lib():selectedCat['Playlist']==true?Playlist():const SizedBox()

                    ],
                  ),
                ),

              ],
            ),
          )),
    );
  }
}

Future clearall(VoidCallback updateUI)async{
  for(int i=0; i<audioPlayers.length; i++){
    await audioPlayers[i].stop();
  }
  audioPlayers.clear();
  CommonController commonController = Get.find<CommonController>();
  commonController.playaudiofav.clear();
  commonController.Audio_name_fav.clear();
  commonController.volumes_fav.clear();
  commonController.Detail_play_stop.value=false;
  updateUI();


}

Future stopSingleMusic(int index, VoidCallback updateUI) async {
  CommonController commonController = Get.find<CommonController>();

  if(audioPlayers.isNotEmpty){
    commonController.Play_Stop_fav.value=false;
    await audioPlayers[index].stop();
    audioPlayers.removeAt(index);
    commonController.volumes_fav.removeAt(index);
    commonController.playaudiofav.removeAt(index);
    commonController.Audio_name_fav.removeAt(index);
    updateUI();
  }
  else{
    commonController.Audio_name_fav.removeAt(index);
    commonController.playaudiofav.removeAt(index);
    commonController.volumes_fav.removeAt(index);
    updateUI();
  }
}

void playMultipleMusicfav(List<String> audioPaths) {
  // Clear the existing audioPlayers list
  audioPlayers.clear();

  // Add new AudioPlayer instances for each audio path
  for (var audioPath in audioPaths) {
    playSingleMusic(audioPath);

  }

}
Widget Container_items(BuildContext context, List soundsItems, double minutes) {
  WeightSliderController? controller;
  CommonController commonController=Get.find<CommonController>();
  RxBool play_stop=false.obs;
  return Container(
    height: MediaQuery.of(context).size.height * 0.8,
    decoration: BoxDecoration(
      color: const Color(0xFF2A2C58),
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
                    padding: const EdgeInsets.all(12.0),
                    child: SvgPicture.asset('assets/images/compose.svg'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset('assets/images/share.svg'),
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
                    const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 30.0),
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
                            '(3/3)',
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
                            setState(() {});
                          });
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
                    itemCount: commonController.playaudiofav.value.length,
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
                                width: 60.21,
                                height: 60.21,
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
                                    '${commonController.Audio_name_fav[index]}',
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
                                    value: commonController.volumes_fav[index],
                                    onChanged: (val) {
                                      setState(() {
                                        commonController.volumes_fav[index] = val;
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
                                await stopSingleMusic(index, () {
                                  setState(() {});
                                });
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
        // Container(
        //   height: 80,
        //   width: Get.width,
        //   decoration: BoxDecoration(
        //     color: const Color(0xB21B2050),
        //     borderRadius: BorderRadius.circular(15),
        //     border: Border.all(
        //       color: const Color(0xFF35CDFF),
        //     ),
        //   ),
        //   child: Row(
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //     children: [
        //       Column(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           GestureDetector(
        //             onTap: () {
        //               Get.bottomSheet(
        //                 isScrollControlled: true,
        //                 Container(
        //                   height: MediaQuery.of(context).size.height * 0.7,
        //                   decoration: BoxDecoration(
        //                     color: const Color(0xFF2A2C58),
        //                     borderRadius: BorderRadius.circular(20),
        //                   ),
        //                   child: Column(
        //                     crossAxisAlignment: CrossAxisAlignment.start,
        //                     mainAxisSize: MainAxisSize.min,
        //                     children: <Widget>[
        //                       Padding(
        //                         padding: const EdgeInsets.all(8.0),
        //                         child: Row(
        //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                           children: [
        //                             GestureDetector(
        //                               onTap: () {
        //                                 Get.back();
        //                               },
        //                               child: const Icon(
        //                                 Icons.keyboard_arrow_down_outlined,
        //                                 size: 40,
        //                               ),
        //                             ),
        //                           ],
        //                         ),
        //                       ),
        //                       const Column(
        //                         crossAxisAlignment: CrossAxisAlignment.center,
        //                         children: [
        //                           Text(
        //                             'Set Timer',
        //                             textAlign: TextAlign.center,
        //                             style: TextStyle(
        //                               color: Color(0xFFD3FB8F),
        //                               fontSize: 20,
        //                               fontFamily: AppFonts.fontFamily,
        //                               fontWeight: FontWeight.w600,
        //                               height: 0,
        //                             ),
        //                           ),
        //                           Row(
        //                             mainAxisAlignment: MainAxisAlignment.center,
        //                             children: [
        //                               Padding(
        //                                 padding: EdgeInsets.all(8.0),
        //                                 child: SizedBox(
        //                                   width: 273,
        //                                   child: Text(
        //                                     'How long do you want the audio to play for?',
        //                                     textAlign: TextAlign.center,
        //                                     style: TextStyle(
        //                                       color: Colors.white,
        //                                       fontSize: 16,
        //                                       fontFamily: AppFonts.fontFamily,
        //                                       fontWeight: FontWeight.w500,
        //                                       height: 0,
        //                                     ),
        //                                   ),
        //                                 ),
        //                               ),
        //                             ],
        //                           )
        //                         ],
        //                       ),
        //                       const SizedBox(
        //                         height: 50,
        //                       ),
        //                       Row(
        //                         mainAxisAlignment: MainAxisAlignment.center,
        //                         children: [
        //                           StatefulBuilder(
        //                             builder: (BuildContext context, StateSetter setState) {
        //                               controller = WeightSliderController(
        //                                 initialWeight: minutes,
        //                                 minWeight: 0,
        //                                 interval: 0.1,
        //                               );
        //                               return Column(
        //                                 children: [
        //                                   Container(
        //                                     height: 70,
        //                                     width: 70,
        //                                     alignment: Alignment.center,
        //                                     decoration: const BoxDecoration(
        //                                       image: DecorationImage(
        //                                         image: AssetImage('assets/images/Ellipse.png'),
        //                                         fit: BoxFit.cover,
        //                                       ),
        //                                     ),
        //                                     child: Text(
        //                                       "${minutes.toInt()} ",
        //                                       style: const TextStyle(
        //                                         fontSize: 40,
        //                                         fontWeight: FontWeight.w500,
        //                                       ),
        //                                     ),
        //                                   ),
        //                                   const Padding(
        //                                     padding: EdgeInsets.only(top: 15.0),
        //                                     child: Text(
        //                                       'Minutes',
        //                                       textAlign: TextAlign.center,
        //                                       style: TextStyle(
        //                                         color: Colors.white,
        //                                         fontSize: 14.91,
        //                                         fontFamily: AppFonts.fontFamily,
        //                                         fontWeight: FontWeight.w500,
        //                                         height: 0.08,
        //                                       ),
        //                                     ),
        //                                   ),
        //                                   Transform.rotate(
        //                                     angle: -90 * 3.14 / 180,
        //                                     child: SizedBox(
        //                                       height: 200,
        //                                       width: 50,
        //                                       child: VerticalWeightSlider(
        //                                         controller: controller!,
        //                                         decoration: const PointerDecoration(
        //                                           width: 150,
        //                                           height: 4,
        //                                           largeColor: Color(0xFF898989),
        //                                           mediumColor: Color(0xFFC5C5C5),
        //                                           smallColor: Color(0xFFF0F0F0),
        //                                           gap: 70,
        //                                         ),
        //                                         onChanged: (double value) {
        //                                           setState(() {
        //                                             minutes = value;
        //                                           });
        //                                         },
        //                                         indicator: Container(
        //                                           height: 3,
        //                                           width: 200,
        //                                           alignment: Alignment.centerLeft,
        //                                           color: const Color(0xFFD3FB8F),
        //                                         ),
        //                                       ),
        //                                     ),
        //                                   ),
        //                                 ],
        //                               );
        //                             },
        //                           ),
        //                         ],
        //                       ),
        //                       Row(
        //                         mainAxisAlignment: MainAxisAlignment.center,
        //                         children: [
        //                           GestureDetector(
        //                             onTap: () {
        //                               Get.back();
        //                             },
        //                             child: Application_Button('Start'),
        //                           )
        //                         ],
        //                       ),
        //                     ],
        //                   ),
        //                 ),
        //               );
        //             },
        //             child: SvgPicture.asset('assets/images/timer.svg'),
        //           ),
        //           const Padding(
        //             padding: EdgeInsets.all(8.0),
        //             child: Text(
        //               'Add timer',
        //               style: TextStyle(
        //                 color: Colors.white,
        //                 fontSize: 10,
        //                 fontFamily: AppFonts.fontFamily,
        //                 fontWeight: FontWeight.w600,
        //                 height: 0,
        //               ),
        //             ),
        //           ),
        //         ],
        //       ),
        //       Obx(()=>
        //           GestureDetector(
        //             onTap: () {
        //               // if(commonController.play_stop.value==false){
        //               //  commonController. play_stop.value=true;
        //               //   playMultipleMusic(commonController.playaudio); // Call the function to play/pause all music
        //               //
        //               // }else{
        //               //   commonController.play_stop.value=false;
        //               //   pauseAllMusic();
        //               // }
        //               },
        //             child: Container(
        //               height: 50,
        //               width: 50,
        //               decoration: const BoxDecoration(
        //                 color: Color(0x4C9AC1FF),
        //                 shape: BoxShape.circle,
        //               ),
        //               alignment: Alignment.center,
        //               child: Container(
        //                 height: 30,
        //                 width: 30,
        //                 decoration: const BoxDecoration(
        //                   color: Color(0xFFCDFF78),
        //                   shape: BoxShape.circle,
        //                 ),
        //                 child: commonController.play_stop.value&&volumes.isNotEmpty?const Icon(Icons.stop,color: Colors.black,
        //                   size: 20,):const Icon(Icons.play_arrow,
        //                   size: 20,
        //                   color: Colors.black,),
        //               ),
        //             ),
        //           ),
        //       ),
        //       GestureDetector(
        //         onTap: ()async{
        //
        //           // Map<String, dynamic> body={
        //           //   'Favourites':commonController.playaudio,
        //           //   'Name':commonController.Audio_name
        //           // };
        //           // await FirebaseFirestore.instance.collection('users').doc(commonController.uid.value).collection('Favourites').doc().set(body).then((value) =>
        //           //     Get.snackbar('Added Successfully', 'Mixes added successfully',
        //           //         snackPosition: SnackPosition.TOP));
        //
        //         },
        //         child: Column(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: [
        //             SvgPicture.asset('assets/images/favorite_border.svg'),
        //             const Padding(
        //               padding: EdgeInsets.all(8.0),
        //               child: Text(
        //                 'Save mix',
        //                 style: TextStyle(
        //                   color: Colors.white,
        //                   fontSize: 10,
        //                   fontFamily: AppFonts.fontFamily,
        //                   fontWeight: FontWeight.w600,
        //                   height: 0,
        //                 ),
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ],
    ),
  );
}

