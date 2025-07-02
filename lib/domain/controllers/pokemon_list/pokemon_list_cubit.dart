import 'package:bloc/bloc.dart';
import 'package:laa26/data/entity/pokemon_entity.dart';
import 'package:laa26/data/repositories/pokemon_repository.dart';
import 'package:meta/meta.dart';

part 'pokemon_list_state.dart';

class PokemonListCubit extends Cubit<PokemonListState> {
  PokemonListCubit(this._repository) : super(PokemonListInitialState());

  final PokemonRepository _repository;

  Future<void> get() async {
    bool isLoading = switch(state) {
      PokemonListInitialState() || PokemonListExceptionState() => false,
      PokemonListLoadingState() => true,
      PokemonListLoadedState state => state.isLoading,
    };

    if(isLoading) return;

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
    } catch (err) {
      emit(PokemonListExceptionState());
    }
  }
}
