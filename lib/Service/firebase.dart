import 'package:cloud_firestore/cloud_firestore.dart';


class FirebaseMethod{

  createChatRoom(String chatRoomId, chatRoomMap) {
    Firestore.instance
        .collection("ChatRoom")
        .document(chatRoomId)
        .setData(chatRoomMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  addConversationMessage(String chatRoomId, messageMap) {
    Firestore.instance
        .collection("ChatRoom")
        .document(chatRoomId)
        .collection("chats")
        .add(messageMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  getConversationMessage(String chatRoomId) async {
    return await Firestore.instance
        .collection("ChatRoom")
        .document(chatRoomId)
        .collection("chats")
        .orderBy("time", descending: false)
        .snapshots();
  }

  getChatRoomStream(int staffId)  async{
    return  await Firestore.instance
        .collection("ChatRoom")
        .where("users", arrayContains: staffId)
        .snapshots();
  }

  getUserById(String id) async {
    return await Firestore.instance
        .collection("users")
        .where("id", isEqualTo: id)
        .getDocuments();
  }

  getUserByUsername(String username) async {
    return await Firestore.instance
        .collection("users")
        .where("name", isEqualTo: username)
        .getDocuments();
  }

  uploadUserInfo(userInfoMap) {
    Firestore.instance.collection("users").add(userInfoMap);
  }

}