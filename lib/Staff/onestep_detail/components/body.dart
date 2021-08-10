import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:spa_and_beauty_staff/Model/BookingDetailSteps.dart';
import 'package:spa_and_beauty_staff/Model/StaffSchedule.dart';
import 'package:spa_and_beauty_staff/Service/staff_service.dart';
import 'package:spa_and_beauty_staff/constants.dart';
import 'package:spa_and_beauty_staff/default_button.dart';

class OneStepDetailBody extends StatefulWidget {
  const OneStepDetailBody({Key key, this.bookingDetail}) : super(key: key);
  final StaffBookingDetailInstance bookingDetail;

  @override
  _OneStepDetailBodyState createState() => _OneStepDetailBodyState();
}

class _OneStepDetailBodyState extends State<OneStepDetailBody> {
  bool _loading;
  BookingDetailSteps _bookingDetailSteps;
  int _duration=0;

  @override
  void initState() {
    _loading = true;
    StaffService.getBookingDetailStepsByBookingDetailId(widget.bookingDetail.id)
        .then((value) => {
              setState(() {
                _bookingDetailSteps = value;
                for(int i=0; i < value.data.length ; i++){
                  _duration =_duration+ value.data[i].treatmentService.spaService.durationMin;
                }
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
                Container(
                  padding: EdgeInsets.only(top: 30, bottom: 10, left: 20),
                  height: 100,
                  width: double.infinity,
                  color: kPrimaryColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tên gói dịch vụ:",
                        style: TextStyle(fontSize: 14, color: Colors.grey[100]),
                      ),
                      Text(
                        widget.bookingDetail.spaPackage.name,
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "KHÁCH HÀNG",
                        style: TextStyle(color: kTextColor),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          widget.bookingDetail.booking.customer.user.image ==
                                  null
                              ? CircleAvatar(
                                  radius: 15.0,
                                  backgroundImage: NetworkImage(
                                      "https://huyhoanhotel.com/wp-content/uploads/2016/05/765-default-avatar.png"),
                                  backgroundColor: Colors.transparent,
                                )
                              : CircleAvatar(
                                  radius: 15.0,
                                  backgroundImage: NetworkImage(widget
                                      .bookingDetail
                                      .booking
                                      .customer
                                      .user
                                      .image),
                                  backgroundColor: Colors.transparent,
                                ),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              widget
                                  .bookingDetail.booking.customer.user.fullname,
                              style: TextStyle(fontSize: 16),
                            ),
                          ))
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "THÔNG TIN DỊCH VỤ",
                        style: TextStyle(color: kTextColor),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(children: [
                        Icon(Icons.timer,color: kTextColor,),
                        Text(" $_duration phút")
                      ],),
                      SizedBox(
                        height: 20,
                      ),
                      ...List.generate(
                          _bookingDetailSteps.data.length,
                          (index) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("BƯỚC ${index + 1}:", style: TextStyle(fontWeight: FontWeight.bold),),
                                  SizedBox(height: 10),
                                  Container(
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                          ),
                                        ],
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 90,
                                          width: 80,
                                          child: ClipRRect(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  bottomLeft:
                                                      Radius.circular(10)),
                                              child: Image.network(
                                                _bookingDetailSteps
                                                    .data[index]
                                                    .treatmentService
                                                    .spaService
                                                    .image,
                                                fit: BoxFit.cover,
                                              )),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 10),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  _bookingDetailSteps
                                                      .data[index]
                                                      .treatmentService
                                                      .spaService
                                                      .name,
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                                                ),
                                                Text(
                                                  _bookingDetailSteps
                                                      .data[index]
                                                      .treatmentService
                                                      .spaService
                                                      .description,
                                                  maxLines: 4,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                ],
                              )),
                      SizedBox(height: 40),
                      Text(
                        "THÔNG TIN KẾT QUẢ",
                        style: TextStyle(color: kTextColor),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Image.network(
                                'https://via.placeholder.com/150'),
                          ),
                          Expanded(
                            flex: 1,
                            child: Image.network(
                                'https://via.placeholder.com/150'),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Center(child: Text("Trước dịch vụ")),
                          ),
                          Expanded(
                            flex: 1,
                            child: Center(child: Text("Sau dịch vụ")),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      DefaultButton(
                        text: "Hoàn thành",
                        press: () {},
                      )
                    ],
                  ),
                )
              ],
            ),
          );
  }
}
