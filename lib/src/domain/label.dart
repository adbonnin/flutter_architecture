import 'package:json_annotation/json_annotation.dart';

part 'label.g.dart';

@JsonSerializable()
class Label {
  Label();

  factory Label.fromJson(Map<String, dynamic> json) => //
      _$LabelFromJson(json);

  Map<String, dynamic> toJson() => //
      _$LabelToJson(this);
}
