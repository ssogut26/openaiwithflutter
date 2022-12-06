import 'package:chatai/model/embedding.dart';
import 'package:chatai/model/image_generation.dart';
import 'package:chatai/model/text_edit.dart';
import 'package:chatai/model/text_generation.dart';
import 'package:chatai/secrets.dart';
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
  Future<TextModel?> movieToEmoji(String prompt);
  Future<TextModel?> chatBot(String prompt);
}

class OpenAiService extends IOpenAiService {
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
  Future<TextModel?> movieToEmoji(String prompt) async {
    final response = await networkManager.send<TextModel, TextModel>(
      'completions',
      data: {
        'model': 'text-davinci-003',
        'prompt': 'Convert movie titles into emoji.\n\n$prompt:',
        'max_tokens': 60,
        'temperature': 0.8,
        'top_p': 1,
        'frequency_penalty': 0,
        'presence_penalty': 0,
        'stop': ['\n']
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

  @override
  Future<TextModel?> chatBot(String prompt) async {
    final response = await networkManager.send<TextModel, TextModel>(
      'completions',
      data: {
        'model': 'text-davinci-003',
        'prompt':
            'The following is a conversation with an AI assistant. The assistant is helpful, creative, clever, and very friendly.\n\nHuman:$prompt\nAI:',
        'max_tokens': 150,
        'temperature': 0.9,
        'top_p': 1,
        'frequency_penalty': 0.0,
        'presence_penalty': 0.6,
        'stop': [' Human:', ' AI:'],
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

  @override
  Future<TextModel?> translate(
    String language,
    String prompt,
  ) async {
    final response = await networkManager.send<TextModel, TextModel>(
      'completions',
      data: {
        'model': 'text-davinci-003',
        'prompt': 'Translate this into:$language\n\n$prompt\n\n:',
        'max_tokens': 100,
        'temperature': 0.3,
        'top_p': 1,
        'frequency_penalty': 0.0,
        'presence_penalty': 0.0,
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

  Future<TextEditModel?> createEditText(String input, String instruction) async {
    final response = await networkManager.send<TextEditModel, TextEditModel>(
      'edits',
      parseModel: TextEditModel(),
      method: RequestType.POST,
      data: {
        'model': 'text-davinci-edit-001',
        'input': input,
        'instruction': instruction,
      },
    );
    if (response.data != null) {
      return response.data;
    } else {
      return null;
    }
  }

  Future<EmbeddingModel?> createEmbeddingText(
    String input,
  ) async {
    final response = await networkManager.send<EmbeddingModel, EmbeddingModel>(
      'embeddings',
      parseModel: EmbeddingModel(),
      method: RequestType.POST,
      data: {
        'model': 'text-similarity-babbage-001',
        'input': input,
      },
    );
    if (response.data != null) {
      return response.data;
    } else {
      return null;
    }
  }
}
