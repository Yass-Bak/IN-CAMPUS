import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../helper/hexColors.dart';
import '../../helper/contrast.dart';
import '../../models/messages.dart';
import '../../widgets/chat_buble.dart';

class ChatPage extends StatefulWidget {
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _controller = ScrollController();

  CollectionReference messages = FirebaseFirestore.instance.collection(kMessagesCollections);

  final user = FirebaseAuth.instance.currentUser!;
  String MessageData = '';
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messagesList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
          }

          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: HexColor.fromHex('2F2E41'),
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/HomeScreen');
                    // do something
                  },
                )
              ],
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    kLogo,
                    height: 40,
                    width: 40,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('IN-CAMPUS CHAT', textAlign: TextAlign.center),
                ],
              ),
              centerTitle: true,
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      reverse: true,
                      controller: _controller,
                      itemCount: messagesList.length,
                      itemBuilder: (context, index) {
                        return messagesList[index].id == user.email.toString()
                            ? ChatBuble(
                                message: messagesList[index],
                              )
                            : ChatBubleForFriend(message: messagesList[index]);
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (data) {
                      MessageData = data;

                      if (MessageData == '') {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(backgroundColor: HexColor.fromHex('2F88FF'), duration: Duration(seconds: 1), content: Text('Le Message ne peut pas etre vide')));
                      } else {
                        messages.add(
                          {kMessage: MessageData, kCreatedAt: DateTime.now(), 'id': user.email.toString()},
                        );
                        controller.clear();
                        _controller.animateTo(0, duration: Duration(milliseconds: 500), curve: Curves.easeIn);
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'Send Message',
                      suffixIcon: InkWell(
                        onTap: () {
                          MessageData = controller.text.trim();
                          if (MessageData == '') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(backgroundColor: HexColor.fromHex('2F88FF'), duration: Duration(seconds: 1), content: Text('Le Message ne peut pas etre vide')),
                            );
                          } else {
                            messages.add(
                              {kMessage: MessageData, kCreatedAt: DateTime.now(), 'id': user.email.toString()},
                            );
                            controller.clear();
                            _controller.animateTo(0, duration: Duration(milliseconds: 500), curve: Curves.easeIn);
                          }
                        },
                        child: Icon(
                          Icons.send,
                          color: HexColor.fromHex('2F88FF'),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: HexColor.fromHex('2F88FF'),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
