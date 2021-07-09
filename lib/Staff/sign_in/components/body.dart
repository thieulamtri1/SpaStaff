import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:spa_and_beauty_staff/Service/firebase.dart';

import 'package:spa_and_beauty_staff/Staff/bottom_navigation/bottom_navigation.dart';

import '../../../constants.dart';
import '../../../default_button.dart';
import '../../../form_error.dart';
import '../../../main.dart';
import 'package:spa_and_beauty_staff/Service/staff_service.dart';



class Body extends StatelessWidget {

  final bool isMainLogin;

  const Body({Key key, @required this.isMainLogin}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 50),
                Text(
                  "Chào mừng bạn trở lại",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 50),
                SignForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SignForm extends StatefulWidget {
  final bool isMainLogin = true;

  const SignForm({
    Key key,
  }) : super(key: key);

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  String phoneNumber;
  String password;
  final List<String> errors = [];
  FirebaseMethod firebaseMethod = FirebaseMethod();
  var jsonResponse;

  void onClickSignIn(String phone, String password) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
    }

    String url = "https://swp490spa.herokuapp.com/api/public/login";

    final res = await http.post(Uri.parse(url),
        headers: {
          "accept": "application/json",
          "content-type": "application/json"
        },
        body: jsonEncode(  {"phone": phone, "password": password, "role": "CONSULTANT"} ));

    if (res.statusCode == 200) {
      jsonResponse = json.decode(res.body);
      if (jsonResponse != null) {
        setState(() {
          isLoading = false;
        });
        if (jsonResponse['errorMessage'] == null) {
          await MyApp.storage.ready;
          MyApp.storage.setItem("token", jsonResponse['jsonWebToken']);
          MyApp.storage.setItem("staffId", jsonResponse['idAccount']);

          setUser();


          if(MyApp.storage.getItem("image") == null){
            MyApp.storage.setItem("image", "https://huyhoanhotel.com/wp-content/uploads/2016/05/765-default-avatar.png");
          }
          print("Image nè: ${MyApp.storage.getItem("image")}");

          widget.isMainLogin
              ? Navigator.pushNamed(context, BottomNavigation.routeName)
              : Navigator.pop(context, );
        } else {
          if (jsonResponse['errorCode'] == 1 &&
              !errors.contains(kWrongPhoneNumberError)) {
            errors.add(kWrongPhoneNumberError);
          }
          if (jsonResponse['errorCode'] == 2 &&
              !errors.contains(kInvalidPasswordError)) {
            errors.add(kInvalidPasswordError);
            errors.remove(kWrongPhoneNumberError);
          }
        }
      }
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  setUser() async{
    await StaffService.getStaffProfileById(MyApp.storage.getItem("staffId"), MyApp.storage.getItem("token")).then((staff) => {
      setState(() {
        MyApp.storage.setItem("fullname", staff.data.user.fullname);
        MyApp.storage.setItem("phone", staff.data.user.phone);
        MyApp.storage.setItem("password", staff.data.user.password);
        MyApp.storage.setItem("gender", staff.data.user.gender);
        MyApp.storage.setItem("birthdate", staff.data.user.birthdate);
        MyApp.storage.setItem("email", staff.data.user.email);
        MyApp.storage.setItem("image", staff.data.user.image);
        MyApp.storage.setItem("address", staff.data.user.address);
      }),
    });
  }

  setEmployee(){

  }

  setSpa(){

  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildPhoneFormField(),
          SizedBox(height: 20),
          buildPasswordFormField(),
          SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: Text(
              "QUÊN MẬT KHẨU?",
              textAlign: TextAlign.right,
              style: TextStyle(decoration: TextDecoration.underline),
            ),
          ),
          SizedBox(height: 20),
          FormError(errors: errors),
          SizedBox(height: 50),
          DefaultButton(
            text: "Đăng nhập",
            press: () {
              onClickSignIn(phoneNumber, password);
            },
          ),
          SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Chưa có tài khoản?",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              GestureDetector(
                onTap: (){},
                child: Text(
                  "Đăng ký ngay.",
                  style: TextStyle(
                    fontSize: 16,
                    color: kPrimaryColor,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  TextFormField buildPhoneFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => phoneNumber = newValue,
      onChanged: (value) {
        phoneNumber = value;
        if (value.isNotEmpty && errors.contains(kPhoneNumberNullError)) {
          setState(() {
            errors.remove(kPhoneNumberNullError);
          });
        }
      },
      validator: (value) {
        if (value.isEmpty && !errors.contains(kPhoneNumberNullError)) {
          setState(() {
            errors.add(kPhoneNumberNullError);
          });
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "Số điện thoại",
          hintText: "Nhập số điện thoại",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.phone)),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        password = value;
        if (value.isNotEmpty && errors.contains(kPasswordNullError)) {
          setState(() {
            errors.remove(kPasswordNullError);
          });
        }
      },
      validator: (value) {
        if (value.isEmpty && !errors.contains(kPasswordNullError)) {
          setState(() {
            errors.add(kPasswordNullError);
          });
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "Mật khẩu",
          hintText: "Nhập mật khẩu",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.lock_outline)),
    );
  }
}
