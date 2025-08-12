import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart';
import 'package:timezone/timezone.dart' as tz;

import '../../../Controller/Common_Controller.dart';
import '../../../Utlis/theme.dart';
import '../../../Widgets/Widgets.dart';
import '../../../main.dart';
import '../../Track_sleep/Connect_to_Charger.dart';

class SetBedTime extends StatefulWidget {
  const SetBedTime({super.key});

  @override
  State<SetBedTime> createState() => _SetBedTimeState();
}

class _SetBedTimeState extends State<SetBedTime> {
  CommonController commonController = Get.find<CommonController>();
  List bedtime = [];

  @override
  void initState() {
    super.initState();

    _loadBedtimeData();
  }

  void showNotification(DateTime items, int index) async {
    AndroidNotificationDetails androidDetails =
        const AndroidNotificationDetails(
            "notifications-youtube", "YouTube Notifications",
            priority: Priority.max, importance: Importance.max);

    DarwinNotificationDetails iosDetails = const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    NotificationDetails notiDetails =
        NotificationDetails(android: androidDetails, iOS: iosDetails);

    DateTime.now().add(const Duration(seconds: 5));

    await notificationsPlugin.zonedSchedule(
        0,
        "Notification",
        "It's time to sleep",
        tz.TZDateTime.from(items, tz.local),
        notiDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.wallClockTime,
        androidAllowWhileIdle: true,
        payload: "notification-payload");
  }

  void checkForNotification() async {
    initializeTimeZones();

    AndroidInitializationSettings androidSettings =
        const AndroidInitializationSettings("@mipmap/ic_launcher");

    DarwinInitializationSettings iosSettings =
        const DarwinInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestCriticalPermission: true,
            requestSoundPermission: true);

    InitializationSettings initializationSettings =
        InitializationSettings(android: androidSettings, iOS: iosSettings);

    bool? initialized = await notificationsPlugin.initialize(
        initializationSettings, onDidReceiveNotificationResponse: (response) {
      log(response.payload.toString());
    });
    log("Notifications: $initialized");

    NotificationAppLaunchDetails? details =
        await notificationsPlugin.getNotificationAppLaunchDetails();

    if (details != null) {
      if (details.didNotificationLaunchApp) {
        NotificationResponse? response = details.notificationResponse;
        _handleNotificationPayload(response?.payload);
        if (response != null) {
          String? payload = response.payload;
          log("Notification Payload: $payload");
        }
      }
    }
  }

  void _handleNotificationPayload(String? payload) {
    log("Received payload: $payload");
    if (payload == "notification-payload") {
      // Check if the user is currently on the SetBedTime screen
      if (ModalRoute.of(context)?.settings.name == '/set_bedtime') {
        Get.to(() => const Connect_to_charger());
      }
    } else {
      log("Unknown payload: $payload");
    }
  }

  List<DateTime>? storedBedtime;

  Future<void> _loadBedtimeData() async {
    final box = await Hive.openBox('Bedtime');
    storedBedtime = box.get('Bedtime')?.cast<DateTime>();

    if (storedBedtime != null) {
      List<DateTime> updatedBedtime = [];
      // Iterate through storedBedtime list
      for (DateTime time in storedBedtime!) {
        // Check if time is after the current time
        if (time.isAfter(DateTime.now())) {
          // Add valid time to updatedBedtime list
          updatedBedtime.add(time);
        }
      }
      // Update bedtime list
      setState(() {
        bedtime = updatedBedtime;
      });
      // Update Hive box with valid bedtime list
      await box.put('Bedtime', bedtime);
    }
  }


  Future<void> _saveBedtimeData() async {
    for (int i = 0; i < bedtime.length; i++) {
      showNotification(bedtime[i], i);
    }

    checkForNotification();
    final box = await Hive.openBox('Bedtime');
    box.put('Bedtime', bedtime);
  }

  Future<void> _cancelNotification(int index) async {
    // Cancel notification using the notification id (in this case, using index as id)
    await notificationsPlugin.cancel(index);
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
            SizedBox(height: Get.height * 0.02),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Bedtime',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                bedtime.isEmpty
                    ? SvgPicture.asset('assets/images/bed.svg')
                    : SvgPicture.asset(
                        'assets/images/notifications_active.svg'),
                SizedBox(
                  height: Get.height * 0.04,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0, top: 0),
                  child: Text(
                    '${bedtime.isEmpty ? 'No' : bedtime.length} Bedtime set',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      height: 0.15,
                    ),
                  ),
                ),
              ],
            ),
            bedtime.isNotEmpty
                ? SizedBox(
                    height: Get.height * 0.55,
                    width: Get.width * 93,
                    child: ListView.builder(
                      itemCount: bedtime.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              top: 15.0, left: 10, right: 10),
                          child: _buildAlarmCard(index, bedtime[index]),
                        );
                      },
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: Get.height * 0.55,
                          width: bedtime.isEmpty
                              ? Get.width * 0.7
                              : Get.width * 0.93,
                          child: bedtime.isEmpty
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: 100,
                                    child: SvgPicture.asset(
                                      'assets/images/Group (4).svg',
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                )
                              : const Text('')),
                    ],
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () async {
                      DateTime? selectedDateTime = await _selectTime(context);
                      print('Selected Time: $selectedDateTime');
                      DateFormat dateFormat = DateFormat("hh:mm a");
                      commonController.Set_bedtime.value=dateFormat.format(selectedDateTime!);
                      print(commonController.Set_bedtime.value);
                      print('Current Time: ${DateTime.now()}');
                      if (selectedDateTime != null) {
                        // Calculate the difference in minutes between selectedDateTime and current time
                        int differenceInMinutes = selectedDateTime.difference(DateTime.now()).inMinutes;
                        // Check if the difference is less than 1 minut

                        if (differenceInMinutes < 1) {
                          // Show a Snackbar to notify the user
                          Get.snackbar(
                            'Error',
                            'Please select a time at least 1 minute in the future.',
                            snackPosition: SnackPosition.TOP,

                          );
                        } else {
                          setState(() {
                            bedtime.add(selectedDateTime);
                          });
                          await _saveBedtimeData();
                        }
                      }
                    },

                    child: Application_Button('SET BEDTIME'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<DateTime?> _selectTime(BuildContext context) async {
    final TimeOfDay? res = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            timePickerTheme: TimePickerThemeData(
              cancelButtonStyle: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              confirmButtonStyle: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              dayPeriodBorderSide: const BorderSide(color: AppColor.themeColor),
              hourMinuteTextColor: Colors.white,
              dialHandColor: AppColor.themeColor,
              dialBackgroundColor: AppColor.scaffold,
            ),
            textSelectionTheme: const TextSelectionThemeData(
              selectionColor: Colors.red,
            ),
            textTheme: const TextTheme(
              labelLarge: TextStyle(color: Colors.white),
            ),
            colorScheme: const ColorScheme.light(
              secondary: AppColor.themeColor,
              onPrimary: Colors.black,
              background: AppColor.scaffold,
              primary: AppColor.scaffold,
              surface: Color(0xFF2A2C58),
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (res != null) {
      return DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        res.hour,
        res.minute,
      );
    }
    return null;
  }

  Widget _buildAlarmCard(int index, DateTime time) {
    DateFormat dateFormat = DateFormat("hh:mm a");
    String formattedDate = DateFormat('EEE, d MMM').format(time);

    return GestureDetector(
      child: Slidable(
        closeOnScroll: true,
        endActionPane: ActionPane(
          extentRatio: 0.4,
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              foregroundColor: Colors.white,
              borderRadius: BorderRadius.circular(12),
              onPressed: (context) async {
                await _cancelNotification(index);
                setState(() {
                  commonController.Set_bedtime.value='';
                  bedtime.removeAt(index);
                  _saveBedtimeData();
                });
              },
              icon: Icons.delete_forever,
              backgroundColor: Colors.red.shade700,
            ),
          ],
        ),
        child: Container(
          decoration: ShapeDecoration(
            color: const Color(0xFF2A2C58),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 20.0, left: 20),
                child: Text(
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
                  title: Row(
                    children: [
                      Text(
                        dateFormat.format(time),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                      const Expanded(child: Text("")),
                      Text(formattedDate.toString()),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
