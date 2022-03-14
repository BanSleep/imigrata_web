import 'package:imigrata_web/models/values_model.dart';

class MultipleSelectionModel {
  bool? requiredNew;
  List<ValuesModel>? values;
  List<String>? defaultNew;

  MultipleSelectionModel({this.requiredNew, this.values, this.defaultNew});

  MultipleSelectionModel.fromJson(Map<String, dynamic> json) {
    requiredNew = json['required'];
    if (json['values'] != null) {
      values = [];
      json['values'].forEach((v) { values!.add(ValuesModel.fromJson(v)); });
    }
    // values =
    // json['values'] != null ? ValuesModel?.fromJson(json['values']) : null;
    if (json['default'] != null) {
      defaultNew = [];
      json['default'].forEach((v) {
        defaultNew!.add(v);
      });
    }
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
