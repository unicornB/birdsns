class Menu {
  int? id;
  String? iconimage;
  String? name;
  String? position;
  String? route;
  int? weigh;
  int? displayswitch;
  int? createtime;

  Menu(
      {this.id,
      this.iconimage,
      this.name,
      this.position,
      this.route,
      this.weigh,
      this.displayswitch,
      this.createtime});

  Menu.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    iconimage = json['iconimage'];
    name = json['name'];
    position = json['position'];
    route = json['route'];
    weigh = json['weigh'];
    displayswitch = json['displayswitch'];
    createtime = json['createtime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['iconimage'] = iconimage;
    data['name'] = name;
    data['position'] = position;
    data['route'] = route;
    data['weigh'] = weigh;
    data['displayswitch'] = displayswitch;
    data['createtime'] = createtime;
    return data;
  }
}
