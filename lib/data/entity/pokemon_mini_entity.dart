
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