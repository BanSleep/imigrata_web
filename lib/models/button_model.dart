class ButtonModel {
  String? content;

  ButtonModel({this.content});

  ButtonModel.fromJson(Map<String, dynamic> json) {
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    json['content'] = content;
    return json;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}