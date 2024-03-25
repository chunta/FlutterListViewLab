import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final int maxLines;
  final bool expanded;
  final VoidCallback? onExpand;
  const ExpandableText(
      {Key? key,
      required this.text,
      this.maxLines = 2,
      required this.expanded,
      this.onExpand})
      : super(key: key);

  @override
  ExpandableTextState createState() {
    return ExpandableTextState();
  }
}

class ExpandableTextState extends State<ExpandableText> {
  bool selfExpand = false;
  @override
  Widget build(BuildContext context) {
    bool isExpanded = widget.expanded || selfExpand;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          widget.text,
          maxLines: isExpanded ? null : widget.maxLines,
          overflow: TextOverflow.fade,
        ),
        if (!isExpanded)
          TextButton(
            onPressed: () {
              widget.onExpand?.call();
              setState(() {
                selfExpand = !selfExpand;
              });
            },
            child: const Text('Read more'),
          ),
      ],
    );
  }
}
