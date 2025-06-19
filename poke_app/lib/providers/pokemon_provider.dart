import 'package:flutter/material.dart';
import '../models/pokemon.dart';
import '../services/poke_api_service.dart';

class PokemonProvider extends ChangeNotifier {
  final PokemonService _service = PokemonService();

  List<Pokemon> _pokemons = [];
  List<Pokemon> _filteredPokemons = [];
  bool _loading = false;

  List<Pokemon> get pokemons => _pokemons;
  List<Pokemon> get filteredPokemons => _filteredPokemons;
  bool get loading => _loading;

  Future<void> loadPokemons({int limit = 50}) async {
    _loading = true;
    notifyListeners();

    try {
      final list = await _service.fetchPokemonList(limit: limit);
      List<Pokemon> tempList = [];

      // Carga detallada (puedes paralelizar para mejorar velocidad)
      for (var item in list) {
        final detail = await _service.fetchPokemonDetail(item['url']);
        tempList.add(detail);
      }

      _pokemons = tempList;
      _filteredPokemons = tempList;
    } catch (e) {
      print('Error cargando pokemons: $e');
    }

    _loading = false;
    notifyListeners();
  }

  void search(String query) {
    if (query.isEmpty) {
      _filteredPokemons = _pokemons;
    } else {
      _filteredPokemons = _pokemons
          .where((p) => p.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}
