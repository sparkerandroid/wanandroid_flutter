import 'package:wanandroid/model/home_articles_model.dart';
import 'package:wanandroid/model/home_banner_model.dart';

class HomeModel {
  List<HomeBannerModel> banners;
  List<HomeArticle> articles;

  HomeModel.jsonToBanners(Map<String, dynamic> json) {
    if (json != null && json['data'] != null) {
      banners = new List<HomeBannerModel>();
      json['data'].forEach((item) {
        banners.add(HomeBannerModel.fromJson(item));
      });
    }
  }

  HomeModel.jsonToArticles(Map<String, dynamic> json) {
    if (json != null && json['data'] != null && json['data']['datas'] != null) {
      articles = new List<HomeArticle>();
      json['data']['datas'].forEach((item) {
        articles.add(HomeArticle.fromJson(item));
      });
    }
  }
}
