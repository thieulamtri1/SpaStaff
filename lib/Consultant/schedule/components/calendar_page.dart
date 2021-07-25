import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:spa_and_beauty_staff/Model/ConsultantSchedule.dart';
import 'package:spa_and_beauty_staff/Model/StaffSchedule.dart';
import 'package:spa_and_beauty_staff/Service/consultant_service.dart';
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
        ConsultantService.getConsultantSchedule(MyApp.storage.getItem("consultantId"), MyHelper.getMachineDate(selectedDay),
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
      ConsultantService.getConsultantSchedule(MyApp.storage.getItem("consultantId"), MyHelper.getMachineDate(DateTime.now()),
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
            ListToDoConsultant(consultantId: consultantId,loading: loading,selectedDay: selectedDay,ConsultantSchedule: ConsultantSchedule,)
          ],
        ),
      ),
    );
  }


  // ListToDoConsultant(String date) {
  //   getData(date);
  //   if (loading) {
  //     return Center(
  //         child: SpinKitWave(
  //       color: Colors.white,
  //       size: 50,
  //     ));
  //   } else {
  //     if (ConsultantSchedule.data.length == 0) {
  //       return Expanded(
  //         child: Container(
  //           padding: EdgeInsets.all(20),
  //           decoration: BoxDecoration(
  //               borderRadius: BorderRadius.only(
  //                   topLeft: Radius.circular(40),
  //                   topRight: Radius.circular(40)),
  //               color: Colors.white),
  //           child: Container(
  //             child: SingleChildScrollView(
  //               child: Column(
  //                 children: [
  //                   Row(
  //                     children: [
  //                       Text(
  //                         date,
  //                         style: TextStyle(color: Colors.grey),
  //                       )
  //                     ],
  //                   ),
  //                   SizedBox(
  //                     height: 15,
  //                   ),
  //                   Column(
  //                     children: [],
  //                   )
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //       );
  //     } else if (ConsultantSchedule.data.length != 0) {
  //       return Expanded(
  //         child: Container(
  //           padding: EdgeInsets.all(20),
  //           decoration: BoxDecoration(
  //               borderRadius: BorderRadius.only(
  //                   topLeft: Radius.circular(40),
  //                   topRight: Radius.circular(40)),
  //               color: Colors.white),
  //           child: Container(
  //             child: SingleChildScrollView(
  //               child: Column(
  //                 children: [
  //                   Row(
  //                     children: [
  //                       Text(
  //                         date,
  //                         style: TextStyle(color: Colors.grey),
  //                       )
  //                     ],
  //                   ),
  //                   SizedBox(
  //                     height: 15,
  //                   ),
  //                   Column(
  //                     children: [
  //                       ...List.generate(
  //                           ConsultantSchedule.data.length,
  //                           (index) => ConsultantSchedule
  //                                       .data[index].isConsultation
  //                                       .toString() ==
  //                                   "TRUE"
  //                               ? Column(
  //                                   children: [
  //                                     dayTask(
  //                                       startTime: ConsultantSchedule
  //                                           .data[index].startTime
  //                                           .toString()
  //                                           .substring(0, 5),
  //                                       customerName: ConsultantSchedule
  //                                           .data[index]
  //                                           .bookingDetail
  //                                           .booking
  //                                           .customer
  //                                           .user
  //                                           .fullname,
  //                                       phone: ConsultantSchedule
  //                                           .data[index]
  //                                           .bookingDetail
  //                                           .booking
  //                                           .customer
  //                                           .user
  //                                           .phone,
  //                                       package: ConsultantSchedule.data[index]
  //                                           .bookingDetail.spaPackage.name,
  //                                       customerGender: ConsultantSchedule
  //                                           .data[index]
  //                                           .bookingDetail
  //                                           .booking
  //                                           .customer
  //                                           .user
  //                                           .gender,
  //                                       customerMail: ConsultantSchedule
  //                                           .data[index]
  //                                           .bookingDetail
  //                                           .booking
  //                                           .customer
  //                                           .user
  //                                           .email,
  //                                     ),
  //                                   ],
  //                                 )
  //                               : SizedBox())
  //                     ],
  //                   )
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //       );
  //     }
  //   }
  // }
  //
  // Row dayTask(
  //     {String startTime,
  //     String customerName,
  //     String package,
  //     String phone,
  //     customerMail,
  //     customerGender}) {
  //   return Row(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Container(
  //         padding: EdgeInsets.all(10),
  //         width: MediaQuery.of(context).size.width * 0.2,
  //         child: Text(
  //           startTime,
  //           style: TextStyle(
  //             color: Colors.black,
  //             fontWeight: FontWeight.w700,
  //           ),
  //           textAlign: TextAlign.right,
  //         ),
  //       ),
  //       Expanded(
  //         child: Container(
  //           margin: EdgeInsets.only(bottom: 20),
  //           padding: EdgeInsets.all(20),
  //           color: Colors.grey[100],
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text(
  //                 customerName,
  //                 style: TextStyle(
  //                     color: Colors.orange, fontWeight: FontWeight.w700),
  //               ),
  //               SizedBox(
  //                 height: 10,
  //               ),
  //               Text(
  //                 package,
  //                 style: TextStyle(
  //                     color: Colors.black, fontWeight: FontWeight.w600),
  //               ),
  //               SizedBox(
  //                 height: 10,
  //               ),
  //               Row(
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 children: [
  //                   Icon(Icons.wc_sharp, color: Colors.grey),
  //                   SizedBox(width: 5),
  //                   Text(
  //                     customerGender,
  //                     style: TextStyle(
  //                         color: Colors.black,
  //                         fontSize: 13,
  //                         fontWeight: FontWeight.w500),
  //                   )
  //                 ],
  //               ),
  //               Row(
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 children: [
  //                   Icon(Icons.mail, color: Colors.grey),
  //                   SizedBox(width: 5),
  //                   Text(
  //                     customerMail,
  //                     style: TextStyle(
  //                         color: Colors.black,
  //                         fontSize: 13,
  //                         fontWeight: FontWeight.w500),
  //                   )
  //                 ],
  //               ),
  //               SizedBox(
  //                 height: 15,
  //               ),
  //               Container(
  //                 height: 0.5,
  //                 color: Colors.grey,
  //               ),
  //               SizedBox(
  //                 height: 15,
  //               ),
  //               Row(
  //                 children: [
  //                   Icon(
  //                     Icons.call,
  //                     color: Colors.green,
  //                   ),
  //                   SizedBox(
  //                     width: 10,
  //                   ),
  //                   Text(
  //                     phone,
  //                     style: TextStyle(color: Colors.green),
  //                   ),
  //                   Expanded(
  //                     child: Container(),
  //                   ),
  //                 ],
  //               )
  //             ],
  //           ),
  //         ),
  //       )
  //     ],
  //   );
  // }

}


class ListToDoConsultant extends StatefulWidget {

  const ListToDoConsultant({Key key, this.ConsultantSchedule, this.consultantId, this.value, this.loading, this.selectedDay}) : super(key: key);

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
          if (widget.ConsultantSchedule.data.length == 0) {
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
          } else if (widget.ConsultantSchedule.data.length != 0) {
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
                                widget.ConsultantSchedule.data.length,
                                (index) => widget.ConsultantSchedule
                                            .data[index].isConsultation
                                            .toString() ==
                                        "TRUE"
                                    ? Column(
                                        children: [
                                          dayTask(
                                            startTime: widget.ConsultantSchedule
                                                .data[index].startTime
                                                .toString()
                                                .substring(0, 5),
                                            customerName: widget.ConsultantSchedule
                                                .data[index]
                                                .bookingDetail
                                                .booking
                                                .customer
                                                .user
                                                .fullname,
                                            phone: widget.ConsultantSchedule
                                                .data[index]
                                                .bookingDetail
                                                .booking
                                                .customer
                                                .user
                                                .phone,
                                            package: widget.ConsultantSchedule.data[index]
                                                .bookingDetail.spaPackage.name,
                                            customerGender: widget.ConsultantSchedule
                                                .data[index]
                                                .bookingDetail
                                                .booking
                                                .customer
                                                .user
                                                .gender,
                                            customerMail: widget.ConsultantSchedule
                                                .data[index]
                                                .bookingDetail
                                                .booking
                                                .customer
                                                .user
                                                .email,
                                          ),
                                        ],
                                      )
                                    : SizedBox())
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
    String package,
    String phone,
    customerMail,
    customerGender}) {
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
                package,
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w600),
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
      )
    ],
  );
}
}

