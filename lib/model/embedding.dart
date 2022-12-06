import 'package:vexana/vexana.dart';

class EmbeddingModel extends INetworkModel<EmbeddingModel> {
  EmbeddingModel({this.object, this.data, this.usage});
  @override
  EmbeddingModel fromJson(Map<String, dynamic> json) {
    return EmbeddingModel(
      object: json['object'] as String?,
      data: json['data'] != null
          ? (json['data'] as List)
              .map((e) => Data().fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
      usage: json['usage'] != null
          ? Usage().fromJson(json['usage'] as Map<String, dynamic>)
          : null,
    );
  }

  String? object;
  List<Data>? data;
  Usage? usage;

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['object'] = object;
    data['data'] = this.data?.map((v) => v.toJson()).toList();
    if (usage != null) {
      data['usage'] = usage?.toJson();
    }
    return data;
  }
}

class Data extends INetworkModel<Data> {
  Data({this.object, this.embedding, this.index});
  @override
  Data fromJson(Map<String, dynamic> json) {
    return Data(
      object: json['object'] as String?,
      embedding: json['embedding'] as List<double>?,
      index: json['index'] as int?,
    );
  }

  String? object;
  List<double>? embedding;
  int? index;

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['object'] = object;
    data['embedding'] = embedding;
    data['index'] = index;
    return data;
  }
}

class Usage extends INetworkModel<Usage> {
  Usage({this.promptTokens, this.totalTokens});
  @override
  Usage fromJson(Map<String, dynamic> json) {
    return Usage(
      promptTokens: json['prompt_tokens'] as int?,
      totalTokens: json['total_tokens'] as int?,
    );
  }

  int? promptTokens;
  int? totalTokens;

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['prompt_tokens'] = promptTokens;
    data['total_tokens'] = totalTokens;
    return data;
  }
}
