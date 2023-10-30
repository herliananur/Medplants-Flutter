import 'package:flutter/material.dart';
import 'package:medplants/API_plant/model/med_screen_viewmodel.dart';
import 'package:medplants/API_plant/screen/med_detail.dart';
import 'package:provider/provider.dart';

class MedScreen extends StatefulWidget {
  const MedScreen({super.key});

  @override
  _MedScreenState createState() => _MedScreenState();
}

class _MedScreenState extends State<MedScreen> {
  late MedScreenViewModel medScreenProvider;

  @override
  void initState() {
    super.initState();
    medScreenProvider = Provider.of<MedScreenViewModel>(context, listen: false);
    medScreenProvider.fetchPlants();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Plant List"),
      ),
      body: medScreenProvider.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: medScreenProvider.plants.length,
              itemBuilder: (context, index) {
                var plant = medScreenProvider.plants[index];
                return ListTile(
                  leading: plant.imageUrl != null
                      ? Image.network(plant.imageUrl!)
                      : const Icon(Icons.image),
                  title: Text(plant.commonName ?? "Unknown"),
                  subtitle: Text(plant.scientificName ?? ""),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MedDetail(plant: plant),
                    ));
                  },
                );
              },
            ),
    );
  }
}
