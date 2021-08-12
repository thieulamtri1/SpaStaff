import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spa_and_beauty_staff/Model/StaffSchedule.dart';
import 'package:spa_and_beauty_staff/Service/staff_service.dart';
import 'package:spa_and_beauty_staff/Staff/onestep_detail/onestep_detail.dart';
import 'package:spa_and_beauty_staff/Staff/process_detail/process_detail_screen.dart';
import 'package:spa_and_beauty_staff/constants.dart';
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
        StaffService.getStaffSchedule(
                MyApp.storage.getItem("staffId"),
                MyHelper.getMachineDate(selectedDay),
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
      StaffService.getStaffSchedule(
              MyApp.storage.getItem("staffId"),
              MyHelper.getMachineDate(DateTime.now()),
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
      backgroundColor: kPrimaryColor,
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
            ListToDoStaff(
              staffId: staffId,
              loading: loading,
              selectedDay: selectedDay,
              StaffSchedule: StaffSchedule,
            )
          ],
        ),
      ),
    );
  }
}

class ListToDoStaff extends StatefulWidget {
  const ListToDoStaff(
      {Key key,
      this.StaffSchedule,
      this.staffId,
      this.value,
      this.loading,
      this.selectedDay})
      : super(key: key);

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
      return Expanded(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(color: Colors.grey[100]),
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/schedule.svg",
                          width: 24,
                          height: 24,
                        ),
                        Text(
                          MyHelper.getUserDate(widget.selectedDay),
                          style: TextStyle(color: kTextColor, fontSize: 24),
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      ...List.generate(
                          widget.StaffSchedule.data.length,
                          (index) => Column(
                                children: [
                                  GestureDetector(
                                    onTap: ()
                                    {
                                      if(widget.StaffSchedule.data[index].treatmentService.spaService.type == "MORESTEP") {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  StaffProcessDetail(
                                                    bookingDetail: widget
                                                        .StaffSchedule
                                                        .data[index]
                                                        .bookingDetail,
                                                  )),
                                        );
                                      }
                                      else{
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  OneStepDetailScreen( bookingDetail: widget
                                                      .StaffSchedule
                                                      .data[index]
                                                      .bookingDetail,)),
                                        );
                                      }
                                    },
                                    child: dayTask(
                                      startTime: widget
                                          .StaffSchedule.data[index].startTime
                                          .toString()
                                          .substring(0, 5),
                                      customerName: widget
                                          .StaffSchedule
                                          .data[index]
                                          .bookingDetail
                                          .booking
                                          .customer
                                          .user
                                          .fullname,
                                      phone: widget
                                          .StaffSchedule
                                          .data[index]
                                          .bookingDetail
                                          .booking
                                          .customer
                                          .user
                                          .phone,
                                      service:
                                      widget.StaffSchedule.data[index].treatmentService.spaService.type == "MORESTEP"
                                          ? widget.StaffSchedule.data[index].treatmentService.spaService.name
                                          : widget.StaffSchedule.data[index].bookingDetail.spaPackage.name
                                      ,
                                      durationMin: widget
                                          .StaffSchedule
                                          .data[index]
                                          .treatmentService
                                          .spaService
                                          .durationMin
                                          .toString(),
                                      note:widget
                                          .StaffSchedule
                                          .data[index]
                                          .consultationContent == null ?
                                      "Không có ghi chú."
                                      :widget
                                          .StaffSchedule
                                          .data[index]
                                          .consultationContent.note==null ?
                                      "Không có ghi chú."
                                      :widget
                                          .StaffSchedule
                                          .data[index]
                                          .consultationContent.note,
                                      type: widget.StaffSchedule.data[index].treatmentService.spaService.type ,
                                      status: widget.StaffSchedule.data[index].statusBooking
                                    ),
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

  Column dayTask(
      {String startTime,
      String customerName,
        String status,
      String service,
      String phone,
      String durationMin,
        String type,
      String note}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ], color: Colors.white, borderRadius: BorderRadius.circular(20)),
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20)),
                  color: kPrimaryColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          WidgetSpan(
                            child: Icon(
                              Icons.timer,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                          TextSpan(
                              text: startTime,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              )),
                        ],
                      ),
                    )
                    ,
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      customerName,
                      style: TextStyle(
                          color: kPrimaryColor, fontWeight: FontWeight.w700),
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
                    type == "MORESTEP"
                        ?
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.timer, color: kPrimaryColor),
                        SizedBox(width: 5),
                        Text(
                          "$durationMin phút",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    )
                    :Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.spa, color: kPrimaryColor),
                        SizedBox(width: 5),
                        Text(
                          "Dịch vụ một lần",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    )
                    ,
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.description, color: kPrimaryColor),
                        SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            note,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.w500),
                          ),
                        )
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
            ],
          ),
        )
      ],
    );
  }
}
