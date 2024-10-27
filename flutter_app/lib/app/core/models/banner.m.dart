class Banner {
  int? id;
  String? position;
  String? title;
  String? image;
  String? url;
  int? weigh;
  int? displayswitch;
  int? createtime;

  Banner(
      {this.id,
      this.position,
      this.title,
      this.image,
      this.url,
      this.weigh,
      this.displayswitch,
      this.createtime});

  Banner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    position = json['position'];
    title = json['title'];
    image = json['image'];
    url = json['url'];
    weigh = json['weigh'];
    displayswitch = json['displayswitch'];
    createtime = json['createtime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['position'] = position;
    data['title'] = title;
    data['image'] = image;
    data['url'] = url;
    data['weigh'] = weigh;
    data['displayswitch'] = displayswitch;
    data['createtime'] = createtime;
    return data;
  }
}
