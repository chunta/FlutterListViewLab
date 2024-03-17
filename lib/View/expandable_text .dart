import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final int maxLines;

  const ExpandableText({Key? key, required this.text, this.maxLines = 2})
      : super(key: key);

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GestureDetector(
          onTap: () {
            // Handle tap gesture here
            if (_isExpanded) {
              setState(() {
                _isExpanded = false;
              });
            }
          },
          child: Text(
            widget.text,
            maxLines: _isExpanded ? null : widget.maxLines,
            overflow: TextOverflow.fade,
          ),
        ),
        if (!_isExpanded)
          TextButton(
            onPressed: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: const Text('Read more'),
          ),
      ],
    );
  }
}
