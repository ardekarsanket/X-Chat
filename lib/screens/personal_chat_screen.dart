import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:x_chat/screens/chat_screen.dart';

class PersonalChatScreen extends StatefulWidget {
  const PersonalChatScreen({Key? key}) : super(key: key);

  @override
  _PersonalChatScreenState createState() => _PersonalChatScreenState();
}

class _PersonalChatScreenState extends State<PersonalChatScreen> {
  List chatList = [];
  bool isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  void getAvailableChats() async {
    String uid = _auth.currentUser!.uid;

    await _firestore
        .collection('users')
        .doc(uid)
        .collection('personal')
        .get()
        .then((value) {
      setState(() {
        chatList = value.docs;
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getAvailableChats();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Chats"),
      ),
      body: isLoading
          ? Container(
              height: size.height,
              width: size.width,
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )
          : Container(
              height: 400,
              child: ListView.builder(
                itemCount: chatList.length,
                itemBuilder: (context, index) {
                  return Material(
                    elevation: 6,
                    borderRadius: BorderRadius.circular(12),
                    child: ListTile(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => ChatRoom(
                            chatRoomId: chatList[index]['id'],
                            userMap: chatList[index]['usermap'],
                          ),
                        ),
                      ),
                      leading: Icon(Icons.account_box, color: Colors.white),
                      title: Text(
                        chatList[index]['usermap']['name'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Text(chatList[index]['usermap']['email']),
                      trailing: Icon(Icons.chat, color: Colors.white),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
