import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:spa_and_beauty_staff/Consultant/chat/components/search_widget.dart';
import 'package:spa_and_beauty_staff/Model/CustomerOfConsultant.dart';
import 'package:spa_and_beauty_staff/Service/consultant_service.dart';
import 'package:spa_and_beauty_staff/Service/firebase.dart';
import 'package:spa_and_beauty_staff/constants.dart';
import '../../../main.dart';
import 'chat_card.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  FirebaseMethod firebaseMethod = FirebaseMethod();
  Stream chatRoomStream;
  TextEditingController searchInput = TextEditingController();
  QuerySnapshot searchResult;
  bool isSearch = false;
  int consultantId;
  bool loading;

  CustomerOfConsultant customerOfConsultant = CustomerOfConsultant();
  String customerImage;
  String customerName;
  String customerPhone;
  String query = '';
  List<Datum> customerDefault;
  List<Datum> customerSearch;

  getChatRoom() async {
    loading = true;
    await MyApp.storage.ready;
    consultantId = MyApp.storage.getItem("consultantId");
    await getListCustomerOfConsultant();
    await createChatRoom();
    await firebaseMethod.getChatRoomStream(consultantId).then((value) {
      setState(() {
        chatRoomStream = value;
        loading = false;
      });
    });
  }

  getListCustomerOfConsultant() async {
    await ConsultantService.getListCustomerOfConsultant(
            MyApp.storage.getItem("consultantId"),
            MyApp.storage.getItem("token"))
        .then((value) => {
              setState(() {
                customerOfConsultant = value;
                customerDefault = value.data;
                loading = false;
              })
            });
  }

  createChatRoom() {
    for (int i = 0; i < customerOfConsultant.data.length; i++) {
      List<int> users = [
        customerOfConsultant.data[i].id,
        MyApp.storage.getItem("consultantId")
      ];
      FirebaseMethod firebaseMethod = FirebaseMethod();
      String chatRoomId =
          "${customerOfConsultant.data[i].id}_${MyApp.storage.getItem("consultantId")}";
      Map<String, dynamic> chatRoom = {
        "users": users,
        "chatRoomId": chatRoomId,
      };
      firebaseMethod.createChatRoom(chatRoomId, chatRoom);
    }
  }

  getCustomerInfo(customerId) {
    for (int i = 0; i < customerOfConsultant.data.length; i++) {
      if (customerOfConsultant.data[i].id.toString() == customerId) {
        customerName = customerOfConsultant.data[i].fullname;
        customerPhone = customerOfConsultant.data[i].phone;
        customerImage = customerOfConsultant.data[i].image;
      }
    }
    // print("customerName: " + customerName);
  }

  Widget showChatRoomList() {
    return StreamBuilder(
      stream: chatRoomStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  String customerId = snapshot.data.docs[index]["chatRoomId"]
                      .toString()
                      .replaceAll("_", "")
                      .replaceAll("$consultantId", "");
                  getCustomerInfo(customerId);
                  return ChatCard(
                    customerId: customerId,
                    chatRoomId: snapshot.data.docs[index]["chatRoomId"],
                    customerName: customerName,
                    customerPhone: customerPhone,
                    customerImage: customerImage == null
                        ? "https://huyhoanhotel.com/wp-content/uploads/2016/05/765-default-avatar.png"
                        : customerImage,
                  );
                })
            : Container();
      },
    );
  }

  Widget buildSearch() => SearchWidget(query, searchCustomer, false);

  void searchCustomer(String query) {
    final customerSearch = customerDefault.where((customer) {
      final nameLower = customer.fullname.toLowerCase();
      final searchLower = query.toLowerCase();
      return nameLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      this.customerSearch = customerSearch;
    });
  }

  @override
  void initState() {
    super.initState();
    getChatRoom();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Center(
          child: SpinKitWave(
        color: kPrimaryColor,
        size: 50,
      ));
    } else if (customerOfConsultant.data.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Chat", style: TextStyle(fontSize: 24, color: Colors.white),),
          automaticallyImplyLeading: false,
          backgroundColor: kPrimaryColor,
        ),
        body: Center(
          child: Container(
            child: Text("Chưa có khách hàng", style: TextStyle(fontSize: 18),),
          ),
        ),
      );
    } else {
      return Scaffold(
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Chat",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              buildSearch(),
              query == ""
                  ? showChatRoomList()
                  : ListView.builder(
                      itemCount: customerSearch.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final customer = customerSearch[index];

                        return ChatCard(
                          customerId: customer.id.toString(),
                          chatRoomId:
                              "${customer.id.toString()}_${MyApp.storage.getItem("consultantId")}",
                          customerImage: customer.image,
                          customerName: customer.fullname,
                          customerPhone: customer.phone,
                        );
                      },
                    ),
            ],
          ),
        ),
      );
    }
  }
}
