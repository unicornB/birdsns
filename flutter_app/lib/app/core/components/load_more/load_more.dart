import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LoadMore extends StatelessWidget {
  LoadMore({super.key, this.text});
  String? text;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2.0,
            ),
          ),
          Text(text ?? 'Loading...'),
        ],
      ),
    );
  }
}
