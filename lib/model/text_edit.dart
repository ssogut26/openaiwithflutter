import 'package:vexana/vexana.dart';

class TextEditModel extends INetworkModel<TextEditModel> {
  TextEditModel({this.object, this.created, this.choices, this.usage});

  String? object;
  int? created;
  List<Choices>? choices;
  Usage? usage;

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['object'] = object;
    data['created'] = created;
    if (choices != null) {
      data['choices'] = choices?.map((v) => v.toJson()).toList();
    }
    if (usage != null) {
      data['usage'] = usage?.toJson();
    }
    return data;
  }

  @override
  TextEditModel fromJson(Map<String, dynamic> json) {
    return TextEditModel(
      object: json['object'] as String?,
      created: json['created'] as int?,
      choices: json['choices'] != null
          ? (json['choices'] as List)
              .map((e) => Choices().fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
      usage: json['usage'] != null
          ? Usage.fromJson(json['usage'] as Map<String, dynamic>)
          : null,
    );
  }
}

class Choices extends INetworkModel<Choices> {
  Choices({this.text, this.index});
  @override
  Choices fromJson(Map<String, dynamic> json) {
    return Choices(
      text: json['text'] as String?,
      index: json['index'] as int?,
    );
  }

  String? text;
  int? index;

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['text'] = text;
    data['index'] = index;
    return data;
  }
}

class Usage {
  Usage({this.promptTokens, this.completionTokens, this.totalTokens});

  Usage.fromJson(Map<String, dynamic> json) {
    Usage(
      promptTokens: json['prompt_tokens'] as int?,
      completionTokens: json['completion_tokens'] as int?,
      totalTokens: json['total_tokens'] as int?,
    );
  }
  int? promptTokens;
  int? completionTokens;
  int? totalTokens;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['prompt_tokens'] = promptTokens;
    data['completion_tokens'] = completionTokens;
    data['total_tokens'] = totalTokens;
    return data;
  }
}
