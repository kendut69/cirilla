import 'package:json_annotation/json_annotation.dart';
import 'package:cirilla/models/setting/feature/feature.dart';

part 'setting.g.dart';

@JsonSerializable()
class Setting {
  @JsonKey(name: 'plugin_name')
  String? pluginName;

  String? language;

  @JsonKey(toJson: dataToJson)
  DataScreen? data;

  @JsonKey(fromJson: _fromFeatures)
  Features features;

  Setting({
    this.pluginName,
    this.language,
    this.data,
    required this.features,
  });

  factory Setting.fromJson(Map<String, dynamic> json) => _$SettingFromJson(json);

  Map<String, dynamic> toJson() => _$SettingToJson(this);

  static dataToJson(DataScreen? data) => data?.toJson();

  static Features _fromFeatures(dynamic json) {
    if (json is Map<String, dynamic>) {
      return Features.fromJson(json);
    }
    return Features.defaultData;
  }
}

@JsonSerializable()
class DataScreen {
  @JsonKey(toJson: dataToJson)
  Map<String, Data>? screens;

  @JsonKey(toJson: dataToJson)
  Map<String, Data>? settings;

  @JsonKey(toJson: dataToJson)
  Map<String, Data>? extraScreens;

  DataScreen({
    this.screens,
    this.settings,
    this.extraScreens,
  });

  factory DataScreen.fromJson(Map<String, dynamic> json) => _$DataScreenFromJson(json);

  Map<String, dynamic> toJson() => _$DataScreenToJson(this);

  static Map<String, dynamic> dataToJson(Map<String, Data>? json) {
    if (json == null) return {};
    final result = Map.fromEntries(json.keys.map((key) => MapEntry(key, json[key]!.toJson())));
    return result;
  }
}

@JsonSerializable()
class Data {
  @JsonKey(toJson: dataToJson,fromJson: _dataFromJson)
  Map<String, WidgetConfig>? widgets;

  @JsonKey(fromJson: _fromIds)
  List<String>? widgetIds;

  @JsonKey(defaultValue: {})
  Map<String, dynamic>? configs;

  Data({
    this.widgets,
    this.widgetIds,
    this.configs,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);

  static Map<String, dynamic> dataToJson(Map<String, WidgetConfig>? json) {
    if (json == null) return {};

    final result = Map.fromEntries(json.keys.map((key) => MapEntry(key, json[key]!.toJson())));
    return result;
  }

  static Map<String, WidgetConfig>? _dataFromJson(dynamic value) {
    if (value is Map) {
      return value.map(
        (k, e) => MapEntry(k, WidgetConfig.fromJson(e as Map<String, dynamic>)),
      );
    }
    return null;
  }

  static List<String> _fromIds(List<dynamic>? ids) {
    if (ids == null) return [];
    List<String> newIds = ids.whereType<String>().toList();
    return newIds;
  }
}

@JsonSerializable()
class WidgetConfig {
  String? id;

  String? type;

  @JsonKey(fromJson: _fromMap)
  Map<String, dynamic>? fields;

  @JsonKey(fromJson: _fromMap)
  Map<String, dynamic>? styles;

  String? layout;

  WidgetConfig({
    this.id,
    this.type,
    this.fields,
    this.styles,
    this.layout,
  });

  factory WidgetConfig.fromJson(Map<String, dynamic> json) => _$WidgetConfigFromJson(json);

  Map<String, dynamic> toJson() => _$WidgetConfigToJson(this);

  static Map<String, dynamic>? _fromMap(dynamic value) {
    if (value is Map<String, dynamic>?) {
      return value;
    }
    return {};
  }
}
