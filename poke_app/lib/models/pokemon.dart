class Pokemon {
  final String name;
  final String imageUrl;
  final List<String> types;
  final int height;
  final int weight;
  final List<String> abilities;

  Pokemon({
    required this.name,
    required this.imageUrl,
    required this.types,
    required this.height,
    required this.weight,
    required this.abilities,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      name: json['name'] ?? '',
      imageUrl: json['sprites']?['front_default'] ?? '',
      types: (json['types'] as List<dynamic>? ?? [])
          .map((typeInfo) => typeInfo['type']['name'] as String)
          .toList(),
      height: json['height'] ?? 0,
      weight: json['weight'] ?? 0,
      abilities: (json['abilities'] as List<dynamic>? ?? [])
          .map((abilityInfo) => abilityInfo['ability']['name'] as String)
          .toList(),
    );
  }
}
