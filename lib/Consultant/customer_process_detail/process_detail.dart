import 'package:flutter/material.dart';
import 'package:spa_and_beauty_staff/Consultant/customer_process_detail/components/body.dart';
import 'package:spa_and_beauty_staff/Model/BookingDetail.dart';
import 'package:spa_and_beauty_staff/constants.dart';

class ConsultantProcessDetailScreen extends StatefulWidget {
  const ConsultantProcessDetailScreen({Key key, this.bookingDetail, this.customerId}) : super(key: key);
  final BookingDetailInstance bookingDetail;
  final int customerId;
  @override
  _ConsultantProcessDetailScreenState createState() => _ConsultantProcessDetailScreenState();
}

class _ConsultantProcessDetailScreenState extends State<ConsultantProcessDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: kPrimaryColor
        ),
        title: Text("Chi tiết liệu trình",

        ),
        centerTitle: true,
      ),
      body: Body(bookingDetail: widget.bookingDetail,customerId: widget.customerId,),
    );
  }
}
