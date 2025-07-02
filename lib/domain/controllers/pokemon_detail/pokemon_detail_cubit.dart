import 'package:bloc/bloc.dart';
import 'package:laa26/data/entity/pokemon_entity.dart';
import 'package:laa26/data/repositories/pokemon_repository.dart';
import 'package:meta/meta.dart';

part 'pokemon_detail_state.dart';

class PokemonDetailCubit extends Cubit<PokemonDetailState> {
  PokemonDetailCubit(this._repository) : super(PokemonDetailInitialState());

  final PokemonRepository _repository;

  Future<void> getById(int id) async {
    emit(PokemonDetailLoadingState());
    try {
      final result = await _repository.getById(id);
      emit(PokemonDetailLoadedState(pokemon: result));
    } catch(err) {
      emit(PokemonDetailExceptionState());
    }
  }
}
