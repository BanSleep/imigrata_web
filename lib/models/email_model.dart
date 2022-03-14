class EmailModel {
  bool? requiredNew;
  String? defaultNew;

  EmailModel({this.requiredNew, this.defaultNew});

  EmailModel.fromJson(Map<String, dynamic> json) {
    requiredNew = json['required'];
    defaultNew = json['default'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    json['required'] = requiredNew;
    json['default'] = defaultNew;
    return json;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
