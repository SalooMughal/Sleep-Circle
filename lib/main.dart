import 'dart:developer';

import 'package:alarm/alarm.dart';
import 'package:demoapp/Utlis/theme.dart';
import 'package:demoapp/View/Auth/Auth.dart';
import 'package:demoapp/View/Home/HomeScreen.dart';
import 'package:demoapp/View/Oboarding/Onboarding_Screen1.dart';
import 'package:demoapp/View/Oboarding/Welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:timezone/data/latest.dart';
import 'Controller/Common_Controller.dart';
import 'View/Profile/Wakeup_alarm/Home.dart';
import 'Widgets/App_Font.dart';
import 'Widgets/Notification.dart';
import 'Widgets/Testnotification.dart';
import 'firebase_options.dart';
import 'package:timezone/data/latest.dart' as tz;

FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();

 main() async{
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  NotificationService().initNotification(); // Initialize notifications

  var directory  = await getApplicationDocumentsDirectory();
   Hive.init(directory.path);

   await Alarm.init(showDebugLogs: true);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform);
  Get.put(CommonController());
  runApp(ScreenUtilInit(
    builder: (_,child){
      return  GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        theme: darkTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.system,
      );
    },
  ),
  );
}
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  CommonController commonController = Get.find<CommonController>();

  @override
  void initState() {
    super.initState();
    navigateToNextScreen();
  }
  void navigateToNextScreen() {

    Future.delayed(const Duration(seconds: 2), ()async {
      final box=await Hive.openBox('uid');

      final box2=await Hive.openBox('uid');
      if(box2.isNotEmpty){
        commonController.uid.value=box2.get('uid');
        commonController.checkin.value=box2.get('uid');
        print( commonController.checkin.value);
      }else{
        commonController.uid.value='abc';
      }
      Get.to( box.isEmpty?Welcome():HomeScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        children: [
          Container(
            height: Get.height * 0.5,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    'assets/images/Illustration.png',
                  ),
                  fit: BoxFit.cover
                // Add your content here
              ),
            ),

          ),

          Column(
            children: [
              SvgPicture.asset('assets/icons/App Icon.svg'),
              SizedBox(
                height: 20,
              ),
              const Text(
                'Sleep Circle',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFD3FB8F),
                  fontSize: 20,
                  fontFamily: AppFonts.fontFamily,
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
              ),
        Text(
          'Sound & Tracker',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: AppFonts.fontFamily,
            fontWeight: FontWeight.w500,
            height: 0,
          ),
        )
            ],
          )
        ],
      )
    );
  }
}
