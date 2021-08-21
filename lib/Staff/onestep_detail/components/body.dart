import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:spa_and_beauty_staff/Consultant/customer_process_detail/components/booking_for_first_step/components/body.dart';
import 'package:spa_and_beauty_staff/Model/BookingDetailSteps.dart';
import 'package:spa_and_beauty_staff/Model/StaffSchedule.dart';
import 'package:spa_and_beauty_staff/Service/staff_service.dart';
import 'package:spa_and_beauty_staff/constants.dart';
import 'package:spa_and_beauty_staff/default_button.dart';
import 'package:spa_and_beauty_staff/main.dart';

class OneStepDetailBody extends StatefulWidget {
  const OneStepDetailBody({Key key, this.bookingDetail}) : super(key: key);
  final StaffBookingDetailInstance bookingDetail;

  @override
  _OneStepDetailBodyState createState() => _OneStepDetailBodyState();
}

class _OneStepDetailBodyState extends State<OneStepDetailBody> {
  bool _loading;
  BookingDetailSteps _bookingDetailSteps;
  int _duration = 0;

  @override
  void initState() {
    _loading = true;
    StaffService.getBookingDetailStepsByBookingDetailId(widget.bookingDetail.id)
        .then((value) => {
              setState(() {
                _bookingDetailSteps = value;
                for (int i = 0; i < value.data.length; i++) {
                  _duration = _duration +
                      value.data[i].treatmentService.spaService.durationMin;
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
                      _bookingDetailSteps.data[0].rating != null ?
                      Visibility(
                        visible: _bookingDetailSteps.data[0].rating.rate != null ,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "ĐÁNH GIÁ CỦA KHÁCH HÀNG",
                              style: TextStyle(color: kTextColor),
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                ...List.generate(_bookingDetailSteps.data[0].rating.rate, (index) => Icon(Icons.star, color: kPrimaryColor,))
                              ],
                            ),
                            Text(
                              _bookingDetailSteps.data[0].rating.comment==null?"Khách hàng không nhận xét thêm" :_bookingDetailSteps.data[0].rating.comment,
                              style: TextStyle( color: Colors.grey),
                            ),
                          ],
                        ),
                      )
                          :SizedBox()
                      ,
                      SizedBox(height: 20,),
                      Text(
                        "THÔNG TIN DỊCH VỤ",
                        style: TextStyle(color: kTextColor),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.timer,
                            color: kTextColor,
                          ),
                          Text(" $_duration phút")
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ...List.generate(
                          _bookingDetailSteps.data.length,
                          (index) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "BƯỚC ${index + 1}:",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
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
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  _bookingDetailSteps
                                                      .data[index]
                                                      .treatmentService
                                                      .spaService
                                                      .name,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  _bookingDetailSteps
                                                      .data[index]
                                                      .treatmentService
                                                      .spaService
                                                      .description,
                                                  maxLines: 4,
                                                  overflow:
                                                      TextOverflow.ellipsis,
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

                      _bookingDetailSteps.data[0].statusBooking=="FINISH" ?
                       Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text(
                             "THÔNG TIN KẾT QUẢ",
                             style: TextStyle(color: kTextColor),
                           ),
                           SizedBox(
                             height: 20,
                           ),
                           Row(
                             children: [
                               Icon(Icons.check_circle, color: kGreen,),
                               SizedBox(width: 10,),
                               Text("Dịch vụ đã hoàn thành", ),
                             ],
                           ),
                         ],
                       )
                      :DefaultButton(
                        text: "Hoàn thành dịch vụ",
                        press:() {
                          showDialog(
                            context: context,
                            builder: (builder) {
                              return Dialog(
                                child: Stack(
                                  overflow: Overflow.visible,
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 50, 20, 20),
                                      width: double.infinity,
                                      height: 200,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Xác nhận",
                                            style: TextStyle(fontSize: 24),
                                          ),
                                          Text(
                                              "Bạn có chắc chắn muốn hoàn tất dịch vụ ?"),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                  flex: 1,
                                                  child: TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
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
                                                        StaffService.finishOnestepPackage(widget.bookingDetail.id).then((value)
                                                            {
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
                                                              },
                                                              title: "Thành Công !",
                                                              description:
                                                              "Hoàn tất dịch vụ thành công",
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
                                                              description:
                                                              value.data,
                                                              buttonTitle: "Thoát",
                                                              lottie: "assets/lottie/fail.json",
                                                            );
                                                          },
                                                        );
                                                            }

                                                        );
                                                      },
                                                      child: Text("Xác nhận"))),
                                              Expanded(
                                                  flex: 1,
                                                  child: TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text("Thoát"))),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      top: -35,
                                      child: SvgPicture.asset(
                                        "assets/icons/check.svg",
                                        width: 70,
                                        height: 70,
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          );
  }
}
