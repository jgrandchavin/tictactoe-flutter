import 'package:freezed_annotation/freezed_annotation.dart';

part 'position.freezed.dart';

@freezed
abstract class Position with _$Position {
  factory Position({@Default(0) int row, @Default(0) int column}) = _Position;
}
