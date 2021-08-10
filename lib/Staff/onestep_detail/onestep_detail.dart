import 'package:flutter/material.dart';
import 'package:spa_and_beauty_staff/Model/StaffSchedule.dart';
import 'package:spa_and_beauty_staff/Staff/onestep_detail/components/body.dart';
import 'package:spa_and_beauty_staff/constants.dart';

class OneStepDetailScreen extends StatelessWidget {
  const OneStepDetailScreen({Key key, this.bookingDetail}) : super(key: key);
  final StaffBookingDetailInstance bookingDetail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Thông tin chi tiết", style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: OneStepDetailBody(bookingDetail: bookingDetail,),
    );
  }
}
