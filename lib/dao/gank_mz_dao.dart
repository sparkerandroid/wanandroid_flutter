import 'package:http/http.dart' as http;
import 'package:wanandroid/constants.dart';
import 'package:wanandroid/model/gank_mz_model.dart';
import 'dart:convert';

class GankDao {
  static Future<MzModel> fetchGankMzPics(int pageIndex) async {
    if (pageIndex < 0) {
      return null;
    }
    final response =
        await http.get(Apis.GANK_MZ_PICS.replaceAll("#", pageIndex.toString()));
    if (response != null && response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder();
      return MzModel.fromJson(
          json.decode(utf8decoder.convert(response.bodyBytes)));
    } else {
      return null;
    }
  }
}
