import 'dart:async';
import 'dart:convert';

import 'package:laa26/core/services/http/http_service.dart';
import 'package:laa26/data/entity/pokemon_entity.dart';
import 'package:http/http.dart' as http;
import 'package:laa26/data/entity/pokemon_mini_entity.dart';
import 'package:laa26/domain/params/pokemon_create_params.dart';

class PokemonRepository {
  final HttpService _httpService;

  PokemonRepository(this._httpService) : _streamController = StreamController();

  final StreamController<PokemonEntity> _streamController;
  Stream<PokemonEntity> get stream => _streamController.stream;

  Future<List<PokemonMiniEntity>> get(int offset) async {
    final response = await _httpService.dio.get(
      '',
      queryParameters: {'limit': 60, 'offset': offset},
    );

    if (response.statusCode == 200) {
      return ((response.data as Map<String, dynamic>)['results']
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
    final response = await _httpService.dio.get('/$id/');

    if (response.statusCode == 200) {
      return PokemonEntity.fromJson(response.data as Map<String, dynamic>);
    } else {
      throw Exception();
    }
  }

  Future<void> create(PokemonCreateParams params) async {
    final PokemonEntity pokemon = PokemonEntity(
      name: params.name,
      height: params.height,
      weight: params.width,
      types: [],
    );
    _streamController.add(pokemon);
  }
}
