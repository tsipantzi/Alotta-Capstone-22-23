import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class CouponSearchOptions {
  static final _defaultDate = DateTime(0);
  final String zipCode;
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  final DateTime _endDate;

  CouponSearchOptions({
    this.zipCode = '',
    DateTime? endDate,
  }) : _endDate = endDate ?? _defaultDate;

  static DateTime _fromJson(int int) =>
      DateTime.fromMillisecondsSinceEpoch(int);
  static int _toJson(DateTime time) => time.millisecondsSinceEpoch;
}
