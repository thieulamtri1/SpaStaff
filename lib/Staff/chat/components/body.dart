import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:spa_and_beauty_staff/Service/firebase.dart';
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
  int staffId;
  bool loading = true;

  getData() async {
    await MyApp.storage.ready;
    staffId = MyApp.storage.getItem("staffId");
    getChatRoom();
    print("StaffID: $staffId");
  }

  initiateSearch() async {
    if (searchInput.text != "") {
      await firebaseMethod.getUserByUsername(searchInput.text).then((value) {
        setState(() {
          isSearch = true;
          //searchResult = value;
        });
      });
    }
    return;
  }

  Widget searchList() {
    return searchResult != null
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: searchResult.documents.length,
            itemBuilder: (context, index) {
              return ChatCard(
                customerId: searchResult.docs[index]["id"],
                chatRoomId: getChatRoomId(
                    int.parse(searchResult.docs[index]["id"]),
                    MyApp.storage.getItem("staffId")),
              );
            },
          )
        : Container();
  }

  getChatRoomId(int a, int b) {
    if (a > b) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  getChatRoom() async {
    await firebaseMethod.getChatRoomStream(staffId).then((value) {
      setState(() {
        chatRoomStream = value;
        loading = false;
      });
    });
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
            return ChatCard(
                customerId: snapshot
                    .data.docs[index]["chatRoomId"]
                    .toString()
                    .replaceAll("_", "")
                    .replaceAll("$staffId", ""),
                chatRoomId:
                snapshot.data.docs[index]["chatRoomId"]);
          }
        )
            : Container();
      },
    );
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
    else{
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
                        "Chats",
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
              Padding(
                padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                child: TextField(
                  controller: searchInput,
                  decoration: InputDecoration(
                    hintText: "Search...",
                    hintStyle: TextStyle(color: Colors.grey.shade400),
                    prefixIcon: IconButton(
                      icon: Icon(Icons.search),
                      color: Colors.grey.shade400,
                      iconSize: 25,
                      onPressed: () {
                        initiateSearch();
                      },
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    contentPadding: EdgeInsets.all(8),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.grey.shade100)),
                  ),
                ),
              ),
              isSearch ? searchList() : showChatRoomList(),
            ],
          ),
        ),
      );
    }


  }


}
