import 'package:flutter/material.dart';
import 'package:spa_and_beauty_staff/Staff/staff_profile/change_password/change_password.dart';
import 'package:spa_and_beauty_staff/Staff/staff_profile/profile/components/profile_picture.dart';
import 'package:spa_and_beauty_staff/Staff/staff_profile/profile_detail/profile_detail_screen.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        children: [
          ProfilePic(),
          SizedBox(
            height: 30,
          ),
          ProfileMenu(
            icon: Icon(
              Icons.person_outline,
              size: 30,
              color: Color(0xFFFF7643),
            ),
            text: "Thông tin tài khoản",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileDetailScreen()),
              );
            },
          ),
          ProfileMenu(
            icon: Icon(
              Icons.security,
              size: 30,
              color: Color(0xFFFF7643),
            ),
            text: "Đổi mật khẩu",
            press: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ChangePassword()));
            },
          ),
          ProfileMenu(
            icon: Icon(
              Icons.notifications_none_outlined,
              size: 30,
              color: Color(0xFFFF7643),
            ),
            text: "Thông báo",
            press: () {},
          ),
          ProfileMenu(
            icon: Icon(
              Icons.help_outline,
              size: 30,
              color: Color(0xFFFF7643),
            ),
            text: "Trung tâm trợ giúp",
            press: () {},
          ),
          ProfileMenu(
            icon: Icon(
              Icons.logout,
              size: 30,
              color: Color(0xFFFF7643),
            ),
            text: "Đăng xuất",
            press: () {
              // MyApp.storage.deleteItem("token");
              // MyApp.storage.deleteItem("customerId");
              // Navigator.pushNamed(context, BottomNavigation.routeName);
            },
          ),
        ],
      ),
    );
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key key,
    @required this.text,
    @required this.icon,
    @required this.press,
  }) : super(key: key);

  final String text;
  final Icon icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: FlatButton(
        padding: EdgeInsets.all(15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Color(0xFFF5F6F9),
        onPressed: press,
        child: Row(
          children: [
            icon,
            SizedBox(width: 20),
            Expanded(
              child: Text(
                text,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded)
          ],
        ),
      ),
    );
  }
}
