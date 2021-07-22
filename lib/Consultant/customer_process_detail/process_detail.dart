import 'package:flutter/material.dart';
import 'package:spa_and_beauty_staff/Consultant/customer_process_detail/components/body.dart';
import 'package:spa_and_beauty_staff/Model/BookingDetail.dart';
import 'package:spa_and_beauty_staff/constants.dart';

class CustomerProcessDetailScreen extends StatefulWidget {
  const CustomerProcessDetailScreen({Key key, this.bookingDetail, this.customerId}) : super(key: key);
  final BookingDetailInstance bookingDetail;
  final int customerId;
  @override
  _CustomerProcessDetailScreenState createState() => _CustomerProcessDetailScreenState();
}

class _CustomerProcessDetailScreenState extends State<CustomerProcessDetailScreen> {
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
