import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:wanandroid/constants.dart';
import 'package:wanandroid/model/home_model.dart';

class HomeDao {
  static Future<HomeModel> fetchHomeBanner() async {
    final response = await http.get(Apis.HOME_PAGE_URL);
    if (response != null && response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder(); // fix 中文乱码
      return HomeModel.jsonToBanners(
          json.decode(utf8decoder.convert(response.bodyBytes)));
    } else {
      return null;
    }
  }

  static Future<HomeModel> fetchHomeArticles(int pageIndex) async {
    if (pageIndex < 0) {
      return null;
    }
    final response = await http.get(Apis.HOME_ARTICLE_URL.replaceAll("#", pageIndex.toString()));
    if (response != null && response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder();
      return HomeModel.jsonToArticles(
          json.decode(utf8decoder.convert(response.bodyBytes)));
    } else {
      return null;
    }
  }
}
