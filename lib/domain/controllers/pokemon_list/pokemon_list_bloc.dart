import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:laa26/data/entity/pokemon_entity.dart';
import 'package:laa26/data/repositories/pokemon_repository.dart';
import 'package:meta/meta.dart';

part 'pokemon_list_state.dart';
part 'pokemon_list_event.dart';

class PokemonListBloc extends Bloc<PokemonListFetchEvent, PokemonListState> {
  PokemonListBloc(this._repository) : super(PokemonListInitialState()) {
    on<PokemonListFetchEvent>(
      (event, emit) => switch (event) {
        PokemonListFetchEvent() => _get(event, emit),
      },
    );
  }

  final PokemonRepository _repository;

  Future<void> _get(
    PokemonListFetchEvent event,
    Emitter<PokemonListState> emit,
  ) async {
    bool isLoading = switch (state) {
      PokemonListInitialState() || PokemonListExceptionState() => false,
      PokemonListLoadingState() => true,
      PokemonListLoadedState state => state.isLoading,
    };

    if (isLoading) return;

    if (state case PokemonListLoadedState state) {
      emit(PokemonListLoadedState(pokemons: state.pokemons, isLoading: true));
    } else {
      emit(PokemonListLoadingState());
    }

    try {
   
      if (state case PokemonListLoadedState state) {
        final result = await _repository.get(state.pokemons.length);
        emit(
          PokemonListLoadedState(
            pokemons: [...state.pokemons, ...result],
            isLoading: false,
          ),
        );
      } else {
        final result = await _repository.get(0);
        emit(PokemonListLoadedState(pokemons: result, isLoading: false));
      }
    } catch (err, stackTrace) {
      print(err);
      print(stackTrace);

      emit(PokemonListExceptionState());
    }
  }
}
