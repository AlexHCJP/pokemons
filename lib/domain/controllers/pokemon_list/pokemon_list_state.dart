part of 'pokemon_list_cubit.dart';

@immutable
sealed class PokemonListState {}

final class PokemonListInitialState extends PokemonListState {}

final class PokemonListLoadingState extends PokemonListState {}

final class PokemonListLoadedState extends PokemonListState {
  final List<PokemonMiniEntity> pokemons;
  final bool isLoading;

  PokemonListLoadedState( {required this.pokemons, required this.isLoading,});
}

final class PokemonListExceptionState extends PokemonListState {}

