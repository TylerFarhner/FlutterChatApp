import 'package:flutter/material.dart';
import 'package:talkjs_flutter/talkjs_flutter.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final session = Session(appId: 'tDF4HOyD');

    final me = session.getUser(
      id: '123456',
      name: 'Alice',
      email: ['alice@example.com'],
      photoUrl: 'https://talkjs.com/images/avatar-1.jpg',
      welcomeMessage: 'Hey there! How are you? :-)',
      role: 'default',
    );

    session.me = me;

    final other = session.getUser(
      id: '654321',
      name: 'Sebastian',
      email: ['Sebastian@example.com'],
      photoUrl: 'https://talkjs.com/images/avatar-5.jpg',
      welcomeMessage: 'Hey, how can I help?',
      role: 'default',
    );

    final conversation = session.getConversation(
      id: Talk.oneOnOneId(me.id, other.id),
      participants: {Participant(me), Participant(other)},
    );

    return MaterialApp(
      title: 'TalkJS Demo',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('TalkJS Demo'),
        ),
        body: ChatBox(
          session: session,
          conversation: conversation,
        ),
      ),
    );
  }
}