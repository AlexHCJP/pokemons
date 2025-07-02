import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laa26/data/repositories/pokemon_repository.dart';
import 'package:laa26/domain/controllers/pokemon_detail/pokemon_detail_cubit.dart';
import 'package:laa26/domain/controllers/pokemon_list/pokemon_list_cubit.dart';
import 'package:laa26/presentation/screens/pokemon_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  late final PokemonRepository _repository = PokemonRepository();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PokemonListCubit(_repository),
        ),
        BlocProvider(
          create: (context) =>
              PokemonDetailCubit(
                  _repository
              ),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        home: PokemonListScreen(),
      ),
    );
  }
}
