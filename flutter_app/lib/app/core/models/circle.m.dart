class Circle {
  int? id;
  int? pid;
  String? title;
  String? titlesub;
  String? iconimage;
  int? weigh;
  int? status;
  int? userId;
  String? bannerimage;
  int? followNum;
  int? recswitch;
  int? zanNum;
  int? postNum;
  int? hotswitch;
  int? payswitch;
  String? bg;
  String? desc;
  String? privpostdata;
  String? privcomdata;
  int? createtime;
  int? updatetime;
  String? statusText;
  String? privpostdataText;
  String? privcomdataText;
  List<Circle>? children;

  Circle({
    this.id,
    this.pid,
    this.title,
    this.titlesub,
    this.iconimage,
    this.weigh,
    this.status,
    this.userId,
    this.bannerimage,
    this.followNum,
    this.recswitch,
    this.zanNum,
    this.postNum,
    this.hotswitch,
    this.payswitch,
    this.bg,
    this.desc,
    this.privpostdata,
    this.privcomdata,
    this.createtime,
    this.updatetime,
    this.statusText,
    this.privpostdataText,
    this.privcomdataText,
    this.children,
  });

  Circle.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pid = json['pid'];
    title = json['title'];
    titlesub = json['titlesub'];
    iconimage = json['iconimage'];
    weigh = json['weigh'];
    status = json['status'];
    userId = json['user_id'];
    bannerimage = json['bannerimage'];
    followNum = json['follow_num'];
    recswitch = json['recswitch'];
    zanNum = json['zan_num'];
    postNum = json['post_num'];
    hotswitch = json['hotswitch'];
    payswitch = json['payswitch'];
    bg = json['bg'];
    desc = json['desc'];
    privpostdata = json['privpostdata'];
    privcomdata = json['privcomdata'];
    createtime = json['createtime'];
    updatetime = json['updatetime'];
    statusText = json['status_text'];
    privpostdataText = json['privpostdata_text'];
    privcomdataText = json['privcomdata_text'];
    children = json['children'] != null
        ? List<Circle>.from(
            json['children'].map((item) => Circle.fromJson(item)).toList())
        : [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pid'] = this.pid;
    data['title'] = this.title;
    data['titlesub'] = this.titlesub;
    data['iconimage'] = this.iconimage;
    data['weigh'] = this.weigh;
    data['status'] = this.status;
    data['user_id'] = this.userId;
    data['bannerimage'] = this.bannerimage;
    data['follow_num'] = this.followNum;
    data['recswitch'] = this.recswitch;
    data['zan_num'] = this.zanNum;
    data['post_num'] = this.postNum;
    data['hotswitch'] = this.hotswitch;
    data['payswitch'] = this.payswitch;
    data['bg'] = this.bg;
    data['desc'] = this.desc;
    data['privpostdata'] = this.privpostdata;
    data['privcomdata'] = this.privcomdata;
    data['createtime'] = this.createtime;
    data['updatetime'] = this.updatetime;
    data['status_text'] = this.statusText;
    data['privpostdata_text'] = this.privpostdataText;
    data['privcomdata_text'] = this.privcomdataText;
    data['children'] = this.children;
    return data;
  }
}
