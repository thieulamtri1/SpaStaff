import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spa_and_beauty_staff/Model/ConsultantSchedule.dart';
import 'package:spa_and_beauty_staff/Model/StaffSchedule.dart';
import 'package:spa_and_beauty_staff/Service/consultant_service.dart';
import 'package:spa_and_beauty_staff/constants.dart';
import 'package:spa_and_beauty_staff/helper/Helper.dart';
import 'package:spa_and_beauty_staff/main.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;

class calendarPage extends StatefulWidget {
  @override
  _calendarPageState createState() => _calendarPageState();
}

class _calendarPageState extends State<calendarPage> {
  CalendarController _calendarController;
  DateTime selectedDay = DateTime.now();
  ScheduleConsultant ConsultantSchedule;
  int consultantId;
  String value;
  bool loading = true;

  getData(date) {
    ConsultantService.getConsultantSchedule(
            MyApp.storage.getItem("consultantId"),
            date,
            MyApp.storage.getItem("token"))
        .then((value) => {
              setState(() {
                ConsultantSchedule = value;
                loading = false;
              })
            });
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   _calendarController.dispose();
  //   super.dispose();
  // }

  // void _onDaySelected(DateTime dateNow, List events, List holidays) {
  //   setState(() {
  //     selectedDay = dateNow;
  //   });
  // }

  void _onDaySelected(DateTime dateNow, List events, List holidays) {
    setState(() {
      selectedDay = dateNow;
      setState(() {
        loading = true;
        ConsultantService.getConsultantSchedule(
                MyApp.storage.getItem("consultantId"),
                MyHelper.getMachineDate(selectedDay),
                MyApp.storage.getItem("token"))
            .then((value) => {
                  setState(() {
                    ConsultantSchedule = value;
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
      ConsultantService.getConsultantSchedule(
              MyApp.storage.getItem("consultantId"),
              MyHelper.getMachineDate(DateTime.now()),
              MyApp.storage.getItem("token"))
          .then((value) => {
                setState(() {
                  ConsultantSchedule = value;
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
            ListToDoConsultant(
              consultantId: consultantId,
              loading: loading,
              selectedDay: selectedDay,
              ConsultantSchedule: ConsultantSchedule,
            )
          ],
        ),
      ),
    );
  }
}

class ListToDoConsultant extends StatefulWidget {
  const ListToDoConsultant(
      {Key key,
      this.ConsultantSchedule,
      this.consultantId,
      this.value,
      this.loading,
      this.selectedDay})
      : super(key: key);

  final ScheduleConsultant ConsultantSchedule;
  final int consultantId;
  final String value;
  final bool loading;
  final DateTime selectedDay;

  @override
  _ListToDoConsultantState createState() => _ListToDoConsultantState();
}

class _ListToDoConsultantState extends State<ListToDoConsultant> {
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
                          widget.ConsultantSchedule.data.length,
                          (index) => widget.ConsultantSchedule.data[index]
                                      .isConsultation
                                      .toString() ==
                                  "TRUE"
                              ? Column(
                                  children: [
                                    dayTask(
                                      startTime: widget.ConsultantSchedule
                                          .data[index].startTime
                                          .toString()
                                          .substring(0, 5),
                                      customerName: widget
                                          .ConsultantSchedule
                                          .data[index]
                                          .bookingDetail
                                          .booking
                                          .customer
                                          .user
                                          .fullname,
                                      phone: widget
                                          .ConsultantSchedule
                                          .data[index]
                                          .bookingDetail
                                          .booking
                                          .customer
                                          .user
                                          .phone,
                                      package: widget
                                          .ConsultantSchedule
                                          .data[index]
                                          .bookingDetail
                                          .spaPackage
                                          .name,
                                      customerGender: widget
                                          .ConsultantSchedule
                                          .data[index]
                                          .bookingDetail
                                          .booking
                                          .customer
                                          .user
                                          .gender,
                                      customerMail: widget
                                          .ConsultantSchedule
                                          .data[index]
                                          .bookingDetail
                                          .booking
                                          .customer
                                          .user
                                          .email,
                                      isConsult: true,
                                    ),
                                  ],
                                )
                              : Column(
                                  children: [
                                    dayTask(
                                      startTime: widget.ConsultantSchedule
                                          .data[index].startTime
                                          .toString()
                                          .substring(0, 5),
                                      customerName: widget
                                          .ConsultantSchedule
                                          .data[index]
                                          .bookingDetail
                                          .booking
                                          .customer
                                          .user
                                          .fullname,
                                      phone: widget
                                          .ConsultantSchedule
                                          .data[index]
                                          .bookingDetail
                                          .booking
                                          .customer
                                          .user
                                          .phone,
                                      package: widget
                                          .ConsultantSchedule
                                          .data[index]
                                          .bookingDetail
                                          .spaPackage
                                          .name,
                                      customerGender: widget
                                          .ConsultantSchedule
                                          .data[index]
                                          .bookingDetail
                                          .booking
                                          .customer
                                          .user
                                          .gender,
                                      customerMail: widget
                                          .ConsultantSchedule
                                          .data[index]
                                          .bookingDetail
                                          .booking
                                          .customer
                                          .user
                                          .email,
                                      isConsult: false,
                                      stepName: widget
                                          .ConsultantSchedule
                                          .data[index]
                                          .treatmentService
                                          .spaService
                                          .name,
                                    ),
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
      String stepName,
      String package,
      String phone,
      customerMail,
      customerGender,
      bool isConsult}) {
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
                  color: isConsult ? kBlue : kGreen,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          WidgetSpan(
                            child: Icon(Icons.timer, size: 20, color: Colors.white,),
                          ),
                          TextSpan(
                              text: startTime,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              )),
                        ],
                      ),
                    ),
                    isConsult
                        ? Text(
                            "Tư vấn",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          )
                        : SizedBox(),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          customerName,
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 20),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    isConsult
                        ? Text(
                            package,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          )
                        : Text(
                            stepName,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.wc_sharp, color: Colors.grey),
                        SizedBox(width: 5),
                        Text(
                          customerGender,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.mail, color: Colors.grey),
                        SizedBox(width: 5),
                        Text(
                          customerMail,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
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
        ),
      ],
    );
  }
}
