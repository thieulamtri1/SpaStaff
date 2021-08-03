import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:spa_and_beauty_staff/Consultant/chat/components/search_widget.dart';
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
  String query = '';
  List<Datum> customerDefault;
  List<Datum> customerSearch;

  getListCustomerOfConsultant() async {
    await ConsultantService.getListCustomerOfConsultant(
            MyApp.storage.getItem("consultantId"),
            MyApp.storage.getItem("token"))
        .then((value) => {
              setState(() {
                print("day ne");
                customerOfConsultant = value;
                customerDefault = value.data;
                customerSearch = value.data;
                loading = false;
              })
            });
  }

  Widget buildSearch() => SearchWidget(query, searchCustomer, false);

  void searchCustomer(String query) {
    final customerSearch = customerDefault.where((customer) {
      final nameLower = customer.fullname.toLowerCase();
      final searchLower = query.toLowerCase();
      return nameLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      this.customerSearch = customerSearch;
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
      ));
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
              SizedBox(height: 10),
              buildSearch(),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: customerSearch.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final customer = customerSearch[index];
                    return CustomerCard(
                      customerId:
                      customer.id.toString(),
                      customerName: customer.fullname,
                      customerImage: customer.image,
                      customerPhone: customer.phone,
                      customerEmail: customer.email,
                      customerGender: customer.gender,
                    );
                  })
            ],
          ),
        ),
      );
    }
  }
}
