part of 'pokemon_list_bloc.dart';

sealed class PokemonListEvent {}

final class PokemonListFetchEvent extends PokemonListEvent {}

final class _PokemonListCreateEvent extends PokemonListEvent {
  final PokemonMiniEntity pokemon;

  _PokemonListCreateEvent({required this.pokemon});
}
