import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:wanandroid/constants.dart';
import 'package:wanandroid/model/public_subscription_articles_model.dart';
import 'package:wanandroid/model/public_subscription_model.dart';

class PublicSubscriptionDao {
  static Future<PublicSubscriptionModel> getSubscriptions() async {
    http.Response response = await http.get(Apis.PUBLIC_SUBSCRIPTION);
    if (response != null && response.statusCode == 200) {
      Utf8Decoder utf8decoder = new Utf8Decoder();
      return PublicSubscriptionModel.fromJson(
          json.decode(utf8decoder.convert(response.bodyBytes)));
    } else {
      return null;
    }
  }

  static Future<PublicSubscriptionArticlesModel> fetchSubscriptionArticles(
      int subscriptionId, int pageIndex) async {
    if (pageIndex < 0) {
      return null;
    }
    final response = await http.get(Apis.PUBLIC_SUBSCRIPTION_HISTORY
        .replaceAll("@", pageIndex.toString())
        .replaceAll("#", subscriptionId.toString()));
    if (response != null && response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder();
      return PublicSubscriptionArticlesModel.fromJson(
          json.decode(utf8decoder.convert(response.bodyBytes)));
    } else {
      return null;
    }
  }
}
