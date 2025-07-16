import 'dart:async';

import 'package:depend/depend.dart';
import 'package:laa26/core/di/container.dart';
import 'package:laa26/core/services/http/http_service.dart';
import 'package:laa26/data/repositories/pokemon_repository.dart';

class RootContainerFactory extends DependencyFactory<RootContainer> {
  @override
  RootContainer create() {
    final httpService = HttpService.factory();

    return RootContainer(
      httpService: httpService,
      pokemonRepository: PokemonRepository(httpService),
    );
  }
}
