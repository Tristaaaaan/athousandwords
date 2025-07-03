import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StoryTextField extends StatefulWidget {
  final void Function(String) onChanged;
  final int maxChars;
  final double fontSize;
  final String hintText;

  const StoryTextField({
    super.key,
    required this.onChanged,
    required this.maxChars,
    required this.fontSize,
    required this.hintText,
  });

  @override
  State<StoryTextField> createState() => _StoryTextFieldState();
}

class _StoryTextFieldState extends State<StoryTextField> {
  late final TextEditingController _controller;
  late int remaining;

  @override
  void initState() {
    super.initState();
    remaining = widget.maxChars;
    _controller = TextEditingController()
      ..addListener(() {
        final text = _controller.text;
        setState(() {
          remaining = widget.maxChars - text.length;
        });
        widget.onChanged(text);
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: const Border(bottom: BorderSide(color: Colors.grey)),
          ),
          child: TextField(
            controller: _controller,
            maxLength: widget.maxChars,
            maxLines: null,
            textAlignVertical: TextAlignVertical.top,
            cursorColor: Colors.black,
            style: TextStyle(fontSize: widget.fontSize),
            inputFormatters: [
              LengthLimitingTextInputFormatter(widget.maxChars),
              SpaceSanitizerFormatter(),
            ],
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: TextStyle(
                color: Colors.black45,
                fontSize: widget.fontSize,
              ),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              counterText: '',
              contentPadding: EdgeInsets.fromLTRB(12, 12, 12, 36),
            ),
          ),
        ),
        Positioned(
          bottom: 8,
          right: 12,
          child: Text(
            '$remaining/${widget.maxChars}',
            style: const TextStyle(fontSize: 8, color: Colors.black54),
          ),
        ),
      ],
    );
  }
}

class SpaceSanitizerFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String newText = newValue.text.replaceAll(RegExp(r'\s+'), ' ');
    int offsetAdjustment = newText.length - newValue.text.length;
    int newOffset = (newValue.selection.end + offsetAdjustment).clamp(
      0,
      newText.length,
    );

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newOffset),
    );
  }
}
