import 'package:chatai/model/text_generation.dart';
import 'package:chatai/services/network.dart';
import 'package:flutter/material.dart';

class MovieToEmojiView extends StatefulWidget {
  const MovieToEmojiView({super.key});

  @override
  State<MovieToEmojiView> createState() => _MovieToEmojiViewState();
}

class _MovieToEmojiViewState extends State<MovieToEmojiView> {
  final TextEditingController _controller = TextEditingController();

  Future<String?> getTexts(String prompt) async {
    final get = OpenAiService().movieToEmoji(prompt);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text Completion'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(
                height: 100,
                child: Row(
                  children: [
                    Expanded(
                      flex: 8,
                      child: TextFormField(
                        controller: _controller,
                        decoration: const InputDecoration(
                          hintText: 'Enter your prompt',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        onPressed: () async {
                          getText = await getTexts(_controller.text) ?? '';
                          changeLoading();
                        },
                        icon: const Icon(Icons.send),
                      ),
                    ),
                  ],
                ),
              ),
              if (_controller.text == '' || getText == '')
                const SizedBox(
                  height: 270,
                  child: Card(
                    elevation: 2,
                    child: Center(
                      child: Text('Waiting'),
                    ),
                  ),
                )
              else
                SizedBox(
                  height: 270,
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    elevation: 2,
                    child: Center(child: Text(getText)),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
