import 'package:flutter/material.dart';
import 'package:spa_and_beauty_staff/Model/StaffSchedule.dart';
import 'package:spa_and_beauty_staff/Service/staff_schedule_service.dart';
import 'package:spa_and_beauty_staff/main.dart';
import 'package:table_calendar/table_calendar.dart';

class calendarPage extends StatefulWidget {
  @override
  _calendarPageState createState() => _calendarPageState();
}

class _calendarPageState extends State<calendarPage> {
  CalendarController _calendarController;
  DateTime selectedDay = DateTime.now();
  List<StaffSchedule> listStaffSchedule;
  int staffId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    _calendarController = CalendarController();

  }

  getData() async {
    await MyApp.storage.ready;
    staffId = MyApp.storage.getItem("staffId");
    StaffScheduleService.getStaffSchedule(staffId).then((value) =>
    {
      setState(() {
        listStaffSchedule = value;

      }),
    });
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   _calendarController.dispose();
  //   super.dispose();
  // }

  void _onDaySelected(DateTime dateNow, List events, List holidays) {
    setState(() {
      selectedDay = dateNow;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Schedule",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          TableCalendar(
            calendarController: _calendarController,
            initialCalendarFormat: CalendarFormat.week,
            startingDayOfWeek: StartingDayOfWeek.monday,
            formatAnimation: FormatAnimation.slide,
            onDaySelected: _onDaySelected,
            headerStyle: HeaderStyle(
              centerHeaderTitle: true,
              formatButtonVisible: false,
              titleTextStyle: TextStyle(color: Colors.white, fontSize: 16),
              leftChevronIcon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 15,
              ),
              rightChevronIcon: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 15,
              ),
              leftChevronMargin: EdgeInsets.only(left: 70),
              rightChevronMargin: EdgeInsets.only(right: 70),
            ),
            calendarStyle: CalendarStyle(
                weekendStyle: TextStyle(color: Colors.white),
                weekdayStyle: TextStyle(color: Colors.white)),
            daysOfWeekStyle: DaysOfWeekStyle(
                weekendStyle: TextStyle(color: Colors.white),
                weekdayStyle: TextStyle(color: Colors.white)),
          ),
          SizedBox(
            height: 5,
          ),
          ListToDo(selectedDay.toString().substring(0, 10)),
        ],
      ),
    );
  }

  Expanded ListToDo(String date) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40)),
            color: Colors.white),
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      date,
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Column(
                  children: [
                    ...List.generate(
                        listStaffSchedule.length,
                            (index) => date == listStaffSchedule[index].day.toString().substring(0, 10)
                                ?Column(
                              children: [
                                ...List.generate(listStaffSchedule[index].listStaffScheduleForSlots.length, (index1) =>
                                    listStaffSchedule[index].listStaffScheduleForSlots[index1].bookingId!=null?
                                    dayTask(
                                      time: listStaffSchedule[index].listStaffScheduleForSlots[index1].slotTime.toString(),
                                      customerName: listStaffSchedule[index].listStaffScheduleForSlots[index1].customerInfo.fullname,
                                      service: listStaffSchedule[index].listStaffScheduleForSlots[index1].service.name,
                                      phone: listStaffSchedule[index].listStaffScheduleForSlots[index1].customerInfo.street,
                                    )
                                        :
                                        Container()
                                )
                              ],
                            )

                                : Container())

                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }



  Row dayTask({String time, String customerName, String service, String phone}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(10),
          width: MediaQuery
              .of(context)
              .size
              .width * 0.2,
          child: Text(
            time,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.right,
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(bottom: 20),
            padding: EdgeInsets.all(20),
            color: Colors.grey[100],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  customerName,
                  style: TextStyle(
                      color: Colors.orange, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  service,
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: 0.5,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.call,
                      color: Colors.orange,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      phone,
                      style: TextStyle(color: Colors.orange),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
