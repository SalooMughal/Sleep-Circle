import 'package:demoapp/Utlis/theme.dart';
import 'package:demoapp/View/Auth/Signin.dart';
import 'package:demoapp/View/Home/HomeScreen.dart';
import 'package:demoapp/View/Oboarding/Welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../Firebase_interface/Firebase_interface.dart';
import '../../Widgets/App_Font.dart';
import '../../Widgets/Widgets.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController emailcontroller=TextEditingController();
  TextEditingController passwordcontroller=TextEditingController();
  TextEditingController name=TextEditingController();
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
                     padding: EdgeInsets.only(left: 30.0,top: 20),
                     child: Text(
                       'Signup with Email',
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
                     padding: EdgeInsets.only(left: 35.0,bottom: 12),
                     child: Text(
                       'USER NAME',
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
                     padding: const EdgeInsets.only(left: 25.0, right: 22),
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
                         controller: name,
                         textAlign: TextAlign.start,
                         decoration: const InputDecoration(
                             prefixIcon: Icon(Icons.person_outline,
                               color:Color(0xFF636598), ),
                             hintText: 'First Name',
                             hintStyle: TextStyle(
                               color: Color(0xFF636598),
                               fontSize: 14,
                               fontFamily: AppFonts.fontFamily,
                               fontWeight: FontWeight.w500,
                               height: 0,
                             ),
                             border: InputBorder.none
                         ),
                       ),
                     ),
                   ),
                   SizedBox(
                       height: Get.height*0.02),
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
                     padding: const EdgeInsets.only(left: 25.0, right: 22),
                     child: Container(
                       alignment: Alignment.center,
                       height: Get.height*0.07,
                       width: Get.width * 0.9,
                       decoration: ShapeDecoration(
                         color: const Color(0xFF2A2C58),
                         shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(18),
                         ),
                       ),
                       child: TextFormField(
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
                       height: Get.height*0.021),
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
                     padding: const EdgeInsets.only(left: 25.0, right: 22),
                     child: Container(
                       alignment: Alignment.center,
                       height: Get.height*0.07,
                       width: Get.width * 0.9,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                Obx(()=>
                    GestureDetector(
                    onTap: ()async{

                      istrue.value=true;
                      final user=await Firebase_intefacee().signUpWithEmailAndPassword(emailcontroller.text.toString(), passwordcontroller.text.toString(), name.text.toString());
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
                      ):Application_Button('CREATE MY ACCOUNT')),
                )] ),
               SizedBox(
                height: Get.height*0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already Have an account?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: AppFonts.fontFamily,
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),),
                  GestureDetector(
                    onTap: (){
                      Get.to(const Signin());
          
                    },
                    child: const Text(' Login',
                      style:TextStyle(
                        color: AppColor.themeColor,
                        fontSize: 14,
                        fontFamily: AppFonts.fontFamily,
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ) ,),
                  )
                ],
              ),
              const SizedBox(
                height: 40,
              ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    child:  Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'By Continuing you’re agree with our ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: AppFonts.fontFamily,
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),


                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    child:  Text.rich(
                      TextSpan(
                        children: [

                          TextSpan(
                            text: 'Terms',
                            style: TextStyle(
                              color: Color(0xFFD3FB8F),
                              fontSize: 14,
                              fontFamily: AppFonts.fontFamily,
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                          TextSpan(
                            text: ' & ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: AppFonts.fontFamily,
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(
                              color: Color(0xFFD3FB8F),
                              fontSize: 14,
                              fontFamily: AppFonts.fontFamily,
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
