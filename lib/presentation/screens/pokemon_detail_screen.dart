import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laa26/domain/controllers/pokemon_detail/pokemon_detail_cubit.dart';

class PokemonDetailScreen extends StatefulWidget {
  final int id;

  const PokemonDetailScreen({super.key, required this.id});

  @override
  State<PokemonDetailScreen> createState() => _PokemonDetailScreenState();
}

class _PokemonDetailScreenState extends State<PokemonDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PokemonDetailCubit>().getById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<PokemonDetailCubit, PokemonDetailState>(
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
