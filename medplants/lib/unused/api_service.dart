// import 'package:dio/dio.dart';
// import 'package:medplants/model/plant_model.dart';

// class PlantService {
//   static const String _baseUrl =
//       'https://trefle.io/api/v1/plants?token=DAlQ2IdeL8NmTwS-h5ex1FX9T7cn7DSL2icXjy5BpHY';

//   Future<List<PlantSpecies>> fetchPlant() async {
//     try {
//       final response = await Dio().get(_baseUrl);
//       if (response.statusCode == 200) {
//         List<dynamic> data = response.data["data"];
//         List<PlantSpecies> plantSpecies =
//             data.map((item) => PlantSpecies.fromJson(item)).toList();
//         return plantSpecies;
//       } else {
//         throw Exception('Failed to load plant species');
//       }
//     } catch (e) {
//       throw Exception('Failed to load plant species: $e');
//     }
//   }
// }
