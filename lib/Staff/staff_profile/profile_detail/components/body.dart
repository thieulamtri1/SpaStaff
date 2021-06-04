import 'package:flutter/material.dart';
import 'package:spa_and_beauty_staff/Staff/staff_profile/profile/components/profile_picture.dart';
import 'package:spa_and_beauty_staff/Staff/staff_profile/profile_detail/components/profile_form.dart';

class Body extends StatelessWidget {

  bool edit;
  bool enableDropDown;


  Body(this.edit, this.enableDropDown);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ProfilePic(),
            SizedBox(height: 20),
            Text("thieulamtri2@gmail.com",
                textAlign: TextAlign.center),
            SizedBox(height: 40),
            ProfileForm(edit, enableDropDown),
          ],
        ),
      ),
    );
  }
}

