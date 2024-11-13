import 'package:baykurs/util/YOColors.dart';
import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final Color? cursorColor;
  final Color? hintColor;
  final Color? labelColor;
  final String hint;

  const PasswordField({
    Key? key,
    required this.controller,
    this.cursorColor,
    this.hintColor,
    this.labelColor,
    this.hint = 'Şifre',
  }) : super(key: key);

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _isObscured = true;

  void _toggleVisibility() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      cursorColor: color1,
      obscureText: _isObscured,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        hintText: widget.hint,
        hintStyle: styleWhite16Regular.copyWith(
            color:(widget.hintColor ?? Colors.grey).withAlpha(75)
        ),
        labelStyle: styleBlack14Bold.copyWith(
          color: widget.labelColor ?? Theme.of(context).primaryColor,

        ),
        focusedBorder: const UnderlineInputBorder(),
        suffixIcon: IconButton(
          icon: Icon(
            _isObscured ? Icons.visibility_off : Icons.visibility,
            size: 18,
            color: color5.withAlpha(60) ,
          ),
          onPressed: _toggleVisibility,
        ),
      ),
    );
  }
}
