import 'package:depend/depend.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laa26/core/di/container.dart';
import 'package:laa26/domain/controllers/pokemon_detail/pokemon_detail_bloc.dart';
import 'package:laa26/main.dart';

class PokemonDetailScreen extends StatefulWidget {
  final int id;

  const PokemonDetailScreen({super.key, required this.id});

  Widget wrappedRoute() {
    return BlocProvider(
      create: (context) => PokemonDetailBloc(
        DependencyProvider.of<RootContainer>(context).pokemonRepository,
      ),
      child: this,
    );
  }

  @override
  State<PokemonDetailScreen> createState() => _PokemonDetailScreenState();
}

class _PokemonDetailScreenState extends State<PokemonDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PokemonDetailBloc>().add(PokemonDetailFetchEvent(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<PokemonDetailBloc, PokemonDetailState>(
        builder: (context, state) {
          return switch (state) {
            PokemonDetailInitialState() || PokemonDetailLoadingState() =>
              Center(child: CupertinoActivityIndicator()),
            PokemonDetailExceptionState() => Center(
              child: Text('Oops, sorry!'),
            ),
            PokemonDetailLoadedState state => Column(
              children: [
                Text(state.pokemon.name),
                Text(state.pokemon.height.toString()),
                Text(state.pokemon.weight.toString()),
                Divider(),
                ...state.pokemon.types.map((value) {
                  return Text(value.name);
                }),
              ],
            ),
          };
        },
      ),
    );
  }
}
