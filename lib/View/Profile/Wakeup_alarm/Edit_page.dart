import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demoapp/Widgets/Widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../Controller/Common_Controller.dart';
import '../../../Utlis/theme.dart';
import 'Wakeup_alarm.dart';

class ExampleAlarmEditScreen extends StatefulWidget {
  final AlarmSettings? alarmSettings;

  const ExampleAlarmEditScreen({Key? key, this.alarmSettings})
      : super(key: key);

  @override
  State<ExampleAlarmEditScreen> createState() => _ExampleAlarmEditScreenState();
}

DateTime selectedDateTime = DateTime.now();

class _ExampleAlarmEditScreenState extends State<ExampleAlarmEditScreen> {
  bool loading = false;
  CommonController commonController=Get.find<CommonController>();
  late bool creating;

  late bool loopAudio;
  late bool vibrate;
  late double? volume;
  bool volumncontroller=false;
  late String assetAudio;
  int hour = 0;
  int minute = 0;
  String amPm = 'AM';
  FixedExtentScrollController _minuteController = FixedExtentScrollController();
  FixedExtentScrollController _hourController = FixedExtentScrollController();
  FixedExtentScrollController _ampmController = FixedExtentScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _selectTime(context);
    });
    creating = widget.alarmSettings == null;


    if (creating) {
      selectedDateTime = DateTime.now().add(const Duration(minutes: 1));
      selectedDateTime = selectedDateTime.copyWith(second: 0, millisecond: 0);
      loopAudio = true;
      vibrate = true;
      volume = null;
      assetAudio = 'assets/marimba.mp3';
    } else {
      selectedDateTime = widget.alarmSettings!.dateTime;
      loopAudio = widget.alarmSettings!.loopAudio;
      vibrate = widget.alarmSettings!.vibrate;
      volume = widget.alarmSettings!.volume;
      assetAudio = widget.alarmSettings!.assetAudioPath;
    }
    int initialMinute = 30;
    _minuteController =
        FixedExtentScrollController(initialItem: selectedDateTime.minute);
    _hourController =
        FixedExtentScrollController(initialItem: selectedDateTime.hour - 1);
    if (selectedDateTime.hour > 12) {
      _ampmController = FixedExtentScrollController(initialItem: 1);
    }
  }

  String getDay() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final difference = selectedDateTime.difference(today).inDays;

    switch (difference) {
      case 0:
        return 'Today - ${DateFormat('EEE, d MMM').format(selectedDateTime)}';
      case 1:
        return 'Tomorrow - ${DateFormat('EEE, d MMM').format(selectedDateTime)}';
      default:
        return DateFormat('EEE, d MMM').format(selectedDateTime);
    }
  }
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? res = await showTimePicker(
      initialTime: TimeOfDay.fromDateTime(selectedDateTime),
      context: context,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            timePickerTheme:TimePickerThemeData(
                cancelButtonStyle: ButtonStyle(foregroundColor:MaterialStateProperty.all<Color>(Colors.white)),
                confirmButtonStyle: ButtonStyle( foregroundColor:MaterialStateProperty.all<Color>(Colors.white)),
                dayPeriodBorderSide: const BorderSide(color: AppColor.themeColor),
                hourMinuteTextColor: Colors.white,
                dialHandColor: AppColor.themeColor,
                dialBackgroundColor:AppColor.scaffold

            ),
            textSelectionTheme: const TextSelectionThemeData(
              selectionColor: Colors.red, // Change the color of the selected time here
            ),
            textTheme: const TextTheme(

              labelLarge: TextStyle(color: Colors.white), // Change the color of OK and CANCEL text here
            ),
            colorScheme: const ColorScheme.light(
              secondary:AppColor.themeColor,
              onPrimary:Colors.black,
              background: AppColor.scaffold,
              primary: AppColor.scaffold,
              surface: Color(0xFF2A2C58),
              onSurface: Colors.white,
            ),
            //.dialogBackgroundColor:Colors.blue[900],
          ),
          child: child!,
        );
      },
    );

    if (res != null) {
      setState(() {
        selectedDateTime = DateTime(
          selectedDateTime.year,
          selectedDateTime.month,
          selectedDateTime.day,
          res.hour,
          res.minute,
        );
      });
    }
  }
  Future saveAlarmToFirestore(AlarmSettings alarmSettings) async {
    final alarmData = {
      'id': alarmSettings.id,
      'dateTime': alarmSettings.dateTime,
      'loopAudio': alarmSettings.loopAudio,
      'vibrate': alarmSettings.vibrate,
      'volume': alarmSettings.volume,
      'assetAudioPath': alarmSettings.assetAudioPath,
      'notificationTitle': alarmSettings.notificationTitle,
      'notificationBody': alarmSettings.notificationBody,
    };

    final response=await FirebaseFirestore.instance.collection('users').doc(commonController.uid.value).collection('alarms').doc('${alarmSettings.id}').set(alarmData);
  }
  Future<void> pickTime() async {
    final res = await showTimePicker(
      initialTime: TimeOfDay.fromDateTime(selectedDateTime),
      context: context,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            textSelectionTheme: const TextSelectionThemeData(
              selectionColor: Colors.red, // Change the color of the selected time here
            ),
            textTheme: const TextTheme(

              labelLarge: TextStyle(color: Colors.white), // Change the color of OK and CANCEL text here
            ),
            colorScheme: const ColorScheme.light(
              secondaryContainer: Colors.white,
              primaryContainer: Colors.white,
              outline: Color(0xFFD3FB8F) ,
              secondary:Color(0xFFD3FB8F) ,

              onSurface: Colors.white,


            ),
            //.dialogBackgroundColor:Colors.blue[900],
          ),
          child: child!,
        );
      },
    );

    if (res != null) {
      setState(() {
        final DateTime now = DateTime.now();
        selectedDateTime = now.copyWith(
            hour: res.hour,
            minute: res.minute,
            second: 0,
            millisecond: 0,
            microsecond: 0);
        if (selectedDateTime.isBefore(now)) {
          selectedDateTime = selectedDateTime.add(const Duration(days: 1));
        }
      });
    }
  }

  AlarmSettings buildAlarmSettings() {
    final id = creating ? DateTime.now().millisecondsSinceEpoch % 10000 : widget.alarmSettings!.id;
    final alarmSettings = AlarmSettings(

      id: id,
      dateTime: selectedDateTime,
      loopAudio: loopAudio,
      vibrate: vibrate,
      volume: volume,

      notificationTitle: 'Alarm example',
      notificationBody: 'Your alarm ($id) is ringing',
      assetAudioPath: 'assets/marimba.mp3',
    );
    return alarmSettings;
  }

  void saveAlarm() async{

    final alarmSettings = buildAlarmSettings();
    try {
      if (loading) return;
      setState(() => loading = true);
      await Alarm.set(alarmSettings: alarmSettings);
      // await saveAlarmToFirestore(alarmSettings);

      Navigator.pop(context, true);
    } finally {
      setState(() => loading = false);
    }
  }
  String formatDateTime(DateTime dateTime) {
    // Extracting minutes, hours (12-hour format), month, and year
    String minutes = DateFormat('mm').format(dateTime);
    String hours = DateFormat('hh').format(dateTime);
    String period = DateFormat('a').format(dateTime);
    String month = DateFormat('MMMM').format(dateTime);
    String year = DateFormat('yyyy').format(dateTime);

    return "$hours:$minutes $period";
  }
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const Text(
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/images/notifications_active.svg'),
                          const Text(
                            '  Next alarm will ring tomorrow at 8:00 am',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              height: 0.15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  height: Get.height*0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: Get.height*0.13,
                    ),
                    Container(
                      height: Get.height*0.1,
                      width: Get.width*0.90,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF2A2C58),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ListTile(
                            title:   Text(
                              ' ${formatDateTime(selectedDateTime)}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                            ),
                            trailing: SizedBox(
                              height: 100,
                              width: Get.width*0.15,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    onTap:(){
                                      _selectTime(context);
                            },
                                    child: const Icon(Icons.edit_outlined,
                                    color: Color(0xFF636598),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: GestureDetector(
                                      onTap: (){
                                        Get.back();
                                      },
                                      child: SvgPicture.asset('assets/images/delete.svg',
                                      color: const Color(0xFF636598),),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                // const SizedBox(
                //   height: 25,
                // ),

                Container(
                  height: Get.height*0.25,
                  width: Get.width*0.90,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF2A2C58),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ListTile(
                        leading: SvgPicture.asset('assets/images/music (1).svg'),
                        title: const  Text(
                          'Ringtone',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            height: 0.11,
                          ),
                        ),
                        // subtitle: const Text("Basic Bell"),
                        trailing: DropdownButton(
                          value: assetAudio,
                          items: const [
                            DropdownMenuItem<String>(
                              value: 'assets/marimba.mp3',
                              child: Text('Marimba'),
                            ),
                            DropdownMenuItem<String>(
                              value: 'assets/nokia.mp3',
                              child: Text('Nokia'),
                            ),
                            DropdownMenuItem<String>(
                              value: 'assets/mozart.mp3',
                              child: Text('Mozart'),
                            ),
                            DropdownMenuItem<String>(
                              value: 'assets/star_wars.mp3',
                              child: Text('Star Wars'),
                            ),
                            DropdownMenuItem<String>(
                              value: 'assets/one_piece.mp3',
                              child: Text('One Piece'),
                            ),
                          ],
                          onChanged: (value) =>
                              setState(() => assetAudio = value!),
                        ),
                      ),
                      SvgPicture.asset('assets/images/Vector 215.svg'),
                      ListTile(
                        leading: SvgPicture.asset('assets/images/snooze.svg'),
                        title: const Text(
                          'Snooze',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            height: 0.11,
                          ),
                        ),
                        // subtitle: Text("Basic call"),
                        trailing: Container(
                          height: 33,
                          width: 54,
                          decoration: BoxDecoration(
                              color: vibrate?AppColor.themeColor:Colors.white,
                              borderRadius: BorderRadius.circular(30)
                          ),
                          child: CupertinoSwitch(


                              onLabelColor: Colors.white,
                              trackColor: AppColor.scaffold,
                              thumbColor: vibrate?AppColor.themeColor:Colors.white,
                              activeColor: AppColor.scaffold,
                              value: vibrate,
                              onChanged: (value) =>
                                  setState(() => vibrate = value)),
                        ),
                      ),
                      SvgPicture.asset('assets/images/Vector 215.svg'),
                      ListTile(
                          leading: SvgPicture.asset('assets/images/vibration.svg'),
                          title: const Text(
                            'Vibrate',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              height: 0.11,
                            ),
                          ),
                          // subtitle: const Text("Basic Bell"),
                          trailing: Container(
                              height: 33,
                              width: 54,
                              decoration: BoxDecoration(
                                  color: volumncontroller?AppColor.themeColor:Colors.white,
                                  borderRadius: BorderRadius.circular(30)
                              ),
                              child: CupertinoSwitch(
                                  onLabelColor: Colors.white,
                                  trackColor: AppColor.scaffold,
                                  thumbColor: volumncontroller?AppColor.themeColor:Colors.white,
                                  activeColor: AppColor.scaffold,
                                  value:  volume != null,
                                  onChanged: (value) {
                                    volumncontroller=value;
                                    setState(() => volume = value ? 0.5 : null);
                                  }

                              ))),
                      SizedBox(
                        height: 30,
                        child: volume != null
                            ? Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                volume! > 0.7
                                    ? Icons.volume_up_rounded
                                    : volume! > 0.1
                                    ? Icons.volume_down_rounded
                                    : Icons.volume_mute_rounded,
                              ),
                              Expanded(
                                child: Slider(
                                  value: volume!,
                                  onChanged: (value) {
                                    setState(() => volume = value);
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                            : const SizedBox(),
                      ),
                      const SizedBox(),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: Get.height*0.12,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                GestureDetector(
                    onTap: (){
                      saveAlarm();
                    },
                    child: Application_Button('Save')),

              ],
            ),
          ],
        ),
      ),
    );
  }



  DateTime convertStringToDateTime(String timeString) {
    DateFormat format = DateFormat('hh:mm a');
    DateTime dateTime = format.parse(timeString);

    // Assuming you want to set the date part to today
    DateTime today = DateTime.now();
    dateTime = DateTime(
        today.year, today.month, today.day, dateTime.hour, dateTime.minute);

    return dateTime;
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? now = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        currentDate: selectedDateTime,
        lastDate: DateTime(2030, 12, 31));

    if (now != null) {
      setState(() {
        selectedDateTime = now;
        if (selectedDateTime.isBefore(DateTime.now())) {
          selectedDateTime = selectedDateTime.add(const Duration(days: 1));
        }
        getDay();
      });
    }
  }
}