import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_1.dart';
import 'package:provider/provider.dart';

import '../../auth/models/MessageModel.dart';
import '../../auth/providers/ChatProvider.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Expanded(
          child: Container(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: Provider.of<ChatProvider>(context).getStream(),
              builder: (context, querySnapshot) {
                if (querySnapshot.hasData) {
                  /// get the docuemnts from stream
                  List<QueryDocumentSnapshot<Map<String, dynamic>>> documents =
                      querySnapshot.data.docs;

                  /// convert the documents to messageModels
                  List<MessageModel> messages = documents
                      .map((e) => MessageModel.fromMap(e.data()))
                      .toList();
                  // messages.sort((a, b) => a.timeStamp.compareTo(b.timeStamp));

                  /// convert list of messageModels to list of widgets
                  List<Widget> widgets = messages.map((e) {
                    return e.senderId ==
                        Provider.of<ChatProvider>(context, listen: false)
                            .getMyId()
                        ? ChatBubble(
                      clipper:
                      ChatBubbleClipper1(type: BubbleType.sendBubble),
                      alignment: Alignment.topRight,
                      margin: EdgeInsets.only(top: 20),
                      backGroundColor: Colors.blue,
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth:
                          MediaQuery.of(context).size.width * 0.7,
                        ),
                        child: Text(
                          e.content,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                        : ChatBubble(
                      clipper: ChatBubbleClipper1(
                          type: BubbleType.receiverBubble),
                      backGroundColor: Color(0xffE7E7ED),
                      margin: EdgeInsets.only(top: 20),
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth:
                          MediaQuery.of(context).size.width * 0.7,
                        ),
                        child: Text(
                          e.content,
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    );
                  }).toList();

                  /// return the build widget
                  return ListView(
                    children: widgets,
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller:
                  Provider.of<ChatProvider>(context).messageController,
                  decoration: InputDecoration(
                      fillColor: Colors.grey[300],
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
              ),
              Container(
                  padding: EdgeInsets.all(7),
                  margin: EdgeInsets.only(left: 5),
                  decoration: BoxDecoration(
                      color: Colors.lightBlue,
                      borderRadius: BorderRadius.circular(15)),
                  child: IconButton(
                      onPressed: () {
                        Provider.of<ChatProvider>(context, listen: false)
                            .sendMessage();
                      },
                      icon: Icon(Icons.send,color: Colors.white,)))
            ],
          ),
        )
      ],
    );
  }
}
