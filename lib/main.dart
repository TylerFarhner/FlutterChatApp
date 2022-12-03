// import 'package:flutter/material.dart';
// import 'package:talkjs_flutter/talkjs_flutter.dart';
// import 'package:flutter_chat_ui/flutter_chat_ui.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     final session = Session(appId: 'tDF4HOyD');

//     final me = session.getUser(
//       id: '123456',
//       name: 'Alice',
//       email: ['alice@example.com'],
//       photoUrl: 'https://talkjs.com/images/avatar-1.jpg',
//       welcomeMessage: 'Hey there! How are you? :-)',
//       role: 'default',
//     );

//     session.me = me;

//     final other = session.getUser(
//       id: '654321',
//       name: 'Sebastian',
//       email: ['Sebastian@example.com'],
//       photoUrl: 'https://talkjs.com/images/avatar-5.jpg',
//       welcomeMessage: 'Hey, how can I help?',
//       role: 'default',
//     );

//     final conversation = session.getConversation(
//       id: Talk.oneOnOneId(me.id, other.id),
//       participants: {Participant(me), Participant(other)},
//     );

//     return MaterialApp(
//       title: 'TalkJS Demo',
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('TalkJS Demo'),
//         ),
//         body: ChatBox(
//           session: session,
//           conversation: conversation,
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

// For the testing purposes, you should probably use https://pub.dev/packages/uuid.
String randomString() {
  final random = Random.secure();
  final values = List<int>.generate(16, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => const MaterialApp(
        home: MyHomePage(),
      );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<types.Message> _messages = [];
  final _user = const types.User(id: '82091008-a484-4a89-ae75-a22bf8d6f3ac');

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Chat(
          messages: _messages,
          onSendPressed: _handleSendPressed,
          user: _user,
        ),
      );

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: message.text,
    );

    _addMessage(textMessage);
  }
}