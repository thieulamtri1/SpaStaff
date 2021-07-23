import 'package:flutter/material.dart';

import 'components/body.dart';

class ProfileDetailScreenConsultant extends StatefulWidget {
  @override
  _ProfileDetailScreenState createState() => _ProfileDetailScreenState();
}

class _ProfileDetailScreenState extends State<ProfileDetailScreenConsultant> {
  bool edit = false;
  bool enableDropDown = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Profile",
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  if (edit) {
                    edit = false;
                    enableDropDown = false;
                  } else {
                    edit = true;
                    enableDropDown = true;
                  }
                });
              },
              child: Icon(Icons.edit),
            ),
          ),
        ],
      ),
      body: Body(edit, enableDropDown),
    );
  }
}
