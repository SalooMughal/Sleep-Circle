import 'dart:async';
import 'dart:developer';

import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:demoapp/Widgets/Widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:noise_meter/noise_meter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../Controller/Common_Controller.dart';
import '../Profile/Wakeup_alarm/ring.dart';
import 'Track_Sleep.dart';

class Connect_to_charger extends StatefulWidget {
  const Connect_to_charger({super.key});

  @override
  State<Connect_to_charger> createState() => _Connect_to_chargerState();
}

class _Connect_to_chargerState extends State<Connect_to_charger> {
  bool _isRecording = false;

  NoiseReading? _latestReading;
  StreamSubscription<NoiseReading>? _noiseSubscription;
  NoiseMeter? noiseMeter;
  StreamController<AlarmSettings> _streamController = StreamController<AlarmSettings>.broadcast();

  StreamSubscription<AlarmSettings>? subscription;

  @override
  Future<bool> _checkPermission() async {
    var status = await Permission.microphone.status;
    if (!status.isGranted) {
      status = await Permission.microphone.request();
      print(status);
    }
    return status.isGranted;
  }
  void initState() {


    _checkPermission();
    subscription = _streamController.stream.listen(
          (alarmSettings) => Get.to(ExampleAlarmRingScreen(alarmSettings: alarmSettings)),
    );
    super.initState();
  }
  void dispose() {
    _noiseSubscription?.cancel();
    super.dispose();
  }
  CommonController commonController = Get.find<CommonController>();


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: Get.height*0.12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: Get.height*0.25,
                  width: Get.width*0.55,
                  alignment: Alignment.center,
                  child: Container(
                    height: Get.height*0.16,
                    width: Get.width*0.36,
                    decoration: BoxDecoration(
                      color: Color(0xFF2A2C58),
                     shape: BoxShape.circle
                    ),
                    child: Container(
                      height: 50,
                      width: 50,
                      alignment: Alignment.center,
                      child: SvgPicture.asset('assets/images/Group (6).svg'),
                    )
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage('assets/images/Group.png'),
                    fit: BoxFit.cover)
                  ),
                )
              ],
            ),
            SizedBox(
              height: Get.height*0.12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Connect to the charger',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Get.height*0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      'Connect to a charger, otherwise sleep',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        height: 0.11,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 17.0),
                      child: Text(
                        'tracker will stop in the night.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          height: 0.11,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: Get.height*0.08,
            ),
            GestureDetector(
              onTap: (){
                log('id ${commonController.uid}');

                Get.to(TrackSleep(latestReading:_latestReading?.meanDecibel.toStringAsFixed(2), ));
              },
                child: Application_Button('CONTINUE')),
            SizedBox(
              height: Get.height*0.04,
            ),
            GestureDetector(
              onTap: (){
                Get.to(TrackSleep(latestReading:_latestReading?.meanDecibel.toStringAsFixed(2), ));

              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don’t show again',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
