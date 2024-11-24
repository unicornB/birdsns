import 'package:flutter_app/app/core/models/poll.m.dart';

class Feed {
  int? id;
  String? images;
  int? userId;
  int? circleId;
  String? type;
  String? fileUrl;
  List<Poll>? poll;
  int? likeNum;
  int? comNum;
  int? viewNum;
  int? recswitch;
  int? topswitch;
  int? status;
  String? content;
  int? updatetime;
  int? createtime;
  String? deletetime;
  String? nickname;
  String? avatar;
  String? title;
  String? typeText;
  String? statusText;
  String? ipCity;
  double? mediaWidth;
  double? mediaHeight;
  int? polled;
  int? polledId;
  bool? liked;
  bool? collected;
  int? collectNum;
  Feed({
    this.id,
    this.images,
    this.userId,
    this.circleId,
    this.type,
    this.fileUrl,
    this.poll,
    this.likeNum,
    this.comNum,
    this.viewNum,
    this.recswitch,
    this.topswitch,
    this.status,
    this.content,
    this.updatetime,
    this.createtime,
    this.deletetime,
    this.nickname,
    this.avatar,
    this.title,
    this.typeText,
    this.statusText,
    this.ipCity,
    this.mediaWidth,
    this.mediaHeight,
    this.polled,
    this.polledId,
    this.liked,
    this.collected,
    this.collectNum,
  });

  Feed.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    images = json['images'];
    userId = json['user_id'];
    circleId = json['circle_id'];
    type = json['type'];
    fileUrl = json['file_url'];
    poll = json['poll'] != null
        ? List<Poll>.from(
            json['poll'].map((item) => Poll.fromJson(item)).toList())
        : null;
    likeNum = json['like_num'];
    comNum = json['com_num'];
    viewNum = json['view_num'];
    recswitch = json['recswitch'];
    topswitch = json['topswitch'];
    status = json['status'];
    content = json['content'];
    updatetime = json['updatetime'];
    createtime = json['createtime'];
    deletetime = json['deletetime'];
    nickname = json['nickname'];
    avatar = json['avatar'];
    title = json['title'];
    typeText = json['type_text'];
    statusText = json['status_text'];
    ipCity = json['ip_city'];
    mediaWidth = json['media_width'] != null
        ? double.parse(json['media_width'].toString())
        : 0.0;
    mediaHeight = json['media_height'] != null
        ? double.parse(json['media_height'].toString())
        : 0.0;
    polled = json['polled'];
    polledId = json['polled_id'];
    liked = json['liked'];
    collected = json['collected'];
    collectNum = json['collect_num'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['images'] = this.images;
    data['user_id'] = this.userId;
    data['circle_id'] = this.circleId;
    data['type'] = this.type;
    data['file_url'] = this.fileUrl;
    data['poll'] = this.poll;
    data['like_num'] = this.likeNum;
    data['com_num'] = this.comNum;
    data['view_num'] = this.viewNum;
    data['recswitch'] = this.recswitch;
    data['topswitch'] = this.topswitch;
    data['status'] = this.status;
    data['content'] = this.content;
    data['updatetime'] = this.updatetime;
    data['createtime'] = this.createtime;
    data['deletetime'] = this.deletetime;
    data['nickname'] = this.nickname;
    data['avatar'] = this.avatar;
    data['title'] = this.title;
    data['type_text'] = this.typeText;
    data['status_text'] = this.statusText;
    data['ip_city'] = this.ipCity;
    data['media_width'] = this.mediaWidth;
    data['media_height'] = this.mediaHeight;
    data['polled'] = this.polled;
    data['polled_id'] = this.polledId;
    data['liked'] = this.liked;
    data['collected'] = this.collected;
    data['collect_num'] = this.collectNum;
    return data;
  }
}
