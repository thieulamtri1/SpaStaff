import 'package:flutter/material.dart';
import 'package:spa_and_beauty_staff/Staff/customer_process_detail/components/booking_for_first_step/components/body.dart';

class BookingForFirstStepScreen extends StatefulWidget {
  final int consultantId;
  final int customerId;
  final int spaId;
  final int spaTreatmentId;
  final int bookingDetailId;

  const BookingForFirstStepScreen({Key key, this.consultantId, this.customerId, this.spaId, this.spaTreatmentId, this.bookingDetailId}) : super(key: key);

  @override
  _BookingForFirstStepScreenState createState() =>
      _BookingForFirstStepScreenState();
}

class _BookingForFirstStepScreenState extends State<BookingForFirstStepScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Đặt lịch hẹn",
          style: TextStyle(
              fontSize: 28,
              color: Colors.black
          ),
        ),
      ),
      body:FirstStepBookingBody(customerId: widget.customerId,spaId: widget.spaId,consultantId: widget.consultantId,bookingDetailId: widget.bookingDetailId,spaTreatmentId: widget.spaTreatmentId,),
    );
  }
}
