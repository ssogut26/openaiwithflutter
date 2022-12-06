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

class TranslateView extends StatefulWidget {
  const TranslateView({super.key});

  @override
  State<TranslateView> createState() => _TranslateViewState();
}

class _TranslateViewState extends State<TranslateView> {
  final TextEditingController _controller = TextEditingController();

  Future<String?> chat(String language, String prompt) async {
    final get = OpenAiService().translate(language, prompt);
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
  TextEditingController languageController = TextEditingController();
  List<ChatMessage>? messages = [
    ChatMessage(
      messageContent: 'Hi, I am translator. Give me a sentence to translate.',
      messageType: 'receiver',
    )
  ];
  List<DateTime> dates = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Translator'),
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
                    Expanded(
                      flex: 2,
                      child: TextField(
                        controller: languageController,
                        decoration: const InputDecoration(
                          hintText: 'Language',
                          hintStyle: TextStyle(color: Colors.red),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      flex: 5,
                      child: TextField(
                        controller: _controller,
                        decoration: const InputDecoration(
                          hintText: 'Write a sentence...',
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
                            languageController.clear();
                          });
                          getText =
                              await chat(languageController.text, _controller.text) ?? '';
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
