import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:aws_flutter/model/art_work.dart';

const String baseUrl = 'https://127.0.0.1:7178/api';

class BaseClient {
  var client = http.Client();

  //Fetch Api ArtWork
  Future<List<ArtWork>> fetchArtWorks() async {
    var response =
        await http.get(
          Uri.parse('http://127.0.0.1:5211/api/ArtWork/GetAll')
        );
    if(response.statusCode == 200) {
      final List result = json.decode(response.body);
      return result.map((e) => ArtWork.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}