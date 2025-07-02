import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laa26/data/entity/pokemon_entity.dart';
import 'package:laa26/domain/controllers/pokemon_list/pokemon_list_cubit.dart';
import 'package:laa26/presentation/screens/pokemon_detail_screen.dart';

class PokemonListScreen extends StatefulWidget {
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
    context.read<PokemonListCubit>().get();
  }

  VoidCallback _onTap(int index) => () {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PokemonDetailScreen(id: index + 1),
      ),
    );
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PokemonListCubit, PokemonListState>(
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
