import 'package:laa26/data/entity/pokemon_mini_entity.dart';

class PokemonEntity {
  final String name;
  final double height;
  final double weight;
  final List<PokemonTypeEntity> types;

  PokemonEntity({
    required this.name,
    required this.height,
    required this.weight,
    required this.types,
  });

  factory PokemonEntity.fromJson(Map<String, dynamic> json) {
    return PokemonEntity(
      name: json['name'],
      height: (json['height'] as num).toDouble(),
      weight: (json['weight'] as num).toDouble(),
      types: (json['types'] as List<dynamic>)
          .map((type) => PokemonTypeEntity.fromJson(type['type']))
          .toList(),
    );
  }

  PokemonMiniEntity toMiniModel() {
    return PokemonMiniEntity(name: name, url: '1');
  }
}
