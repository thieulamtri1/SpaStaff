import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:spa_and_beauty_staff/Model/ConsultantSchedule.dart';
import 'package:spa_and_beauty_staff/Model/StaffSchedule.dart';
import 'package:spa_and_beauty_staff/Service/staff_service.dart';
import 'package:spa_and_beauty_staff/helper/Helper.dart';
import 'package:spa_and_beauty_staff/main.dart';
import 'package:table_calendar/table_calendar.dart';

class calendarPage extends StatefulWidget {
  @override
  _calendarPageState createState() => _calendarPageState();

}

class _calendarPageState extends State<calendarPage> {
  CalendarController _calendarController;
  DateTime selectedDay = DateTime.now();
  ScheduleStaff StaffSchedule;
  int staffId;
  String value;
  bool loading;



  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   _calendarController.dispose();
  //   super.dispose();
  // }

  void _onDaySelected(DateTime dateNow, List events, List holidays) {
    setState(() {
      selectedDay = dateNow;
      setState(() {
        loading = true;
        StaffService.getStaffSchedule(MyApp.storage.getItem("staffId"), MyHelper.getMachineDate(selectedDay),
            MyApp.storage.getItem("token"))
            .then((value) => {
          setState(() {
            StaffSchedule = value;
            loading = false;
          })
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    setState(() {
      loading = true;
      StaffService.getStaffSchedule(MyApp.storage.getItem("staffId"), MyHelper.getMachineDate(DateTime.now()),
          MyApp.storage.getItem("token"))
          .then((value) => {
        setState(() {
          StaffSchedule = value;
          loading = false;
        })
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: SafeArea(
        child: Column(
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
            ListToDoStaff(staffId: staffId,loading: loading,selectedDay: selectedDay,StaffSchedule: StaffSchedule,)
          ],
        ),
      ),
    );
  }




}
class ListToDoStaff extends StatefulWidget {
  const ListToDoStaff({Key key, this.StaffSchedule, this.staffId, this.value, this.loading, this.selectedDay}) : super(key: key);
  final ScheduleStaff StaffSchedule;
  final int staffId;
  final String value;
  final bool loading;
  final DateTime selectedDay;


  @override
  _ListToDoStaffState createState() => _ListToDoStaffState();
}

class _ListToDoStaffState extends State<ListToDoStaff> {
  @override
  Widget build(BuildContext context) {
    if (widget.loading) {
      return Center(
          child: SpinKitWave(
            color: Colors.white,
            size: 50,
          ));
    } else {
      if (widget.StaffSchedule.data.length == 0) {
        return Expanded(
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
                color: Colors.white),
            child: Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          MyHelper.getUserDate(widget.selectedDay),
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Column(
                      children: [],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      } else if (widget.StaffSchedule.data.length != 0) {
        return Expanded(
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
                color: Colors.white),
            child: Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          MyHelper.getUserDate(widget.selectedDay),
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
                            widget.StaffSchedule.data.length,
                                (index) => Column(
                              children: [
                                dayTask(
                                  startTime: widget.StaffSchedule
                                      .data[index].startTime
                                      .toString()
                                      .substring(0, 5)
                                  ,
                                  customerName: widget.StaffSchedule
                                      .data[index]
                                      .bookingDetail
                                      .booking
                                      .customer
                                      .user
                                      .fullname,
                                  phone: widget.StaffSchedule
                                      .data[index]
                                      .bookingDetail
                                      .booking
                                      .customer
                                      .user
                                      .phone,
                                  service: widget.StaffSchedule.data[index]
                                      .treatmentService.spaService.name,
                                  durationMin: widget.StaffSchedule
                                      .data[index]
                                      .treatmentService
                                      .spaService
                                      .durationMin
                                      .toString(),
                                  description: widget.StaffSchedule
                                      .data[index]
                                      .treatmentService
                                      .spaService
                                      .description,
                                )
                              ],
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }
    }

  }
  Row dayTask(
      {String startTime,
        String customerName,
        String service,
        String phone,
        String durationMin,
        String description}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width * 0.2,
          child: Text(
            startTime,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 15,
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
                      color: Colors.black, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.timer, color: Colors.grey),
                    SizedBox(width: 5),
                    Text("$durationMin min", style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w500
                    ),)
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.description, color: Colors.grey),
                    SizedBox(width: 5),
                    Text(description, style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w500
                    ),)
                  ],
                ),
                SizedBox(
                  height: 10,
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
                      color: Colors.green,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      phone,
                      style: TextStyle(color: Colors.green),
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

