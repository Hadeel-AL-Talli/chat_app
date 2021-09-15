
import 'package:chat_app/ui/auth/data/AuthHelper.dart';
import 'package:chat_app/ui/auth/data/ChatFirestoreHelper.dart';
import 'package:chat_app/ui/auth/models/MessageModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ChatProvider extends ChangeNotifier {
  PageController pageController = PageController();
  String getMyId() {
    return AuthHelper.authHelper.getUserId();
  }

  int currentPageIndex = 0;
  changePageIndex(int newIndex) {
    pageController.jumpToPage(newIndex);
    this.currentPageIndex = newIndex;
    notifyListeners();
  }

  TextEditingController messageController = TextEditingController();

  sendMessage() {
    MessageModel messageModel =
    MessageModel(messageController.text, AuthHelper.authHelper.getUserId());
    ChatFirestoreHelper.dataFirestoreHelper.sendMessage(messageModel);
    messageController.clear();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getStream() {
    return ChatFirestoreHelper.dataFirestoreHelper.getChatStream();
  }
}
