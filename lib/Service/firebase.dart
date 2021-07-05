import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseMethod{

  createChatRoom(String chatRoomId, chatRoomMap) {
    FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomId)
        .set(chatRoomMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  addConversationMessage(String chatRoomId, messageMap) {
    FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .add(messageMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  getConversationMessage(String chatRoomId) async {
    await Firebase.initializeApp();
    return await FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy("time", descending: false)
        .snapshots();
  }

  getChatRoomStream(int staffId)  async{
    await Firebase.initializeApp();
    return  await FirebaseFirestore.instance
        .collection("ChatRoom")
        .where("users", arrayContains: staffId)
        .snapshots();
  }

  getUserById(String id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("id", isEqualTo: id)
        .get();
  }

  getUserByUsername(String username) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("name", isEqualTo: username)
        .get();
  }

  uploadUserInfo(userInfoMap) {
    FirebaseFirestore.instance.collection("users").add(userInfoMap);
  }

}