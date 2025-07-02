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
}

class PokemonMiniEntity {
  final String name;
  final String url;

  PokemonMiniEntity({required this.name, required this.url});

  factory PokemonMiniEntity.fromJson(Map<String, dynamic> json) {
    return PokemonMiniEntity(name: json['name'], url: json['url']);
  }
}

class PokemonTypeEntity {
  final String name;
  final String url;

  PokemonTypeEntity({required this.name, required this.url});

  factory PokemonTypeEntity.fromJson(Map<String, dynamic> json) {
    return PokemonTypeEntity(name: json['name'], url: json['url']);
  }
}
