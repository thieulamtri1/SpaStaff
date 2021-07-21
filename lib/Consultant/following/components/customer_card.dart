import 'package:flutter/material.dart';

import 'customer_detail.dart';

class CustomerCard extends StatefulWidget {
  final String customerId;
  final String customerName;
  final String customerPhone;
  String customerImage;
  final String customerEmail;
  final String customerGender;

  CustomerCard(
      {this.customerId,
      this.customerName,
      this.customerPhone,
      this.customerImage,
      this.customerEmail,
      this.customerGender});

  @override
  _CustomerCardState createState() => _CustomerCardState();
}

class _CustomerCardState extends State<CustomerCard> {
  @override
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CustomerDetail(
                      widget.customerId,
                      widget.customerName,
                      widget.customerPhone,
                      widget.customerImage,
                      widget.customerEmail,
                      widget.customerGender,
                    )));
      },
      child: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  widget.customerImage == null
                      ? CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://huyhoanhotel.com/wp-content/uploads/2016/05/765-default-avatar.png"),
                          maxRadius: 30,
                        )
                      : CircleAvatar(
                          backgroundImage: NetworkImage(widget.customerImage),
                          maxRadius: 30,
                        ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.customerName,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            widget.customerPhone,
                            style: TextStyle(
                                fontSize: 14, color: Colors.grey.shade500),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
