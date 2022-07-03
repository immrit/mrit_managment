class Post {
  bool? error;
  String? errmsg;
  List<Data>? data;

  Post({this.error, this.errmsg, this.data});

  Post.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    errmsg = json['errmsg'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['errmsg'] = this.errmsg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? title;
  String? descript;

  Data({this.id, this.title, this.descript});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    descript = json['descript'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['descript'] = this.descript;
    return data;
  }
}
