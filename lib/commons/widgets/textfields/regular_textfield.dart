import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StoryTextField extends StatefulWidget {
  final void Function(String) onChanged;
  final int minWords;
  final int maxWords;
  final double fontSize;
  final String hintText;
  final TextEditingController controller;

  const StoryTextField({
    super.key,
    required this.onChanged,
    required this.minWords,
    required this.maxWords,
    required this.fontSize,
    required this.hintText,
    required this.controller,
  });

  @override
  State<StoryTextField> createState() => _StoryTextFieldState();
}

class _StoryTextFieldState extends State<StoryTextField> {
  late int wordCount;

  @override
  void initState() {
    super.initState();
    wordCount = _countWords(widget.controller.text);
    widget.controller.addListener(_handleTextChange);
  }

  void _handleTextChange() {
    final currentText = widget.controller.text;
    final words = _splitWords(currentText);

    if (words.length > widget.maxWords) {
      final trimmed = words.take(widget.maxWords).join(' ');
      widget.controller.value = TextEditingValue(
        text: trimmed,
        selection: TextSelection.collapsed(offset: trimmed.length),
      );
    }

    setState(() {
      wordCount = _countWords(widget.controller.text);
    });

    widget.onChanged(widget.controller.text);
  }

  int _countWords(String text) => _splitWords(text).length;

  List<String> _splitWords(String text) =>
      text.trim().split(RegExp(r'\s+')).where((w) => w.isNotEmpty).toList();

  @override
  void dispose() {
    widget.controller.removeListener(_handleTextChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isValid = wordCount >= widget.minWords;
    final remaining = widget.maxWords - wordCount;

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: const Border(bottom: BorderSide(color: Colors.grey)),
          ),
          child: TextField(
            controller: widget.controller,
            maxLines: null,
            textAlignVertical: TextAlignVertical.top,
            cursorColor: Colors.black,
            style: TextStyle(fontSize: widget.fontSize),
            inputFormatters: [SpaceSanitizerFormatter()],
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
                borderRadius: BorderRadius.circular(8),
              ),
              counterText: '',
              contentPadding: const EdgeInsets.fromLTRB(12, 12, 12, 36),
            ),
          ),
        ),
        Positioned(
          bottom: 8,
          right: 12,
          child: Text(
            isValid
                ? '$wordCount/${widget.maxWords} words'
                : 'Minimum: ${widget.minWords}, current: $wordCount',
            style: TextStyle(
              fontSize: 10,
              color: isValid ? Colors.black54 : Colors.red,
              fontWeight: FontWeight.w500,
            ),
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
    // Replace 3 or more spaces with 2 spaces
    final newText = newValue.text.replaceAll(RegExp(r' {3,}'), '  ');

    // Adjust the cursor to match the new text length
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
