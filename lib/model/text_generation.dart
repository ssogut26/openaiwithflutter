// ignore_for_file: avoid_dynamic_calls

import 'package:vexana/vexana.dart';

class TextModel extends INetworkModel<TextModel> {
  TextModel({
    this.id,
    this.object,
    this.created,
    this.model,
    this.choices,
    this.usage,
  });

  String? id;
  String? object;
  int? created;
  String? model;
  List<Choice>? choices;
  Usage? usage;

  @override
  TextModel fromJson(Map<String, dynamic> json) {
    return TextModel(
      id: json['id'] as String?,
      object: json['object'] as String?,
      created: json['created'] as int?,
      model: json['model'] as String?,
      choices: <Choice>[
        Choice(
          text: json['choices'][0]['text'] as String?,
          index: json['choices'][0]['index'] as int?,
          logprobs: json['choices'][0]['logprobs'] as Map<String, dynamic>?,
          finishReason: json['choices'][0]['finish_reason'] as String?,
        ),
      ],
      usage: Usage().fromJson(json['usage'] as Map<String, dynamic>),
    );
  }

  @override
  Map<String, dynamic>? toJson() => {
        'id': id,
        'object': object,
        'created': created,
        'model': model,
        'choices': List<dynamic>.from(choices!.map((x) => x.toJson())),
        'usage': usage!.toJson(),
      };
}

class Choice extends INetworkModel<Choice> {
  Choice({
    this.text,
    this.index,
    this.logprobs,
    this.finishReason,
  });

  String? text;
  int? index;
  dynamic? logprobs;
  String? finishReason;

  @override
  Map<String, dynamic> toJson() => {
        'text': text,
        'index': index,
        'logprobs': logprobs,
        'finish_reason': finishReason,
      };

  @override
  Choice fromJson(Map<String, dynamic> json) {
    return Choice(
      text: json['text'] as String?,
      index: json['index'] as int?,
      logprobs: json['logprobs'],
      finishReason: json['finish_reason'] as String?,
    );
  }
}

class Usage extends INetworkModel<Usage> {
  Usage({
    this.promptTokens,
    this.completionTokens,
    this.totalTokens,
  });

  int? promptTokens;
  int? completionTokens;
  int? totalTokens;

  @override
  Map<String, dynamic> toJson() => {
        'prompt_tokens': promptTokens,
        'completion_tokens': completionTokens,
        'total_tokens': totalTokens,
      };

  @override
  Usage fromJson(Map<String, dynamic> json) {
    return Usage(
      promptTokens: json['prompt_tokens'] as int,
      completionTokens: json['completion_tokens'] as int,
      totalTokens: json['total_tokens'] as int,
    );
  }
}
