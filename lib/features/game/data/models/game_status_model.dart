import 'package:tictactoe_flutter/features/game/domain/enums/game_status.dart';

class GameStatusModel {
  final GameStatus value;

  const GameStatusModel({required this.value});

  factory GameStatusModel.fromJson(Map<String, dynamic> json) {
    final raw = json['value'] as String?;
    switch (raw) {
      case 'not_started':
        return const GameStatusModel(value: GameStatus.notStarted);
      case 'in_progress':
        return const GameStatusModel(value: GameStatus.inProgress);
      case 'finished':
        return const GameStatusModel(value: GameStatus.finished);
      default:
        throw ArgumentError.value(raw, 'value', 'Invalid GameStatus value');
    }
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'value': value == GameStatus.notStarted
        ? 'not_started'
        : value == GameStatus.inProgress
        ? 'in_progress'
        : 'finished',
  };

  factory GameStatusModel.fromDomain(GameStatus domain) =>
      GameStatusModel(value: domain);

  GameStatus toDomain() => value;
}
