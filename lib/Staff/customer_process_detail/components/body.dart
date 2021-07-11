import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spa_and_beauty_staff/Model/BookingDetail.dart';
import 'package:spa_and_beauty_staff/Model/BookingDetailSteps.dart';
import 'package:spa_and_beauty_staff/Service/consultant_service.dart';
import 'package:spa_and_beauty_staff/constants.dart';
import 'package:spa_and_beauty_staff/helper/Helper.dart';

class Body extends StatefulWidget {
  const Body({Key key, this.bookingDetail}) : super(key: key);
  final BookingDetailInstance bookingDetail;

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool _loading;
  BookingDetailSteps _bookingDetailSteps;

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StatusSection(),
        SizedBox(
          height: 10,
        ),
        CompanySection(
          address: widget.bookingDetail.spaPackage.spa.street +
              " " +
              widget.bookingDetail.spaPackage.spa.district +
              " " +
              widget.bookingDetail.spaPackage.spa.city,
          name: widget.bookingDetail.spaPackage.spa.name,
        ),
        Divider(
          thickness: 1,
          height: 20,
        ),
        StaffSection(
          name: _bookingDetailSteps.data[0].consultant.user.fullname == null
              ? "Chưa có tư vấn viên"
              : _bookingDetailSteps.data[0].consultant.user.fullname,
          phone: _bookingDetailSteps.data[0].consultant.user.fullname == null
              ? "Chưa có tư vấn viên"
              : _bookingDetailSteps.data[0].consultant.user.phone,
        ),
        Divider(
          thickness: 1,
          height: 20,
        ),
        ProcessSection(
          serviceName: widget.bookingDetail.spaPackage.name,
          serviceId: widget.bookingDetail.spaPackage.id,
          bookingDetailSteps: _bookingDetailSteps,
        )
      ],
    );
  }
}

class ProcessSection extends StatefulWidget {
  final String serviceName;
  final int serviceId;
  final BookingDetailSteps bookingDetailSteps;

  const ProcessSection({
    Key key,
    @required this.serviceName,
    @required this.serviceId,
    @required this.bookingDetailSteps,
  }) : super(key: key);

  @override
  _ProcessSectionState createState() => _ProcessSectionState();
}

class _ProcessSectionState extends State<ProcessSection> {

  @override
  Widget build(BuildContext context) {
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
                "Thông tin chi tiết liệu trình",
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
                  "Dịch Vụ: " + widget.serviceName,
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
                SizedBox(
                  height: 10,
                ),
                ...List.generate(
                  widget.bookingDetailSteps.data.length,
                  (index) => ProcessStepSection(
                    status: widget.bookingDetailSteps.data[index].statusBooking,
                    date: widget.bookingDetailSteps.data[index]
                                .dateBooking ==
                            null
                        ? "Chưa đặt lịch"
                        : MyHelper.getUserDate(widget.bookingDetailSteps.data[index].dateBooking) +
                            " Lúc " +
                        widget.bookingDetailSteps.data[index]
                                .startTime
                                .substring(0, 5),
                    stepName: widget.bookingDetailSteps.data[index]
                                .treatmentService ==
                            null
                        ? "Tư Vấn"
                        : widget.bookingDetailSteps.data[index]
                            .treatmentService.spaService.name,
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

class ProcessStepSection extends StatelessWidget {
  final String date, stepName, status;

  const ProcessStepSection({
    Key key,
    this.date,
    this.stepName,
    this.status,
  }) : super(key: key);

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
                color: status == "FINISH"
                    ? kGreen
                    : status == "PENDING"
                        ? Colors.black
                        : kYellow,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              status == "FINISH"
                  ? "$stepName (Đã hoàn tất)"
                  : status == "PENDING"
                      ? stepName
                      : "$stepName (Đang chờ...)",
              style: TextStyle(
                  color: status == "FINISH"
                      ? kGreen
                      : status == "PENDING"
                          ? Colors.black
                          : kYellow,
                  fontSize: 17),
            ),
          ],
        ),
        Container(
          height: 40,
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
              Text("Ngày hẹn : $date"),
            ],
          ),
        ),
      ],
    );
  }
}

class StaffSection extends StatelessWidget {
  final String name, phone;

  const StaffSection({
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
                    "Thông tin nhân viên",
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
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Icon(
            Icons.chat,
            color: kPrimaryColor,
          ),
        ),
      ],
    );
  }
}

class CompanySection extends StatelessWidget {
  final String name, address;

  const CompanySection({
    Key key,
    @required this.name,
    @required this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: SvgPicture.asset("assets/icons/company.svg"),
                width: 18,
                height: 18,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Thông tin Spa",
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
                Text(name),
                Text(address),
              ],
            ),
          )
        ],
      ),
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
                      "Liệu trình vẫn đang được tiếp tục !",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    Text(
                      "Theo dõi liệu trình thường xuyên để không bị lỡ hẹn với spa của bạn",
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
