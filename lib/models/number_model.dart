class NumberModel {
  bool? requiredNew;
  int? min;
  int? max;
  int? defaultNew;

  NumberModel({this.requiredNew, this.min, this.max, this.defaultNew});

  NumberModel.fromJson(Map<String, dynamic> json) {
    requiredNew = json['required'];
    min = json['min'];
    max = json['max'];
    defaultNew = json['default'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    json['required'] = requiredNew;
    json['min'] = min;
    json['max'] = max;
    json['default'] = defaultNew;
    return json;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}