import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';

// Assuming these are your custom imports, adjust as per your project structure

import '../../Controller/Common_Controller.dart';
import '../../Utlis/theme.dart';
import '../../Widgets/App_Font.dart';
import '../Home/HomeScreen.dart';
AudioPlayer audioPlayer_for_music = AudioPlayer();

class Audio_Player extends StatefulWidget {
  final String? url;
  final String? image;
  final String? name;
  final List<dynamic>? musics;

  Audio_Player({Key? key, this.name, this.url, this.image, this.musics})
      : super(key: key);

  @override
  _Audio_PlayerState createState() => _Audio_PlayerState();
}

class _Audio_PlayerState extends State<Audio_Player> {
  CommonController commonController = Get.find<CommonController>();

  Duration totalDuration = const Duration();
  Duration currentPosition = const Duration();
  int currentMusicIndex = 0;
  String nextimage = '';
  String? favoriteDocId;
  String nextname = '';
  bool isFavorite = false;
  @override
  void initState() {
    super.initState();
    super.initState();
    checkIfFavorite();
    commonController.stopMusic_for_dailypicks();
    clearallmusic();

    // Set up listeners for audio player events
    audioPlayer_for_music.onDurationChanged.listen((Duration duration) {
      setState(() {
        totalDuration = duration;
      });
    });

    audioPlayer_for_music.onPositionChanged.listen((Duration duration) {
      setState(() {
        currentPosition = duration;
      });
    });

    // Set up the listener for when the player completes
    audioPlayer_for_music.onPlayerComplete.listen((event) {
      audioPlayer_for_music.seek(Duration.zero);
      audioPlayer_for_music.resume();
    });

    // Set the initial audio source URL and start playing
    audioPlayer_for_music.setSourceUrl('${widget.url}');
    audioPlayer_for_music.resume();

    // Set initial state of play/pause button
    audioPlayer_for_music.onPlayerStateChanged.listen((PlayerState state) {
      setState(() {
        commonController.isPlaying_for_music.value = state == PlayerState.playing;
      });
    });
  }
  void toggleFavorite() async {
    if (commonController.uid.value == 'abc') {
      Get.snackbar('Error', 'Please login first!');
      return;
    }

    if (isFavorite) {
      // Remove from favorites
      await FirebaseFirestore.instance
          .collection('users')
          .doc(commonController.uid.value)
          .collection('Favourites')
          .doc(favoriteDocId)
          .delete()
          .then((value) {
        Get.snackbar('Removed Successfully', 'Your music has been removed from favorites');
        setState(() {
          isFavorite = false;
        });
      }).catchError((error) {
        Get.snackbar('Error', '$error');
        print(error);
      });
    } else {
      // Add to favorites
      final response = FirebaseFirestore.instance
          .collection('users')
          .doc(commonController.uid.value)
          .collection('Favourites')
          .doc();

      Map<String, dynamic> body = {
        'Category': 'Music',
        'Icon': widget.image,
        'Name': widget.name,
        'music': widget.url,
        'duration': totalDuration.toString()
      };

      response.set(body).then((value) {
        Get.snackbar('Added Successfully', 'Your music has been added to favorites');
        setState(() {
          isFavorite = true;
          favoriteDocId = response.id;
        });
      }).catchError((error) {
        Get.snackbar('Error', '$error');
        print(error);
      });
    }
  }
  @override
  void dispose() {
    super.dispose();
  }
  void checkIfFavorite() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(commonController.uid.value)
        .collection('Favourites')
        .where('music', isEqualTo: widget.url)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      setState(() {
        isFavorite = true;
        favoriteDocId = querySnapshot.docs.first.id;
      });
    } else {
      setState(() {
        isFavorite = false;
      });
    }
  }
  // Function to seek to a specific position in the audio
  void seekToSecond(double second) {
    Duration newPosition = Duration(
        milliseconds: (second * totalDuration.inMilliseconds / 100.0).round());
    audioPlayer_for_music.seek(newPosition);
  }

  // Function to play the next music in the list
  void playNext() {
    if (currentMusicIndex < widget.musics!.length - 1) {
      currentMusicIndex++;
      String nextUrl = widget.musics![currentMusicIndex]['music'];
      nextimage = '${widget.musics![currentMusicIndex]['Icon']}';
      nextname = '${widget.musics![currentMusicIndex]['Name']}';
      audioPlayer_for_music.setSourceUrl(nextUrl);
      audioPlayer_for_music.resume();
      setState(() {
        currentPosition = Duration.zero;
        totalDuration = Duration.zero;
      });
    }
  }

  // Function to play the previous music in the list
  void playPrevious() {
    if (currentMusicIndex > 0) {
      currentMusicIndex--;
      String prevUrl = widget.musics![currentMusicIndex]['music'];
      nextimage = '${widget.musics![currentMusicIndex]['Icon']}';
      nextname = '${widget.musics![currentMusicIndex]['Name']}';
      audioPlayer_for_music.setSourceUrl(prevUrl);
      audioPlayer_for_music.resume();
      setState(() {
        currentPosition = Duration.zero;
        totalDuration = Duration.zero;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: AppColor.scaffold,
      body: Stack(
        children: [
          ColorFiltered(
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.6), BlendMode.dstATop),
            child: SvgPicture.network(
              '${nextimage.isEmpty ? widget.image : nextimage}',
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              // Adjust sigmaX and sigmaY for blur intensity
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        commonController.Audioname.value=widget.name!;
                        commonController.Audioimage.value=widget.image!;                        commonController.isaudioplaying.value=true;
                      },
                      child: Icon(Icons.arrow_back_ios_new_rounded),
                    ),
                  )
                ],
              ),
              SizedBox(height: Get.height * 0.25),
              Text(
                '${nextname.isEmpty ? widget.name : nextname}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: AppFonts.fontFamily,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 50),
              const Text(
                'Jason Stepheson',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: AppFonts.fontFamily,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Text(
                  'Artist',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: AppFonts.fontFamily,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: Get.height * 0.2),
              Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 30),
                child: ProgressBar(
                  progress: currentPosition,
                  total: totalDuration,
                  onSeek: (duration) {
                    setState(() {
                      currentPosition = duration;
                      seekToSecond(currentPosition.inMilliseconds.toDouble() /
                          totalDuration.inMilliseconds *
                          100.0);
                    });
                  },
                  timeLabelLocation: TimeLabelLocation.below,
                  thumbRadius: 8.0,
                  barHeight: 8.0,
                  baseBarColor: Colors.grey[800],
                  progressBarColor: const Color(0xFF35CDFF),
                  bufferedBarColor: Colors.grey[600],
                  thumbColor: const Color(0xFF35CDFF),
                  timeLabelTextStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: AppFonts.fontFamily,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: toggleFavorite,
                    child: SvgPicture.asset(
                      isFavorite
                          ? 'assets/icons/favorite_border.svg'
                          : 'assets/images/favorite_border (1).svg',
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        playPrevious();
                      },
                      child: SvgPicture.asset('assets/images/playback.svg')),
                  GestureDetector(
                    onTap: () {
                      if (commonController.isPlaying_for_music.value) {
                        audioPlayer_for_music.pause();
                      } else {
                        audioPlayer_for_music.resume();
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: commonController.isPlaying_for_music.value
                          ? SvgPicture.asset(
                              'assets/icons/stop.svg',
                              height: 80,
                              width: 80,
                            )
                          : SvgPicture.asset(
                              'assets/images/Group 7032 (1).svg',
                              height: 80,
                              width: 80,
                            ),
                    ),
                  ),

                  GestureDetector(
                      onTap: () {
                        playNext();
                      },
                      child:
                          SvgPicture.asset('assets/images/playback (1).svg')),
                  GestureDetector(
                    onTap: () async {
                      if(commonController.uid.value=='abc'){
                        Get.snackbar('Error', 'Please login first!');

                      }else{
                        final response = await FirebaseFirestore.instance
                            .collection('users')
                            .doc(commonController.uid.value)
                            .collection('Playlist')
                            .doc();

                        // Generate a new document ID
                        String docId = response.id;

                        Map<String, dynamic> body = {
                          'Icon': widget.image,
                          'Name': widget.name,
                          'music': widget.url,
                          'duration': totalDuration.toString(),
                          'uid': docId,
                          // Include the document ID in the document
                        };

                        // Set the document with the data including the docId
                        response.set(body).then((value) {
                          Get.snackbar('Added Successful',
                              'Your music has been added to playlist successfully');
                        }).onError((error, stackTrace) {
                          Get.snackbar('Error', '$error');
                          print(error);
                        });
                      }

                    },
                    child: SvgPicture.asset('assets/images/playlist.svg'),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }


}





Widget MusicCard(){
  return
      GestureDetector(
        onTap: (){

        },
        child: Dismissible(
          key: Key('unique_key'), // unique key for each item
          direction: DismissDirection.endToStart, // swipe from right to left
          onDismissed: (direction) {
            audioPlayer_for_music.stop();
            commonController.isaudioplaying.value=false;

          },
          background: Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 20.0),
            color: Colors.red,
            child: Icon(Icons.delete, color: Colors.white),
          ),
          child: Container(
            height: Get.height*0.1,
            width: Get.width*0.95,
            clipBehavior: Clip.antiAlias,
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
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Obx(()=>
                         Container(
                          child: SvgPicture.network("${commonController.Audioimage.value}",fit: BoxFit.fill,),
                          width: 70,
                          height: 52.81,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 0, color: Color(0xFF35CDFF)),
                              borderRadius: BorderRadius.circular(9),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Obx(()=>
                               Text(
                                '${commonController.Audioname.value}',
                                style: TextStyle(
                                  color: Color(0xFFCDFF78),
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  height: 0.15,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0,left: 0),
                              child: Text(
                                'Music',
                                style: TextStyle(
                                  color: Color(0xFFDFDFDF),
                                  fontSize: 10,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  height: 0.22,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                 Padding(
                   padding: const EdgeInsets.only(right: 20.0),
                   child: GestureDetector(
                     onTap: (){
                       if (commonController.isPlaying_for_music.value) {
                         audioPlayer_for_music.pause();
                         commonController.isPlaying_for_music.value=false;
                       } else {
                         commonController.isPlaying_for_music.value=true;

                         audioPlayer_for_music.resume();
                       }
                     },
                       child: Obx(()=> commonController.isPlaying_for_music.value?SvgPicture.asset('assets/icons/pause-button.svg'):SvgPicture.asset('assets/icons/Playbutton.svg'))),
                 )
                ],
              ),
            ),
            ),
        ),
      );

}