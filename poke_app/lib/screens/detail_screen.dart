import 'package:flutter/material.dart';
import '../models/pokemon.dart';
import '../theme/pokemon_detail_theme.dart';

class DetailScreen extends StatelessWidget {
  final Pokemon pokemon;

  const DetailScreen({Key? key, required this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final typeColor = PokemonDetailTheme.getTypeColor(
      pokemon.types.isNotEmpty ? pokemon.types.first : '',
    );

    return Scaffold(
      backgroundColor: typeColor,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: PokemonDetailTheme.expandedHeight,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    typeColor.withOpacity(0.9),
                    typeColor,
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.25),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12), // menos redondeado
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          pokemon.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.error, size: 80, color: Colors.white70),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Text(
                        pokemon.name.toUpperCase(),
                        style: PokemonDetailTheme.mainTitleStyle.copyWith(
                          shadows: [], // opcional: quitar sombra para más limpio
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: PokemonDetailTheme.backgroundColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                padding: PokemonDetailTheme.contentPadding,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: 8,
                        children: pokemon.types.map((type) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                            decoration: BoxDecoration(
                              color: PokemonDetailTheme.getTypeColor(type),
                              borderRadius: BorderRadius.circular(8), // menos redondeado
                              boxShadow: [
                                BoxShadow(
                                  color: PokemonDetailTheme.getTypeColor(type).withOpacity(0.3),
                                  blurRadius: 6,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Text(
                              type,
                              style: PokemonDetailTheme.typeChipTextStyle.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 24),
                      Text('Altura:', style: PokemonDetailTheme.sectionTitleStyle),
                      Text('${pokemon.height / 10} m', style: PokemonDetailTheme.statLabelStyle),
                      const SizedBox(height: 16),
                      Text('Peso:', style: PokemonDetailTheme.sectionTitleStyle),
                      Text('${pokemon.weight / 10} kg', style: PokemonDetailTheme.statLabelStyle),
                      const SizedBox(height: 24),
                      Text('Habilidades:', style: PokemonDetailTheme.sectionTitleStyle),
                      const SizedBox(height: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: pokemon.abilities.map((ability) {
                          final abilityColor = typeColor.withOpacity(0.8);
                          return Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: PokemonDetailTheme.cardBackground,
                              borderRadius: BorderRadius.circular(10), // menos redondeado
                              border: Border.all(color: abilityColor, width: 1.5),
                              boxShadow: [
                                BoxShadow(
                                  color: abilityColor.withOpacity(0.3),
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Text(
                              ability,
                              style: PokemonDetailTheme.abilityTextStyle.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
