import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:spa_and_beauty_staff/Model/Staff.dart';
import 'package:spa_and_beauty_staff/Service/staff_service.dart';
import 'package:spa_and_beauty_staff/constants.dart';
import 'package:spa_and_beauty_staff/default_button.dart';
import 'package:spa_and_beauty_staff/main.dart';

import '../profile_detail_screen.dart';

class ProfileFormStaff extends StatefulWidget {
  bool edit;
  bool enableDropDown;

  ProfileFormStaff(this.edit, this.enableDropDown);

  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileFormStaff> {
  Staff staff;
  String genderChoose;
  DateTime selectedDate;
  bool loading = true;

  TextEditingController fullnameTextController = TextEditingController();
  TextEditingController streetTextController = TextEditingController();
  TextEditingController dateOfBirthTextController = TextEditingController();
  TextEditingController genderTextController = TextEditingController();

  void fillText() {
    fullnameTextController =
        TextEditingController(text: staff.data.user.fullname);
    genderTextController =
        TextEditingController(text: staff.data.user.gender);
    streetTextController =
        TextEditingController(text: staff.data.user.address);
    dateOfBirthTextController =
        TextEditingController(text: staff.data.user.birthdate.toString().substring(0,10));
  }

  getData() async {
    await MyApp.storage.ready;
    int staffId = MyApp.storage.getItem("staffId");
    String staffToken = MyApp.storage.getItem("token");
    await StaffService.getStaffProfileById(staffId, staffToken)
        .then((value) => {
      setState(() {
        staff = value;
        loading = false;
      }),
    });
  }

  validate(name){
    if(name.toString().trim() == ""){
      final snackBar = SnackBar(
        content: Text('Vui lòng nhập tên'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return false;
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    if(loading){
      return Center(
          child: SpinKitWave(
            color: kPrimaryColor,
            size: 50,
          )
      );
    }
    fillText();
    return Container(
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FullNameTextField(),
            SizedBox(height: 30),
            BirthDateTextField(),
            SizedBox(height: 30),
            GenderField(),
            SizedBox(height: 30),
            DistrictTextField(),
            SizedBox(height: 30),
            buildUpdateButton(context),
          ],
        ),
      ),
    );
  }

  DefaultButton buildUpdateButton(BuildContext context) {
    return DefaultButton(
      text: "Cập nhật",
      press: () async {
        if(validate(fullnameTextController.text)){
          final res = await StaffService().updateStaffProfile(
            token: MyApp.storage.getItem('token'),
            active: true,
            address: streetTextController.text,
            birthdate: dateOfBirthTextController.text,
            email: staff.data.user.email,
            fullname: fullnameTextController.text,
            gender: genderTextController.text,
            id: MyApp.storage.getItem("staffId"),
            image: staff.data.user.image,
            password: staff.data.user.password,
            phone: staff.data.user.phone,
          );
          print("Status: ${res.body}");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ProfileDetailScreenStaff()),
          );
        }

      },
    );
  }

  TextFormField FullNameTextField() {
    return TextFormField(
      controller: fullnameTextController,
      enabled: widget.edit,
      decoration: InputDecoration(
        labelText: "Tên",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.drive_file_rename_outline),
      ),
    );
  }

  TextFormField BirthDateTextField() {
    return TextFormField(
      controller: dateOfBirthTextController,
      enabled: false,
      decoration: InputDecoration(
        labelText: "Ngày sinh",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.baby_changing_station),
      ),
    );
  }

  TextFormField DistrictTextField() {
    return TextFormField(
      controller: streetTextController,
      enabled: false,
      minLines: 1,
      maxLines: 4,
      decoration: InputDecoration(
        labelText: "Địa chỉ",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.home),
      ),
    );
  }

  Widget GenderField() {
    return TextFormField(
      controller: genderTextController,
      enabled: false,
      decoration: InputDecoration(
        labelText: "Giới tính",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.support_agent),
      ),
    );
  }

}
