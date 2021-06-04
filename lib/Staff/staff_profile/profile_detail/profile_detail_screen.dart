import 'package:flutter/material.dart';
import 'package:spa_and_beauty_staff/Staff/staff_profile/profile_detail/components/body.dart';

class ProfileDetailScreen extends StatefulWidget {
  @override
  _ProfileDetailScreenState createState() => _ProfileDetailScreenState();
}

class _ProfileDetailScreenState extends State<ProfileDetailScreen> {
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
