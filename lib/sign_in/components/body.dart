import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:http/http.dart' as http;
import 'package:spa_and_beauty_staff/Consultant/bottom_navigation/bottom_navigation.dart';
import 'package:spa_and_beauty_staff/Service/firebase.dart';

import 'package:spa_and_beauty_staff/Staff/bottom_navigation/bottom_navigation.dart';
import 'package:spa_and_beauty_staff/constants.dart';
import 'package:spa_and_beauty_staff/default_button.dart';
import 'package:spa_and_beauty_staff/form_error.dart';
import 'package:spa_and_beauty_staff/main.dart';



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
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  loginAsStaff(phone, password, tokenFCM) async{
    print("Login as STaff");
    String url = "https://swp490spa.herokuapp.com/api/public/login";
    final res = await http.post(Uri.parse(url),
        headers: {
          "accept": "application/json",
          "content-type": "application/json"
        },
        body: jsonEncode(
            {"phone": phone,
              "password": password,
              "role": "STAFF",
              "tokenFCM": tokenFCM,
            }));
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
          MyApp.storage.setItem("role", "STAFF");

          widget.isMainLogin
              ? Navigator.pushNamed(context, BottomNavigationStaff.routeName)
              : Navigator.pop(
            context,
          );
        }
        else
        {
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

  void onClickSignIn(String phone, String password, String tokenFCM) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
    }
    String url = "https://swp490spa.herokuapp.com/api/public/login";

    final res = await http.post(Uri.parse(url),
        headers: {
          "accept": "application/json",
          "content-type": "application/json"
        },
        body: jsonEncode(
            {"phone": phone,
              "password": password,
              "role": "CONSULTANT",
              "tokenFCM": tokenFCM,
            }));
    if (res.statusCode == 200) {
      jsonResponse = json.decode(res.body);
      if (jsonResponse != null) {
        setState(() {
          isLoading = false;
        });
        if (jsonResponse['errorMessage'] == null) {
          await MyApp.storage.ready;
          MyApp.storage.setItem("token", jsonResponse['jsonWebToken']);
          MyApp.storage.setItem("consultantId", jsonResponse['idAccount']);
          MyApp.storage.setItem("role", "CONSULTANT");

          widget.isMainLogin
              ? Navigator.pushNamed(context, BottomNavigationConsultant.routeName)
              : Navigator.pop(
                  context,
                );
        }
        else
          {
            if(jsonResponse['jsonWebToken'] == null){
              loginAsStaff(phone, password, tokenFCM);
            }
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


  Future showNotification(NotiTitle, NotiBody) async {
    var androidDetails = new AndroidNotificationDetails(
        "channelId", "Local Notification", "channelDescription",
        importance: Importance.high);
    var iosDetails = new IOSNotificationDetails();
    var generalNotification =
        new NotificationDetails(android: androidDetails, iOS: iosDetails);
    await flutterLocalNotificationsPlugin.show(
        0, NotiTitle, NotiBody, generalNotification);
  }

  getToken() async {
    await Firebase.initializeApp();
    _firebaseMessaging.getToken().then((value) {
      print("TokenFCM: $value");
      MyApp.storage.setItem('tokenFCM', value);
    });
  }

  getNotification() {
    var initialzationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
        InitializationSettings(android: initialzationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        showNotification(
            message['notification']['title'], message['notification']['body']);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        final data = message['data'];
        String mMessage = data['message'];
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        final data = message['data']['message'];
        String mMessage = data['message'];
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
  }

  @override
  void initState() {
    super.initState();
    getToken();
    getNotification();
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
              onClickSignIn(phoneNumber, password, MyApp.storage.getItem("tokenFCM"));
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
                onTap: () {},
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
