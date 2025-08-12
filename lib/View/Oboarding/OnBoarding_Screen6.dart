import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../Controller/Common_Controller.dart';
import '../../Utlis/theme.dart';
import '../../Widgets/App_Font.dart';
import '../../Widgets/Widgets.dart';
import '../Profile/Profile.dart';
import '../Profile/Wakeup_alarm/Home.dart';
import 'onBoarding_Screen7.dart';

class OnBoarding6 extends StatefulWidget {
  String? origin;
   OnBoarding6({super.key, this.origin});

  @override
  State<OnBoarding6> createState() => _OnBoarding6State();
}

class _OnBoarding6State extends State<OnBoarding6> {
  CommonController commonController=Get.find<CommonController>();
  late Future<DateTime?> selectedDate;
  String date = "-";

  late Future<TimeOfDay?> selectedTime;
  String time = "-";

  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    void showDialogTimePicker(BuildContext context){
      selectedTime = showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
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
                outline: Color(0xFFD3FB8F) ,
                secondary:Color(0xFFD3FB8F) ,
                onPrimary:Colors.black,
                background: AppColor.themeColor,
                primary: Color(0xFFD3FB8F),
                surface: AppColor.themeColor,
                onSurface: Colors.white,
                onBackground: Colors.black,

              ),
              //.dialogBackgroundColor:Colors.blue[900],
            ),
            child: child!,
          );
        },
      );
      selectedTime.then((value) {
        setState(() {
          if(value == null) return;
          commonController.Bedtime.value = "${value.hour} : ${value.minute}";

        });
      }, onError: (error) {
        if (kDebugMode) {
          print(error);
        }
      });
    }


    return  Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: Get.height*0.77,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: const Icon(Icons.arrow_back_ios_new),
                          ),
                          TextButton( // Changed from GestureDetector to TextButton
                              onPressed: (){
                                Get.to(const OnBoarding6p2());
                              },
                              child: const Text(
                                'SKIP',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: AppFonts.fontFamily,
                                  fontWeight: FontWeight.w400,
                                  height: 0.15,
                                ),
                              )),
                        ],
                      ),
                    ),
                    Expanded(
                      // height: Get.height*0.68,
                      child: Column(
                        children: [
                          const SizedBox(
                            width: 302,
                            child: Text(
                              'Lets set up your bedtime',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: AppFonts.fontFamily,
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Get.height*0.03,
                          ),
                          const SizedBox(
                            width: 327,
                            child: Text(
                              'Based on your target, we will suggest you the best ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontFamily: AppFonts.fontFamily,
                                fontWeight: FontWeight.w400,
                                height: 0.15,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Get.height*0.02,
                          ),
                          const SizedBox(
                            width: 327,
                            child: Text(
                              'time to wind down for sleep',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontFamily: AppFonts.fontFamily,
                                fontWeight: FontWeight.w400,
                                height: 0.15,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Get.height*0.02,
                          ),
                          SizedBox(height: Get.height*0.1,),
                          Container(
                            height: Get.height*0.25,
                            width: Get.width*0.478,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle
                            ),
                            child: SvgPicture.asset('assets/images/Clock face - 12 hour.svg',
                              fit: BoxFit.contain,),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: (){
                                showDialogTimePicker(context);
                              },
                              child: Container(
                                height: Get.height*0.05,
                                width: Get.width*0.3,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color:  const Color(0xFF363869),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: const Text(
                                  'Select Time',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 9.30,
                                    fontFamily: AppFonts.fontFamily,
                                    fontWeight: FontWeight.w500,
                                    height: 0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 23.0,bottom: 5),
                                child: Text(
                                  'Repeat on',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontFamily: AppFonts.fontFamily,
                                    fontWeight: FontWeight.w500,
                                    height: 0.15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const WeekdaySelector(),
                          SizedBox(
                            height: Get.height*0.02,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Get.height*0.002,
                    ),
                  ],
                ),
              ),
              SizedBox(height: Get.height*0.006,),
              GestureDetector(
                  onTap: (){
                    if(widget.origin=='Profile'){
                      Get.to(const Profile());
                    }else{
                      Get.to(const OnBoarding6p2());
                    }
                  },
                  child: Application_Button('Continue')),
              SizedBox(
                height: Get.height*0.05,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class WeekdaySelector extends StatefulWidget {
  const WeekdaySelector({super.key});

  @override
  _WeekdaySelectorState createState() => _WeekdaySelectorState();
}

class _WeekdaySelectorState extends State<WeekdaySelector> {
// Selected state for each day
Map<String, bool> selectedDays = {
  'Sun': false,
  'Mon': false,
  'Tue': false,
  'Wed': false,
  'Thu': false,
  'Fri': false,
  'Sat': false,
};

@override
Widget build(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
      width: Get.width*0.92,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for (var day in selectedDays.keys)
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedDays[day] = !selectedDays[day]!;
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Container(
                  alignment: Alignment.center,
                  height: Get.height*0.05,
                  width: Get.width*0.12,
                  decoration: ShapeDecoration(
                    color: selectedDays[day]! ? const Color(0xFFD3FB8F) : const Color(0xFF363869),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text(
                    day,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: selectedDays[day]! ? Colors.black : const Color(0xFF636598),
                      fontSize: 9.30,
                      fontFamily: AppFonts.fontFamily,
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    ),
  );
}
}
class OnBoarding6p2 extends StatefulWidget {
  const OnBoarding6p2({super.key});

  @override
  _OnBoarding6p2State createState() => _OnBoarding6p2State();
}

class _OnBoarding6p2State extends State<OnBoarding6p2> {
  CommonController commonController=Get.find<CommonController>();

  late Future<DateTime?> selectedDate;
  String date = "-";

  late Future<TimeOfDay?> selectedTime;
  String time = "-";

  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {


    return  Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: Get.height*0.77,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: const Icon(Icons.arrow_back_ios_new),
                          ),
                          TextButton( // Changed from GestureDetector to TextButton
                              onPressed: (){
                                Get.to(const OnBoarding6p2());
                              },
                              child: const Text(
                                'SKIP',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: AppFonts.fontFamily,
                                  fontWeight: FontWeight.w400,
                                  height: 0.15,
                                ),
                              )),
                        ],
                      ),
                    ),
                    Expanded(
                      // height: Get.height*0.68,
                      child: Column(
                        children: [
                          const SizedBox(
                            width: 302,
                            child: Text(
                              'Lets set up your wake up',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: AppFonts.fontFamily,
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Get.height*0.03,
                          ),
                          const SizedBox(
                            width: 327,
                            child: Text(
                              'Based on your target, we will suggest you the best ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontFamily: AppFonts.fontFamily,
                                fontWeight: FontWeight.w400,
                                height: 0.15,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Get.height*0.02,
                          ),
                          const SizedBox(
                            width: 327,
                            child: Text(
                              'time to wind down for sleep',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontFamily: AppFonts.fontFamily,
                                fontWeight: FontWeight.w400,
                                height: 0.15,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Get.height*0.02,
                          ),
                          SizedBox(height: Get.height*0.1,),
                          Container(
                            height: Get.height*0.25,
                            width: Get.width*0.478,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle
                            ),
                            child: SvgPicture.asset('assets/images/Clock face - 12 hour.svg',
                              fit: BoxFit.contain,),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: (){
                               // Get.to(const ExampleAlarmHomeScreen());
                              },
                              child: Container(
                                height: Get.height*0.05,
                                width: Get.width*0.3,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color:  const Color(0xFF363869),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: const Text(
                                  'Select Time',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 9.30,
                                    fontFamily: AppFonts.fontFamily,
                                    fontWeight: FontWeight.w500,
                                    height: 0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 23.0,bottom: 5),
                                child: Text(
                                  'Repeat on',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontFamily: AppFonts.fontFamily,
                                    fontWeight: FontWeight.w500,
                                    height: 0.15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const WeekdaySelector(),
                          SizedBox(
                            height: Get.height*0.02,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Get.height*0.002,
                    ),
                  ],
                ),
              ),
              SizedBox(height: Get.height*0.006,),
              GestureDetector(
                  onTap: (){
          
                      Get.to(const OnBoarding7());
          
                  },
                  child: Application_Button('Continue')),
              SizedBox(
                height: Get.height*0.05,
              ),
            ],
          ),
        ),
      ),
    );
  }
}