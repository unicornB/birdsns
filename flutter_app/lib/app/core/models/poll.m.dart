class Poll {
  int? id;
  int? postsId;
  String? title;
  int? tickets;
  int? createtime;

  Poll({this.id, this.postsId, this.title, this.tickets, this.createtime});

  Poll.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    postsId = json['posts_id'];
    title = json['title'];
    tickets = json['tickets'];
    createtime = json['createtime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['posts_id'] = this.postsId;
    data['title'] = this.title;
    data['tickets'] = this.tickets;
    data['createtime'] = this.createtime;
    return data;
  }
}
