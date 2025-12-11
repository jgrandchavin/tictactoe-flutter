import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tictactoe_flutter/features/game/domain/enums/game_status.dart';

class GameStatusConverter implements JsonConverter<GameStatus, String> {
  const GameStatusConverter();

  @override
  GameStatus fromJson(String json) {
    switch (json) {
      case 'not_started':
        return GameStatus.notStarted;
      case 'in_progress':
        return GameStatus.inProgress;
      case 'finished':
        return GameStatus.finished;
      default:
        throw ArgumentError('Unknown GameStatus: $json');
    }
  }

  @override
  String toJson(GameStatus object) {
    switch (object) {
      case GameStatus.notStarted:
        return 'not_started';
      case GameStatus.inProgress:
        return 'in_progress';
      case GameStatus.finished:
        return 'finished';
    }
  }
}
