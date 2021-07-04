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
    fullnameTextController =
        TextEditingController(text: MyApp.storage.getItem("fullname"));
    districtTextController =
        TextEditingController(text: MyApp.storage.getItem("address"));
    genderTextController =
        TextEditingController(text: MyApp.storage.getItem("gender"));
    provinceTextController =
        TextEditingController(text: MyApp.storage.getItem("address"));
    streetTextController =
        TextEditingController(text: MyApp.storage.getItem("address"));
    dateOfBirthTextController =
        TextEditingController(text: MyApp.storage.getItem("birthdate"));
  }

  getData() async {
    await MyApp.storage.ready;
    int staffId = MyApp.storage.getItem("staffId");
    String staffToken = MyApp.storage.getItem("token");
    await StaffService.getStaffProfileById(staffId, staffToken)
        .then((value) => {
              setState(() {
                staff = value;
              }),
            });
  }

  @override
  void initState() {
    super.initState();
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
        bool active = true;
        String address = MyApp.storage.getItem("address");
        String birthdate = MyApp.storage.getItem("birthdate");
        String email = MyApp.storage.getItem("email");
        String fullname = fullnameTextController.text;
        String gender = MyApp.storage.getItem("gender");
        int staffId = MyApp.storage.getItem("staffId");
        String staffImage = MyApp.storage.getItem("image");
        String staffToken = MyApp.storage.getItem("token");
        String password = MyApp.storage.getItem("password");
        String phone = MyApp.storage.getItem("phone");

        final res = await StaffService().updateStaffProfile(
          token: staffToken,
          active: active,
          address: address,
          birthdate: birthdate,
          email: email,
          fullname: fullname,
          gender: gender,
          id: staffId,
          image: staffImage,
          password: password,
          phone: phone,
        );
        print("Status: ${res.body}");
        if(res.statusCode == 200){
          await StaffService.getStaffProfileById(staffId,staffToken).then((value) => {
            setState(() {
              MyApp.storage.setItem("fullname", value.data.user.fullname);
            }),
          });
        }
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ProfileDetailScreen()),
        );
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
      controller: districtTextController,
      enabled: false,
      decoration: InputDecoration(
        labelText: "Địa chỉ",
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
        labelText: "Giới tính",
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
