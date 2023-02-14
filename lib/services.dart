import 'package:test/features/number_trivia/data/models/images.dart';
import 'package:test/main.dart';
import 'package:http/http.dart' as http;

import 'features/number_trivia/data/models/poems_model.dart';

class RemoteService {
  Future<List<Poems>> getPoems() async {
    var client = http.Client();

    var url = Uri.parse('https://poetrydb.org/random/10');
    var response = await client.get(url);

    if (response.statusCode == 200) {
      var json = response.body;
      return PoemsFromJson(json);
    }
    throw Exception("An error occured");
  }

  Future<List<Images>> getPhotos() async {
    var client = http.Client();

    var url = Uri.parse('https://picsum.photos/v2/list?page=1&limit=10');

    var response = await client.get(url);

    if (response.statusCode == 200) {
      var json = response.body;
      return imagesFromJson(json);
    }
    throw Exception("Something bad happened");
  }
}
