import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/bloc/pokemon_bloc.dart';
import 'bloc/pokemon_state.dart';
import 'bloc/nav_cubit.dart';

class PokedexView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('P@kedex App')),
      ),
      body: BlocBuilder<PokemonBloc, PokemonState>(
        builder: (content, state) {
          if(state is PokemonLoadInProgress) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PokemonPageLoadSuccess) {
            return GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemCount: state.pokemonListings.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => BlocProvider.of<NavCubit>(context)
                  .showPokemonDetails(state.pokemonListings[index].id),
                  child: Card(
                  child: GridTile(
                    child: Column(
                      children: [
                        Text('ID : ${state.pokemonListings[index].id.toString()}'),
                        Image.network(state.pokemonListings[index].imageUrl), 
                        Text(state.pokemonListings[index].name)
                        ]
                      ),
                    ),
                  ),
                );
              },
            );
          }else if (state is PokemonPageLoadFailed) {
            return Center(
              child: Text(state.error.toString()),
            );
          }else {
            return Container();
          }
        },
      ),
    );
  }
}