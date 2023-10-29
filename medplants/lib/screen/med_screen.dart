// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';

// class MedScreen extends StatefulWidget {
//   @override
//   State<MedScreen> createState() => _MedScreenState();
// }

// class _MedScreenState extends State<MedScreen> {
//   Future<Map<String, dynamic>>? data;

//   @override
//   void initState() {
//     super.initState();
//     data = fetchData();
//   }

//   Future<Map<String, dynamic>> fetchData() async {
//     try {
//       Dio dio = Dio();
//       String apiKey = 'DAlQ2IdeL8NmTwS-h5ex1FX9T7cn7DSL2icXjy5BpHY';
//       Response response =
//           await dio.get('https://trefle.io/api/v1/plants?token=$apiKey');

//       if (response.statusCode == 200) {
//         return response.data;
//       } else {
//         throw Exception('Gagal mengambil data dari API');
//       }
//     } catch (e) {
//       throw Exception('Error: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Center(
//             child: FutureBuilder<Map<String, dynamic>>(
//                 future: data,
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return CircularProgressIndicator();
//                   } else if (snapshot.hasError) {
//                     return Text("${snapshot.error}");
//                   } else {
//                     return Text('Data: ${snapshot.data.toString()}');
//                   }
//                 })));
//   }
// }

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
    // Replace the token with your own
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
        title: Text("Plant List"),
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: plants.length,
              itemBuilder: (context, index) {
                var plant = plants[index];
                return ListTile(
                  leading: plant["image_url"] != null
                      ? Image.network(plant["image_url"])
                      : Icon(Icons.image),
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
                : Icon(Icons.image, size: 200),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                plant["bibliography"] ?? "No description available",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}