import 'package:depend/depend.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laa26/core/di/container.dart';
import 'package:laa26/domain/controllers/pokemon_create/pokemon_create_bloc.dart';
import 'package:laa26/domain/params/pokemon_create_params.dart';

class PokemonCreateScreen extends StatefulWidget {
  const PokemonCreateScreen({super.key});

  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PokemonCreateBloc(context.depend<RootContainer>().pokemonRepository),
      child: this,
    );
  }

  @override
  State<PokemonCreateScreen> createState() => _PokemonCreateScreenState();
}

class _PokemonCreateScreenState extends State<PokemonCreateScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _widthController;
  late final TextEditingController _heightController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _widthController = TextEditingController();
    _heightController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _widthController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  void _create() {
    context.read<PokemonCreateBloc>().add(
      PokemonCreateEvent(
        params: PokemonCreateParams(
          name: _nameController.text,
          width: double.parse(_widthController.text),
          height: double.parse(_heightController.text),
        ),
      ),
    );
  }

  void _listener(BuildContext context, PokemonCreateState state) {
    if (state is PokemonCreateLoadedtate) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pokemon')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(controller: _nameController),
            TextField(controller: _widthController),
            TextField(controller: _heightController),
            BlocConsumer<PokemonCreateBloc, PokemonCreateState>(
              listener: _listener,
              builder: (context, state) {
                return switch (state) {
                  PokemonCreateExceptionState() ||
                  PokemonCreateLoadedtate() ||
                  PokemonCreateInitialState() => ElevatedButton(
                    onPressed: _create,
                    child: Text('Create'),
                  ),
                  PokemonCreateLoadingState() => ElevatedButton(
                    onPressed: () {},
                    child: CupertinoActivityIndicator(),
                  ),
                };
              },
            ),
          ],
        ),
      ),
    );
  }
}
