import 'package:chatai/model/text_generation.dart';
import 'package:chatai/services/network.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class ChatMessage {
  ChatMessage({
    required this.messageContent,
    required this.messageType,
  });
  String? messageContent;
  String? messageType;
}

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final TextEditingController _controller = TextEditingController();

  Future<String?> chat(String prompt) async {
    final get = OpenAiService().chatBot(prompt);
    return get.then(
      (value) => Choice()
          .fromJson(
            value?.choices?.first.toJson() ?? <String, dynamic>{},
          )
          .text,
    );
  }

  bool isLoading = false;

  void changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  String getText = '';
  List<ChatMessage>? messages = [
    ChatMessage(
      messageContent: 'Hi, I am ChatBot. How can I help you?',
      messageType: 'receiver',
    )
  ];
  List<DateTime> dates = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Bot'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 50),
              height: context.isKeyBoardOpen
                  ? context.dynamicHeight(0.30)
                  : context.dynamicHeight(0.75),
              child: ListView.builder(
                itemCount: messages?.length,
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    padding:
                        const EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
                    child: Align(
                      alignment: messages?[index].messageType == 'receiver'
                          ? Alignment.topLeft
                          : Alignment.topRight,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: messages?[index].messageType == 'receiver'
                              ? Colors.grey.shade200
                              : Colors.blue[200],
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          messages?[index].messageContent ?? '',
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
                height: 60,
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: const InputDecoration(
                          hintText: 'Write message...',
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    FloatingActionButton(
                      onPressed: () async {
                        if (_controller.text.isNotEmpty) {
                          setState(() {
                            messages?.add(
                              ChatMessage(
                                messageContent: _controller.text,
                                messageType: 'sender',
                              ),
                            );
                            messages?.add(
                              ChatMessage(
                                messageContent: getText,
                                messageType: 'receiver',
                              ),
                            );
                            _controller.clear();
                          });
                          getText = await chat(_controller.text) ?? '';
                        }
                      },
                      backgroundColor: Colors.blue,
                      elevation: 0,
                      child: const Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
