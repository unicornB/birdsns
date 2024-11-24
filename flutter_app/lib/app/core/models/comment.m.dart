class Comment {
  int? id;
  int? postsId;
  int? userId;
  int? pid;
  int? faUserId;
  String? type;
  String? fileUrl;
  String? content;
  int? likeNum;
  int? commNum;
  int? topswitch;
  String? status;
  int? createtime;
  String? nickname;
  String? avatar;
  String? country;
  String? province;
  String? city;
  List<Comment>? children;
  bool? liked;

  Comment({
    this.id,
    this.postsId,
    this.userId,
    this.pid,
    this.faUserId,
    this.type,
    this.fileUrl,
    this.content,
    this.likeNum,
    this.commNum,
    this.topswitch,
    this.status,
    this.createtime,
    this.nickname,
    this.avatar,
    this.country,
    this.province,
    this.city,
    this.children,
    this.liked,
  });

  Comment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    postsId = json['posts_id'];
    userId = json['user_id'];
    pid = json['pid'];
    faUserId = json['fa_user_id'];
    type = json['type'];
    fileUrl = json['file_url'];
    content = json['content'];
    likeNum = json['like_num'];
    commNum = json['comm_num'];
    topswitch = json['topswitch'];
    status = json['status'];
    createtime = json['createtime'];
    nickname = json['nickname'];
    avatar = json['avatar'];
    country = json['country'];
    province = json['province'];
    city = json['city'];
    children = json['children'] != null
        ? List<Comment>.from(json['children'].map((x) => Comment.fromJson(x)))
        : null;
    liked = json['liked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['posts_id'] = this.postsId;
    data['user_id'] = this.userId;
    data['pid'] = this.pid;
    data['fa_user_id'] = this.faUserId;
    data['type'] = this.type;
    data['file_url'] = this.fileUrl;
    data['content'] = this.content;
    data['like_num'] = this.likeNum;
    data['comm_num'] = this.commNum;
    data['topswitch'] = this.topswitch;
    data['status'] = this.status;
    data['createtime'] = this.createtime;
    data['nickname'] = this.nickname;
    data['avatar'] = this.avatar;
    data['country'] = this.country;
    data['province'] = this.province;
    data['city'] = this.city;
    data['children'] = this.children;
    data['liked'] = this.liked;
    return data;
  }
}
