import 'package:flutter/material.dart';
import 'package:spa_and_beauty_staff/Staff/staff_profile/change_password/change_password.dart';
import 'package:spa_and_beauty_staff/Staff/staff_profile/profile/components/profile_picture.dart';

import '../../../../default_button.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {



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
            ChangePasswordForm(),
          ],
        ),
      ),
    );
  }
}

class ChangePasswordForm extends StatefulWidget {
  @override
  _ChangePasswordFormState createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {

  TextEditingController oldPasswordTextController = TextEditingController();
  TextEditingController newPasswordTextController = TextEditingController();
  TextEditingController confirmPasswordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OldPasswordTextField(),
            SizedBox(height: 30),
            NewPasswordTextField(),
            SizedBox(height: 30),
            ConfirmPasswordTextField(),
            SizedBox(height: 30),
            buildUpdateButton(context),
          ],
        ),
      ),
    );
  }


  TextFormField OldPasswordTextField() {
    return TextFormField(
      controller: oldPasswordTextController,
      decoration: InputDecoration(
        labelText: "Mật khẩu cũ",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.drive_file_rename_outline),
      ),
    );
  }
  TextFormField NewPasswordTextField() {
    return TextFormField(
      controller: newPasswordTextController,
      decoration: InputDecoration(
        labelText: "Mật khẩu mới",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.drive_file_rename_outline),
      ),
    );
  }
  TextFormField ConfirmPasswordTextField() {
    return TextFormField(
      controller: confirmPasswordTextController,
      decoration: InputDecoration(
        labelText: "Nhập lại mật khẩu",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.drive_file_rename_outline),
      ),
    );
  }

  DefaultButton buildUpdateButton(BuildContext context) {
    return DefaultButton (
      text: "Cập nhật",
      press: ()  {},
    );
  }
}





