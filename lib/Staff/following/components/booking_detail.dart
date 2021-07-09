import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:spa_and_beauty_staff/Model/BookingDetail.dart';
import 'package:spa_and_beauty_staff/Service/consultant_service.dart';
import 'package:spa_and_beauty_staff/Staff/chat/components/conversation_appBar.dart';

import '../../../main.dart';

class BookingDetailScreen extends StatefulWidget {
  final String customerId;
  final String customerName;
  final String customerPhone;
  final String customerImage;
  final String customerEmail;
  final String customerGender;

  BookingDetailScreen(this.customerId, this.customerName, this.customerPhone,
      this.customerImage, this.customerEmail, this.customerGender);

  @override
  _BookingDetailState createState() => _BookingDetailState();
}

class _BookingDetailState extends State<BookingDetailScreen> {
  BookingDetailByCustomerAndConsultant bookingDetail =
      BookingDetailByCustomerAndConsultant();
  bool loading = true;

  getBookingDetail() {
    ConsultantService.findByCustomerAndConsultant(widget.customerId,
            MyApp.storage.getItem("staffId"), MyApp.storage.getItem("token"))
        .then((value) => {
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
          color: Colors.orange,
          size: 50,
        )),
      );
    } else {
      return Scaffold(
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
                    children: [
                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(1.0),
                            child: Text(
                              "Tên: " + widget.customerName,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(1.0),
                            child: Text(
                              "Số điện thoại: " + widget.customerPhone,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(1.0),
                            child: Text(
                              "Email: " + widget.customerEmail,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(1.0),
                            child: Text(
                              "Giới tính: " + widget.customerGender,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 0.5,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 50),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: bookingDetail.data.length,
                    itemBuilder: (BuildContext ctx, int index) {
                      return BookingdetailList(
                        bookingDetail.data[index].spaPackage.name,
                        bookingDetail.data[index].spaPackage.image,
                        bookingDetail.data[index].statusBooking,
                        bookingDetail.data[index].totalPrice,
                        bookingDetail.data[index].totalTime,
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

Widget BookingdetailList(name, image, status, totalPrice, totalTime) {
  return GestureDetector(
    onTap: () {},
    child: Container(
      height: 150,
      width: 150,
      color: Colors.grey[200],
      padding: EdgeInsets.all(10),
      child: Container(
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(5),
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Image.network(
                image,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Status: " + status,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
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
                  "Tên: " + name,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Giá: " + totalPrice.toString(),
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Thời gian: " + totalTime.toString() + " phút ",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
