import 'package:flutter/material.dart';
import 'package:spa_and_beauty_staff/Staff/customer_process_detail/components/booking_for_next_step/components/body.dart';

class BookingForNextStepScreen extends StatefulWidget {
  final int bookingDetailStepId;
  final int customerId;
  final int spaId;
  final int spaServiceId;

  const BookingForNextStepScreen({Key key, this.bookingDetailStepId, this.customerId, this.spaId, this.spaServiceId}) : super(key: key);

  @override
  _BookingForNextStepScreenState createState() => _BookingForNextStepScreenState();
}

class _BookingForNextStepScreenState extends State<BookingForNextStepScreen> {
  @override
  Widget build(BuildContext context) {
    print ("spa service id: ${widget.spaServiceId}");
    print ("customer id: ${widget.customerId}");
    print ("spa id: ${widget.spaId}");
    print ("booking detail step id: ${widget.bookingDetailStepId}");
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
      body: NextStepBookingBody(spaId: widget.spaId,customerId: widget.customerId,bookingDetailStepId: widget.bookingDetailStepId,spaServiceId: widget.spaServiceId,),
    );
  }
}
