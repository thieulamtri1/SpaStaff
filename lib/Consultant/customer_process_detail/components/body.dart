import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spa_and_beauty_staff/Consultant/customer_process_detail/components/booking_for_first_step/components/body.dart';
import 'package:spa_and_beauty_staff/Consultant/customer_process_detail/components/booking_for_next_step/booking_for_next_step.dart';
import 'package:spa_and_beauty_staff/Consultant/customer_process_detail/components/choose_staff.dart';
import 'package:spa_and_beauty_staff/Consultant/customer_process_detail/components/choose_treatment.dart';
import 'package:spa_and_beauty_staff/Consultant/customer_process_detail/components/edit_consultation_content.dart';
import 'package:spa_and_beauty_staff/Model/BookingDetail.dart';
import 'package:spa_and_beauty_staff/Model/BookingDetailSteps.dart';
import 'package:spa_and_beauty_staff/Model/Treatment.dart';
import 'package:spa_and_beauty_staff/Service/consultant_service.dart';
import 'package:spa_and_beauty_staff/constants.dart';
import 'package:spa_and_beauty_staff/helper/Helper.dart';
import 'package:spa_and_beauty_staff/size_config.dart';

class Body extends StatefulWidget {
  const Body({Key key, this.bookingDetail, this.customerId}) : super(key: key);
  final BookingDetailInstance bookingDetail;
  final customerId;

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool _loading;
  BookingDetailSteps _bookingDetailSteps;
  final reasonController = TextEditingController();

  @override
  void initState() {
    _loading = true;
    ConsultantService.getBookingDetailStepsByBookingDetailId(
            widget.bookingDetail.id)
        .then((value) => {
              setState(() {
                _bookingDetailSteps = value;
                _loading = false;
              })
            });
    // TODO: implement initState
    super.initState();
  }

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.bookingDetail.statusBooking == "CHANGE_STAFF"
                    ? StatusChangingStaffSection()
                    : widget.bookingDetail.statusBooking == "FINISH"
                        ? StatusFinishSection()
                        : StatusSection(),
                SizedBox(
                  height: 10,
                ),
                CustomerSection(
                    name: widget.bookingDetail.booking.customer.user.fullname,
                    phone: widget.bookingDetail.booking.customer.user.phone),
                Visibility(
                  visible: widget.bookingDetail.statusBooking == "BOOKING",
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: TextButton(
                      child: Text("Gửi yêu cầu đổi nhân viên"),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (builder) {
                            return Dialog(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                height: 180,
                                child: Column(
                                  children: [
                                    Text(
                                      "Yêu cầu đổi nhân viên",
                                      style: TextStyle(
                                          color: kPrimaryColor, fontSize: 17),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      controller: reasonController,
                                      minLines: 2,
                                      maxLines: 2,
                                      keyboardType: TextInputType.multiline,
                                      decoration: InputDecoration(
                                          hintText: "Lý do",
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: kPrimaryColor),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: kPrimaryColor),
                                          )),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        TextButton(
                                          child: Text("Gửi"),
                                          onPressed: () {
                                            int i = 0;
                                            while (i <
                                                _bookingDetailSteps
                                                    .data.length) {
                                              if (_bookingDetailSteps
                                                      .data[i].dateBooking ==
                                                  null) {
                                                ConsultantService
                                                        .requestChangeStaff(
                                                            _bookingDetailSteps
                                                                .data[i].id,
                                                            reasonController
                                                                .text)
                                                    .then((value) => {
                                                          if (value.code == 200)
                                                            {
                                                              showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return MyCustomDialog(
                                                                    height: 250,
                                                                    press: () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    title:
                                                                        "Thành Công !",
                                                                    description:
                                                                        "Gửi yêu cầu đổi nhân viên thành công",
                                                                    buttonTitle:
                                                                        "thoát",
                                                                    lottie:
                                                                        "assets/lottie/success.json",
                                                                  );
                                                                },
                                                              ),
                                                            }
                                                          else
                                                            {
                                                              showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return MyCustomDialog(
                                                                    height: 250,
                                                                    press: () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    title:
                                                                        "Thất bại !",
                                                                    description:
                                                                        value
                                                                            .data,
                                                                    buttonTitle:
                                                                        "Thoát",
                                                                    lottie:
                                                                        "assets/lottie/fail.json",
                                                                  );
                                                                },
                                                              )
                                                            }
                                                        });
                                                Navigator.pop(context);
                                                setState(() {
                                                  print("dang reload ne");
                                                  _loading = true;
                                                  ConsultantService
                                                          .getBookingDetailStepsByBookingDetailId(
                                                              widget
                                                                  .bookingDetail
                                                                  .id)
                                                      .then((value) => {
                                                            setState(() {
                                                              _bookingDetailSteps =
                                                                  value;
                                                              _loading = false;
                                                            })
                                                          });
                                                });
                                                print(
                                                    "id : ${_bookingDetailSteps.data[i].id}");
                                                break;
                                              } else {
                                                i++;
                                              }
                                            }
                                          },
                                        ),
                                        TextButton(
                                          child: Text("Hủy"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
                Divider(
                  thickness: 1,
                  height: 20,
                ),
                ProcessSection(
                  statusBooking: widget.bookingDetail.statusBooking,
                  notifyParent: () {
                    setState(() {
                      print("dang reload ne");
                      _loading = true;
                      ConsultantService.getBookingDetailStepsByBookingDetailId(
                              widget.bookingDetail.id)
                          .then((value) => {
                                setState(() {
                                  _bookingDetailSteps = value;
                                  _loading = false;
                                })
                              });
                    });
                  },
                  packageName: widget.bookingDetail.spaPackage.name,
                  packageId: widget.bookingDetail.spaPackage.id,
                  bookingDetailSteps: _bookingDetailSteps,
                  treatment: _bookingDetailSteps.data.length == 1
                      ? "Chưa có liệu trình"
                      : _bookingDetailSteps.data[1] == null
                          ? "Chưa có liệu trình"
                          : _bookingDetailSteps
                              .data[1].bookingDetail.spaTreatment.name,
                  consultantId: _bookingDetailSteps.data[0].consultant.id,
                  spaId: _bookingDetailSteps.data[0].consultant.spa.id,
                  customerId: widget.customerId,
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          );
  }
}

class ProcessSection extends StatefulWidget {
  final Function() notifyParent;
  final int consultantId;
  final int spaId;
  final int customerId;
  final String packageName;
  final String treatment;
  final int packageId;
  final BookingDetailSteps bookingDetailSteps;
  final String statusBooking;

  const ProcessSection({
    Key key,
    @required this.packageName,
    @required this.packageId,
    @required this.bookingDetailSteps,
    @required this.treatment,
    @required this.consultantId,
    this.spaId,
    this.customerId,
    this.notifyParent,
    this.statusBooking,
  }) : super(key: key);

  @override
  _ProcessSectionState createState() => _ProcessSectionState();
}

class _ProcessSectionState extends State<ProcessSection> {
  String _treatmentName;

  TreatmentInstance _treatmentInstance;

  @override
  Widget build(BuildContext context) {
    if (_treatmentName == null) {
      _treatmentName = widget.treatment;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: SvgPicture.asset("assets/icons/process.svg"),
                width: 18,
                height: 18,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Thông tin chi tiết dịch vụ",
                style: TextStyle(fontSize: 15, color: Colors.black),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Dịch Vụ: " + widget.packageName,
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Liệu trình: " + _treatmentName,
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                      widget.treatment == "Chưa có liệu trình"
                          ? GestureDetector(
                              onTap: () async {
                                TreatmentInstance choosenTreatment =
                                    await showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext buildContext) {
                                          return Container(
                                            height: SizeConfig
                                                .getProportionateScreenHeight(
                                                    800),
                                            child: ListView(
                                              children: [
                                                IconButton(
                                                  alignment: Alignment.topRight,
                                                  icon: Icon(
                                                    Icons.close,
                                                    color: kPrimaryColor,
                                                    size: 25,
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                ChooseTreatmentScreen(
                                                  packageId: widget.packageId,
                                                )
                                              ],
                                            ),
                                          );
                                        });
                                print("treatment đã chọn: " +
                                    choosenTreatment.id.toString() +
                                    choosenTreatment.name);
                                setState(() {
                                  _treatmentName = choosenTreatment.name;
                                  print(_treatmentName);
                                  _treatmentInstance = choosenTreatment;
                                });
                              },
                              child: Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                    color: kGreen,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Center(
                                  child: Text(
                                    "+",
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.white),
                                  ),
                                ),
                              ),
                            )
                          : SizedBox()
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ...List.generate(
                  widget.bookingDetailSteps.data.length,
                  (index) => ProcessStepSection(
                    visibleBookingButton: index > 0
                        ? widget.bookingDetailSteps.data[index - 1]
                                    .statusBooking ==
                                "FINISH" &&
                            widget.statusBooking != "CHANGE_STAFF"
                        : false,
                    staffName:
                        widget.bookingDetailSteps.data[index].staff == null
                            ? null
                            : widget.bookingDetailSteps.data[index].staff.user
                                .fullname,
                    bookingDetailStepInstance:
                        widget.bookingDetailSteps.data[index],
                    notifyParent: widget.notifyParent,
                    spaId: widget.spaId,
                    customerId: widget.customerId,
                    bookingDetailStepId:
                        widget.bookingDetailSteps.data[index].id,
                    spaServiceId: widget.bookingDetailSteps.data[index]
                                .treatmentService ==
                            null
                        ? 0
                        : widget.bookingDetailSteps.data[index].treatmentService
                            .spaService.id,
                    status: widget.bookingDetailSteps.data[index].statusBooking,
                    date: widget.bookingDetailSteps.data[index].dateBooking ==
                            null
                        ? "Chưa đặt lịch"
                        : MyHelper.getUserDate(widget
                                .bookingDetailSteps.data[index].dateBooking) +
                            " Lúc " +
                            widget.bookingDetailSteps.data[index].startTime
                                .substring(0, 5),
                    stepName: widget.bookingDetailSteps.data[index]
                                .treatmentService ==
                            null
                        ? "Tư Vấn"
                        : widget.bookingDetailSteps.data[index].treatmentService
                            .spaService.name,
                  ),
                ),
                _treatmentInstance != null
                    ? ProcessStepSectionForConsultant(
                        notifyParent: widget.notifyParent,
                        treatmentInstance: _treatmentInstance,
                        consultantId: widget.consultantId,
                        spaId: widget.spaId,
                        customerId: widget.customerId,
                        bookingDetailId:
                            widget.bookingDetailSteps.data[0].bookingDetail.id,
                      )
                    : SizedBox()
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ProcessStepSectionForConsultant extends StatefulWidget {
  final int consultantId;
  final int customerId;
  final int spaId;
  final int bookingDetailId;
  final TreatmentInstance treatmentInstance;
  final Function() notifyParent;

  const ProcessStepSectionForConsultant(
      {Key key,
      this.treatmentInstance,
      this.consultantId,
      this.customerId,
      this.spaId,
      this.bookingDetailId,
      this.notifyParent})
      : super(key: key);

  @override
  _ProcessStepSectionForConsultantState createState() =>
      _ProcessStepSectionForConsultantState();
}

class _ProcessStepSectionForConsultantState
    extends State<ProcessStepSectionForConsultant> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...List.generate(
            widget.treatmentInstance.treatmentservices.length,
            (index) => Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  padding:
                      EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 20),
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[400],
                        blurRadius: 4,
                        offset: Offset(4, 4), // Shadow position
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "bước ${index + 1}: " +
                                  widget.treatmentInstance
                                      .treatmentservices[index].spaService.name,
                              style: TextStyle(fontSize: 18),
                            ),
                            Expanded(
                              child: Text(widget
                                  .treatmentInstance
                                  .treatmentservices[index]
                                  .spaService
                                  .description),
                            )
                          ],
                        ),
                      ),
                      index == 0
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChooseStaffScreen(
                                            consultantId: widget.consultantId,
                                            customerId: widget.customerId,
                                            spaId: widget.spaId,
                                            spaTreatmentId:
                                                widget.treatmentInstance.id,
                                            bookingDetailId:
                                                widget.bookingDetailId,
                                          )),
                                ).then(
                                    (value) => setState(widget.notifyParent));
                              },
                              child: Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                    color: kGreen,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Center(
                                  child: Icon(
                                    Icons.schedule_outlined,
                                    color: Colors.white,
                                    size: 17.0,
                                  ),
                                ),
                              ),
                            )
                          : SizedBox(),
                    ],
                  ),
                ))
      ],
    );
  }
}

class ProcessStepSection extends StatefulWidget {
  final Function() notifyParent;
  final String date, stepName, status, staffName;
  final int bookingDetailStepId, customerId, spaId, spaServiceId;
  final BookingDetailStepInstance bookingDetailStepInstance;
  final bool visibleBookingButton;

  const ProcessStepSection({
    Key key,
    this.date,
    this.stepName,
    this.status,
    this.bookingDetailStepId,
    this.customerId,
    this.spaId,
    this.spaServiceId,
    this.notifyParent,
    this.bookingDetailStepInstance,
    this.staffName,
    this.visibleBookingButton,
  }) : super(key: key);

  @override
  _ProcessStepSectionState createState() => _ProcessStepSectionState();
}

class _ProcessStepSectionState extends State<ProcessStepSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: widget.status == "FINISH"
                    ? kGreen
                    : widget.status == "BOOKING"
                        ? kYellow
                        : Colors.black,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              widget.status == "FINISH"
                  ? "${widget.stepName} (Đã hoàn tất)"
                  : widget.status == "BOOKING"
                      ? "${widget.stepName} (Đang chờ...)"
                      : widget.stepName,
              style: TextStyle(
                  color: widget.status == "FINISH"
                      ? kGreen
                      : widget.status == "BOOKING"
                          ? kYellow
                          : Colors.black,
                  fontSize: 17),
            ),
          ],
        ),
        Container(
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  VerticalDivider(
                    thickness: 1,
                    width: 10,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Ngày hẹn : ${widget.date}"),
                ],
              ),
              Container(
                padding: EdgeInsets.only(right: 10),
                child: Row(
                  children: [
                    Visibility(
                      visible: widget.staffName != null &&
                          widget.visibleBookingButton &&
                          widget.status != "FINISH",
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BookingForNextStepScreen(
                                      spaServiceId: widget.spaServiceId,
                                      bookingDetailStepId:
                                          widget.bookingDetailStepId,
                                      customerId: widget.customerId,
                                      spaId: widget.spaId,
                                    )),
                          ).then((value) => setState(widget.notifyParent));
                        },
                        child: Icon(
                          Icons.schedule_outlined,
                          color: kGreen,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Visibility(
                      visible: widget.stepName != "Tư Vấn",
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditConsultantContent(
                                      bookingDetailStepInstance:
                                          widget.bookingDetailStepInstance,
                                    )),
                          ).then((value) => setState(widget.notifyParent));
                        },
                        child: Icon(
                          Icons.edit,
                          color: kGreen,
                        ),
                      ),
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

class CustomerSection extends StatelessWidget {
  final String name, phone;

  const CustomerSection({
    Key key,
    @required this.name,
    @required this.phone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person_outline,
                    color: Colors.black,
                    size: 20,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Thông tin khách hàng",
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("$name - $phone"),
                  ],
                ),
              )
            ],
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.only(right: 20),
        //   child: Icon(
        //     Icons.chat,
        //     color: kPrimaryColor,
        //   ),
        // ),
      ],
    );
  }
}

// class CompanySection extends StatelessWidget {
//   final String name, address;
//
//   const CompanySection({
//     Key key,
//     @required this.name,
//     @required this.address,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 10),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Container(
//                 child: SvgPicture.asset("assets/icons/company.svg"),
//                 width: 18,
//                 height: 18,
//               ),
//               SizedBox(
//                 width: 5,
//               ),
//               Text(
//                 "Thông tin Spa",
//                 style: TextStyle(fontSize: 15, color: Colors.black),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 5,
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 24),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(name),
//                 Text(address),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

class StatusSection extends StatelessWidget {
  const StatusSection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(color: kBlue),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Container(
                height: 60,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Liệu trình vẫn đang được tiếp tục !",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    Text(
                      "Theo dõi liệu trình thường xuyên để không bị lỡ hẹn với khách hàng",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 15),
              child: Container(
                width: 50,
                height: 50,
                child: SvgPicture.asset("assets/icons/ongoing.svg"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StatusChangingStaffSection extends StatelessWidget {
  const StatusChangingStaffSection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(color: Colors.red),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Container(
                height: 60,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Liệu trình đang bị gián đoạn !",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    Text(
                      "Liệu trình đang được chờ để xét duyệt đổi nhân viên",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 15),
              child: Container(
                width: 50,
                height: 50,
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 50,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StatusFinishSection extends StatelessWidget {
  const StatusFinishSection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(color: kGreen),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Container(
                height: 60,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Liệu trình đã hoàn tất !",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    Text(
                      "Liệu trình đã hoàn tất, bạn có thể xem lại thông tin",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 15),
              child: Container(
                width: 50,
                height: 50,
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 50,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
