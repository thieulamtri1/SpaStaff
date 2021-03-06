import 'package:flutter/material.dart';
import 'package:spa_and_beauty_staff/Consultant/consultant_profile/profile/components/profile_picture.dart';
import 'package:spa_and_beauty_staff/Service/consultant_service.dart';
import 'package:spa_and_beauty_staff/Service/staff_service.dart';
import 'package:spa_and_beauty_staff/Staff/staff_profile/change_password/change_password.dart';
import 'package:spa_and_beauty_staff/Staff/staff_profile/profile/components/profile_picture.dart';
import 'package:spa_and_beauty_staff/main.dart';

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
            ProfilePicConsultant(),
            SizedBox(height: 20),
            //Text(MyApp.storage.getItem("email"), textAlign: TextAlign.center),
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

  int validate() {
    if (oldPasswordTextController.text != MyApp.storage.getItem('password')) {
      print("M???t kh???u kh??ng ????ng");
      return 1;
    } else if (newPasswordTextController.text != confirmPasswordTextController.text || newPasswordTextController.text == "" || confirmPasswordTextController.text == "") {
      print("2 m???t kh???u kh??ng gi???ng nhau ");
      return 2;
    }
    return 0;
  }

  TextFormField OldPasswordTextField() {
    return TextFormField(
      obscureText: true,
      controller: oldPasswordTextController,
      decoration: InputDecoration(
        labelText: "M???t kh???u c??",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.drive_file_rename_outline),
      ),
    );
  }

  TextFormField NewPasswordTextField() {
    return TextFormField(
      obscureText: true,
      controller: newPasswordTextController,
      decoration: InputDecoration(
        labelText: "M???t kh???u m???i",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.drive_file_rename_outline),
      ),
    );
  }

  TextFormField ConfirmPasswordTextField() {
    return TextFormField(
      obscureText: true,
      controller: confirmPasswordTextController,
      decoration: InputDecoration(
        labelText: "Nh???p l???i m???t kh???u",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.drive_file_rename_outline),
      ),
    );
  }

  DefaultButton buildUpdateButton(BuildContext context) {
    return DefaultButton(
      text: "C???p nh???t",
      press: () async {
        if(validate() == 0){
          print("?????i m???t kh???u th??nh c??ng");
          final snackBar = SnackBar(
            content: Text('?????i m???t kh???u th??nh c??ng'),
            action: SnackBarAction(
              label: 'T???t',
              onPressed: () {},
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          final res = await ConsultantService().editPasswordConsultant(
              MyApp.storage.getItem("token"), newPasswordTextController.text);
          print(res.body);
          setState(() {
            MyApp.storage.setItem("password", newPasswordTextController.text);
            oldPasswordTextController.clear();
            newPasswordTextController.clear();
            confirmPasswordTextController.clear();
          });


        }
        else if(validate() == 1){
          print("Kh??ng th??? ?????i m???t kh???u");
          final snackBar = SnackBar(
            content: Text('Nh???p sai m???t kh???u hi???n t???i'),
            action: SnackBarAction(
              label: 'Th??? l???i',
              onPressed: () {},
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        else if(validate() == 2){
          final snackBar = SnackBar(
            content: Text('Nh???p l???i m???t kh???u m???i'),
            action: SnackBarAction(
              label: 'Th??? l???i',
              onPressed: () {},
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }


      },
    );
  }
}
