import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:spa_and_beauty_staff/Model/BookingDetailSteps.dart';
import 'package:spa_and_beauty_staff/Service/consultant_service.dart';
import 'package:spa_and_beauty_staff/Staff/customer_process_detail/components/booking_for_first_step/components/body.dart';
import 'package:spa_and_beauty_staff/constants.dart';
import 'package:spa_and_beauty_staff/default_button.dart';
import 'package:spa_and_beauty_staff/helper/Helper.dart';

class EditConsultantContent extends StatefulWidget {
  final BookingDetailStepInstance bookingDetailStepInstance;

  const EditConsultantContent({Key key, this.bookingDetailStepInstance})
      : super(key: key);

  @override
  _EditConsultantContentState createState() => _EditConsultantContentState();
}

class _EditConsultantContentState extends State<EditConsultantContent> {
  TextEditingController _descriptionControler;

  TextEditingController _expectationControler;
  TextEditingController _noteControler;

  @override
  void initState() {
    setState(() {
      _descriptionControler = TextEditingController(
          text: widget.bookingDetailStepInstance.consultationContent != null
              ? widget.bookingDetailStepInstance.consultationContent.description
              : "");
      _expectationControler = TextEditingController(
          text: widget.bookingDetailStepInstance.consultationContent != null
              ? widget.bookingDetailStepInstance.consultationContent.expectation
              : "");
      _noteControler = TextEditingController(
          text: widget.bookingDetailStepInstance.consultationContent != null
              ? widget.bookingDetailStepInstance.consultationContent.note
              : "");
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cập nhật thông tin"),
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Tên bước: ",
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                        widget.bookingDetailStepInstance.treatmentService
                            .spaService.name,
                        style: TextStyle(fontSize: 20))
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Ngày đặt lịch: ", style: TextStyle(fontSize: 20)),
                    Text(
                        MyHelper.getUserDate(
                            widget.bookingDetailStepInstance.dateBooking),
                        style: TextStyle(fontSize: 20))
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Thời gian: ", style: TextStyle(fontSize: 20)),
                    Text(widget.bookingDetailStepInstance.startTime.toString(),
                        style: TextStyle(fontSize: 20))
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Chuyên viên: ", style: TextStyle(fontSize: 20)),
                    Text(widget.bookingDetailStepInstance.staff.user.fullname,
                        style: TextStyle(fontSize: 20))
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  "Mô tả: ",
                  style: TextStyle(fontSize: 20, color: kBlue),
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: _descriptionControler,
                  minLines: 3,
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                      hintText: "Mô tả",
                      hintStyle: TextStyle(color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: kBlue),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: kPrimaryColor),
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Kết quả dự kiến: ",
                  style: TextStyle(fontSize: 20, color: kGreen),
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: _expectationControler,
                  minLines: 3,
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                      hintText: "Kết quả dự kiến",
                      hintStyle: TextStyle(color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: kGreen),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: kPrimaryColor),
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Ghi chú: ",
                  style: TextStyle(fontSize: 20, color: kYellow),
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: _noteControler,
                  minLines: 3,
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                      hintText: "Ghi chú",
                      hintStyle: TextStyle(color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: kYellow),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: kPrimaryColor),
                      )),
                ),
                SizedBox(
                  height: 40,
                ),
                DefaultButton(
                  text: "Cập nhật",
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

                    ConsultantService.editConsultationContent(
                        widget.bookingDetailStepInstance.consultationContent
                            .id,
                        _descriptionControler.text,
                        _expectationControler.text,
                        _noteControler.text)
                        .then((value) {
                      Navigator.pop(context);
                      value.compareTo("200") == 0
                          ? showDialog(
                        context: context,
                        builder: (context) {
                          return MyCustomDialog(
                            height: 250,
                            press: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            title: "Thành Công !",
                            description:
                            "Cập nhật thông tin thành công",
                            buttonTitle: "Thoát",
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
                              Navigator.pop(context);
                            },
                            title: "Thất bại !",
                            description:
                            "Cập nhật thông tin thất bại.",
                            buttonTitle: "Thoát",
                            lottie: "assets/lottie/fail.json",
                          );
                        },
                      );
                    });
                  },
                )
              ],
            )),
      ),
    );
  }
}
