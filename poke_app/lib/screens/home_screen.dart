import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/pokemon_provider.dart';
import 'detail_screen.dart';
import '../theme/home_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<PokemonProvider>(context, listen: false);
    provider.loadPokemons(limit: 50);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(
              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/items/poke-ball.png',
              height: 24,
              width: 24,
            ),
            const SizedBox(width: 8),
            const Text('Pokemon App'),
          ],
        ),
        centerTitle: true,
      ),
      body: Consumer<PokemonProvider>(
        builder: (context, provider, _) {
          if (provider.loading) {
            return HomeTheme.loadingIndicator;
          }

          if (provider.filteredPokemons.isEmpty) {
            return HomeTheme.emptyState;
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  decoration: HomeTheme.searchFieldDecoration,
                  child: TextField(
                    decoration: HomeTheme.searchInputDecoration,
                    onChanged: provider.search,
                  ),
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding: HomeTheme.gridPadding,
                  gridDelegate: HomeTheme.gridDelegate,
                  itemCount: provider.filteredPokemons.length,
                  itemBuilder: (context, index) {
                    final pokemon = provider.filteredPokemons[index];
                    final typeColor =
                    HomeTheme.getTypeColor(pokemon.types.isNotEmpty ? pokemon.types.first : '');

                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailScreen(pokemon: pokemon),
                          ),
                        );
                      },
                      child: Container(
                        decoration: HomeTheme.pokemonCardDecoration(typeColor),
                        padding: HomeTheme.cardPadding,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Imagen cuadrada
                            Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white.withOpacity(0.3),
                              ),
                              child: Image.network(
                                pokemon.imageUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.error),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              pokemon.name.toUpperCase(),
                              style: HomeTheme.pokemonNameStyle,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 6),
                            Wrap(
                              spacing: 4,
                              children: pokemon.types.map((type) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: HomeTheme.typeChipDecoration,
                                  child: Text(
                                    type,
                                    style: HomeTheme.typeTextStyle,
                                  ),
                                );
                              }).toList(),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
