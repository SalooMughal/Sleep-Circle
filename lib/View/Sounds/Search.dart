import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../Widgets/App_Font.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                    onTap: (){
                      Get.back();
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.arrow_back_ios_new_rounded),
                    )),

              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                  height: 60,
                  width: Get.width*0.9,
                  decoration: BoxDecoration(
                      color:  const Color(0xFF2A2C58),
                      borderRadius: BorderRadius.circular(40)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5.0,left: 20),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          hintStyle: TextStyle(
                            color: Color(0xFF636598),
                          ),
                          hintText: 'Search',
                          border: InputBorder.none
                      ),
                    ),
                  )),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20.0,top: 15.0),
              child: Text(
                'Recently Searched',
                style: TextStyle(
                  color: Color(0xFF636598),
                  fontSize: 14,
                  fontFamily: AppFonts.fontFamily,
                  fontWeight: FontWeight.w400,
                  height: 0.22,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 17,top: 20),
              child: Row(
                children: [
                  SvgPicture.asset('assets/images/history.svg'),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Deep Sleep',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: AppFonts.fontFamily,
                        fontWeight: FontWeight.w400,
                        height: 0.15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20.0,top: 15.0),
              child: Text(
                'Popular Searched',
                style: TextStyle(
                  color: Color(0xFF636598),
                  fontSize: 14,
                  fontFamily: AppFonts.fontFamily,
                  fontWeight: FontWeight.w400,
                  height: 0.22,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 17,top: 20),
              child: Row(
                children: [
                  SvgPicture.asset('assets/images/history.svg'),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Meads of Poetry',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: AppFonts.fontFamily,
                        fontWeight: FontWeight.w400,
                        height: 0.15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 17,top: 20),
              child: Row(
                children: [
                  SvgPicture.asset('assets/images/history.svg'),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Take a Nap',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: AppFonts.fontFamily,
                        fontWeight: FontWeight.w400,
                        height: 0.15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 17,top: 20),
              child: Row(
                children: [
                  SvgPicture.asset('assets/images/history.svg'),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Under the Sea',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: AppFonts.fontFamily,
                        fontWeight: FontWeight.w400,
                        height: 0.15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
