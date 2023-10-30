import 'package:flutter/material.dart';
import 'package:medplants/API_plant/model/plant.dart';

class MedDetail extends StatelessWidget {
  final Plant plant;
  const MedDetail({
    Key? key,
    required this.plant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(plant.commonName ?? "Unknown"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            plant.imageUrl != null
                ? Image.network(plant.imageUrl!)
                : const Icon(
                    Icons.image,
                    size: 200,
                  ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                plant.bibliography ?? "No description available",
                style: const TextStyle(fontSize: 18),
              ),
            )
          ],
        ),
      ),
    );
  }
}
