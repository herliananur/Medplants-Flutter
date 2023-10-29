class PlantSpecies {
  final int id;
  final String commonName;
  final String slug;
  final String scientificName;
  final int year;
  final String bibliography;
  final String author;
  final String status;
  final String rank;
  final String familyCommonName;
  final int genusId;
  final String imageUrl;
  final List<String> synonyms;
  final String genus;
  final String family;

  PlantSpecies({
    required this.id,
    required this.commonName,
    required this.slug,
    required this.scientificName,
    required this.year,
    required this.bibliography,
    required this.author,
    required this.status,
    required this.rank,
    required this.familyCommonName,
    required this.genusId,
    required this.imageUrl,
    required this.synonyms,
    required this.genus,
    required this.family,
  });

  factory PlantSpecies.fromJson(Map<String, dynamic> json) {
    return PlantSpecies(
      id: json['id'],
      commonName: json['common_name'],
      slug: json['slug'],
      scientificName: json['scientific_name'],
      year: json['year'],
      bibliography: json['bibliography'],
      author: json['author'],
      status: json['status'],
      rank: json['rank'],
      familyCommonName: json['family_common_name'],
      genusId: json['genus_id'],
      imageUrl: json['image_url'],
      synonyms: List<String>.from(json['synonyms']),
      genus: json['genus'],
      family: json['family'],
    );
  }
}
