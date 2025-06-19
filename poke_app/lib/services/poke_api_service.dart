import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pokemon.dart';

class PokemonService {
  static const baseUrl = 'https://pokeapi.co/api/v2/pokemon';

  Future<List<Map<String, dynamic>>> fetchPokemonList({int limit = 50}) async {
    final url = Uri.parse('$baseUrl?limit=$limit');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data['results']);
    } else {
      throw Exception('Error al obtener lista de Pokémon');
    }
  }

  Future<Pokemon> fetchPokemonDetail(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Pokemon.fromJson(data);
    } else {
      throw Exception('Error al obtener detalle del Pokémon');
    }
  }
}
