
import 'package:depend/depend.dart';
import 'package:laa26/data/repositories/pokemon_repository.dart';

class RootContainer extends DependencyContainer {
  final PokemonRepository pokemonRepository;

  RootContainer({required this.pokemonRepository});
}
