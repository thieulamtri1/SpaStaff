import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:spa_and_beauty_staff/Model/Staff.dart';
import 'package:spa_and_beauty_staff/Service/staff_service.dart';
import 'package:spa_and_beauty_staff/default_button.dart';
import 'package:spa_and_beauty_staff/main.dart';

import '../profile_detail_screen.dart';

class ProfileForm extends StatefulWidget {
  bool edit;
  bool enableDropDown;

  ProfileForm(this.edit, this.enableDropDown);

  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
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
    if(MyApp.storage.getItem('role') == "STAFF"){
      int staffId = MyApp.storage.getItem("staffId");
      String staffToken = MyApp.storage.getItem("token");
      await StaffService.getStaffProfileById(staffId, staffToken)
          .then((value) => {
        setState(() {
          staff = value;
          loading = false;
          print("IMAGE nè duma: " + staff.data.user.image);
        }),
      });
    }
    else{
      print("lấy consultant");
      int staffId = MyApp.storage.getItem("staffId");
      String staffToken = MyApp.storage.getItem("token");
      await StaffService.getConsultantProfileById(staffId, staffToken)
          .then((value) => {
        setState(() {
          staff = value;
          loading = false;
        }),
      });
    }
    
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
            color: Colors.orange,
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
        if(MyApp.storage.getItem("role") == "STAFF"){
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
            MaterialPageRoute(builder: (context) => ProfileDetailScreen()),
          );
        }else{
          final res = await StaffService().updateConsultantProfile(
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
            MaterialPageRoute(builder: (context) => ProfileDetailScreen()),
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
