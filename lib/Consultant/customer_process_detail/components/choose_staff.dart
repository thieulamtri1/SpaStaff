import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:spa_and_beauty_staff/Consultant/customer_process_detail/components/booking_for_first_step/booking_for_first_step_screen.dart';
import 'package:spa_and_beauty_staff/Model/ListStaffForBooking.dart';
import 'package:spa_and_beauty_staff/Service/consultant_service.dart';
import 'package:spa_and_beauty_staff/constants.dart';

class ChooseStaffScreen extends StatefulWidget {
  final int consultantId;
  final int customerId;
  final int spaId;
  final int spaTreatmentId;
  final int bookingDetailId;

  const ChooseStaffScreen(
      {Key key,
      this.consultantId,
      this.customerId,
      this.spaId,
      this.spaTreatmentId,
      this.bookingDetailId})
      : super(key: key);

  @override
  _ChooseStaffScreenState createState() => _ChooseStaffScreenState();
}

class _ChooseStaffScreenState extends State<ChooseStaffScreen> {
  ListStaffForBooking _listStaffForBooking;
  bool _loading;

  @override
  void initState() {
    _loading = true;
    ConsultantService.getListStaffForBooking(widget.spaId).then((value) => {
          setState(() {
            _listStaffForBooking = value;
            _loading = false;
          })
        });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chọn nhân viên"),
      ),
      body: _loading
          ? Center(
              child: SpinKitWave(
              color: kPrimaryColor,
              size: 50,
            ))
          : SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: TextButton(
                        child: Text("Để quản lý chọn nhân viên"),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BookingForFirstStepScreen(
                                      consultantId: widget.consultantId,
                                      customerId: widget.customerId,
                                      spaId: widget.spaId,
                                      spaTreatmentId: widget.spaTreatmentId,
                                      bookingDetailId: widget.bookingDetailId,
                                      choosenStaff: null,
                                    )),
                          );
                        },
                      ),
                    ),
                    ...List.generate(_listStaffForBooking.data.length, (index) =>
                        InkWell(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BookingForFirstStepScreen(
                                    consultantId: widget.consultantId,
                                    customerId: widget.customerId,
                                    spaId: widget.spaId,
                                    spaTreatmentId: widget.spaTreatmentId,
                                    bookingDetailId: widget.bookingDetailId,
                                    choosenStaff: _listStaffForBooking.data[index],
                                  )),
                            );
                          },
                          child: Container(
                            margin:  EdgeInsets.symmetric(vertical: 10),
                            padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                  ),
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        _listStaffForBooking.data[index].user.image),
                                    maxRadius: 30,
                                  ),
                                ),
                                Expanded(
                                    flex: 8,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        _listStaffForBooking.data[index].user.fullname,
                                        style: TextStyle(fontSize: 17),
                                      ),
                                    )),
                                Expanded(
                                  flex: 1,
                                  child: Icon(Icons.chevron_right),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ),


                  ],
                ),
              ),
            ),
    );
  }
}
