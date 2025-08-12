import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demoapp/View/Home/HomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:get/state_manager.dart';
import 'package:just_audio/just_audio.dart'as package1;

import '../Widgets/App_Font.dart';
import '../Widgets/Widgets.dart';
import '../models/Music_model.dart';

class CommonController extends GetxController{
  RxString Audioname=''.obs;
  RxBool isaudioplaying=false.obs;
  RxList add_new=[].obs;
  List Mixes_images=['assets/images/sea.svg','assets/images/waves.svg','assets/images/wind.svg'];
  RxBool isPlaying_for_music=false.obs;
  RxString Audioimage=''.obs;
  RxDouble Goal_hours=0.0.obs;
  RxString Bedtime=''.obs;
  RxInt selectedIndex = 0.obs;
  RxString uid=''.obs;
  RxList mixes=[].obs;
  RxList mixesfav=[].obs;
  List filterdates=[].obs;
  RxString checkin=''.obs;
  RxString Selectedcat=''.obs;
  //Fav Player Variable
  final RxList<String> playaudio = <String>[].obs;
  final RxList<String> playaudiofav = <String>[].obs;
  RxBool Play_Stop_fav=false.obs;
  RxList FavouritesIcons=[].obs;
   RxList Audio_name = [].obs;
   RxList Audio_name_fav = [].obs;
  RxList volumes_fav = [].obs;
  //Home Screen Mixes  variables
  RxBool play_stop=false.obs;
  RxList TopMixes_icons=[].obs;
  RxBool snoozeplaystop=false.obs;
  RxBool Home_play_stop=false.obs;
  RxList Playing_items=[].obs;
  RxList Home_Volume=[].obs;
  RxList TopMixes_name=[].obs;
  RxString Set_bedtime=''.obs;
  // Top Mixes details variables
  RxBool Detail_play_stop=false.obs;
  RxList Detail_Playing_items=[].obs;
  RxList Top_Mixes_Details_Icons=[].obs;
  RxList Detail_Mixesname=[].obs;
  RxList Detail_Volume=[].obs;

  //Sounds variables
  RxList soundsicons=[].obs;


  var Music_items = <Music>[].obs;
  Rx<Music?> currentlyPlaying = Rx<Music?>(null);
  AudioPlayer audioPlayer = AudioPlayer();

  CommonController() {
    audioPlayer.onPlayerComplete.listen((_) {
      onMusicComplete();
    });
  }

  void onMusicComplete() {
    if (currentlyPlaying.value != null) {
      currentlyPlaying.value!.isplaying = false;
      currentlyPlaying.value = null;
      update();  // Notify listeners to update the UI
    }
  }

  void playMusic(Music music) async {
    clearallmusic();
    if (currentlyPlaying.value != null) {
      currentlyPlaying.value!.isplaying = false;
      await audioPlayer.stop();
    }
    music.isplaying = true;
    currentlyPlaying.value = music;
    Music_items.clear();
    Music_items.add(music);
    await audioPlayer.setSourceUrl(music.url);
    await audioPlayer.resume();
    update();  // Notify listeners to update the UI
  }

  void stopMusic_for_dailypicks() async {
    if (currentlyPlaying.value != null) {
      currentlyPlaying.value!.isplaying = false;
      await audioPlayer.stop();
      currentlyPlaying.value = null;
      update();  // Notify listeners to update the UI
    }
  }

  Future toggleMusic(Music music) async{

    print('Toggled music: ${music.name}, URL: ${music.url}');
    if (currentlyPlaying.value != null) {

      print('Currently playing: ${currentlyPlaying.value!.name}, URL: ${currentlyPlaying.value!.url}');
    }

    if (currentlyPlaying.value?.url == music.url && currentlyPlaying.value!.isplaying) {
      stopMusic_for_dailypicks();
    } else {
     if(commonController.uid.value!='abc'){
       Map<String, dynamic> body={
         'Icon':music.Icon,
         'Name':music.name,
         'music':music.url,
         'Duration':music.duration
       };
       final response=await FirebaseFirestore.instance.collection('users').doc(uid.value).collection('Recently Played').doc();
       response.set(body);
     }
      playMusic(music);
    }
  }
  Future toggleMusic_forRecentlymusic(Music music) async{
    print('Toggled music: ${music.name}, URL: ${music.url}');
    if (currentlyPlaying.value != null) {

      print('Currently playing: ${currentlyPlaying.value!.name}, URL: ${currentlyPlaying.value!.url}');
    }

    if (currentlyPlaying.value?.url == music.url && currentlyPlaying.value!.isplaying) {
      stopMusic_for_dailypicks();
    } else {

      playMusic(music);
    }
  }
  void clearMusicList() {
    Music_items.clear();
    stopMusic_for_dailypicks();
  }


  void name_bottom_sheet(List Audioname, List Audionurl ) {
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
                  Text('===');
                  Map<String, dynamic> body={
                    'Audio_url':commonController.playaudio,
                    'Audio_name':commonController.Audio_name,
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
                 Get.back();
                },
                child: Application_Button('SAVE'))
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
    );
  }

}