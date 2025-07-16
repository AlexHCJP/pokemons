import 'package:depend/depend.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laa26/core/di/container.dart';
import 'package:laa26/core/routing/app_routes.dart';
import 'package:laa26/data/entity/pokemon_entity.dart';
import 'package:laa26/data/entity/pokemon_mini_entity.dart';
import 'package:laa26/domain/controllers/pokemon_list/pokemon_list_bloc.dart';

class PokemonListScreen extends StatefulWidget {
  Widget wrappedRoute() {
    return BlocProvider(
      create: (context) {
        return PokemonListBloc(
          DependencyProvider.of<RootContainer>(context).pokemonRepository,
        );
      },
      child: this,
    );
  }

  @override
  State<PokemonListScreen> createState() => _PokemonListScreenState();
}

class _PokemonListScreenState extends State<PokemonListScreen> {
  @override
  void initState() {
    super.initState();
    _fetch();
  }

  void _fetch() {
    context.read<PokemonListBloc>().add(PokemonListFetchEvent());
  }

  VoidCallback _onTap(int index) => () {
    Navigator.pushNamed(context, AppRoutes.pokemon, arguments: index + 1);
  };

  void _createPokemon() {
    Navigator.of(context).pushNamed(AppRoutes.pokemonCreate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokemons'),
        actions: [IconButton(onPressed: _createPokemon, icon: Icon(Icons.add))],
        leading: Offstage(),
      ),
      body: BlocBuilder<PokemonListBloc, PokemonListState>(
        builder: (context, state) {
          return switch (state) {
            PokemonListInitialState() || PokemonListLoadingState() => Center(
              child: CupertinoActivityIndicator(),
            ),
            PokemonListLoadedState state => ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: state.pokemons.length + 1,
              itemBuilder: (context, index) {
                if (state.pokemons.length == index) {
                  return Padding(
                    padding: EdgeInsets.all(20),
                    child: ElevatedButton(
                      onPressed: _fetch,
                      child: Text('Loaded'),
                    ),
                  );
                }

                PokemonMiniEntity pokemon = state.pokemons[index];
                return ListTile(
                  onTap: _onTap(index),
                  title: Text(pokemon.name),
                );
              },
            ),
            PokemonListExceptionState() => Center(child: Text('Oops, sorry!')),
          };
        },
      ),
    );
  }
}
