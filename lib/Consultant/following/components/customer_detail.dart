import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:spa_and_beauty_staff/Consultant/chat/components/conversation_appBar.dart';
import 'package:spa_and_beauty_staff/Consultant/customer_process_detail/process_detail.dart';
import 'package:spa_and_beauty_staff/Model/BookingDetail.dart';
import 'package:spa_and_beauty_staff/Service/consultant_service.dart';
import 'package:spa_and_beauty_staff/constants.dart';

import '../../../main.dart';

class CustomerDetail extends StatefulWidget {
  final String customerId;
  final String customerName;
  final String customerPhone;
  final String customerImage;
  final String customerEmail;
  final String customerGender;

  CustomerDetail(this.customerId, this.customerName, this.customerPhone,
      this.customerImage, this.customerEmail, this.customerGender);

  @override
  _BookingDetailState createState() => _BookingDetailState();
}

class _BookingDetailState extends State<CustomerDetail> {
  BookingDetailByConsultant bookingDetail = BookingDetailByConsultant();
  bool loading = true;

  getBookingDetail() {
    ConsultantService.findBookingDetailByCustomerAndConsultant(
        widget.customerId,
        MyApp.storage.getItem("consultantId"),
        MyApp.storage.getItem("token"))
        .then((value) =>
    {
      setState(() {
        bookingDetail = value;
        loading = false;
      })
    });
  }

  @override
  void initState() {
    super.initState();
    getBookingDetail();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: SpinKitWave(
              color: kPrimaryColor,
              size: 50,
            )),
      );
    } else {
      return Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: ConversationAppBar(
              image: widget.customerImage,
              name: widget.customerName,
              phone: widget.customerPhone),
          body: Padding(
            padding: const EdgeInsets.all(30),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Khách hàng: ",
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.customerName,
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Số điện thoại: ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        widget.customerPhone,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Email: ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        widget.customerEmail,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Giới tính: ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        widget.customerGender,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 0.5,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Các liệu trình đang theo dõi",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: kTextColor),
                  ),
                  SizedBox(height: 20),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: bookingDetail.data.length,
                    itemBuilder: (BuildContext ctx, int index) {
                      return BookingdetailList(
                        bookingDetail: bookingDetail.data[index],
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ConsultantProcessDetailScreen(
                                      bookingDetail: bookingDetail.data[index],
                                      customerId:
                                      int.tryParse(widget.customerId),
                                    )),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ));
    }
  }
}

class BookingdetailList extends StatefulWidget {
  const BookingdetailList({Key key, this.bookingDetail, this.press})
      : super(key: key);
  final BookingDetailInstance bookingDetail;
  final GestureTapCallback press;

  @override
  _BookingdetailListState createState() => _BookingdetailListState();
}

class _BookingdetailListState extends State<BookingdetailList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.press,
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
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
        height: 120,
        width: 100,
        padding: EdgeInsets.all(10),
        child: Container(
          child: Row(
            children: [
              SizedBox(
                width: 88,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: widget.bookingDetail.spaPackage.image == null
                        ? Image.asset(
                      "assets/images/Splash_1.PNG",
                      fit: BoxFit.cover,
                    )
                        : Image.network(
                      widget.bookingDetail.spaPackage.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        "Dịch vụ: " + widget.bookingDetail.spaPackage.name,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 0.5,
                      width: 150,
                      color: Colors.black,
                    ),
                    SizedBox(height: 10),
                    Text(
                      widget.bookingDetail.statusBooking == "FINISH"
                          ? "Hoàn thành"
                          : widget.bookingDetail.statusBooking == "CHANGE_STAFF"?
                      "Đang đổi nhân viên"
                      : "Đang tiến hành",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      child: Text(
                        widget.bookingDetail.spaTreatment == null
                            ? "Chưa có liệu trình"
                            : "Liệu trình: " +
                            widget.bookingDetail.spaTreatment.name,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
