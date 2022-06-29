import 'package:flutter/material.dart';
import 'package:logan/views/styles/b_style.dart';

class KTextField extends StatefulWidget {
  final String? hintText;
  final Widget? prefixIcon;
  final bool passWordField;
  final TextEditingController? controller;
  final TextInputType? keyboardType;

  const KTextField({Key? key, this.prefixIcon, this.hintText, this.controller, this.passWordField = false, this.keyboardType}) : super(key: key);

  @override
  State<KTextField> createState() => _KTextFieldState();
}

class _KTextFieldState extends State<KTextField> {
  bool _obscureText = true;

  void _password() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: KColor.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: KColor.blueSapphire.withOpacity(0.42), blurRadius: 4)],
      ),
      child: TextField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        obscureText: widget.passWordField ? _obscureText : !_obscureText,
        style: KTextStyle.headline3.copyWith(fontSize: 15, color: KColor.black),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 27, top: 14, bottom: 13),
          prefixIcon: widget.prefixIcon == null
              ? null
              : Padding(
                  padding: const EdgeInsets.only(right: 23, left: 20),
                  child: widget.prefixIcon,
                ),
          prefixIconConstraints: const BoxConstraints(minHeight: 48),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
          suffixIcon: widget.passWordField
              ? IconButton(
                  onPressed: () {
                    _password();
                  },
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    color: KColor.primary,
                    size: 16.0,
                  ),
                )
              : null,
          hintText: widget.hintText,
          hintStyle: KTextStyle.headline3.copyWith(
            fontSize: 15,
            color: KColor.black.withOpacity(0.6),
          ),
        ),
      ),
    );
  }
}
