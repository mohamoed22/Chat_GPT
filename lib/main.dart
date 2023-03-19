import 'package:dfnmbs/provider/chat_provider.dart';
import 'package:dfnmbs/screens/start_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'constants/constan.dart';
import 'provider/models_provider.dart';
import 'screens/chat_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx)=> ModelsProvider()),
        ChangeNotifierProvider(create: (ctx)=> ChatProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor:  scaffoldBackgroundColor,
          appBarTheme: AppBarTheme(
            color: cardColor
          )
        ),
        home: const StartScreem(),
        routes: {
         ChatScreen.routeName:(ctx) =>  const ChatScreen(),
        },
      ),
    );
  }
}

