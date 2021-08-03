import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:spa_and_beauty_staff/Model/CustomerOfConsultant.dart';
import 'package:spa_and_beauty_staff/Service/consultant_service.dart';
import 'package:spa_and_beauty_staff/constants.dart';
import 'package:spa_and_beauty_staff/main.dart';

import 'customer_card.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController searchInput = TextEditingController();
  CustomerOfConsultant customerOfConsultant = CustomerOfConsultant();
  bool loading = true;

  getListCustomerOfConsultant() {
    ConsultantService.getListCustomerOfConsultant(
            MyApp.storage.getItem("staffId"), MyApp.storage.getItem("token"))
        .then((value) => {
              setState(() {
                customerOfConsultant = value;
                loading = false;
              })
            });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getListCustomerOfConsultant();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Center(
        child: SpinKitWave(
          color: kPrimaryColor,
          size: 50,
        )
      );
    } else {
      return Scaffold(
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Danh sách khách hàng",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                child: TextField(
                  controller: searchInput,
                  decoration: InputDecoration(
                    hintText: "Search...",
                    hintStyle: TextStyle(color: Colors.grey.shade400),
                    prefixIcon: IconButton(
                      icon: Icon(Icons.search),
                      color: Colors.grey.shade400,
                      iconSize: 25,
                      onPressed: () {},
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    contentPadding: EdgeInsets.all(8),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.grey.shade100)),
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: customerOfConsultant.data.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => CustomerCard(
                  customerId: customerOfConsultant.data[index].id.toString(),
                  customerName: customerOfConsultant.data[index].fullname,
                  customerImage: customerOfConsultant.data[index].image,
                  customerPhone: customerOfConsultant.data[index].phone,
                  customerEmail: customerOfConsultant.data[index].email,
                  customerGender: customerOfConsultant.data[index].gender,
                ),
              )
            ],
          ),
        ),
      );
    }
  }
}
