import 'dart:async';
import 'dart:developer';


import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demoapp/Utlis/theme.dart';
import 'package:demoapp/View/Profile/Wakeup_alarm/ring.dart';
import 'package:demoapp/Widgets/Widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../Controller/Common_Controller.dart';
import '../../../Widgets/Alarm.dart';
import '../../../Widgets/App_Font.dart';
import '../../../Widgets/Notification.dart';
import '../../../Widgets/Testnotification.dart';
import 'Edit_page.dart';
late List<AlarmSettings> alarms;

class ExampleAlarmHomeScreen extends StatefulWidget {
  const ExampleAlarmHomeScreen({super.key});

  @override
  State<ExampleAlarmHomeScreen> createState() => _ExampleAlarmHomeScreenState();
}

class _ExampleAlarmHomeScreenState extends State<ExampleAlarmHomeScreen> {

  final List<bool> _alarmOnOff = [];


  CommonController commonController=Get.find<CommonController>();
  static StreamSubscription<AlarmSettings>? subscription;

  @override
  void initState() {
    super.initState();

    if (Alarm.android) {


    }
    loadAlarms();
    // subscription ??= Alarm.ringStream.stream.listen((alarmSettings) => Get.to( ExampleAlarmRingScreen(alarmSettings: alarmSettings,))
    //
    // );

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

  Future<void> navigateToRingScreen(AlarmSettings alarmSettings) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ExampleAlarmRingScreen(alarmSettings: alarmSettings),
        ));
    loadAlarms();
  }

  Future<void> navigateToAlarmScreen(AlarmSettings? settings) async {
    // final res = await showModalBottomSheet<bool?>(
    //     context: context,
    //     isScrollControlled: true,
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(10.0),
    //     ),
    //     builder: (context) {
    //       return FractionallySizedBox(
    //         heightFactor: 0.75,
    //         child: ExampleAlarmEditScreen(alarmSettings: settings),
    //       );
    //     });
    final res = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ExampleAlarmEditScreen(
              alarmSettings: settings,
            )));

    if (res != null && res == true) loadAlarms();
  }



  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  List items=[];
  String Split='';
  String Split2='';
  // final NotificationService _notificationService = NotificationService();

  List<Map<String, dynamic>> dataList=[];
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: BackArrow(),
              ),
              // const SizedBox(height: 100),
              // const Center(child: Realtime()),
              // const SizedBox(height: 60),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     IconButton(
              //       onPressed: () => navigateToAlarmScreen(null),
              //       icon: const Icon(Icons.add),
              //     ),
              //   ],
              // ),
              SizedBox(height: Get.height*0.02,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      'Alarm',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                        height: 0,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        alarms.isEmpty?SvgPicture.asset('assets/images/notifications_off.svg'):SvgPicture.asset('assets/images/notifications_active.svg'),
                                        SizedBox(height: Get.height*0.04,),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 5.0,top: 0),
                                          child: Text(
                                            '${alarms.isEmpty?'No':alarms.length} alarm set',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w400,
                                              height: 0.15,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: Get.height*0.02,
                            ),
                            SizedBox(
                              height: Get.height*0.55,
                              width:  alarms.isEmpty?Get.width*0.7:Get.width*0.93,
                              child: alarms.isEmpty?Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width:100,
                                  child: SvgPicture.asset('assets/images/Group (4).svg',
                                    fit: BoxFit.contain,

                                  ),
                                ),
                              ):ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: alarms.length,
                                itemBuilder: (context, index) {
                                  DateTime currentTime = DateTime.now();
                                  currentTime.add(const Duration(minutes: 2));

                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: _buildAlarmCard(alarms[index], index, alarms[index].dateTime,alarms[index].id.toString()),
                                  );
                                },
                              ),
                            ),
                          ],
                        )


                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                          onTap: (){
                            navigateToAlarmScreen(null);
                          },
                          child: Application_Button('SET ALARM')
                      )),
                ],
              ),
            ],
          )),
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.all(10),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       ExampleAlarmHomeShortcutButton(refreshAlarms: loadAlarms),
      //       FloatingActionButton(
      //         onPressed: () => navigateToAlarmScreen(null),
      //         child: const Icon(Icons.alarm_add_rounded, size: 33),
      //       ),
      //     ],
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void deleteDocumentById( String matchId) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(commonController.uid.value).collection('alarms').doc(matchId)
          .delete();
      if (kDebugMode) {
        print("Document with ID $matchId deleted successfully.");
      }
    } catch (e) {
    }
  }
  Widget _buildAlarmCard(AlarmSettings alarm, int index, DateTime time,String alarmid) {
    DateFormat dateFormat = DateFormat("hh:mm a");
    String formattedTime = dateFormat.format(time);
    final timeParts = formattedTime.split(' ');
    Split = timeParts[0]; // "HH:MM"
    Split2 = timeParts.length > 1 ? timeParts[1] : ''; // "PM"
    String formattedDate = DateFormat('EEE, d MMM').format(alarm.dateTime);
    return GestureDetector(
      child: Slidable(
        closeOnScroll: true,
        endActionPane: ActionPane(
            extentRatio: 0.4,
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                foregroundColor: Colors.white,
                borderRadius: BorderRadius.circular (12),
                onPressed: (context) {
                  // deleteDocumentById(alarmid.toString());
                  alarms.removeAt(index);
                  Alarm.stop(int.parse(alarmid));
                  setState(() {

                  });
                },
                icon: Icons.delete_forever,
                backgroundColor: Colors.red.shade700,
              )
            ]),
        child: Container(
          decoration: ShapeDecoration(
            color: Color(0xFF2A2C58),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0,left: 20),
                child: const Text(
                  'Work',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    height: 0.15,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: ListTile(
                  splashColor: null,
                  dense: true,
                  minVerticalPadding: 10,
                  horizontalTitleGap: 10,
                  enabled: false,
                  // onLongPress: () {
                  //   // print("object");
                  // },
                  title: Row(
                    children: [
                      Text(
                        '${Split}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                      Text(
                        '  ${Split2}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),

                      const Expanded(child: Text("")),
                      Text(formattedDate.toString()),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              // const SlideTransitionExample()
            ],
          ),
        ),
      ),
    );
  }
}