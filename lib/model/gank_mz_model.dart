class MzModel {
  bool error;
  List<MzItem> results;

  MzModel({this.error, this.results});

  MzModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    if (json['results'] != null) {
      results = new List<MzItem>();
      json['results'].forEach((v) {
        results.add(new MzItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MzItem {
  String sId;
  String createdAt;
  String desc;
  String publishedAt;
  String source;
  String type;
  String url;
  bool used;
  String who;

  MzItem(
      {this.sId,
      this.createdAt,
      this.desc,
      this.publishedAt,
      this.source,
      this.type,
      this.url,
      this.used,
      this.who});

  MzItem.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    createdAt = json['createdAt'];
    desc = json['desc'];
    publishedAt = json['publishedAt'];
    source = json['source'];
    type = json['type'];
    url = json['url'];
    used = json['used'];
    who = json['who'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['createdAt'] = this.createdAt;
    data['desc'] = this.desc;
    data['publishedAt'] = this.publishedAt;
    data['source'] = this.source;
    data['type'] = this.type;
    data['url'] = this.url;
    data['used'] = this.used;
    data['who'] = this.who;
    return data;
  }
}
