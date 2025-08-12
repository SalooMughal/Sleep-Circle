
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';


import '../../Widgets/App_Font.dart';
import '../../Widgets/Widgets.dart';
import 'Slider_Screen/Slider.dart';


class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  bool isChecked = false;
  @override

  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: Get.height*0.36,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/icons/App Icon.svg')
            ],
          ),
          SizedBox(
            height: Get.height*0.1,
          ),
          const Text(
            'Welcome to Sleep Circle',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFFD3FB8F),
              fontSize: 20,
              fontFamily: AppFonts.fontFamily,
              fontWeight: FontWeight.w600,
              height: 0,
            ),
          ),
       SizedBox(height: Get.height*0.015,),
       SizedBox(
        width: Get.width*0.7,
        child: const Text(
          'Let’s begin your journey',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: AppFonts.fontFamily,
            fontWeight: FontWeight.w500,
            height: 0,
          ),
        )),
          Container(
            height: Get.height*0.13,
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Container(
          //       height: 20,
          //       width: 20,
          //       alignment: Alignment.center,
          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(5), // Adjust the radius as needed
          //         color: isChecked ? const Color(0xFFD3FB8F) : const Color(0xFFD0D0D0), // Change color when active/inactive
          //       ),
          //       child: InkWell(
          //         onTap: () {
          //           setState(() {
          //             isChecked = !isChecked;
          //           });
          //         },
          //         borderRadius: BorderRadius.circular(30), // Adjust the radius as needed
          //         child: isChecked
          //             ? const Icon(
          //           Icons.check,
          //           color: Colors.black,
          //           size: 20,
          //         ) // Show icon when active
          //             : const Icon(
          //           Icons.check,
          //           color: Colors.black,
          //           size: 20,
          //         ), // Show circle icon when inactive
          //       ),
          //     ),
          //     const SizedBox(width: 10,),
          //     // SizedBox(
          //     //   width: Get.width*0.78,
          //     //   child: const Column(
          //     //     crossAxisAlignment: CrossAxisAlignment.start,
          //     //     children: [
          //     //       Text(
          //     //         'By Continuing you’re agree with our',
          //     //         style: TextStyle(
          //     //           color: Colors.white,
          //     //           fontSize: 13,
          //     //           fontFamily: AppFonts.fontFamily,
          //     //           fontWeight: FontWeight.w400,
          //     //           height: 0,
          //     //         ),
          //     //       ),
          //     //       Padding(
          //     //         padding: EdgeInsets.all(1.0),
          //     //         child: Text(
          //     //           'Terms & Privacy Policy',
          //     //           style: TextStyle(
          //     //             color: Colors.white,
          //     //             fontSize: 13,
          //     //             fontFamily: AppFonts.fontFamily,
          //     //             fontWeight: FontWeight.w400,
          //     //             height: 0,
          //     //           ),
          //     //         ),
          //     //       ),
          //     //     ],
          //     //   ),
          //     // )
          //   ],
          // ),
           SizedBox(height: Get.height*0.04,),
          InkWell(
            onTap: (){
              Get.to(const onBoarding_Slider());
            },
              child: Application_Button('GET STARTED'))
        ],
      ),
    );
  }
}
