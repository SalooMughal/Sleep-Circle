import 'package:demoapp/Utlis/theme.dart';
import 'package:demoapp/View/Reports/Week_reports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../Controller/Common_Controller.dart';
import '../../Widgets/App_Font.dart';
import 'Days_report.dart';
import 'Monthly_report.dart';

class Reports_View extends StatefulWidget {
  const Reports_View({super.key});

  @override
  State<Reports_View> createState() => _Reports_ViewState();
}

class _Reports_ViewState extends State<Reports_View> {
  CommonController commonController=Get.find<CommonController>();
  int _selectindex_Days=0;
  DateTime? _selectedDate=DateTime.now();
  String? month;
  int month_no=0;

  int getWeekOfMonth(DateTime date) {
    // Start of the month
    DateTime firstDayOfMonth = DateTime(date.year, date.month, 1);

    // Get the difference in days between the given date and the start of the month
    int dayOfMonth = date.day;

    // Determine the day of the week for the first day of the month
    int firstDayWeekday = firstDayOfMonth.weekday;

    // Calculate the offset from the start of the week
    int offset = (firstDayWeekday - 1);

    // Calculate the week number (add 1 to convert from zero-based to one-based index)
    int weekOfMonth = ((dayOfMonth + offset) / 7).ceil();

    return weekOfMonth;
  }
  List<DateTime> getDatesOfWeek(DateTime date) {
    // Calculate the start and end of the week
    DateTime firstDayOfWeek = date.subtract(Duration(days: date.weekday - 1));
    DateTime lastDayOfWeek = firstDayOfWeek.add(const Duration(days: 6));

    // Get the start of the month and the end of the month
    DateTime firstDayOfMonth = DateTime(date.year, date.month, 1);
    DateTime lastDayOfMonth = DateTime(date.year, date.month + 1, 0);

    // Adjust the start and end of the week to stay within the month
    DateTime adjustedStartOfWeek = firstDayOfWeek.isBefore(firstDayOfMonth)
        ? firstDayOfMonth
        : firstDayOfWeek;
    DateTime adjustedEndOfWeek = lastDayOfWeek.isAfter(lastDayOfMonth)
        ? lastDayOfMonth
        : lastDayOfWeek;

    // Create a list of dates for the week
    List<DateTime> weekDates = [];
    for (DateTime day = adjustedStartOfWeek;
    day.isBefore(adjustedEndOfWeek.add(const Duration(days: 1)));
    day = day.add(const Duration(days: 1))) {
      weekDates.add(day);
    }

    return weekDates;
  }
  List filterdates=[];
  void initState() {
    _selectindex_Days=1;


    weekOfMonth = getWeekOfMonth(DateTime.now());
    super.initState();
  }
  List<DateTime>? datesOfWeek;
  int? weekOfMonth;
  String? start_weekdate;
  String? last_weekdate;

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('MMMM d, y').format(_selectedDate!);
    return  Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0,top: 15,right: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                    onTap: (){
                      commonController.selectedIndex.value=0;
                      setState(() {

                      });
                    },
                    child: const Icon(Icons.arrow_back_ios_new_rounded)),

                SizedBox(height: Get.height*0.02,),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return LayoutBuilder(
                                    builder: (context, constraints) {
                                      return Container(
                                        color: AppColor.scaffold,
                                        height: constraints.maxHeight, // Set the height of the bottom sheet
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              color: const Color(0xBF101334), // Change to your desired background color
                                              child: TableCalendar(
                                                firstDay: DateTime(2000),
                                                lastDay: DateTime(2050),
                                                focusedDay: DateTime.now(),
                                                calendarFormat: CalendarFormat.month,
                                                calendarStyle: CalendarStyle(
                                                  selectedDecoration: BoxDecoration(
                                                    color: Theme.of(context).primaryColor,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  todayDecoration: const BoxDecoration(
                                                    color: Color(0x35636598),
                                                    shape: BoxShape.circle,
                                                  ),
                                                ),
                                                selectedDayPredicate: (date) {
                                                  return isSameDay(_selectedDate, date);
                                                },
                                                onDaySelected: (date, focusedDay) {
                                                  filterdates.clear();
                                                  _selectedDate = date;

                                                  month=DateFormat.MMMM().format(_selectedDate!);
                                                  getWeekOfMonth(_selectedDate!);
                                                  month_no=_selectedDate!.month;
                                                  datesOfWeek = getDatesOfWeek(_selectedDate!);
                                                  weekOfMonth = getWeekOfMonth(date);
                                                   for(int i=0; i<datesOfWeek!.length; i++){
                                                    String formattedDate = DateFormat('MMMM d').format(datesOfWeek!.first);
                                                    String formattedDate2 = DateFormat('MMMM d').format(datesOfWeek!.last);
                                                    start_weekdate=formattedDate;
                                                    last_weekdate=formattedDate2;
                                                    String formattedDate3 = DateFormat('MMMM d, y').format(datesOfWeek![i]);
                                                    filterdates.add(formattedDate3);


                                                  }
                                                  setState(() {

                                                  });
                                                  Navigator.pop(context);
                                                },
                                                calendarBuilders: CalendarBuilders(
                                                  selectedBuilder: (context, date, _) => Container(
                                                    decoration: const BoxDecoration(
                                                      color: Color(0x35636598),
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        date.day.toString(),
                                                        style: const TextStyle(color: Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                            },
                            child: Text(
                              _selectindex_Days == 1 ? formattedDate : _selectindex_Days == 2 ? 'Week ${weekOfMonth}th' : _selectindex_Days == 3 ? '$month Month' : '',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: AppFonts.fontFamily,
                                fontWeight: FontWeight.w500,
                                height: 0,
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: SvgPicture.asset('assets/images/down-arrow.svg'),
                          )
                        ],
                      ),
                      SizedBox(height: Get.height*0.02,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: (){
                              _selectindex_Days=1;
                              setState(() {
            
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: Get.height*0.05,
                              width: Get.width*0.28,
                              decoration: ShapeDecoration(
                                color: _selectindex_Days==1?const Color(0xFFD3FB8F):const Color(0x4C9AC1FF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(11.08),
                                ),
                              ),
                              child:  Text(
                                                'Day',
                                                  style: TextStyle(
                            color: _selectindex_Days==1?const Color(0xFF101334):Colors.white,
                            fontSize: 13.85,
                            fontFamily: AppFonts.fontFamily,
                            fontWeight: FontWeight.w500,
                            height: 0,
                                                  ),
                                                ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){

                              setState(() {

                                filterdates.clear();
                                _selectindex_Days=2;
                                datesOfWeek = getDatesOfWeek(DateTime.now());
                                String formattedDate = DateFormat('MMMM d').format(datesOfWeek!.first);
                                String formattedDate2 = DateFormat('MMMM d').format(datesOfWeek!.last);
                                start_weekdate=formattedDate;
                                last_weekdate=formattedDate2;
                                for(int i=0; i<datesOfWeek!.length; i++){
                                  String formattedDate = DateFormat('MMMM d, y').format(datesOfWeek![i]);

                                  filterdates.add(formattedDate);

                                }
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: Get.height*0.05,
                              width: Get.width*0.28,
                              decoration: ShapeDecoration(
                                color:  _selectindex_Days==2?const Color(0xFFD3FB8F):const Color(0x4C9AC1FF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(11.08),
                                ),
                              ),
                              child:  Text(
                                'Week',
                                style: TextStyle(
                                  color: _selectindex_Days==2?const Color(0xFF101334):Colors.white,
                                  fontSize: 13.85,
                                  fontFamily: AppFonts.fontFamily,
                                  fontWeight: FontWeight.w500,
                                  height: 0,
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              _selectindex_Days=3;
                              DateTime time = DateTime.now();

                               month = DateFormat.MMMM().format(time);
                              month_no=time.month;
                              setState(() {
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: Get.height*0.05,
                              width: Get.width*0.28,
                              decoration: ShapeDecoration(
                                color: _selectindex_Days==3?const Color(0xFFD3FB8F):const Color(0x4C9AC1FF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(11.08),
                                ),
                              ),
                              child:  Text(
                                'Month',
                                style: TextStyle(
                                  color: _selectindex_Days==3?const Color(0xFF101334):Colors.white,
                                  fontSize: 13.85,
                                  fontFamily: AppFonts.fontFamily,
                                  fontWeight: FontWeight.w500,
                                  height: 0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      _selectindex_Days==1?Day_Reports(formattedDate):_selectindex_Days==2?Week_Reports(start_weekdate!,last_weekdate!,filterdates):_selectindex_Days==3?Monthly_Reports(month!,month_no):const SizedBox()
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
