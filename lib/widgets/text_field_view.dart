import 'package:flutter/material.dart';

class TextFieldView extends StatefulWidget {
  final bool obscureText;
  final Color focusColor;
  final Color unfocusColor;
  final Color borderColor;
  final Color focusedBorderColor;
  final InputDecoration? decoration;

  const TextFieldView({
    super.key,
    this.obscureText = false,
    required this.focusColor,
    required this.unfocusColor,
    required this.borderColor,
    required this.focusedBorderColor,
    this.decoration,
  });

  @override
  _TextFieldViewState createState() => _TextFieldViewState();
}

class _TextFieldViewState extends State<TextFieldView> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: _isFocused ? widget.focusedBorderColor : widget.borderColor,
          width: 2,
        ),
        color: _isFocused ? widget.focusColor : widget.unfocusColor,
      ),
      child: TextField(
          focusNode: _focusNode,
          obscureText: widget.obscureText,
          decoration: widget.decoration ??
              const InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0))),
    );
  }
}


 // TextField(
//   decoration: InputDecoration(
//     /// 启用填充背景色
//     filled: true,
//     fillColor: const Color(0xffF4F4F4),
//     focusColor: Colors.white,
//     enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(10.0),
//         borderSide: const BorderSide(
//             // color: Color(0xffe3e3e3),
//             color: Colors.transparent,
//             width: 2,
//             style: BorderStyle.solid)),
//     focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(10.0),
//         borderSide: const BorderSide(
//             color: Color(0xff0098FF),
//             width: 2,
//             style: BorderStyle.solid)),
//   )
// )