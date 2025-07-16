import 'package:depend/depend.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laa26/core/bloc_observer_logger.dart';
import 'package:laa26/core/di/container.dart';
import 'package:laa26/core/di/container_factory.dart';
import 'package:laa26/core/routing/app_routes.dart';
import 'package:laa26/data/repositories/pokemon_repository.dart';
import 'package:laa26/presentation/screens/pokemon_create_screen.dart';
import 'package:laa26/presentation/screens/pokemon_detail_screen.dart';
import 'package:laa26/presentation/screens/pokemon_list_screen.dart';

void main() {
  Bloc.observer = BlocObserverLogger();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DependencyProvider(
      dependency: RootContainerFactory().create(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        initialRoute: AppRoutes.pokemons,
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) {
              switch (settings.name) {
                case AppRoutes.pokemon:
                  return PokemonDetailScreen(
                    id: settings.arguments as int,
                  ).wrappedRoute();
                case AppRoutes.pokemons:
                  return PokemonListScreen().wrappedRoute();
                case AppRoutes.pokemonCreate:
                  return PokemonCreateScreen().wrappedRoute(context);
                default:
                  return Container();
              }
            },
          );
        },
      ),
    );
  }
}

