import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/app/core/extensions/rpx_int_extendsion.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

class LoginInput extends StatelessWidget {
  const LoginInput({
    super.key,
    this.inputFormatters,
    this.controller,
    this.needClear = false,
    this.leftIcon,
    this.hintText,
    this.onChanged,
    this.onClearTap,
    this.rightBtn,
    this.inputType,
    this.obscureText = false,
  });
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final bool? needClear;
  final IconData? leftIcon;
  final String? hintText;
  final void Function(String)? onChanged;
  final void Function()? onClearTap;
  final Widget? rightBtn;
  final TextInputType? inputType;
  final bool obscureText;
  @override
  Widget build(BuildContext context) {
    return TDInput(
      type: TDInputType.normal,
      inputType: inputType,
      inputFormatters: inputFormatters,
      controller: controller,
      needClear: needClear!,
      decoration: const BoxDecoration(
        color: Color(0xffF2F2F2),
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      leftIcon: leftIcon != null
          ? Icon(
              leftIcon,
              color: const Color(0xff666666),
              size: 40.rpx,
            )
          : null,
      backgroundColor: const Color(0xffF2F2F2),
      contentPadding: EdgeInsets.symmetric(
        horizontal: 10.rpx,
        vertical: 26.rpx,
      ),
      hintText: hintText,
      rightBtn: rightBtn,
      hintTextStyle: TextStyle(
        fontSize: 28.rpx,
        color: const Color(0xff999999),
      ),
      textStyle: TextStyle(fontSize: 28.rpx),
      onChanged: onChanged,
      onClearTap: onClearTap,
      obscureText: obscureText,
    );
  }
}
