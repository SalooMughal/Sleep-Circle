import 'package:demoapp/Widgets/Widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../Widgets/App_Font.dart';
import '../../models/Icons_model.dart';
import '../Home/HomeScreen.dart';
class Quit_Tracking extends StatefulWidget {
  const Quit_Tracking({super.key});

  @override
  State<Quit_Tracking> createState() => _Quit_TrackingState();
}

class _Quit_TrackingState extends State<Quit_Tracking> {
  List feel_now=[
    Icons_model(title: 'Stressed', images: 'assets/Sleep_notes_icons/stressed (1).svg'),
    Icons_model(title: 'Depressed', images: 'assets/Sleep_notes_icons/disappointed.svg',),
    Icons_model(title: 'Tired', images: 'assets/Sleep_notes_icons/tired.svg',),
    Icons_model(title: 'Hungry', images: 'assets/Sleep_notes_icons/hungry.svg',),
    Icons_model(title: 'Relaxed', images: 'assets/Sleep_notes_icons/relaxed.svg',),
  ];
  List Pre_sleep_Activites=[
    Icons_model(title: 'Coffee', images: 'assets/Sleep_notes_icons/coffee.svg'),
    Icons_model(title: 'Nicotine', images: 'assets/Sleep_notes_icons/nicotine.svg',),
    Icons_model(title: 'Alcohol', images: 'assets/Sleep_notes_icons/alcohol.svg',),
    Icons_model(title: 'Ate Late', images: 'assets/Sleep_notes_icons/lunch.svg',),
    Icons_model(title: 'Workout', images: 'assets/Sleep_notes_icons/workout.svg',),
    Icons_model(title: 'Nap', images: 'assets/Sleep_notes_icons/sleep (1).svg',),
    Icons_model(title: 'Yoga', images: 'assets/Sleep_notes_icons/yoga.svg',),
    Icons_model(title: 'Medication', images: 'assets/Sleep_notes_icons/meditation.svg',),
    Icons_model(title: 'Shower', images: 'assets/Sleep_notes_icons/shower.svg',),
    Icons_model(title: 'Milk', images: 'assets/Sleep_notes_icons/milk.svg',),
    Icons_model(title: 'Tea', images: 'assets/Sleep_notes_icons/sleep (1).svg',),
  ];
  List Enivornment=[
    Icons_model(title: 'Cold', images: 'assets/Sleep_notes_icons/cold (2).svg'),
    Icons_model(title: 'Hot', images: 'assets/Sleep_notes_icons/hot.svg'),
    Icons_model(title: 'Bright', images: 'assets/Sleep_notes_icons/bright.svg'),
    Icons_model(title: 'New Bed', images: 'assets/Sleep_notes_icons/bed (3).svg')

  ];
  List Todays=[
    Icons_model(title: 'Working', images: 'assets/Sleep_notes_icons/briefcase (1).svg'),
    Icons_model(title: 'Day off', images: 'assets/Sleep_notes_icons/sofa.svg'),
    Icons_model(title: 'Trip', images: 'assets/Sleep_notes_icons/travelling-suitcase.svg'),
  ];
  List add_new=[
    Icons_model(title: 'New', images: 'assets/Sleep_notes_icons/star.svg'),
    Icons_model(title: 'Add', images: 'assets/Sleep_notes_icons/add.svg'),
  ];
  RxInt selectedindex_feelnow=0.obs;
  RxInt selectedindex_sleepactivities=0.obs;
  RxInt selectedindex_environement=0.obs;
  void Create_new_bottom_sheet() {
    Get.bottomSheet(
      Container(
        height: Get.height * 0.45,
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
                  'Create New Tag',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  alignment: Alignment.center,
                  decoration:
                      const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF636598),
                  ),
                  child: SvgPicture.asset(
                    'assets/Sleep_notes_icons/star.svg',
                    color: Colors.white,
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
                  decoration: const InputDecoration(
                      hintStyle: TextStyle(
                        color: Color(0xFF636598),
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        height: 0.09,
                      ),
                      hintText: 'Enter the nme of the tag'),
                )),
            SizedBox(
              height: Get.height * 0.08,
            ),
            GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Application_Button('SAVE'))
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
    );
  }
  void Sleep_notes_bottom_sheet() {
    Get.bottomSheet(
      isScrollControlled: true,
      Container(
        height: MediaQuery.of(context).size.height * 0.9, // Adjust height as needed
        decoration: BoxDecoration(
          color: const Color(0xFF2A2C58),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0,right: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: Get.height * 0.05,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Add Sleep Note',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFD3FB8F),
                        fontSize: 20,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.05,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Text(
                    'How do you feel now?',
                    style: TextStyle(
                      color: const Color(0xFFE1E2F7),
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      height: 0.09,
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                SizedBox(
                  height: Get.height * 0.22,
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(0.0),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4, // Number of columns
                      mainAxisSpacing: 0.0, // Spacing between rows
                      // Spacing between columns
                      childAspectRatio: 0.85, // Adjust as needed
                    ),
                    itemCount: feel_now.length, // Number of items in the grid
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          GestureDetector(
                            onTap:(){
                              selectedindex_feelnow.value=index;
                              setState(() {

                              });
                      },
                            child: Obx(()=>
                               Container(
                                width: 62,
                                height: 62,
                                alignment: Alignment.center,
                                decoration:selectedindex_feelnow.value==index
                                    ? const ShapeDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment(0.81, -0.59),
                                    end: Alignment(-0.81, 0.59),
                                    colors: [
                                      Color(0xFFEFFFD5),
                                      Color(0xFFE0FFAC),
                                      Color(0xFFBEFF51),
                                      Color(0xFF7D9554)
                                    ],
                                  ),
                                  shape: OvalBorder(),
                                )
                                    : const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF636598),
                                ),
                                child: SvgPicture.asset(
                                  '${feel_now[index].images}',
                                  color: selectedindex_feelnow.value==index ? Colors.black : Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: Text(
                              '${feel_now[index].title}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                height: 0.29,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Text(
                    'Pre-sleep Activities',
                    style: TextStyle(
                      color: Color(0xFFE1E2F7),
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      height: 0.09,
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                SizedBox(
                  height: Get.height * 0.37,
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),

                    padding: const EdgeInsets.all(0.0),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4, // Number of columns
                      mainAxisSpacing: 0.0, // Spacing between rows
                      crossAxisSpacing: 10.0, // Spacing between columns
                      childAspectRatio: 0.85, // Adjust as needed
                    ),
                    itemCount: Pre_sleep_Activites.length, // Number of items in the grid
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          GestureDetector(
                            onTap:(){
                              selectedindex_sleepactivities.value=index;
                            },
                            child: Obx(()=>
                              Container(
                                width: 62,
                                height: 62,
                                alignment: Alignment.center,
                                decoration: selectedindex_sleepactivities.value==index
                                    ? const ShapeDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment(0.81, -0.59),
                                    end: Alignment(-0.81, 0.59),
                                    colors: [
                                      Color(0xFFEFFFD5),
                                      Color(0xFFE0FFAC),
                                      Color(0xFFBEFF51),
                                      Color(0xFF7D9554)
                                    ],
                                  ),
                                  shape: OvalBorder(),
                                )
                                    : const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF636598),
                                ),
                                child: SvgPicture.asset(
                                  '${Pre_sleep_Activites[index].images}',
                                  color:   selectedindex_sleepactivities.value==index ? Colors.black : Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: Text(
                              '${Pre_sleep_Activites[index].title}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                height: 0.29,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Text(
                    'Environment',
                    style: TextStyle(
                      color: Color(0xFFE1E2F7),
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      height: 0.09,
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                SizedBox(
                  height: Get.height * 0.1,
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),

                    padding: const EdgeInsets.all(0.0),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4, // Number of columns
                      mainAxisSpacing: 0.0, // Spacing between rows
                      crossAxisSpacing: 10.0, // Spacing between columns
                      childAspectRatio: 0.85, // Adjust as needed
                    ),
                    itemCount: Enivornment.length, // Number of items in the grid
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          GestureDetector(
                            onTap:(){
                              selectedindex_environement.value=index;
                            },
                            child: Obx(()=>
                               Container(
                                width: 62,
                                height: 62,
                                alignment: Alignment.center,
                                decoration:  selectedindex_environement.value==index
                                    ? const ShapeDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment(0.81, -0.59),
                                    end: Alignment(-0.81, 0.59),
                                    colors: [
                                      Color(0xFFEFFFD5),
                                      Color(0xFFE0FFAC),
                                      Color(0xFFBEFF51),
                                      Color(0xFF7D9554)
                                    ],
                                  ),
                                  shape: OvalBorder(),
                                )
                                    : const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF636598),
                                ),
                                child: SvgPicture.asset(
                                  '${Enivornment[index].images}',
                                  color:  selectedindex_environement.value==index ? Colors.black : Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: Text(
                              '${Enivornment[index].title}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                height: 0.29,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Text(
                    "Today's",
                    style: TextStyle(
                      color: Color(0xFFE1E2F7),
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      height: 0.09,
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                SizedBox(
                  height: Get.height * 0.1,
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),

                    padding: const EdgeInsets.all(0.0),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4, // Number of columns
                      mainAxisSpacing: 0.0, // Spacing between rows
                      crossAxisSpacing: 10.0, // Spacing between columns
                      childAspectRatio: 0.85, // Adjust as needed
                    ),
                    itemCount: Todays.length, // Number of items in the grid
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            width: 62,
                            height: 62,
                            alignment: Alignment.center,
                            decoration: index == 0
                                ? const ShapeDecoration(
                              gradient: LinearGradient(
                                begin: Alignment(0.81, -0.59),
                                end: Alignment(-0.81, 0.59),
                                colors: [
                                  Color(0xFFEFFFD5),
                                  Color(0xFFE0FFAC),
                                  Color(0xFFBEFF51),
                                  Color(0xFF7D9554)
                                ],
                              ),
                              shape: OvalBorder(),
                            )
                                : const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF636598),
                            ),
                            child: SvgPicture.asset(
                              '${Todays[index].images}',
                              color: index == 0 ? Colors.black : Colors.white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: Text(
                              '${Todays[index].title}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                height: 0.29,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Text(
                    "Today's",
                    style: TextStyle(
                      color: Color(0xFFE1E2F7),
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      height: 0.09,
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                SizedBox(
                  height: Get.height * 0.1,
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),

                    padding: const EdgeInsets.all(0.0),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4, // Number of columns
                      mainAxisSpacing: 0.0, // Spacing between rows
                      crossAxisSpacing: 10.0, // Spacing between columns
                      childAspectRatio: 0.85, // Adjust as needed
                    ),
                    itemCount: add_new.length, // Number of items in the grid
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          GestureDetector(
                            onTap:(){
                              if(add_new[index].title=='Add'){
                                Create_new_bottom_sheet();
                              }
                            },
                            child: Container(
                              width: 62,
                              height: 62,
                              alignment: Alignment.center,
                              decoration: index == 0
                                  ? const ShapeDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment(0.81, -0.59),
                                  end: Alignment(-0.81, 0.59),
                                  colors: [
                                    Color(0xFFEFFFD5),
                                    Color(0xFFE0FFAC),
                                    Color(0xFFBEFF51),
                                    Color(0xFF7D9554)
                                  ],
                                ),
                                shape: OvalBorder(),
                              )
                                  : const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFF636598),
                              ),
                              child: SvgPicture.asset(
                                '${add_new[index].images}',
                                color: index == 0 ? Colors.black : Colors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: Text(
                              '${add_new[index].title}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                height: 0.29,
                              ),
                            ),
                          ),

                        ],
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap:(){

                         Get.to(const HomeScreen());
                        },
                        child: Application_Button('DONE')),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.05,
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
    );
  }

  @override

  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: Get.height*0.1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
                children:[SvgPicture.asset('assets/images/sleeping-lady.svg')] ,
            ),
            SizedBox(
              height: Get.height*0.07,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Quit Tracking?',
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
              height: Get.height*0.07,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'You’ve slept less than 30 min, not long',
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
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'enough to generate a detailed sleep report.',
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
                ),
              ],
            ),
            SizedBox(
              height: Get.height*0.07,
            ),
            GestureDetector(
              onTap: (){
                Get.back();
              },
                child: Application_Button('KEEP TRACKING')),
            SizedBox(
              height: Get.height*0.04,
            ),
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){
                    Get.to(const HomeScreen());
                  },
                  child: const Text(
                    'Quit now',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                )
              ],
            )
          ],

        ),
      ),
    );
  }
}
