import 'dart:async';

import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demoapp/View/Profile/Wakeup_alarm/Home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';

import '../../../Controller/Common_Controller.dart';
import '../../../Widgets/Widgets.dart';

class ExampleAlarmRingScreen extends StatefulWidget {
  RxInt? selectedindex_feelnow;
  Timer? timer;
  DateTime? endtime;
  Duration? duration;
  RxInt? selectedindex_sleepactivities;
  RxInt? selectedindex_environement;
  RxBool? isquit;
  Future<void> Function()? stop;
  String? origin;
  final AlarmSettings alarmSettings;

   ExampleAlarmRingScreen({Key? key, required this.alarmSettings, this.origin,this.selectedindex_feelnow,this.stop,this.isquit,this.selectedindex_environement,this.selectedindex_sleepactivities, this.timer, this.endtime, this.duration })
      : super(key: key);

  @override
  State<ExampleAlarmRingScreen> createState() => _ExampleAlarmRingScreenState();
}

class _ExampleAlarmRingScreenState extends State<ExampleAlarmRingScreen> {
  CommonController commonController=Get.find<CommonController>();
  StreamSubscription<AlarmSettings>? subscription;

  void deleteDocumentById( String matchId) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(commonController.uid.value).collection('alarms').doc(matchId)
          .delete();
    } catch (e) {
    }
  }
  void showCustomDialog() {
    Get.dialog(
      Dialog(
        backgroundColor: const Color(0xFF2A2C58),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          height: Get.height * 0.22,
          width: Get.width * 0.8,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              const Text(
                'Sleep Tracking',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: Get.height*0.02,),
              const Text(
                'Are you sure you want to stop ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  height: 0.07,
                ),
              ),
              SizedBox(height: Get.height*0.02,),
              const Text(
                'your sleep tracking?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  height: 0.07,
                ),
              ),
              SizedBox(height: Get.height*0.05,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: (){
                      Alarm.stop(widget.alarmSettings.id).then((_) {
                        Get.back();
                        Get.back();
        }

                      );
                      deleteDocumentById(widget.alarmSettings.id.toString());
                      setState(() {
                        alarms.clear();
                      });

                    },
                    child: Container(
                      width: 130,
                      height: 41,
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF2A2C58),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            width: 1,
                            strokeAlign: BorderSide.strokeAlignOutside,
                            color: Color(0xFFD3FB8F),
                          ),
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Keep tracking',
                            style: TextStyle(
                              color: Color(0xFFD3FB8F),
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: ()async{
                      Alarm.stop(widget.alarmSettings.id)
                          .then((_) =>   Sleep_notes_bottom_sheet(widget.selectedindex_feelnow!,widget.selectedindex_sleepactivities!,widget.selectedindex_environement!,widget.isquit!,widget.stop!,subscription,context)
                      );
                      deleteDocumentById(widget.alarmSettings.id.toString());
                      setState(() {
                        alarms.clear();
                      });

                    },
                    child: Container(
                      width: 130,
                      height: 41,
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFD3FB8F),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Stop',
                            style: TextStyle(
                              color: Color(0xFF101334),
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "You alarm is ringing...",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const RippleAnimation(
              color: Colors.black,
              delay: Duration(milliseconds: 300),
              repeat: true,
              minRadius: 75,
              ripplesCount: 6,
              duration: Duration(milliseconds: 6 * 300),
              child: Text("🔔", style: TextStyle(fontSize: 50)),
            ),
            // const Text("🔔", style: TextStyle(fontSize: 50)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                RawMaterialButton(
                  onPressed: () {

                    final now = DateTime.now();
                    Alarm.set(
                      alarmSettings: widget.alarmSettings.copyWith(
                        dateTime: DateTime(
                          now.year,
                          now.month,
                          now.day,
                          now.hour,
                          now.minute,
                          0,
                          0,
                        ).add(const Duration(minutes: 1)),
                      ),
                    ).then((_) => Navigator.pop(context));
                  },
                  child: Text(
                    "Snooze",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                RawMaterialButton(
                  onPressed: () {
                    if(widget.origin=='Tracking'){
                      showCustomDialog();
                    }
                 else{
                      Alarm.stop(widget.alarmSettings.id)
                          .then((_) => Navigator.pop(context));
                      deleteDocumentById(widget.alarmSettings.id.toString());
                      setState(() {
                        alarms.clear();
                      });
                    }

                  },
                  child: Text(
                    "Stop",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
