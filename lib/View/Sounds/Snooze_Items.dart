import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:vertical_weight_slider/vertical_weight_slider.dart';

import '../../Controller/Common_Controller.dart';
import '../../Widgets/App_Font.dart';
import '../../Widgets/Widgets.dart';
import '../Home/HomeScreen.dart';
import 'Audio_Player.dart';
import 'Sound_Screen.dart';

List<AudioPlayer> audioPlayers = [];
RxList volumes = [].obs;
Widget Snooze_items(List items, RxInt selectedIndex, List musicItems, RxList mixes, List musics) {
  CommonController commonController=Get.find<CommonController>();
  RxString Selected_category='Snooring Sound'.obs;
  return Column(
    children: [
      SizedBox(
        height: 48.h,
        width: Get.width * 0.94,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  selectedIndex.value = index;
                  if(items[index]=='Snooring'){
                    Selected_category.value='Snooring Sound';
                  }else if(items[index]=='Rain'){
                    Selected_category.value='Rain sound';
                  }
                  else if(items[index]=='Thunder'){
                    Selected_category.value='Thunder';
                  }
                  else if(items[index]=='Nature'){
                    Selected_category.value='Nature';
                  }
                  else if(items[index]=='Birds'){
                    Selected_category.value='Bird Sound';
                  }
                  else if(items[index]=='ASMR'){
                    Selected_category.value='ASMR Sound';
                  }
                  else if(items[index]=='Special'){
                    Selected_category.value='Special Sound';
                  }
                  else if(items[index]=='City'){
                    Selected_category.value='City Sound';
                  }
                },
                child: Obx(() => IntrinsicWidth(
                  child: Container(
                    height: 48.h,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: index == selectedIndex.value ? const Color(0xFFD3FB8F) : const Color(0x4C9AC1FF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '${items[index]}',
                      style: TextStyle(
                        color: index == selectedIndex.value ? Colors.black : Colors.white,
                        fontSize: 13.5.sp,
                        fontFamily: AppFonts.fontFamily,
                        fontWeight: FontWeight.w500,
                        height: 1,
                      ),
                    ),
                  ),
                )),
              ),
            );
          },
        ),
      ),
      Obx(()=>
         StreamBuilder(
          stream: FirebaseFirestore.instance.collection('${Selected_category.value}').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding:  EdgeInsets.only(top: 20.0.sp, left: 15),
                child: SizedBox(
                  width: Get.width,
                  height: Get.height,
                  child: StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState){
                        return GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 1.0.sp,
                            mainAxisSpacing: 15.0.sp,
                            crossAxisCount: 4,
                          ),
                          itemCount: snapshot.data?.docs.length,
                          itemBuilder: (context, index) {

                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () async
                                  {
                                    audioPlayer_for_music.stop();
                                    commonController.isaudioplaying.value=false;
                                    clearallmusicforsnooze();
                                    String selectedUrl='';
                                    String selectedName = snapshot.data?.docs[index]['Name'];
                                    String selectedIcon = snapshot.data?.docs[index]['Icon'];

                                    if (Selected_category == 'Snooring Sound') {
                                      selectedUrl = snapshot.data?.docs[index]['Snooring_url'];
                                    } else if (Selected_category == 'Rain sound') {
                                      selectedUrl = snapshot.data?.docs[index]['Rain_url'];
                                    } else if (Selected_category == 'Thunder') {
                                      selectedUrl = snapshot.data?.docs[index]['Thunder_url'];
                                    } else if (Selected_category == 'Nature') {
                                      selectedUrl = snapshot.data?.docs[index]['Nature_url'];
                                    } else if (Selected_category == 'Bird Sound') {
                                      selectedUrl = snapshot.data?.docs[index]['Bird_url'];
                                    } else if (Selected_category == 'City Sound') {
                                      selectedUrl = snapshot.data?.docs[index]['city_url'];
                                    } else if (Selected_category == 'ASMR Sound') {
                                      selectedUrl = snapshot.data?.docs[index]['asmr_url'];
                                    } else if (Selected_category == 'Special Sound') {
                                      selectedUrl = snapshot.data?.docs[index]['special_url'];
                                    }

                                    if (commonController.playaudio.length > 6) {
                                      Get.snackbar(
                                        'Error',
                                        'You cannot add more than 7 mixes',
                                        snackPosition: SnackPosition.TOP,
                                      );
                                    } else if (commonController.Audio_name.contains(selectedName)) {
                                      int itemIndex = commonController.Audio_name.indexOf(selectedName);
                                      commonController.Audio_name.removeAt(itemIndex);
                                      commonController.mixes.removeAt(itemIndex);
                                      commonController.playaudio.value.removeAt(itemIndex);
                                      commonController.soundsicons.value.removeAt(itemIndex);
                                      volumes.removeAt(itemIndex);
                                      commonController.snoozeplaystop.value = false;
                                    } else {
                                      commonController.soundsicons.add(selectedIcon);
                                      commonController.mixes.add(selectedUrl);
                                      commonController.playaudio.value.add(selectedUrl);
                                      commonController.Audio_name.value.add(selectedName);
                                      volumes.add(1.0);
                                      commonController.snoozeplaystop.value = false;
                                    }

                                    setState(() {});
                                    // playSingleMusic('rain.mp3');
                                  },
                                  child: Obx(()=>
                                      Container(
                                        width: 63.21,
                                        height: 63.21,
                                        alignment: Alignment.center,
                                        decoration:BoxDecoration(
                                          shape: BoxShape.circle,
                            gradient: LinearGradient(colors: [commonController.Audio_name.contains(snapshot.data?.docs[index]['Name'])?Colors.pink:Color(0xFF2A2C58), commonController.Audio_name.contains(snapshot.data?.docs[index]['Name'])?Colors.yellow:Color(0xFF2A2C58)]),

                            ),
                                        child: Container(
                                          width: 60.21,
                                          height: 60.21,
                                          alignment: Alignment.center,
                                          child: SvgPicture.network(
                                            '${snapshot.data?.docs[index]['Icon']}',
                                            fit: BoxFit.cover,
                                          ),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF2A2C58),
                                            shape: BoxShape.circle,

                                          ),
                                        ),
                                      ),
                                  ),
                                ),
                                Padding(
                                  padding:  EdgeInsets.only(top: 7.0.sp),
                                  child: Container(
                                    child: Text(
                                      '${snapshot.data?.docs[index]['Name']}',
                                      textAlign: TextAlign.center,
                                      style:  TextStyle(
                                        color: Colors.white,
                                        fontSize: 9.sp,
                                        fontFamily: AppFonts.fontFamily,
                                        fontWeight: FontWeight.w400,
                                        height: 1.0,
                                      ),
                                      softWrap: true,
                                      overflow: TextOverflow.visible,
                                    ),
                                  ),
                                ),

                              ],
                            );
                          },
                        );
                      }

                  ),
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
                 ),
      ),

    ],
  );
}


Future clearall(VoidCallback updateUI)async{
  for(int i=0; i<audioPlayers.length; i++){
    await audioPlayers[i].stop();
  }
  audioPlayers.clear();
  CommonController commonController = Get.find<CommonController>();
  commonController.playaudio.clear();
  updateUI();

}
Future stopSingleMusic(int index, VoidCallback updateUI) async {
  CommonController commonController = Get.find<CommonController>();

if(audioPlayers.isNotEmpty){
  play_stop.value=false;
  // Remove the corresponding volume
  await audioPlayers[index].stop();
  audioPlayers.removeAt(index);
  volumes.removeAt(index);

  // Remove the corresponding audio path from the playaudio list
  commonController.playaudio.removeAt(index);

  // Call the callback to update the UI
  updateUI();
}
else{

  commonController.playaudio.removeAt(index);
  updateUI();
}
}


void playSingleMusic(String audioPath) async {
  AudioPlayer audioPlayer = AudioPlayer();
  await audioPlayer.setSourceUrl(audioPath);
  audioPlayer.resume();
  audioPlayers.add(audioPlayer);
}

Future pauseSingleMusic(int index,) async {
  if (audioPlayers.isNotEmpty) {
    audioPlayers.clear();
    await audioPlayers[index].pause();
    // Call the callback to update the UI
  }
}

void playMultipleMusic(List audioPaths) {
  // Clear the existing audioPlayers list
  audioPlayers.clear();

  // Add new AudioPlayer instances for each audio path
  for (var audioPath in audioPaths) {
    playSingleMusic(audioPath);

  }

}

Future pauseAllMusic() async {
  for (var audioPlayer in audioPlayers) {
    await audioPlayer.stop();

  }
}
