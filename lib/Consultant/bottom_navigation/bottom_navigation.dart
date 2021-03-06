import 'package:flutter/material.dart';
import 'package:spa_and_beauty_staff/Consultant/chat/chat_screen.dart';
import 'package:spa_and_beauty_staff/Consultant/consultant_profile/profile/profile_screen.dart';
import 'package:spa_and_beauty_staff/Consultant/following/following_screen.dart';
import 'package:spa_and_beauty_staff/Consultant/notification/notification_screen.dart';
import 'package:spa_and_beauty_staff/Consultant/schedule/schedule_screen.dart';
import 'package:spa_and_beauty_staff/constants.dart';
import 'package:spa_and_beauty_staff/size_config.dart';

class BottomNavigationConsultant extends StatefulWidget {
  static String routeName = "/bottom_navigation_consultant";
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigationConsultant> {

  int selectedIndex = 0;
  List<Widget> widgetOptions = <Widget>[
    ConsultantScheduleScreen(),
    ConsultantChatScreen(),
    ConsultantNotificationScreen(),
    ConsultantFollowingScreen(),
    ConsultantProfileScreen(),
  ];

  void  onBottomNavigationItemSelect(int index){
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(

      body: Center(
        child: widgetOptions.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type : BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey,
        selectedItemColor: kPrimaryColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.calendar_today_outlined,
            ),
            title: Text("Lịch"),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.chat,
            ),
            title: Text("Chat"),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications_none_outlined,
            ),
            title: Text("Thông báo"),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.assignment_outlined,
            ),
            title: Text("Theo dõi"),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline,
            ),
            title: Text("Tài khoản"),
          ),
        ],
        currentIndex: selectedIndex,
        onTap: onBottomNavigationItemSelect,
      ),
    );
  }
}
