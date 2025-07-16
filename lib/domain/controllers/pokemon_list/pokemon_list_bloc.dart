import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:laa26/data/entity/pokemon_entity.dart';
import 'package:laa26/data/entity/pokemon_mini_entity.dart';
import 'package:laa26/data/repositories/pokemon_repository.dart';
import 'package:meta/meta.dart';

part 'pokemon_list_state.dart';
part 'pokemon_list_event.dart';

class PokemonListBloc extends Bloc<PokemonListEvent, PokemonListState> {
  PokemonListBloc(this._repository) : super(PokemonListInitialState()) {
    on<PokemonListEvent>(
      (event, emit) => switch (event) {
        PokemonListFetchEvent() => _get(event, emit),
        _PokemonListCreateEvent() => create(event, emit),
      },
    );

    _streamSubscription = _repository.stream.listen((pokemon) {
      add(_PokemonListCreateEvent(pokemon: pokemon.toMiniModel()));
    });
  }

  final PokemonRepository _repository;
  late final StreamSubscription<PokemonEntity> _streamSubscription;

  void create(_PokemonListCreateEvent event, Emitter<PokemonListState> emit) {
    if (state case PokemonListLoadedState state) {
      emit(
        PokemonListLoadedState(
          pokemons: [event.pokemon, ...state.pokemons],
          isLoading: false,
        ),
      );
    }
  }

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

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }
}
