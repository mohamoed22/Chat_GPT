import 'package:dfnmbs/screens/chat_screen.dart';
import 'package:flutter/material.dart';

import '../constants/constan.dart';

class StartScreem extends StatelessWidget {
  const StartScreem({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              padding: const EdgeInsets.only(top: 200, left: 50),
              child: const Text(
                "Hello My Friend",
                style: TextStyle(
                    fontFamily: "RubikIso",
                    color: Colors.greenAccent,
                    fontSize: 30),
              )),
          Padding(
            padding: const EdgeInsets.all(1),
            child: Container(
                padding: const EdgeInsets.only(bottom: 10, left: 50),
                child: ElevatedButton.icon(
                    style: ButtonStyle(
                        overlayColor:
                            const MaterialStatePropertyAll(Colors.green),
                        elevation: const MaterialStatePropertyAll(10),
                        backgroundColor:
                            MaterialStatePropertyAll(scaffoldBackgroundColor)),
                    icon: const Icon(Icons.smart_toy_outlined),
                    label: const Text("Start chatting "),
                    onPressed: () => Navigator.of(context)
                        .pushNamedAndRemoveUntil(
                            ChatScreen.routeName, (route) => true))),
          ),
          const Padding(
            padding: EdgeInsets.all(1),
            child: Center(
              child: Text(
                "power by Open AI",
                style: TextStyle(
                    fontFamily: "AmaticSC", fontSize: 15, color: Colors.green),
              ),
            ),
          )
        ],
      ),
    );
  }
}
