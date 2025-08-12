import 'package:demoapp/Firebase_interface/Firebase_interface.dart';
import 'package:demoapp/View/Auth/Auth.dart';
import 'package:demoapp/Widgets/Widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../Controller/Common_Controller.dart';
import '../../../Widgets/App_Font.dart';

class Delete_Account extends StatefulWidget {
  const Delete_Account({Key? key}) : super(key: key);

  @override
  State<Delete_Account> createState() => _Delete_AccountState();
}

class _Delete_AccountState extends State<Delete_Account> {
  CommonController commonController=Get.find<CommonController>();

  int? selectedIndex;
  List items = [
    "I didn’t find SnoozeSage useful.",
    'I don’t understand how to use it.',
    'I’m deleting it temporarily.',
    'Other'
  ];

   List<bool>? selected;

  @override
  void initState() {
    super.initState();
    // Initialize selected list with false values
    selected = List<bool>.filled(items.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(Icons.arrow_back_ios_new),
                    ),

                  ],
                ),
              ),

              SizedBox(
                width: Get.width * 0.9,
                child: Text(
                  'Why might that happen?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: AppFonts.fontFamily,
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Why do you wish to delete your account?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: AppFonts.fontFamily,
                      fontWeight: FontWeight.w400,
                      height: 0.11,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Get.height * 0.05,
              ),
              Container(
                height: Get.height * 0.6,
                width: Get.width * 0.93,
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (selectedIndex == index) {
                            selectedIndex = null;
                          } else {
                            selectedIndex = index;
                          }
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Row(
                          children: [
                            selectedIndex == index
                                ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  alignment: Alignment.center,
                                  width: 30,
                                  height: 30,
                                  child: SvgPicture.asset('assets/images/Check.svg',)
                              ),
                            )
                                : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                alignment: Alignment.center,
                                width: 30,
                                height: 30,
                               child: SvgPicture.asset('assets/images/uncheck.svg',),

                              ),
                            ),
                            SizedBox(width: Get.width*0.01),
                            Text(
                              '${items[index]}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF636598),
                                fontSize: 14,
                                fontFamily: AppFonts.fontFamily,
                                fontWeight: FontWeight.w500,
                                height: 0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: Get.height * 0.024),
              GestureDetector(
                onTap: ()async{
                 await  Firebase_intefacee().deleteFirebaseAccount(commonController.uid.value).then((value) {
                    Get.to(Auth_Screen());
                  });
                },
                  child: Application_Button('DELETE MY ACCOUNT'))
            ],
          ),
        ),
      ),
    );
  }
}
