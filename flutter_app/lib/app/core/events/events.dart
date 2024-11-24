import 'package:flutter_app/app/core/models/circle.m.dart';

class PublishSelectCircleEvent {
  final Circle circle;
  PublishSelectCircleEvent(this.circle);
}

class NotifiyEvent {
  final int count;
  NotifiyEvent(this.count);
}
