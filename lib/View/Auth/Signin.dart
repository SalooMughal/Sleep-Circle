import 'package:demoapp/Utlis/theme.dart';
import 'package:demoapp/View/Auth/Forget_password.dart';
import 'package:demoapp/View/Auth/Signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../Firebase_interface/Firebase_interface.dart';
import '../../Widgets/App_Font.dart';
import '../../Widgets/Widgets.dart';
import '../Home/HomeScreen.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  TextEditingController emailcontroller=TextEditingController();
  TextEditingController passwordcontroller=TextEditingController();
  bool _isObscure = true;
  RxBool istrue=false.obs;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             SizedBox(
               height: Get.height*0.558,
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Padding(
                     padding: const EdgeInsets.all(15.0),
                     child: BackArrow(),
                   ),
                   const Padding(
                     padding: EdgeInsets.only(left: 25.0,top: 20),
                     child: Text(
                       'Welcome Back',
                       style: TextStyle(
                         color: Colors.white,
                         fontSize: 18,
                         fontFamily: AppFonts.fontFamily,
                         fontWeight: FontWeight.w500,
                         height: 0,
                       ),
                     ),
                   ),
                   SizedBox(
                       height: Get.height*0.03),


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
                           hintText: 'Email@email.com',
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
                       height: Get.height*0.02),
                   const Padding(
                     padding: EdgeInsets.only(left: 35.0,bottom: 15),
                     child: Text(
                       'PASSWORD',
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
                     padding: const EdgeInsets.only(left: 25.0,right: 22),
                     child: Container(
                       alignment: Alignment.center,
                       height: Get.height*0.07,
                       width: Get.width*0.9,
                       decoration: ShapeDecoration(
                         color: const Color(0xFF2A2C58),
                         shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(18),
                         ),
                       ),
                       child: TextFormField(
                         controller: passwordcontroller,
                         textAlign: TextAlign.start,
                         obscureText: _isObscure,
                         decoration: InputDecoration(
                           prefixIcon: Container(
                             padding: const EdgeInsets.all(10), // Adjust padding as needed
                             child: SvgPicture.asset(
                               'assets/images/lock.svg',
                               height: 20, // Adjust height as needed
                               width: 20, // Adjust width as needed
                             ),
                           ),
                           hintText: 'Enter Password',
                           hintStyle: const TextStyle(
                             color: Color(0xFF636598),
                             fontSize: 14,
                             fontFamily: AppFonts.fontFamily,
                             fontWeight: FontWeight.w500,
                           ),
                           border: InputBorder.none,
                           suffixIcon:  GestureDetector(
                               onTap: (){
                                 setState(() {
                                   _isObscure = !_isObscure;
                                 });
                               },
                               child: _isObscure ?Container(
                                 padding: const EdgeInsets.all(14),
                                 child: SvgPicture.asset('assets/images/Vector (3).svg',
                                   height: 5,
                                   width: 5,),
                               ):Container(
                                 padding: const EdgeInsets.all(10),
                                 child: SvgPicture.asset('assets/images/view.svg',
                                   height: 10,
                                   width: 10,),
                               )),

                         ),
                       ),
                     ),
                   ),

                 ],
               ),
             ),
              Obx(()=>
                 Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      GestureDetector(
                        onTap: ()async{

                          istrue.value=true;
                          final user=await Firebase_intefacee().signInWithEmailAndPassword(emailcontroller.text.toString(), passwordcontroller.text.toString(),);
                          if(user!=null){
                            final box=await Hive.openBox('Credentials');
                            await box.put('status', 'Checkin');
                            Get.to(const HomeScreen());
                            istrue.value=false;
                          }else{
                            istrue.value=false;
                          }
                        },
                          child: istrue.value?const Center(
                            child: CircularProgressIndicator(
                              color: AppColor.themeColor,
                            ),
                          ):Application_Button('LOGIN'))] ),
              ),
               SizedBox(
                height: Get.height*0.02,
              ),
               Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      Get.to(ForgetPassword());
                    },
                    child: Text('Forgot Password?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: AppFonts.fontFamily,
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),),
                  ),
          
                ],
              ),
              const SizedBox(
                height: 40,
              ),
          //     Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //     Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       const Text('Not a memeber yet? ',
          //         style: TextStyle(
          //           color: Colors.white,
          //           fontSize: 14,
          //           fontFamily: AppFonts.fontFamily,
          //           fontWeight: FontWeight.w400,
          //           height: 0,
          //         ),),
          //       GestureDetector(
          //         onTap: ()async{
          //
          //           Get.to(const Signup());
          //         },
          //         child: const Text('Create an',
          //           style: TextStyle(
          //             color:AppColor.themeColor,
          //             fontSize: 14,
          //             fontFamily: AppFonts.fontFamily,
          //             fontWeight: FontWeight.w400,
          //             height: 0,
          //           ),),
          //       ),
          //   ],
          // ),
          //         GestureDetector(
          //           onTap: ()async{
          //
          //             Get.to(const Signup());
          //           },
          //           child: const Text('Account',
          //             textAlign: TextAlign.center,
          //             style: TextStyle(
          //               color:AppColor.themeColor,
          //               fontSize: 14,
          //               fontFamily: AppFonts.fontFamily,
          //               fontWeight: FontWeight.w400,
          //               height: 0,
          //             ),),
          //         ),
          //       ],
          //     ),

            ],
          ),
        ),
      ),
    );
  }
  void GoToCreateAccount(){
    Get.to(const Signup());
  }
}
