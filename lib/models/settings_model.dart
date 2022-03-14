import 'package:imigrata_web/models/phone_model.dart';
import 'package:imigrata_web/models/text_model.dart';

import 'button_model.dart';
import 'choice_model.dart';
import 'dropdown_model.dart';
import 'email_model.dart';
import 'multiple_selection_model.dart';
import 'number_model.dart';

class SettingsModel {
  ButtonModel? button;
  ChoiceModel? choice;
  MultipleSelectionModel? multipleSelection;
  DropdownModel? dropdown;
  PhoneModel? phone;
  EmailModel? email;
  NumberModel? number;
  TextModel? text;

  SettingsModel(
      {this.button,
        this.choice,
        this.multipleSelection,
        this.dropdown,
        this.phone,
        this.email,
        this.number,
        this.text});

  SettingsModel.fromJson(Map<String, dynamic> json) {
    button =
    json['button'] != null ? ButtonModel?.fromJson(json['button']) : null;
    choice =
    json['choice'] != null ? ChoiceModel?.fromJson(json['choice']) : null;
    multipleSelection = json['multipleSelection'] != null
        ? MultipleSelectionModel?.fromJson(json['multipleSelection'])
        : null;
    dropdown = json['dropdown'] != null
        ? DropdownModel?.fromJson(json['dropdown'])
        : null;
    phone = json['phone'] != null ? PhoneModel?.fromJson(json['phone']) : null;
    email = json['email'] != null ? EmailModel?.fromJson(json['email']) : null;
    number =
    json['number'] != null ? NumberModel?.fromJson(json['number']) : null;
    text = json['text'] != null ? TextModel?.fromJson(json['text']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    if (button != null) {
      json['button'] = button!.toJson();
    }
    if (choice != null) {
      json['choice'] = choice!.toJson();
    }
    if (multipleSelection != null) {
      json['multipleSelection'] = multipleSelection!.toJson();
    }
    if (dropdown != null) {
      json['dropdown'] = dropdown!.toJson();
    }
    if (phone != null) {
      json['phone'] = phone!.toJson();
    }
    if (email != null) {
      json['email'] = email!.toJson();
    }
    if (number != null) {
      json['number'] = number!.toJson();
    }
    if (text != null) {
      json['text'] = text!.toJson();
    }
    return json;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
