import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PlantList extends StatefulWidget {
  @override
  _PlantListState createState() => _PlantListState();
}

class _PlantListState extends State<PlantList> {
  List plants = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchPlants();
  }

  fetchPlants() async {
    String token = "DAlQ2IdeL8NmTwS-h5ex1FX9T7cn7DSL2icXjy5BpHY";
    String url = "https://trefle.io/api/v1/plants?token=$token";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      setState(() {
        plants = data["data"];
        loading = false;
      });
    } else {
      print("Error: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Plant List"),
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: plants.length,
              itemBuilder: (context, index) {
                var plant = plants[index];
                return ListTile(
                  leading: plant["image_url"] != null
                      ? Image.network(plant["image_url"])
                      : const Icon(Icons.image),
                  title: Text(plant["common_name"] ?? "Unknown"),
                  subtitle: Text(plant["scientific_name"]),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlantDetail(plant: plant),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}

class PlantDetail extends StatelessWidget {
  final plant;
  PlantDetail({this.plant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(plant["common_name"] ?? "Unknown"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            plant["image_url"] != null
                ? Image.network(plant["image_url"])
                : const Icon(Icons.image, size: 200),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                plant["bibliography"] ?? "No description available",
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}