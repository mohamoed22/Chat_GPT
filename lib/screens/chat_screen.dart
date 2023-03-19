import 'dart:developer';
import 'package:dfnmbs/provider/chat_provider.dart';
import 'package:dfnmbs/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import '../constants/constan.dart';
import '../provider/models_provider.dart';
import '../services/assts_manegmeint.dart';
import '../services/services.dart';
import '../widget/chat_widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  static const routeName = "/ChatScreen";

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _isTyping = false;
  late TextEditingController textEditingController;
  late ScrollController _controller;
  late FocusNode focusNode;
  @override
  void initState() {
    _controller = ScrollController();
    textEditingController = TextEditingController();
    focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    textEditingController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  ///List<ChatModel> chatList = [];
  @override
  Widget build(BuildContext context) {
    final modelsProvider = Provider.of<ModelsProvider>(context);
    final chatProvider = Provider.of<ChatProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(AssetsManager.logo),
        ),
        title: const Text("Wonder Boy"),
        actions: [
          IconButton(
            onPressed: () async {
              await Services.showModalSheet(context: context);
            },
            icon: const Icon(Icons.more_vert_rounded, color: Colors.white),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                  controller: _controller,
                  itemCount: chatProvider.getchatlist.length,
                  itemBuilder: (context, index) {
                    return ChatWidget(
                      msg: chatProvider.getchatlist[index].msg,
                      chatIndex: chatProvider.getchatlist[index].chatIndex,
                    );
                  }),
            ),
            if (_isTyping) ...[
              const SpinKitThreeBounce(
                color: Colors.white,
                size: 18,
              ),
            ],
            const SizedBox(
              height: 15,
            ),
            Material(
              color: cardColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        focusNode: focusNode,
                        style: const TextStyle(color: Colors.white),
                        controller: textEditingController,
                        onSubmitted: (value) async {
                          await sendMessageFCT(
                              modelsProvider: modelsProvider,
                              chatprovider: chatProvider);
                        },
                        decoration: const InputDecoration.collapsed(
                            hintText: "How can I help you",
                            hintStyle: TextStyle(color: Colors.grey)),
                      ),
                    ),
                    IconButton(
                        onPressed: () async {
                          await sendMessageFCT(
                              modelsProvider: modelsProvider,
                              chatprovider: chatProvider);
                        },
                        icon: const Icon(
                          Icons.send,
                          color: Colors.white,
                        ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _endscorol() {
    _controller.animateTo(_controller.position.maxScrollExtent,
        duration: const Duration(seconds: 2), curve: Curves.easeInOut);
  }

  Future<void> sendMessageFCT(
      {required ModelsProvider modelsProvider,
      required ChatProvider chatprovider}) async {
    if (_isTyping) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 2),
        backgroundColor: cardColor,
        content: const TextWidget(label: "NO Empty or incorrect text"),
      ));
      return;
    }
    if (textEditingController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 2),
        backgroundColor: cardColor,
        content: const TextWidget(label: "NO  Massege"),
      ));
      return;
    }
    try {
      String mas = textEditingController.text;
      setState(() {
        _isTyping = true;
        chatprovider.addusarMassege(mas: mas);
        // chatList.add(ChatModel(msg: textEditingController.text, chatIndex: 0));
        textEditingController.clear();
        focusNode.unfocus();
      });
      await chatprovider.sendMassege(
          mas: mas, modelId: modelsProvider.getCurrentModel);
      // chatList.addAll(await ApiService.sendMessage(
      //  message: textEditingController.text,
      //  modelId: modelsProvider.getCurrentModel,
      // ));
      setState(() {});
    } catch (error) {
      log("error $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: TextWidget(label: '$error'),
          backgroundColor: Colors.redAccent,
        ),
      );
    } finally {
      setState(() {
        _endscorol();
        _isTyping = false;
      });
    }
  }
}
