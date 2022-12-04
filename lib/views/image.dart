import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatai/model/image_generation.dart';
import 'package:chatai/services/network.dart';
import 'package:flutter/material.dart';

class ImageView extends StatefulWidget {
  const ImageView({super.key});

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  final TextEditingController _controller = TextEditingController();

  Future<String?> getImages(String prompt) async {
    final get = OpenAiService().createImage(prompt);
    return get.then(
      (value) => ImageBody()
          .fromJson(
            value?.data?.first.toJson() ?? <String, dynamic>{},
          )
          .url,
    );
  }

  bool isLoading = false;

  void changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  String getImage = '';
  double get pagePadding => 20;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Generator'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(pagePadding),
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
                          border: OutlineInputBorder(),
                          hintText: 'Enter your prompt',
                        ),
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        onPressed: () async {
                          getImage = await getImages(_controller.text) ?? '';
                          changeLoading();
                        },
                        icon: const Icon(Icons.send),
                      ),
                    ),
                  ],
                ),
              ),
              if (_controller.text == '' || getImage == '' || isLoading == false)
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
                    child: CachedNetworkImage(
                      imageUrl: getImage,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => const Icon(
                        Icons.error,
                      ),
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
