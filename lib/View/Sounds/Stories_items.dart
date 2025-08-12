import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../Utlis/theme.dart';
import '../../Widgets/App_Font.dart';
import 'Audio_Player.dart';

Widget Stories_items(List items, RxInt selectedIndex){
  return Column(
    children: [
      SizedBox(
        height: 48.h,
        width: Get.width*0.94,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  selectedIndex.value = index; // Update the selected index
                },
                child: Obx(
                      () => IntrinsicWidth(
                    child: Container(
                      height: 48.h,
                      padding:  EdgeInsets.symmetric(horizontal: 7.5.sp),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: index == selectedIndex.value
                            ? const Color(0xFFD3FB8F)
                            : const Color(0x4C9AC1FF),
                        // Change color based on selection
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${items[index]}',
                        style: TextStyle(
                          color: index == selectedIndex.value
                              ? Colors.black
                              : Colors.white,
                          // Change color based on selection
                           fontSize: 13.5.sp,
                          fontFamily: AppFonts.fontFamily,
                          fontWeight: FontWeight.w500,
                          height: 1,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 15.0,right: 15.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 22.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap:(){
                      Get.bottomSheet(
                          isScrollControlled: true,
                          Audio_Player()
                      );
                    },
                    child: Container(
                      height: Get.height * 0.2,
                      width: Get.width * 0.9,
                      decoration: ShapeDecoration(
                        color: Color(0xFF2A2C58),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    width: 40,
                                    height: 25,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 7),
                                    clipBehavior: Clip.antiAlias,
                                    decoration: ShapeDecoration(
                                      color: const Color(0xFFD3FB8F),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(6)),
                                    ),
                                    child: const Text(
                                      'New',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontFamily: AppFonts.fontFamily,
                                        fontWeight: FontWeight.w500,
                                        height: 0,
                                      ),
                                    )),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 25,
                                  width: 70,
                                  decoration: BoxDecoration(
                                      color: const Color(0xFF9BC2FF)
                                          .withOpacity(0.3),
                                      borderRadius:
                                      BorderRadius.circular(
                                          8)),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceEvenly,
                                    children: [
                                      Container(
                                        alignment:
                                        Alignment.center,
                                        height: 15,
                                        width: 15,
                                        decoration: const BoxDecoration(
                                            color: AppColor
                                                .themeColor,
                                            shape:
                                            BoxShape.circle),
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
                                          fontWeight:
                                          FontWeight.w400,
                                          height: 0.22,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 15.0),
                    child: Text(
                      'Letting go',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: AppFonts.fontFamily,
                        fontWeight: FontWeight.w400,
                        height: 0.15,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 15.0),
                    child: Text(
                      'Music',
                      style: TextStyle(
                        color: Color(0xFF636598),
                        fontSize: 10,
                        fontFamily: AppFonts.fontFamily,
                        fontWeight: FontWeight.w400,
                        height: 0.22,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Get.height * 0.7, // Adjust the height as needed
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: 4, // Replace itemCount with your actual item count
                gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 1,
                  childAspectRatio:0.80,
                  crossAxisCount: 2, // RepReplace crossAxisCount with your desired value
                  // Replace crossAxisSpacing with your desired value
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: GestureDetector(
                      onTap: () {
                        Get.bottomSheet(
                          isScrollControlled: true,
                          Audio_Player(),
                        );
                      },
                      child: SizedBox(
                        height: Get.height * 0.4, // Adjust the height as needed
                        width: Get.width * 0.44, // Adjust the width as needed
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  alignment: Alignment.bottomLeft,
                                  height: Get.height * 0.2, // Adjust the height as needed
                                  width: Get.width * 0.44, // Adjust the width as needed
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
                                        color: const Color(0xFF9BC2FF).withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            height: 15,
                                            width: 15,
                                            decoration: const BoxDecoration(
                                              color: AppColor.themeColor,
                                              shape: BoxShape.circle,
                                            ),
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
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 8.0, top: 15),
                              child: Text('Cottage by sea',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontFamily: AppFonts.fontFamily,
                                    fontWeight: FontWeight.w400,
                                    height: 0.15,
                                  )),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 8.0, top: 15),
                              child: Text('Music',
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
                  );
                },
              ),
            )
          ],
        ),
      )


    ],
  );
}