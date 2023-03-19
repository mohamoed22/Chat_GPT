import 'package:flutter/material.dart';

import '../models/chat_model.dart';
import '../services/api_services.dart';

class ChatProvider with ChangeNotifier {
  List<ChatModel> chatList = [];
  List<ChatModel> get getchatlist {
    return [...chatList];
  }

  void addusarMassege({required String mas}) {
    chatList.add(ChatModel(msg: mas, chatIndex: 0));
    notifyListeners();
  }

  Future<void> sendMassege(
      {required String mas, required String modelId}) async {
    chatList
        .addAll(await ApiService.sendMessage(message: mas, modelId: modelId));
    notifyListeners();
  }
}
