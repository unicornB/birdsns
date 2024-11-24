class Profile {
  int? id;
  String? nickname;
  String? email;
  String? avatar;
  int? gender;
  String? birthday;
  String? bio;
  String? bgImg;
  int? jointime;
  int? fans;
  int? followsSee;
  int? fansSee;
  String? city;
  String? country;
  String? province;
  String? url;

  Profile(
      {this.id,
      this.nickname,
      this.email,
      this.avatar,
      this.gender,
      this.birthday,
      this.bio,
      this.bgImg,
      this.jointime,
      this.fans,
      this.followsSee,
      this.fansSee,
      this.city,
      this.country,
      this.province,
      this.url});

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nickname = json['nickname'];
    email = json['email'];
    avatar = json['avatar'];
    gender = json['gender'];
    birthday = json['birthday'];
    bio = json['bio'];
    bgImg = json['bg_img'];
    jointime = json['jointime'];
    fans = json['fans'];
    followsSee = json['follows_see'];
    fansSee = json['fans_see'];
    city = json['city'];
    country = json['country'];
    province = json['province'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nickname'] = this.nickname;
    data['email'] = this.email;
    data['avatar'] = this.avatar;
    data['gender'] = this.gender;
    data['birthday'] = this.birthday;
    data['bio'] = this.bio;
    data['bg_img'] = this.bgImg;
    data['jointime'] = this.jointime;
    data['fans'] = this.fans;
    data['follows_see'] = this.followsSee;
    data['fans_see'] = this.fansSee;
    data['city'] = this.city;
    data['country'] = this.country;
    data['province'] = this.province;
    data['url'] = this.url;
    return data;
  }
}
