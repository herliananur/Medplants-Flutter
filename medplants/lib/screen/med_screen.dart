import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class MedScreen extends StatefulWidget {
  @override
  State<MedScreen> createState() => _MedScreenState();
}

class _MedScreenState extends State<MedScreen> {
  Future<Map<String, dynamic>>? data;

  @override
  void initState() {
    super.initState();
    data = fetchData();
  }

  Future<Map<String, dynamic>> fetchData() async {
    try {
      Dio dio = Dio();
      String apiKey = 'DAlQ2IdeL8NmTwS-h5ex1FX9T7cn7DSL2icXjy5BpHY';
      Response response =
          await dio.get('https://trefle.io/api/v1/plants?token=$apiKey');

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Gagal mengambil data dari API');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: FutureBuilder<Map<String, dynamic>>(
                future: data,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  } else {
                    return Text('Data: ${snapshot.data.toString()}');
                  }
                })));
  }
}
