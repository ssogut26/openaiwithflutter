import 'package:chatai/model/image_generation.dart';
import 'package:chatai/model/text_generation.dart';
import 'package:chatai/secrets.dart';
import 'package:dio/dio.dart';
import 'package:vexana/vexana.dart';

abstract class IOpenAiService {
  // ignore: prefer_void_to_null
  INetworkManager networkManager = NetworkManager<Null>(
    isEnableLogger: true,
    options: BaseOptions(
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${ApiKey.apiKey}',
      },
      baseUrl: 'https://api.openai.com/v1/',
    ),
  );

  Future<ImageModel?> createImage(String prompt);
  Future<TextModel?> createText(String prompt);
}

class OpenAiService extends IOpenAiService {
  final Dio _dio = Dio();

  @override
  Future<ImageModel?> createImage(String prompt) async {
    final response = await networkManager.send<ImageModel, ImageModel>(
      'images/generations',
      data: {
        'prompt': prompt,
        'n': 1,
        'size': '256x256',
      },
      parseModel: ImageModel(),
      method: RequestType.POST,
    );
    if (response.data != null) {
      return response.data;
    } else {
      return null;
    }
  }

  @override
  Future<TextModel?> createText(String prompt) async {
    final response = await networkManager.send<TextModel, TextModel>(
      'completions',
      data: {
        'model': 'text-davinci-003',
        'prompt': prompt,
        'max_tokens': 7,
        'temperature': 0,
        'top_p': 1,
        'n': 1,
        'stream': false,
        'logprobs': null,
        'stop': '\n'
      },
      parseModel: TextModel(),
      method: RequestType.POST,
    );
    if (response.data != null) {
      return response.data;
    } else {
      return null;
    }
  }

  // @override
  // Future<TextModel?> createText(String prompt) async {
  //   final response = await _dio.post(
  //     'https://api.openai.com/v1/completions',
  //     data: {
  //       'model': 'text-davinci-003',
  //       'prompt': prompt,
  //       'max_tokens': 7,
  //       'temperature': 0,
  //       'top_p': 1,
  //       'n': 1,
  //       'stream': false,
  //       'logprobs': null,
  //       'stop': '\n'
  //     },
  //     options: Options(
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer ${ApiKey.apiKey}',
  //       },
  //     ),
  //   );
  //   if (response.data != null) {
  //     return TextModel().fromJson(response.data as Map<String, dynamic>);
  //   } else {
  //     return null;
  //   }
  // }
}
