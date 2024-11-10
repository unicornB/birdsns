enum PostsType {
  image,
  video,
  audio,
  text,
  link,
  poll,
}

extension PostsTypeExtension on PostsType {
  String get name {
    switch (this) {
      case PostsType.image:
        return 'image';
      case PostsType.video:
        return 'video';
      case PostsType.audio:
        return 'audio';
      case PostsType.text:
        return 'text';
      case PostsType.link:
        return 'link';
      case PostsType.poll:
        return 'poll';
    }
  }
}
