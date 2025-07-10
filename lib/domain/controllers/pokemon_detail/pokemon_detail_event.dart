part of 'pokemon_detail_bloc.dart';

sealed class PokemonDetailEvent {}

final class PokemonDetailFetchEvent extends PokemonDetailEvent {
  final int id;

  PokemonDetailFetchEvent(this.id);
}
