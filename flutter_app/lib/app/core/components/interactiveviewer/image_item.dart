import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../entity/source_entity.dart';

class ImageItem extends StatefulWidget {
  final SourceEntity source;
  const ImageItem({super.key, required this.source});

  @override
  State<ImageItem> createState() => _ImageItemState();
}

class _ImageItemState extends State<ImageItem> {
  @override
  void initState() {
    super.initState();
    print('initState: ${widget.source.id}');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Navigator.of(context).pop(),
      child: Center(
        child: Hero(
          tag: widget.source.id,
          child: CachedNetworkImage(
            imageUrl: widget.source.url,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
