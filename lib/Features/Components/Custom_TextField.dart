import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextfield extends StatelessWidget {
  final String? hintText;
  final double? height;
  final double? width;
  final TextInputType? textInputType;
  final TextEditingController? customController;
  final int? maxLength;
  VoidCallback? function;
  FocusNode? focusNode;

  CustomTextfield(
      {required this.customController,
      required this.hintText,
      this.height,
      this.width,
      this.textInputType,
      this.maxLength,
        this.function,
        this.focusNode,
      super.key});

  @override
  Widget build(BuildContext context) {
    double wt = MediaQuery.of(context).size.width;
    return Container(
      height: height ?? 100, // Adjust the height here
      width: width ?? wt * 0.70, // Adjust the width here
      decoration: BoxDecoration(
        // Border with dynamic size
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        maxLength: maxLength ?? 20,
        keyboardType:  textInputType??TextInputType.multiline,
        showCursor: true,
        maxLines: null,
        controller: customController,
        onEditingComplete:function,
        focusNode: focusNode,
        onTapUpOutside: (_)=>FocusManager.instance.primaryFocus?.unfocus(),

        decoration: InputDecoration(
          hintFadeDuration: Duration(milliseconds: 250),
          hintMaxLines: 1,


          hintStyle: TextStyle(
            fontFamily: 'Cagody',
                letterSpacing: 1,
                color: Colors.grey[600]
          ),
          hintText: hintText,
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          border: InputBorder.none,
          // Remove default border
          counterText: '',
        ),
      ),
    );
  }
}
