import '../Models/news_channel_headline_model.dart';
import '../Reporsitory/news_repository.dart';

class NewsViewModel {

  final _rep = NewsRepository();

  Future<NewsChannelHeadlineModel> fetchNewsChannelHeadlineApi() async {

    final response = await _rep.fetchNewsChannelHeadlineApi();

    return response;
  }
}
