class ValuesModel {
  String? id;
  String? name;

  ValuesModel({this.id, this.name});

  ValuesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    json['id'] = id;
    json['name'] = name;
    return json;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}