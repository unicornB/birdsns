class Notifications {
  int? id;
  int? notifierId;
  int? recipientId;
  String? status;
  String? subject;
  int? entryId;
  String? extra;
  int? createtime;
  String? avatar;
  String? nickname;
  String? statusText;

  Notifications(
      {this.id,
      this.notifierId,
      this.recipientId,
      this.status,
      this.subject,
      this.entryId,
      this.extra,
      this.createtime,
      this.avatar,
      this.nickname,
      this.statusText});

  Notifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    notifierId = json['notifier_id'];
    recipientId = json['recipient_id'];
    status = json['status'];
    subject = json['subject'];
    entryId = json['entry_id'];
    extra = json['json'];
    createtime = json['createtime'];
    avatar = json['avatar'];
    nickname = json['nickname'];
    statusText = json['status_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['notifier_id'] = this.notifierId;
    data['recipient_id'] = this.recipientId;
    data['status'] = this.status;
    data['subject'] = this.subject;
    data['entry_id'] = this.entryId;
    data['json'] = this.extra;
    data['createtime'] = this.createtime;
    data['avatar'] = this.avatar;
    data['nickname'] = this.nickname;
    data['status_text'] = this.statusText;
    return data;
  }
}
