import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utlis/theme.dart';
import '../../Widgets/App_Font.dart';
import 'Sound_Screen.dart';

Widget Sleeping_Stories(){
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(
            left: 25.0, right: 20, top: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Sleeping Stories',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: AppFonts.fontFamily,
                fontWeight: FontWeight.w500,
                height: 0,
              ),
            ),
            GestureDetector(
              onTap: (){
                Get.to(Sound_Screen(origin: 'Stories',));
              },
              child: const Row(
                children: [
                  Text(
                    'See All',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: AppFonts.fontFamily,
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                  Icon((Icons.navigate_next))
                ],
              ),
            )
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 0,left: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: Get.height * 0.25,
              width: Get.width * 0.44,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment:
                MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    alignment: Alignment.bottomLeft,
                    height: Get.height * 0.2,
                    width: Get.width * 0.45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xFF2A2C58),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 25,
                        width: 70,
                        decoration: BoxDecoration(
                            color: const Color(0xFF9BC2FF)
                                .withOpacity(0.3),
                            borderRadius:
                            BorderRadius.circular(8)),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              height: 15,
                              width: 15,
                              decoration: const BoxDecoration(
                                  color: AppColor.themeColor,
                                  shape: BoxShape.circle),
                              child: const Icon(
                                Icons.play_arrow,
                                color: Colors.black,
                                size: 10,
                              ),
                            ),
                            const Text(
                              '30 min',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontFamily: AppFonts.fontFamily,
                                fontWeight: FontWeight.w400,
                                height: 0.22,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text('Letting go',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontFamily: AppFonts.fontFamily,
                          fontWeight: FontWeight.w400,
                          height: 0.15,
                        )),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                        left: 8.0, top: 4),
                    child: Text('Story',
                        style: TextStyle(
                          color: Color(0xFF636598),
                          fontSize: 10,
                          fontFamily: AppFonts.fontFamily,
                          fontWeight: FontWeight.w400,
                          height: 0.22,
                        )),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: Get.height * 0.25,
                width: Get.width * 0.42,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      alignment: Alignment.bottomLeft,
                      height: Get.height * 0.2,
                      width: Get.width * 0.45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xFF2A2C58),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 25,
                          width: 70,
                          decoration: BoxDecoration(
                              color: const Color(0xFF9BC2FF)
                                  .withOpacity(0.3),
                              borderRadius:
                              BorderRadius.circular(8)),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                height: 15,
                                width: 15,
                                decoration: const BoxDecoration(
                                    color: AppColor.themeColor,
                                    shape: BoxShape.circle),
                                child: const Icon(
                                  Icons.play_arrow,
                                  color: Colors.black,
                                  size: 10,
                                ),
                              ),
                              const Text(
                                '30 min',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontFamily: AppFonts.fontFamily,
                                  fontWeight: FontWeight.w400,
                                  height: 0.22,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text('Letting go',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: AppFonts.fontFamily,
                            fontWeight: FontWeight.w400,
                            height: 0.15,
                          )),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                          left: 8.0, top: 4),
                      child: Text('Story',
                          style: TextStyle(
                            color: Color(0xFF636598),
                            fontSize: 10,
                            fontFamily: AppFonts.fontFamily,
                            fontWeight: FontWeight.w400,
                            height: 0.22,
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 0,left: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: Get.height * 0.25,
              width: Get.width * 0.44,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment:
                MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    alignment: Alignment.bottomLeft,
                    height: Get.height * 0.2,
                    width: Get.width * 0.45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xFF2A2C58),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 25,
                        width: 70,
                        decoration: BoxDecoration(
                            color: const Color(0xFF9BC2FF)
                                .withOpacity(0.3),
                            borderRadius:
                            BorderRadius.circular(8)),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              height: 15,
                              width: 15,
                              decoration: const BoxDecoration(
                                  color: AppColor.themeColor,
                                  shape: BoxShape.circle),
                              child: const Icon(
                                Icons.play_arrow,
                                color: Colors.black,
                                size: 10,
                              ),
                            ),
                            const Text(
                              '30 min',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontFamily: AppFonts.fontFamily,
                                fontWeight: FontWeight.w400,
                                height: 0.22,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text('Letting go',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontFamily: AppFonts.fontFamily,
                          fontWeight: FontWeight.w400,
                          height: 0.15,
                        )),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                        left: 8.0, top: 4),
                    child: Text('Story',
                        style: TextStyle(
                          color: Color(0xFF636598),
                          fontSize: 10,
                          fontFamily: AppFonts.fontFamily,
                          fontWeight: FontWeight.w400,
                          height: 0.22,
                        )),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: Get.height * 0.25,
                width: Get.width * 0.42,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      alignment: Alignment.bottomLeft,
                      height: Get.height * 0.2,
                      width: Get.width * 0.45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xFF2A2C58),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 25,
                          width: 70,
                          decoration: BoxDecoration(
                              color: const Color(0xFF9BC2FF)
                                  .withOpacity(0.3),
                              borderRadius:
                              BorderRadius.circular(8)),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                height: 15,
                                width: 15,
                                decoration: const BoxDecoration(
                                    color: AppColor.themeColor,
                                    shape: BoxShape.circle),
                                child: const Icon(
                                  Icons.play_arrow,
                                  color: Colors.black,
                                  size: 10,
                                ),
                              ),
                              const Text(
                                '30 min',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontFamily: AppFonts.fontFamily,
                                  fontWeight: FontWeight.w400,
                                  height: 0.22,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text('Letting go',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: AppFonts.fontFamily,
                            fontWeight: FontWeight.w400,
                            height: 0.15,
                          )),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                          left: 8.0, top: 4),
                      child: Text('Story',
                          style: TextStyle(
                            color: Color(0xFF636598),
                            fontSize: 10,
                            fontFamily: AppFonts.fontFamily,
                            fontWeight: FontWeight.w400,
                            height: 0.22,
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}