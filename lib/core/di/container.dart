import 'package:depend/depend.dart';
import 'package:laa26/core/services/http/http_service.dart';
import 'package:laa26/data/repositories/pokemon_repository.dart';

class RootContainer extends DependencyContainer {
  final PokemonRepository pokemonRepository;
  final HttpService httpService;

  RootContainer({required this.pokemonRepository, required this.httpService,});
}
