import 'dart:async';
import 'dart:io';
import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demoapp/Firebase_interface/Firebase_interface.dart';
import 'package:demoapp/Utlis/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:noise_meter/noise_meter.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../Controller/Common_Controller.dart';
import '../../Widgets/Widgets.dart';
import '../Home/HomeScreen.dart';
import '../Profile/Wakeup_alarm/Home.dart';
import '../Profile/Wakeup_alarm/ring.dart';
import '../Sounds/Snooze_Items.dart';
import '../Sounds/Sound_Screen.dart';

class TrackSleep extends StatefulWidget {
  String? latestReading;

  TrackSleep({super.key, this.latestReading});

  @override
  State<TrackSleep> createState() => _TrackSleepState();
}

class _TrackSleepState extends State<TrackSleep> {
  DateTime? _startTime;
  String current_datetime='';
  DateTime? _endTime;
  String? Datetime;
  Duration? duration;
  FlutterSoundRecorder? _recorder;
  bool _isRecording = false;
  NoiseReading? _latestReading;
  double decible=0.0;
  StreamSubscription<NoiseReading>? _noiseSubscription;
  NoiseMeter? noiseMeter;
  RxBool isquit=false.obs;
  CommonController commonController = Get.find<CommonController>();
  RxInt selectedindex_feelnow=0.obs;
  RxInt selectedindex_sleepactivities=0.obs;
  RxInt selectedindex_environement=0.obs;
  Duration Deep_Sleep = Duration.zero;
  Duration Average_Sleep = Duration.zero;
  Duration Restfulness_Sleep = Duration.zero;
  Timer? _timer;
  Timer? _timer2;
  final List<bool> _alarmOnOff = [];
  StreamSubscription<AlarmSettings>? subscription;
  @override
  void initState() {
    initializeAudioPlayer();
    super.initState();
    if (Alarm.android) {
      checkAndroidNotificationPermission();
    }
    loadAlarms();
    // Alarm.ringStream.stream.asBroadcastStream();
    //   subscription = Alarm.ringStream.stream.listen((alarmSettings) {
    //     Get.to(ExampleAlarmRingScreen(alarmSettings: alarmSettings, origin: 'Tracking', stop: stop, selectedindex_environement: selectedindex_environement, selectedindex_feelnow: selectedindex_feelnow, selectedindex_sleepactivities: selectedindex_sleepactivities, isquit: isquit, duration: duration))?.then((value) => {});
    //   });
    final dateFormat = DateFormat('h:mma');
    current_datetime = dateFormat.format(DateTime.now());
    _initializeRecorder();
    start();
  }

  void loadAlarms() {
    setState(() {
      alarms = Alarm.getAlarms();
      for (int i = 0; i < alarms.length; i++) {
        if (alarms[i].dateTime.year == 2050) {
          _alarmOnOff.add(false);
        } else {
          _alarmOnOff.add(true);
        }
      }
      alarms.sort((a, b) => a.dateTime.isBefore(b.dateTime) ? 0 : 1);
    });
  }

  Future<void> checkAndroidNotificationPermission() async {
    final status = await Permission.notification.status;
    if (status.isDenied) {
      alarmPrint('Requesting notification permission...');
      final res = await Permission.notification.request();
      alarmPrint(
        'Notification permission ${res.isGranted ? '' : 'not'} granted.',
      );
    }
  }

  Future<void> checkAndroidExternalStoragePermission() async {
    final status = await Permission.storage.status;
    if (status.isDenied) {
      alarmPrint('Requesting external storage permission...');
      final res = await Permission.storage.request();
      alarmPrint(
        'External storage permission ${res.isGranted ? '' : 'not'} granted.',
      );
    }
  }
  @override
  void dispose() {

    super.dispose();
  }

  void onData(NoiseReading noiseReading) {
    setState(() => _latestReading = noiseReading);
    decible=_latestReading!.meanDecibel;

  }


  void onError(Object error) {
    stop();
  }

  Future<void> _initializeRecorder() async {
    _recorder = FlutterSoundRecorder();
    await _recorder!.openRecorder();
  }
  void startTimer() {
    _timer2 = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_latestReading!.meanDecibel < 30) {
          Deep_Sleep += const Duration(seconds: 1);
        }
        else if (_latestReading!.meanDecibel > 30 && _latestReading!.meanDecibel <= 50) {
          Average_Sleep += const Duration(seconds: 1);
        }
        else if(decible>50){
          Restfulness_Sleep += const Duration(seconds: 1);

        }

      });
    });}
  void stopTimer() {
    _timer2?.cancel();

  }
  Future<bool> _checkPermission() async {
    var status = await Permission.microphone.status;
    if (!status.isGranted) {
      status = await Permission.microphone.request();
    }
    return status.isGranted;
  }

  Future<void> start() async {

    startTimer();
    noiseMeter ??= NoiseMeter();
    _startTime = DateTime.now();
    _noiseSubscription = noiseMeter?.noise.listen(onData, onError: onError);
    if (_isRecording) {
      onData(_latestReading!);
    }
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {

    });

    setState(() => _isRecording = true);
    await _recorder!.startRecorder(
      toFile: 'audio.aac',
      codec: Codec.aacADTS,
    );
    setState(() {
      _isRecording = true;
    });
  }
  AudioPlayer audioPlayer=AudioPlayer();
  Future<void> stop() async {
    if (!_isRecording) return;
    _noiseSubscription?.cancel();
    stopTimer();
    _endTime=DateTime.now();
    _timer?.cancel();
    duration = _endTime?.difference(_startTime!);
    final dateFormat = DateFormat('MMMM d, yyyy');
    Datetime = dateFormat.format(DateTime.now());
    setState(() => _isRecording = false);
    final filePath = await _recorder!.stopRecorder();
    setState(() {
      _isRecording = false;
    });

    if (filePath != null) {
      final file = File(filePath);
      if(commonController.uid.value=='abc'){
        Get.snackbar('Error', 'Please login first!');

      }else{
        await Firebase_intefacee().uploadFileToFirebase(file,duration,Deep_Sleep,Average_Sleep,Restfulness_Sleep,Datetime!,_startTime!,_endTime!,);
      }
    }
  }
  int selectedMusicIndex = -1;
  void initializeAudioPlayer() {
    // Listen to audio player state changes
    audioPlayer.onPlayerComplete.listen((event) {
      // When playback completes, reset selectedMusicIndex
      setState(() {
        selectedMusicIndex = -1;
      });
    });

    // You might also want to handle errors and other state changes as needed

  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        return false;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: Get.height * 0.28,
                width: Get.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/Illustration.png'),
                    fit: BoxFit.fitWidth,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      'Tracking',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        height: 0.07,
                      ),
                    ),
                    SizedBox(height: Get.height * 0.03),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Ambient Noise: ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            height: 0.07,
                          ),
                        ),
                        Text(
                          'dB:${_latestReading?.meanDecibel.toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: AppColor.themeColor,
                            fontSize: 13,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            height: 0.07,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: Get.height * 0.08),
              Text(
                current_datetime,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFFD3FB8F),
                  fontSize: 42,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
              ),
              SizedBox(height: Get.height * 0.003),
              const Text(
                'Alarm 0:00',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
          Obx(()=>
          commonController.playaudiofav.isNotEmpty?Padding(
              padding: EdgeInsets.only(top: 0.sp),
              child: TopMixes_Home_Player(context,commonController.playaudiofav,commonController.Audio_name_fav,commonController.Play_Stop_fav,commonController.volumes_fav,commonController.FavouritesIcons)
          ):const Text('')),
              Obx(()=>
              commonController.Detail_Playing_items.isEmpty?Container():Padding(
                padding:  EdgeInsets.only(top: 0.sp),
                child: TopMixes_Home_Player(context,commonController.Detail_Playing_items,commonController.Detail_Mixesname,commonController.Detail_play_stop,commonController.Detail_Volume,commonController.Top_Mixes_Details_Icons),
              ),

              ),
              Obx(()=>
              commonController.Playing_items.isEmpty?Container():Padding(
                  padding:  EdgeInsets.only(top: 0.sp),
                  child: TopMixes_Home_Player(context,commonController.Playing_items,commonController.TopMixes_name,commonController.Home_play_stop,commonController.Home_Volume,commonController.TopMixes_icons)),
              ),
          Obx(()=> commonController.playaudio.isNotEmpty||commonController.mixes.isNotEmpty?Padding(
              padding:  EdgeInsets.only(top: 0.sp),
              child: TopMixes_Home_Player(context, commonController.playaudio.value, commonController.Audio_name.value,play_stop,volumes,commonController.soundsicons)
          ):const Text('')),
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection('Top rated Sound').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return commonController.Detail_Playing_items.isEmpty &&
                      commonController.Playing_items.isEmpty &&
                      commonController.mixes.isEmpty&& commonController.playaudiofav.isEmpty
                      ? Container(
                    height: 120.h,
                    width: Get.width,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (context, index) {
                        bool isSelected =
                            index == selectedMusicIndex; // Check if this item is selected

                        return Row(
                          children: [
                            SizedBox(
                              width: 15,
                            ),
                            GestureDetector(
                              onTap: () {
                                // If the same music item is tapped again
                                if (selectedMusicIndex == index) {
                                  // Stop playback
                                  audioPlayer.stop();
                                  // Reset selected index
                                  setState(() {
                                    selectedMusicIndex = -1;
                                  });
                                } else {
                                  // Stop any previously playing audio
                                  audioPlayer.stop();

                                  // Set the new source URL and resume playback
                                  audioPlayer.setSourceUrl(
                                      snapshot.data?.docs[index]['music']);
                                  audioPlayer.resume();

                                  // Update selected index to this item
                                  setState(() {
                                    selectedMusicIndex = index;
                                  });
                                }
                              },
                              child: Container(
                                height: 120.h,
                                width: 200.w,
                                decoration: ShapeDecoration(
                                  color: isSelected ? Color(0xFF1B2050) : Color(0xB21B2050),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 1,
                                        color: isSelected
                                            ? Color(0xFF35CDFF)
                                            : Colors.transparent), // Blue border when selected
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(top: 20.0, left: 15),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${snapshot.data?.docs[index]['Name']}',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13.46.sp,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w400,
                                              height: 0.16,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(top: 15.0),
                                            child: Text(
                                              'Music',
                                              style: TextStyle(
                                                color: Color(0xFF636598),
                                                fontSize: 12.55,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w400,
                                                height: 0.23,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 233.w,
                                      height: 40.h,
                                      decoration: ShapeDecoration(
                                        color: isSelected ? Color(0xFF1B2050) : Color(0xB21B2050),
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              width: 1,
                                              color: isSelected
                                                  ? Color(0xFF35CDFF)
                                                  : Colors.transparent), // Blue border when selected
                                          borderRadius: BorderRadius.circular(16),
                                        ),
                                      ),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(top: 8.0),
                                            child: isSelected?SvgPicture.asset(
                                              'assets/icons/stop.svg',
                                              height: 70,
                                              width: 70,
                                            ):SvgPicture.asset(
                                              'assets/images/Group 7032 (1).svg',
                                              height: 60,
                                              width: 60,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  )
                      : Text('');
                } else
                  return Center(child: CircularProgressIndicator());
              },
            ),

            SizedBox(height: Get.height * 0.06),
              GestureDetector(
                onTap: () async {
                  Sleep_notes_bottom_sheet(selectedindex_feelnow,selectedindex_sleepactivities,selectedindex_environement,isquit,stop,subscription,context);
                  // if(duration!.inSeconds<3600){
                  //   Get.to(const Quit_Tracking());
                  // }else{
                  //
                  // }

                },
                child: Column(
                  children: [
                    Container(
                      width: 74.91,
                      height: 74.91,
                      alignment: Alignment.center,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF191D48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(44.94),
                        ),
                      ),
                      child: const Text(
                        'Quit',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ),
                    Center(
                      child: Lottie.asset(
                        'assets/animations/Waves.json', // Path to your local animation JSON file
                        width: 200,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
