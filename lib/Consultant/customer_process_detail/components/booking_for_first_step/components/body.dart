import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:spa_and_beauty_staff/Consultant/customer_process_detail/components/booking_for_first_step/components/time_slot.dart';
import 'package:spa_and_beauty_staff/Model/AvailableTime.dart';
import 'package:spa_and_beauty_staff/Model/ListStaffForBooking.dart';
import 'package:spa_and_beauty_staff/Service/consultant_service.dart';
import 'package:spa_and_beauty_staff/constants.dart';
import 'package:spa_and_beauty_staff/default_button.dart';
import 'package:spa_and_beauty_staff/helper/Helper.dart';
import 'package:spa_and_beauty_staff/wrap_toggle_button.dart';

class FirstStepBookingBody extends StatefulWidget {
  final int consultantId;
  final int customerId;
  final int spaId;
  final int spaTreatmentId;
  final int bookingDetailId;
  final StaffInstance choosenStaff;
  @override
  _FirstStepBookingBodyState createState() => _FirstStepBookingBodyState();



  const FirstStepBookingBody({Key key, this.consultantId, this.customerId, this.spaId, this.spaTreatmentId, this.bookingDetailId, this.choosenStaff})
      : super(key: key);
}

class _FirstStepBookingBodyState extends State<FirstStepBookingBody> {
  int slotId;
  String requestDate;

  AvailableTime _availableTime;
  bool _loading;
  bool _loadingSlot = false;

  // TODO: implement initState
  int idButton;

  @override
  void initState() {
    super.initState();
    _loading = true;

    requestDate = MyHelper.getMachineDate(DateTime.now());
    if(widget.choosenStaff == null) {
      ConsultantService.getAvailableTimeForFirstStep(
          widget.consultantId, widget.customerId, requestDate, widget.spaId,
          widget.spaTreatmentId)
          .then((availableTime) =>
      {
        setState(() {
          _availableTime = availableTime;
          _loading = false;
          if (_availableTime.data != null) {
            isSelected =
                List.generate(_availableTime.data.length, (index) => false);
          }
        })
      });
    }else{
      ConsultantService.getAvailableTimeForFirstStepWithStaff(
          widget.consultantId, widget.customerId, requestDate, widget.spaId,
          widget.spaTreatmentId, widget.choosenStaff.id)
          .then((availableTime) =>
      {
        setState(() {
          _availableTime = availableTime;
          _loading = false;
          if (_availableTime.data != null) {
            isSelected =
                List.generate(_availableTime.data.length, (index) => false);
          }
        })
      });
    }
  }

  List<bool> _selections = [true, false, false, false, false, false, false];
  List<bool> isSelected;

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Container(
      child: SpinKitWave(
        color: kPrimaryColor,
        size: 50,
      ),
    )
        : SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding:
          const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Nhân viên đã chọn",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              widget.choosenStaff == null
                  ?Text("Để quản lý chọn nhân viên.")
                  :Container(
                margin:  EdgeInsets.symmetric(vertical: 10),
                padding:
                EdgeInsets.symmetric(vertical: 10,),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            widget.choosenStaff.user.image),
                        maxRadius: 30,
                      ),
                    ),
                    Expanded(
                        flex: 8,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            widget.choosenStaff.user.fullname,
                            style: TextStyle(fontSize: 17),
                          ),
                        )),

                  ],
                ),
              ),
              Text(
                "1.Chọn ngày",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ToggleButtons(
                  children: [
                    DateBox(
                      date: DateTime.now().add(Duration(days: 0)),
                    ),
                    DateBox(
                      date: DateTime.now().add(Duration(days: 1)),
                    ),
                    DateBox(
                      date: DateTime.now().add(Duration(days: 2)),
                    ),
                    DateBox(
                      date: DateTime.now().add(Duration(days: 3)),
                    ),
                    DateBox(
                      date: DateTime.now().add(Duration(days: 4)),
                    ),
                    DateBox(
                      date: DateTime.now().add(Duration(days: 5)),
                    ),
                    DateBox(
                      date: DateTime.now().add(Duration(days: 6)),
                    ),
                  ],
                  isSelected: _selections,
                  onPressed: (int index) {
                    setState(() {
                      _loadingSlot = true;
                      for (int i = 0; i < _selections.length; i++) {
                        _selections[i] = (i == index);
                      }
                      String selectedDay = MyHelper.getMachineDate(
                          DateTime.now().add(Duration(days: index)));
                      requestDate = selectedDay;
                      if(widget.choosenStaff == null) {
                        ConsultantService.getAvailableTimeForFirstStep(
                            widget.consultantId, widget.customerId,
                            requestDate, widget.spaId, widget.spaTreatmentId)
                            .then((availableTime) =>
                        {
                          setState(() {
                            _availableTime = availableTime;
                            if (_availableTime.data != null) {
                              isSelected = List.generate(
                                  _availableTime.data.length, (
                                  index) => false);
                            }
                            _loadingSlot = false;
                          })
                        });
                      }else{
                        ConsultantService.getAvailableTimeForFirstStepWithStaff(widget.consultantId, widget.customerId, requestDate, widget.spaId, widget.spaTreatmentId, widget.choosenStaff.id)
                            .then((availableTime) => {
                          setState(() {
                            _availableTime = availableTime;
                            if(_availableTime.data!=null) {
                              isSelected = List.generate(
                                  _availableTime.data.length, (index) => false);
                            }
                            _loadingSlot = false;
                          })
                        });
                      }
                    });
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "2.Chọn giờ",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TimeBookingDescriptionBar(),
              SizedBox(
                height: 20,
              ),
              _availableTime.data != null ?
              Container(
                child: _loadingSlot
                    ? Container(
                  height: 200,
                  width: double.infinity,
                  child:
                  SpinKitWave(
                    color: kPrimaryColor,
                    size: 50,
                  ),
                )
                    : WrapToggleIconButtons(
                  iconList: List.generate(
                      _availableTime.data.length,
                          (index) => TimeSlot()),
                  isSelected: isSelected,
                  availableTime: _availableTime,
                  isDisabled: List.generate(
                      _availableTime.data.length,
                          (index) => false),
                  // isDisabled: [false,false,false,false,false,false,false,false,false,false,],
                  onPressed: (int index) {
                    setState(() {
                      if (isSelected.isEmpty) {
                        isSelected = List.generate(
                            _availableTime.data.length,
                                (index) => false);
                      } else {
                        for (var i = 0;
                        i < isSelected.length;
                        i++) isSelected.remove(i);
                        isSelected = List.generate(
                            _availableTime.data.length,
                                (index) => false);
                      }
                      for (int buttonIndex = 0;
                      buttonIndex < isSelected.length;
                      buttonIndex++) {
                        if (buttonIndex == index) {
                          isSelected[buttonIndex] =
                          !isSelected[buttonIndex];
                        } else {
                          isSelected[buttonIndex] = false;
                        }
                      }
                      print("$index is selected");
                      slotId = index;
                      print(slotId.toString() + " is selected");
                    });
                  },
                ),
              )
              :Text("Không có nhân viên rảnh")
              ,
              SizedBox(
                height: 40,
              ),
               widget.choosenStaff == null
                   ?DefaultButton(
                  text: "Đặt lịch",
                  press: () {
                    showDialog(
                      context: context,
                      builder: (builder) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 80),
                          child: Dialog(
                            child: Container(
                              height: 150,
                              child: Lottie.asset(
                                  "assets/lottie/circle_loading.json"),
                            ),
                          ),
                        );
                      },
                    );

                    ConsultantService.bookingForFirstStep(widget.bookingDetailId, widget.consultantId, requestDate, widget.spaTreatmentId, _availableTime.data[slotId], null)
                        .then((value) {
                      Navigator.pop(context);
                      value.code == 200
                          ? showDialog(
                        context: context,
                        builder: (context) {
                          return MyCustomDialog(
                            height: 250,
                            press: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            title: "Thành Công !",
                            description:
                            "Đặt lịch thành công",
                            buttonTitle: "Quay về",
                            lottie:
                            "assets/lottie/success.json",
                          );
                        },
                      )
                          : showDialog(
                        context: context,
                        builder: (context) {
                          return MyCustomDialog(
                            height: 250,
                            press: () {
                              Navigator.pop(context);
                            },
                            title: "Thất bại !",
                            description:value.data,
                            buttonTitle: "Thoát",
                            lottie: "assets/lottie/fail.json",
                          );
                        },
                      );
                    });
                  })
                   :DefaultButton(
                   text: "Đặt Lịch",
                   press: () {
                     showDialog(
                       context: context,
                       builder: (builder) {
                         return Padding(
                           padding: const EdgeInsets.symmetric(
                               horizontal: 80),
                           child: Dialog(
                             child: Container(
                               height: 150,
                               child: Lottie.asset(
                                   "assets/lottie/circle_loading.json"),
                             ),
                           ),
                         );
                       },
                     );

                     ConsultantService.bookingForFirstStep(widget.bookingDetailId, widget.consultantId, requestDate, widget.spaTreatmentId, _availableTime.data[slotId], widget.choosenStaff.id)
                         .then((value) {
                       Navigator.pop(context);
                       value.code == 200
                           ? showDialog(
                         context: context,
                         builder: (context) {
                           return MyCustomDialog(
                             height: 250,
                             press: () {
                               Navigator.pop(context);
                               Navigator.pop(context);
                               Navigator.pop(context);
                             },
                             title: "Thành Công !",
                             description:
                             "Đặt lịch thành công",
                             buttonTitle: "Quay về",
                             lottie:
                             "assets/lottie/success.json",
                           );
                         },
                       )
                           : showDialog(
                         context: context,
                         builder: (context) {
                           return MyCustomDialog(
                             height: 250,
                             press: () {
                               Navigator.pop(context);
                             },
                             title: "Thất bại !",
                             description:value.data,
                             buttonTitle: "Thoát",
                             lottie: "assets/lottie/fail.json",
                           );
                         },
                       );
                     });
                   }),


            ],
          ),
        ),
      ),
    );
  }
}



class MyCustomDialog extends StatelessWidget {
  const MyCustomDialog({
    Key key,
    @required this.title,
    @required this.description,
    @required this.buttonTitle,
    @required this.lottie,
    @required this.press,
    @required this.height,
  }) : super(key: key);

  final String title, description, buttonTitle, lottie;
  final double height;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        height: height,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Container(
                child: Lottie.asset(
                  lottie,
                  repeat: false,
                ),
                width: 100,
                height: 100,
              ),
              Text(
                title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                description,
                textAlign: TextAlign.center,
              ),
              TextButton(
                  onPressed: press,
                  child: Text(
                    buttonTitle,
                    style: TextStyle(fontSize: 20),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class DateBox extends StatefulWidget {
  const DateBox({
    Key key,
    @required this.date,
  }) : super(key: key);
  final DateTime date;

  @override
  _DateBoxState createState() => _DateBoxState();
}

class _DateBoxState extends State<DateBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 5),
      height: 60,
      width: 80,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.black)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(widget.date.month.toString()),
              Text(
                MyHelper.dayOfWeekToText(widget.date.weekday),
              ),
            ],
          ),
          Text(
            widget.date.day.toString(),
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class TimeBookingDescriptionBar extends StatelessWidget {
  const TimeBookingDescriptionBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Container(
                width: 50,
                height: 25,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.black),
                )),
            SizedBox(
              height: 5,
            ),
            Text(
              "Còn trống",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
        Column(
          children: [
            Container(
                width: 50,
                height: 25,
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(5),
                )),
            SizedBox(
              height: 5,
            ),
            Text(
              "Đang chọn",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
