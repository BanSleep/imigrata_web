import 'package:imigrata_web/models/settings_model.dart';
import 'package:imigrata_web/models/values_model.dart';

class FormModel {
  int? formId;
  int? formIndex;
  String? sessionId;
  String? formType;
  String? title;
  String? description;
  SettingsModel? settings;
  // List<String>? classList;
  List<ValuesModel>? classList;

  FormModel(
      {this.formId,
        this.formIndex,
      this.sessionId,
      this.formType,
      this.title,
      this.description,
      this.settings,
      this.classList});

  FormModel.fromJson(Map<String, dynamic> json) {
    formId = json['formId'];
    formIndex = json['formIndex'];
    sessionId = json['sessionId'];
    formType = json['formType'];
    title = json['title'];
    description = json['description'];
    settings = json['settings'] != null
        ? SettingsModel?.fromJson(json['settings'])
        : null;
    if (json['classList'] != null) {
      classList = [];
      json['classList'].forEach((v) {
        classList!.add(ValuesModel.fromJson(v));
      });
      // json['classList'].forEach((v) {
      //   classList!.add(v);
      // });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    json['formId'] = formId;
    json['formIndex'] = formIndex;
    json['sessionId'] = sessionId;
    json['formType'] = formType;
    json['title'] = title;
    json['description'] = description;
    if (settings != null) {
      json['settings'] = settings!.toJson();
    }
    // json['classList'] = classList;
    if (classList != null) {
      json['classList'] = classList!.map((v) => v.toJson()).toList();
    }
    return json;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
