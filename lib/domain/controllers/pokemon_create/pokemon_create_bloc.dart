import 'package:bloc/bloc.dart';
import 'package:laa26/data/repositories/pokemon_repository.dart';
import 'package:laa26/domain/params/pokemon_create_params.dart';

part 'pokemon_create_event.dart';
part 'pokemon_create_state.dart';

class PokemonCreateBloc extends Bloc<PokemonCreateEvent, PokemonCreateState> {
  PokemonCreateBloc(this._repository) : super(PokemonCreateInitialState()) {
    on<PokemonCreateEvent>(_create);
  }

  final PokemonRepository _repository;

  Future<void> _create(
    PokemonCreateEvent event,
    Emitter<PokemonCreateState> emit,
  ) async {
    emit(PokemonCreateLoadingState());
    try {
      await _repository.create(event.params);
      emit(PokemonCreateLoadedtate());
    } catch (err) {
      emit(PokemonCreateExceptionState());
    }
  }
}
