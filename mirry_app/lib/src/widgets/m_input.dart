import 'package:flutter/material.dart';
import 'package:mirry/src/config/theme/colors.dart';

class MInput extends StatelessWidget {
  final IconData? prefixIcon;
  final String hintText;
  final bool obscureText;
  final IconData? suffixIcon;
  final void Function()? onSuffixTap;
  final void Function(String)? onChange;

  const MInput({
    Key? key,
    this.prefixIcon,
    this.hintText = '',
    this.obscureText = false,
    this.suffixIcon,
    this.onSuffixTap,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 4,
            color: Colors.black.withOpacity(0.25),
          )
        ],
      ),
      child: TextField(
        onChanged: onChange,
        obscureText: obscureText,
        decoration: InputDecoration(
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          filled: true,
          fillColor: accentDark,
          hintText: hintText,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            borderSide: BorderSide.none,
          ),
          suffixIcon: Material(
            shape: const CircleBorder(),
            clipBehavior: Clip.hardEdge,
            color: Colors.transparent,
            child: suffixIcon != null
                ? IconButton(
                    icon: Icon(suffixIcon),
                    onPressed: onSuffixTap,
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
