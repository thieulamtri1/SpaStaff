import 'package:flutter/material.dart';
import 'package:spa_and_beauty_staff/Model/StaffSchedule.dart';
import 'package:spa_and_beauty_staff/Staff/process_detail/components/body.dart';
import 'package:spa_and_beauty_staff/constants.dart';




class StaffProcessDetail extends StatefulWidget {
  const StaffProcessDetail({Key key, this.bookingDetail}) : super(key: key);
  final StaffBookingDetailInstance bookingDetail;
  @override
  _StaffProcessDetailState createState() => _StaffProcessDetailState();
}

class _StaffProcessDetailState extends State<StaffProcessDetail> {
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
      body: StaffProcessDetailBody(bookingDetail: widget.bookingDetail,customerId: widget.bookingDetail.booking.customer.id,),
    );
  }
}
