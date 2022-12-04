import 'package:chatai/model/text_generation.dart';
import 'package:chatai/services/network.dart';
import 'package:flutter/material.dart';

class TextView extends StatefulWidget {
  const TextView({super.key});

  @override
  State<TextView> createState() => _TextViewState();
}

class _TextViewState extends State<TextView> {
  final TextEditingController _controller = TextEditingController();

  Future<String?> getTexts(String prompt) async {
    final get = OpenAiService().createText(prompt);
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
              if (_controller.text == '' || getText == '' || isLoading == false)
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
                  child: Card(
                    elevation: 2,
                    child: Text(getText),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
