// ignore_for_file: avoid_dynamic_calls

import 'package:vexana/vexana.dart';

class ImageModel extends INetworkModel<ImageModel> {
  ImageModel({
    this.created,
    this.data,
  });

  int? created;
  final List<ImageBody>? data;

  @override
  ImageModel fromJson(Map<String, dynamic> json) {
    final jsonData = json['data'][0]['url'] as String;
    return ImageModel(
      created: json['created'] as int?,
      data: <ImageBody>[
        ImageBody(
          url: jsonData,
        ),
      ],
    );
  }

  @override
  Map<String, dynamic>? toJson() => {
        'created': created,
        'data': List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ImageBody extends INetworkModel<ImageBody> {
  ImageBody({
    this.url,
  });

  String? url;
  @override
  ImageBody fromJson(Map<String, dynamic> json) => ImageBody(
        url: json['url'] as String?,
      );

  @override
  Map<String, dynamic>? toJson() => {
        'url': url,
      };
}
