import 'package:flutter/material.dart';
import 'package:spa_and_beauty_staff/Service/firebase.dart';

import '../../../main.dart';
import 'conversation_appBar.dart';

class ConversationScreen extends StatefulWidget {
  final String chatRoomId;
  final String name;
  final String phone;
  final String image;

  ConversationScreen({this.chatRoomId, this.name, this.phone, this.image});

  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  FirebaseMethod firebaseMethod = FirebaseMethod();
  TextEditingController messageInput = TextEditingController();
  Stream chatMessageStream;
  int staffId;

  Widget ChatMessageList() {
    return StreamBuilder(
      stream: chatMessageStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return MessageTitle(
                      snapshot.data.documents[index].data["message"],
                      snapshot.data.documents[index].data["sendBy"] == staffId);
                },
              )
            : Container();
      },
    );
  }

  sendMessage() {
    if (messageInput.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        "message": messageInput.text,
        "sendBy": staffId,
        "time": DateTime.now().millisecondsSinceEpoch
      };
      firebaseMethod.addConversationMessage(widget.chatRoomId, messageMap);
      messageInput.text = "";
    }
  }

  @override
  void initState() {
    getData();
    firebaseMethod.getConversationMessage(widget.chatRoomId).then((value) {
      setState(() {
        chatMessageStream = value;
      });
    });
    super.initState();
  }

  getData() async {
    await MyApp.storage.ready;
    //staffId = MyApp.storage.getItem("staffId");
    staffId = 4;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ConversationAppBar(
          image: widget.image, name: widget.name, phone: widget.phone),
      body: Stack(
        children: [
          ChatMessageList(),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              height: 70,
              width: double.infinity,
              color: Colors.grey[200],
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    textInputAction: TextInputAction.newline,
                    controller: messageInput,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: "Message...",
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                    ),
                  )),
                  GestureDetector(
                    onTap: () {
                      sendMessage();
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 20),
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.grey,
                      ),
                      child: Icon(
                        Icons.send_sharp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MessageTitle extends StatelessWidget {
  final String message;
  final bool isSendByMe;

  MessageTitle(this.message, this.isSendByMe);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
            left: isSendByMe ? 0 : 24, right: isSendByMe ? 24 : 0),
        margin: EdgeInsets.symmetric(vertical: 10),
        width: MediaQuery.of(context).size.width,
        alignment: isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
          decoration: BoxDecoration(
            color: isSendByMe ? Color(0xff0084ff) : Colors.grey.shade200,
            borderRadius: isSendByMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  )
                : BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
          ),
          child: Text(
            message,
            style: TextStyle(
              color: isSendByMe ? Colors.white : Colors.black,
            ),
          ),
        ),

      ),
    );
  }
}
