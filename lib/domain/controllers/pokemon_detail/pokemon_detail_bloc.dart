import 'package:bloc/bloc.dart';
import 'package:laa26/data/entity/pokemon_entity.dart';
import 'package:laa26/data/repositories/pokemon_repository.dart';
import 'package:meta/meta.dart';

part 'pokemon_detail_state.dart';
part 'pokemon_detail_event.dart';

class PokemonDetailBloc extends Bloc<PokemonDetailEvent, PokemonDetailState> {
  PokemonDetailBloc(this._repository) : super(PokemonDetailInitialState()) {
    on<PokemonDetailEvent>(
      (event, emit) => switch (event) {
        PokemonDetailFetchEvent() => _getById(event, emit),
      },
    );
  }

  final PokemonRepository _repository;

  Future<void> _getById(
    PokemonDetailFetchEvent event,
    Emitter<PokemonDetailState> emit,
  ) async {
    emit(PokemonDetailLoadingState());
    try {
      final result = await _repository.getById(event.id);
      emit(PokemonDetailLoadedState(pokemon: result));
    } catch (err) {
      emit(PokemonDetailExceptionState());
    }
  }
}
