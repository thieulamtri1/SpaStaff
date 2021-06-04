import 'package:flutter/material.dart';
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

  TextEditingController fullnameTextController = TextEditingController();
  TextEditingController districtTextController = TextEditingController();
  TextEditingController streetTextController = TextEditingController();
  TextEditingController provinceTextController = TextEditingController();
  TextEditingController dateOfBirthTextController = TextEditingController();
  TextEditingController genderTextController = TextEditingController();

  void fillText() {
    fullnameTextController = TextEditingController(text: staff.fullname);
    districtTextController = TextEditingController(text: staff.district);
    genderTextController = TextEditingController(text: staff.gender.name);
    provinceTextController = TextEditingController(text: staff.province);
    streetTextController = TextEditingController(text: staff.street);
  }



  getData() async{
    await MyApp.storage.ready;
    int staffId = MyApp.storage.getItem("staffId");
    String staffToken = MyApp.storage.getItem("token");
    await StaffService.getStaffProfileById(staffId, staffToken).then((value) => {
      setState(() {
        staff = value;
        print("Tri");
      }),
    });

  }
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    fillText();
    return Container(
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FullNameTextField(),
            SizedBox(height: 30),
            DistrictTextField(),
            SizedBox(height: 30),
            GenderField(),
            SizedBox(height: 30),
            ProvinceTextField(),
            SizedBox(height: 30),
            StreetTextField(),
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
      press: () {
        String fullname = fullnameTextController.text;
        String staffId;
        String staffImage;
        String staffToken;
        String image = MyApp.storage.getItem("image");
        setState(() async {
          widget.edit = false;
          await StaffService().updateStaffProfile(
            fullname: fullname,
            image: staffImage,
            id: staffId,
            token: staffToken,
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ProfileDetailScreen()),
          );
        });
      },
    );
  }

  TextFormField FullNameTextField() {
    return TextFormField(
      controller: fullnameTextController,
      enabled: widget.edit,
      decoration: InputDecoration(
        labelText: "Họ tên",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.drive_file_rename_outline),
      ),
    );
  }

  TextFormField DistrictTextField() {
    return TextFormField(
      controller: districtTextController,
      enabled: false,
      decoration: InputDecoration(
        labelText: "Quận",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.edit_road),
      ),
    );
  }

  Widget GenderField() {
    return TextFormField(
      controller: genderTextController,
      enabled: false,
      decoration: InputDecoration(
        labelText: "Gender",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.support_agent),
      ),
    );
  }

  TextFormField ProvinceTextField() {
    return TextFormField(
      controller: provinceTextController,
      enabled: false,
      decoration: InputDecoration(
        labelText: "Tỉnh thành",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.home),
      ),
    );
  }

  TextFormField StreetTextField() {
    return TextFormField(
      controller: streetTextController,
      enabled: false,
      decoration: InputDecoration(
        labelText: "Đường",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.add_location_alt_rounded),
      ),
    );
  }
}
