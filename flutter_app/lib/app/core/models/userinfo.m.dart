class UserInfo {
  int? id;
  String? username;
  String? nickname;
  String? email;
  String? mobile;
  String? avatar;
  int? level;
  int? gender;
  String? birthday;
  String? bio;
  int? score;
  String? bgImg;
  int? fansNum;
  int? seeFollowswitch;
  int? seeFansswitch;
  String? city;
  String? token;
  int? userId;
  int? createtime;
  int? expiretime;
  int? expiresIn;

  UserInfo(
      {this.id,
      this.username,
      this.nickname,
      this.email,
      this.mobile,
      this.avatar,
      this.level,
      this.gender,
      this.birthday,
      this.bio,
      this.score,
      this.bgImg,
      this.fansNum,
      this.seeFollowswitch,
      this.seeFansswitch,
      this.city,
      this.token,
      this.userId,
      this.createtime,
      this.expiretime,
      this.expiresIn});

  UserInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    nickname = json['nickname'];
    email = json['email'];
    mobile = json['mobile'];
    avatar = json['avatar'];
    level = json['level'];
    gender = json['gender'];
    birthday = json['birthday'];
    bio = json['bio'];
    score = json['score'];
    bgImg = json['bg_img'];
    fansNum = json['fans_num'];
    seeFollowswitch = json['see_followswitch'];
    seeFansswitch = json['see_fansswitch'];
    city = json['city'];
    token = json['token'];
    userId = json['user_id'];
    createtime = json['createtime'];
    expiretime = json['expiretime'];
    expiresIn = json['expires_in'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['nickname'] = this.nickname;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['avatar'] = this.avatar;
    data['level'] = this.level;
    data['gender'] = this.gender;
    data['birthday'] = this.birthday;
    data['bio'] = this.bio;
    data['score'] = this.score;
    data['bg_img'] = this.bgImg;
    data['fans_num'] = this.fansNum;
    data['see_followswitch'] = this.seeFollowswitch;
    data['see_fansswitch'] = this.seeFansswitch;
    data['city'] = this.city;
    data['token'] = this.token;
    data['user_id'] = this.userId;
    data['createtime'] = this.createtime;
    data['expiretime'] = this.expiretime;
    data['expires_in'] = this.expiresIn;
    return data;
  }
}
