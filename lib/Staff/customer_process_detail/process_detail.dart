import 'package:flutter/material.dart';
import 'package:spa_and_beauty_staff/Model/BookingDetail.dart';
import 'package:spa_and_beauty_staff/Staff/customer_process_detail/components/body.dart';
import 'package:spa_and_beauty_staff/constants.dart';

class CustomerProcessDetailScreen extends StatefulWidget {
  const CustomerProcessDetailScreen({Key key, this.bookingDetail}) : super(key: key);
  final BookingDetailInstance bookingDetail;
  @override
  _CustomerProcessDetailScreenState createState() => _CustomerProcessDetailScreenState();
}

class _CustomerProcessDetailScreenState extends State<CustomerProcessDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: kPrimaryColor
        ),
        title: Text("Chi tiết liệu trình",

        ),
        centerTitle: true,
      ),
      body: Body(bookingDetail: widget.bookingDetail,),
    );
  }
}
