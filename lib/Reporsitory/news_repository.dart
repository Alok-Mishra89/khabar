import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Models/news_channel_headline_model.dart';

class NewsRepository {
  Future<NewsChannelHeadlineModel> fetchNewsChannelHeadlineApi () async{

    String url = "https://newsapi.org/v2/top-headlines?country=in&category=business&apiKey=fb78da346b0344a2827aee85dec1a113";

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsChannelHeadlineModel.fromJson(body);
    } throw Exception("Error");
  }
}