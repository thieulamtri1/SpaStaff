import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  int prevUserId;

  ChatMessageList() {
    return StreamBuilder(
      stream: chatMessageStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                reverse: true,
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  final bool isMe =
                      snapshot.data.docs[index]["sendBy"] == staffId;
                  final bool isSameUser =
                      prevUserId == snapshot.data.docs[index]["sendBy"];
                  prevUserId = snapshot.data.docs[index]["sendBy"];
                  return _chatBubble(
                      snapshot.data.docs[index]["message"], isMe, isSameUser);
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

  getConversationMessage() async {
    await firebaseMethod
        .getConversationMessage(widget.chatRoomId)
        .then((value) {
      setState(() {
        chatMessageStream = value;
      });
    });
  }

  getData() async {
    await MyApp.storage.ready;
    staffId = MyApp.storage.getItem("staffId");
  }

  @override
  void initState() {
    getData();
    getConversationMessage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ConversationAppBar(
          image: widget.image, name: widget.name, phone: widget.phone),
      body: Column(
        children: [
          Expanded(
            child: ChatMessageList(),
          ),
          SizedBox(height: 20),
          sendMessageArea(),
        ],
      ),
    );
  }

  sendMessageArea() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      height: 70,
      color: Colors.grey[300],
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.photo),
            iconSize: 25,
            color: Colors.blue,
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              controller: messageInput,
              decoration: InputDecoration(
                hintText: 'Send a message..',
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding:
                    EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
              ),
              textCapitalization: TextCapitalization.sentences,
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25,
            color: Theme.of(context).primaryColor,
            onPressed: () {
              sendMessage();
            },
          ),
        ],
      ),
    );
  }

  _chatBubble(String text, bool isMe, bool isSameUser) {
    if (isMe) {
      return Padding(
        padding: EdgeInsets.only(right: 20),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.topRight,
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.6,
                ),
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Text(
                  text,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            !isSameUser
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.7),
                              spreadRadius: 2,
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 15,
                          backgroundImage:
                              NetworkImage(MyApp.storage.getItem("image")),
                        ),
                      ),
                    ],
                  )
                : Container(
                    child: null,
                  ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.only(left: 20),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.topLeft,
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.6,
                ),
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Text(
                  text,
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
            !isSameUser
                ? Row(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 15,
                          backgroundImage: NetworkImage(
                              "https://www.chapter3d.com/wp-content/uploads/2020/08/anh-chan-dung.jpg"),
                        ),
                      ),
                    ],
                  )
                : Container(
                    child: null,
                  ),
          ],
        ),
      );
    }
  }
}
