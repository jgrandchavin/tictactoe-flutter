import 'package:tictactoe_flutter/features/game/domain/enums/player.dart';

class PlayerModel {
  final Player value;

  const PlayerModel({required this.value});

  factory PlayerModel.fromJson(Map<String, dynamic> json) {
    final raw = json['value'] as String?;
    switch (raw) {
      case 'x':
        return const PlayerModel(value: Player.x);
      case 'o':
        return const PlayerModel(value: Player.o);
      default:
        throw ArgumentError.value(raw, 'value', 'Invalid Player value');
    }
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'value': value == Player.x ? 'x' : 'o',
  };

  factory PlayerModel.fromDomain(Player domain) => PlayerModel(value: domain);

  Player toDomain() => value;
}
