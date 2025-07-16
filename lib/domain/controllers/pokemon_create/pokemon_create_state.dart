part of 'pokemon_create_bloc.dart';

sealed class PokemonCreateState {}

final class PokemonCreateInitialState extends PokemonCreateState {}
final class PokemonCreateLoadingState extends PokemonCreateState {}
final class PokemonCreateLoadedtate extends PokemonCreateState {}
final class PokemonCreateExceptionState extends PokemonCreateState {}

