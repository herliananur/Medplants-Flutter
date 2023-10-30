import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medplants/API_plant/model/plant.dart';
import 'package:http/http.dart' as http;

class MedScreenViewModel extends ChangeNotifier {
  bool isLoading = false;
  List<Plant> plants = [];

  MedScreenViewModel() {
    fetchPlants();
  }

  fetchPlants() async {
    String token = "DAlQ2IdeL8NmTwS-h5ex1FX9T7cn7DSL2icXjy5BpHY";
    String url = "https://trefle.io/api/v1/plants?token=$token";

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var plantData = data["data"];
      List<Plant> loadedPlants = [];

      for (var plant in plantData) {
        loadedPlants.add(
          Plant(
            plant["common_name"],
            plant["scientific_name"],
            plant["image_url"],
            plant["bibliography"],
          ),
        );
      }

      plants = loadedPlants;
      isLoading = false;
      notifyListeners();
    } else {
      print("Error: ${response.statusCode}");
    }
  }
}
