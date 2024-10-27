class UserInfo {
  int? id;
  String? username;
  String? nickname;
  String? mobile;
  String? avatar;
  int? score;
  String? token;
  int? userId;
  int? createtime;
  int? expiretime;
  int? expiresIn;
  String? email;

  UserInfo({
    this.id,
    this.username,
    this.nickname,
    this.mobile,
    this.avatar,
    this.score,
    this.token,
    this.userId,
    this.createtime,
    this.expiretime,
    this.expiresIn,
    this.email,
  });

  UserInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    nickname = json['nickname'];
    mobile = json['mobile'];
    avatar = json['avatar'];
    score = json['score'];
    token = json['token'];
    userId = json['user_id'];
    createtime = json['createtime'];
    expiretime = json['expiretime'];
    expiresIn = json['expires_in'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['nickname'] = nickname;
    data['mobile'] = mobile;
    data['avatar'] = avatar;
    data['score'] = score;
    data['token'] = token;
    data['user_id'] = userId;
    data['createtime'] = createtime;
    data['expiretime'] = expiretime;
    data['expires_in'] = expiresIn;
    data['email'] = email;
    return data;
  }
}
