import 'package:demoapp/Firebase_interface/Firebase_interface.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Utlis/theme.dart';
import '../../Widgets/App_Font.dart';
import '../../Widgets/Widgets.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController emailcontroller=TextEditingController();
  RxBool  isvalue=false.obs;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: BackArrow(),
            ),
            SizedBox(
                height: Get.height*0.1),
            const Padding(
              padding: EdgeInsets.only(left: 35.0,bottom:15),
              child: Text(
                'EMAIL',
                style: TextStyle(
                  color: Color(0xFF636598),
                  fontSize: 14,
                  fontFamily: AppFonts.fontFamily,
                  fontWeight: FontWeight.w400,
                  height: 0.11,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0, right:22),
              child: Container(
                alignment: Alignment.center,
                height: Get.height*0.07,
                width: Get.width*0.9,
                decoration: BoxDecoration(
                    color: AppColor.container,
                    borderRadius: BorderRadius.circular(20)
                ),
                child:  TextFormField(
                  controller: emailcontroller,
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    prefixIcon: Container(
                      padding: const EdgeInsets.all(10), // Adjust padding as needed
                      child: SvgPicture.asset(
                        'assets/images/email (1).svg',
                        height: 20, // Adjust height as needed
                        width: 20, // Adjust width as needed
                      ),
                    ),
                    hintText: 'Enter your email',
                    hintStyle: const TextStyle(
                      color: Color(0xFF636598),
                      fontSize: 14,
                      fontFamily: AppFonts.fontFamily,
                      fontWeight: FontWeight.w500,
                    ),
                    border: InputBorder.none,

                  ),
                ),
              ),
            ),
            SizedBox(
                height: Get.height*0.07),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
                children: [Obx(()=>
                  GestureDetector(
                    onTap: ()async{
                      isvalue.value=true;
                      await Firebase_intefacee().resetPassword(emailcontroller.text.toString()).then((value) {
                      Get.snackbar('Reset email', 'Password reset email sent successfully');
                      isvalue.value=false;
                      }).onError((error, stackTrace) {
                        Get.snackbar('Error', '$error');
                        isvalue.value=false;
                      });
                      isvalue.value=false;
                    },
                      child: isvalue.value?Center(child: CircularProgressIndicator(
                        color: AppColor.themeColor,
                      )):Application_Button('RESET PASSWORD')),
                )])
          ],
        ),
      ),
    );
  }
}
