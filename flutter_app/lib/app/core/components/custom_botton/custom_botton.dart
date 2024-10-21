import 'package:flutter/material.dart';

class CustomBotton extends StatelessWidget {
  const CustomBotton({
    super.key,
    this.text = "Button",
    this.height = 50,
    this.color = Colors.blue,
    this.textColor = Colors.white,
    this.textFontSize = 16,
    this.textFontWeight = FontWeight.normal,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 10,
    ),
    this.shap = false,
    this.gradient = const LinearGradient(
      colors: [
        Color(0xffde53fc),
        Color(0xff846dfc),
        Color(0xff30c1fd),
      ],
    ),
    this.onPressed,
  });
  final String? text;
  final double? height;
  final Color? color;
  final Color? textColor;
  final double? textFontSize;
  final FontWeight? textFontWeight;
  final EdgeInsetsGeometry? padding;
  final bool? shap;
  final LinearGradient? gradient;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height!,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9),
        gradient: shap!
            ? gradient
            : LinearGradient(
                colors: [color!, color!],
              ),
      ),
      child: ElevatedButton(
        onPressed: () {
          if (onPressed != null) {
            onPressed!();
          }
        },
        style: ButtonStyle(
          //去除阴影
          elevation: WidgetStateProperty.all(0),
          //将按钮背景设置为透明
          backgroundColor: WidgetStateProperty.all(Colors.transparent),
          padding: WidgetStateProperty.all(
            padding!,
          ),
        ),
        child: Text(
          text!,
          style: TextStyle(
            fontSize: textFontSize!,
            color: textColor!,
            fontWeight: textFontWeight!,
          ),
        ),
      ),
    );
  }
}
