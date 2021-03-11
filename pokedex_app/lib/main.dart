import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/app_navigator.dart';
import 'package:pokedex_app/bloc/nav_cubit.dart';
import 'package:pokedex_app/bloc/pokemon_bloc.dart';
import 'package:pokedex_app/bloc/pokemon_details_cubit.dart';
import 'package:pokedex_app/bloc/pokemon_event.dart';
import 'package:pokedex_app/pokedex_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pokemonDetailsCubit = PokemonDetailsCubit();
    return MaterialApp(
      theme: Theme.of(context)
          .copyWith(primaryColor: Colors.teal, accentColor: Colors.tealAccent),
      home: MultiBlocProvider(providers: [
        BlocProvider(
          create: (context) => 
            PokemonBloc()..add(PokemonPageRequest(page: 0))),
            BlocProvider(
            create: (context) => 
                NavCubit(pokemonDetailsCubit: pokemonDetailsCubit)),
                BlocProvider(create: (context) => pokemonDetailsCubit)
      ], child: AppNavigator()),
    );
  }
}