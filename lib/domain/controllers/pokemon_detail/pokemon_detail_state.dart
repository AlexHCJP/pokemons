part of 'pokemon_detail_cubit.dart';

@immutable
sealed class PokemonDetailState {}

final class PokemonDetailInitialState extends PokemonDetailState {}
final class PokemonDetailLoadingState extends PokemonDetailState {}


final class PokemonDetailLoadedState extends PokemonDetailState {
  final PokemonEntity pokemon;

  PokemonDetailLoadedState({required this.pokemon });

}
final class PokemonDetailExceptionState extends PokemonDetailState {}

