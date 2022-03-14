import 'package:imigrata_web/models/values_model.dart';

class ChoiceModel {
  bool? requiredNew;
  List<ValuesModel>? values;
  int? defaultNew;

  ChoiceModel({this.requiredNew, this.values, this.defaultNew});

  ChoiceModel.fromJson(Map<String, dynamic> json) {
    requiredNew = json['required'];
    // values = json['values'] != null ? ValuesModel?.fromJson(json['values']) : null;
    if (json['values'] != null) {
      values = [];
      json['values'].forEach((v) { values!.add(ValuesModel.fromJson(v)); });
    }
    defaultNew = json['default'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    json['required'] = requiredNew;
    if (values != null) {
      json['values'] = values!.map((v) => v.toJson()).toList();
    }
    json['default'] = defaultNew;
    return json;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}