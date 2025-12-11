import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tictactoe_flutter/features/game/domain/enums/player.dart';

class PlayerConverter implements JsonConverter<Player, String> {
  const PlayerConverter();

  @override
  Player fromJson(String json) {
    switch (json) {
      case 'x':
        return Player.x;
      case 'o':
        return Player.o;
      default:
        throw ArgumentError('Unknown Player: $json');
    }
  }

  @override
  String toJson(Player object) {
    switch (object) {
      case Player.x:
        return 'x';
      case Player.o:
        return 'o';
    }
  }
}
