import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spa_and_beauty_staff/Model/BookingDetailSteps.dart';
import 'package:spa_and_beauty_staff/Model/StaffSchedule.dart';
import 'package:spa_and_beauty_staff/Model/Treatment.dart';
import 'package:spa_and_beauty_staff/Service/staff_service.dart';
import 'package:spa_and_beauty_staff/Staff/process_detail/components/edit_process_step.dart';
import 'package:spa_and_beauty_staff/Staff/process_detail/components/process_step_detail.dart';
import 'package:spa_and_beauty_staff/constants.dart';
import 'package:spa_and_beauty_staff/helper/Helper.dart';
import 'package:spa_and_beauty_staff/main.dart';

class StaffProcessDetailBody extends StatefulWidget {
  const StaffProcessDetailBody({Key key, this.bookingDetail, this.customerId})
      : super(key: key);
  final StaffBookingDetailInstance bookingDetail;
  final int customerId;

  @override
  _StaffProcessDetailBodyState createState() => _StaffProcessDetailBodyState();
}

class _StaffProcessDetailBodyState extends State<StaffProcessDetailBody> {
  bool _loading;
  BookingDetailSteps _bookingDetailSteps;

  @override
  void initState() {
    _loading = true;
    StaffService.getBookingDetailStepsByBookingDetailId(widget.bookingDetail.id)
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
                widget.bookingDetail.statusBooking == "FINISH"
                    ? StatusFinishSection()
                    : StatusSection(),
                SizedBox(
                  height: 10,
                ),
                CustomerSection(
                  name: _bookingDetailSteps
                      .data[0].bookingDetail.booking.customer.user.fullname,
                  phone: _bookingDetailSteps
                      .data[0].bookingDetail.booking.customer.user.phone,
                ),
                Divider(
                  thickness: 1,
                  height: 20,
                ),
                ProcessSection(
                  notifyParent: () {
                    setState(() {
                      print("dang reload ne");
                      _loading = true;
                      StaffService.getBookingDetailStepsByBookingDetailId(
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
                  treatment: _bookingDetailSteps.data[1] == null
                      ? "Ch??a c?? li???u tr??nh"
                      : _bookingDetailSteps
                          .data[1].bookingDetail.spaTreatment.name,
                  consultantId: _bookingDetailSteps.data[0].consultant.id,
                  spaId: _bookingDetailSteps.data[0].consultant.spa.id,
                  customerId: widget.customerId,
                )
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
                width: 24,
                height: 24,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Th??ng tin chi ti???t g??i d???ch v???",
                style: TextStyle(fontSize: 22, color: Colors.black),
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
                  "G??i d???ch v???: " + widget.packageName,
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
                        "Li???u tr??nh: " + _treatmentName,
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ...List.generate(
                  widget.bookingDetailSteps.data.length,
                  (index) => ProcessStepSection(
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
                        ? "Ch??a ?????t l???ch"
                        : MyHelper.getUserDate(widget
                                .bookingDetailSteps.data[index].dateBooking) +
                            " L??c " +
                            widget.bookingDetailSteps.data[index].startTime
                                .substring(0, 5),
                    stepName: widget.bookingDetailSteps.data[index]
                                .treatmentService ==
                            null
                        ? "T?? V???n"
                        : widget.bookingDetailSteps.data[index].treatmentService
                            .spaService.name,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ProcessStepSection extends StatefulWidget {
  final Function() notifyParent;
  final String date, stepName, status;
  final int bookingDetailStepId, customerId, spaId, spaServiceId;
  final BookingDetailStepInstance bookingDetailStepInstance;

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
                    : widget.status == "PENDING"
                        ? Colors.black
                        : kYellow,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              widget.status == "FINISH"
                  ? "${widget.stepName} (???? ho??n t???t)"
                  : widget.status == "BOOKING"
                      ? "${widget.stepName} (??ang ch???...)"
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
              Expanded(
                flex: 8,
                child: Row(
                  children: [
                    VerticalDivider(
                      thickness: 1,
                      width: 10,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Ng??y h???n : ${widget.date}"),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.only(right: 10),
                  child: Row(
                    children: [
                      Visibility(
                        visible: widget.status == "BOOKING" &&
                            widget.date != "Ch??a ?????t l???ch" &&
                            widget.bookingDetailStepInstance.staff.id ==
                                MyApp.storage.getItem("staffId"),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditProcessStep(
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
              ),
              Expanded(
                flex: 1,
                child: Visibility(
                  visible: widget.stepName != "T?? V???n",
                  child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProcessStepDetailScreen(
                              bookingDetailStep:
                                  widget.bookingDetailStepInstance,
                            ),
                          ),
                        );
                      },
                      child: Icon(
                        Icons.more_vert,
                        color: kTextColor,
                        size: 28,
                      )),
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
                    "Th??ng tin kh??ch h??ng",
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
      ],
    );
  }
}

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
                      "Li???u tr??nh v???n ??ang ???????c ti???p t???c !",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    Text(
                      "Theo d??i li???u tr??nh th?????ng xuy??n ????? kh??ng b??? l??? h???n v???i spa c???a b???n",
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
                      "Li???u tr??nh ???? ho??n t???t !",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    Text(
                      "Li???u tr??nh ???? ho??n t???t, b???n c?? th??? xem l???i th??ng tin",
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
