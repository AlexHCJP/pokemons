import 'dart:convert';

import 'package:laa26/data/entity/pokemon_entity.dart';
import 'package:http/http.dart' as http;

class PokemonRepository {
  Future<List<PokemonMiniEntity>> get(int offset) async {
    final response = await http.get(
      Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=60&offset=${offset}'),
    );

    if (response.statusCode == 200) {
      return ((jsonDecode(response.body) as Map<String, dynamic>)['results']
              as List<dynamic>)
          .map((value) {
            return PokemonMiniEntity.fromJson(value);
          })
          .toList();
    } else {
      throw Exception();
    }
  }

  Future<PokemonEntity> getById(int id) async {
    final response = await http.get(
      Uri.parse('https://pokeapi.co/api/v2/pokemon/$id/'),
    );


    if (response.statusCode == 200) {
      return PokemonEntity.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    } else {
      throw Exception();
    }
  }
}
