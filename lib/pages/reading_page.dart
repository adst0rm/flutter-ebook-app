import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ReadingPage extends StatefulWidget {
  final String title;
  final String content;

  const ReadingPage({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  State<ReadingPage> createState() => _ReadingPageState();
}

class _ReadingPageState extends State<ReadingPage> {
  double _fontSize = 16.0;
  final List<String> _highlights = [];
  final Map<String, bool> _highlightedText = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.format_size, color: Colors.white),
            onPressed: _showFontSizeDialog,
          ),
          IconButton(
            icon: const Icon(Icons.bookmark_border, color: Colors.white),
            onPressed: _showHighlights,
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: SelectableText.rich(
            TextSpan(
              children: _buildHighlightedText(),
            ),
            selectionControls: _CustomTextSelectionControls(
              onHighlight: _addHighlight,
            ),
            style: TextStyle(fontSize: _fontSize),
          ),
        ),
      ),
    );
  }

  List<TextSpan> _buildHighlightedText() {
    List<TextSpan> spans = [];
    String text = widget.content;

    for (String highlight in _highlights) {
      int index = text.indexOf(highlight);
      if (index != -1) {
        // Add text before highlight
        if (index > 0) {
          spans.add(TextSpan(
            text: text.substring(0, index),
            style: TextStyle(
              fontSize: _fontSize,
              color: Colors.black87,
            ),
          ));
        }
        // Add highlighted text
        spans.add(TextSpan(
          text: highlight,
          style: TextStyle(
            fontSize: _fontSize,
            color: Colors.black87,
            backgroundColor: Colors.yellow,
          ),
        ));
        text = text.substring(index + highlight.length);
      }
    }
    // Add remaining text
    if (text.isNotEmpty) {
      spans.add(TextSpan(
        text: text,
        style: TextStyle(
          fontSize: _fontSize,
          color: Colors.black87,
        ),
      ));
    }
    return spans;
  }

  void _showFontSizeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Adjust Text Size'),
        content: StatefulBuilder(
          builder: (context, setState) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Slider(
                value: _fontSize,
                min: 12.0,
                max: 32.0,
                divisions: 10,
                label: _fontSize.round().toString(),
                onChanged: (value) {
                  setState(() {
                    _fontSize = value;
                  });
                  this.setState(() {});
                },
              ),
              Text(
                'Sample Text',
                style: TextStyle(fontSize: _fontSize),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showHighlights() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Highlights',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _highlights.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(_highlights[index]),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            _highlights.removeAt(index);
                          });
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addHighlight(String highlightedText) {
    setState(() {
      _highlights.add(highlightedText);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Text highlighted'),
        duration: Duration(seconds: 1),
      ),
    );
  }
}

class _CustomTextSelectionControls extends MaterialTextSelectionControls {
  final Function(String) onHighlight;

  _CustomTextSelectionControls({required this.onHighlight});

  @override
  Widget buildToolbar(
    BuildContext context,
    Rect globalEditableRegion,
    double textLineHeight,
    Offset selectionMidpoint,
    List<TextSelectionPoint> endpoints,
    TextSelectionDelegate delegate,
    ValueListenable<ClipboardStatus>? clipboardStatus,
    Offset? lastSecondaryTapDownPosition,
  ) {
    final TextEditingValue value = delegate.textEditingValue;
    final String selectedText = value.selection.textInside(value.text);

    return TextSelectionToolbar(
      anchorAbove: globalEditableRegion.topLeft,
      anchorBelow: globalEditableRegion.bottomLeft,
      children: [
        TextSelectionToolbarTextButton(
          padding: const EdgeInsets.all(8.0),
          onPressed: () {
            onHighlight(selectedText);
            delegate.hideToolbar();
          },
          child: const Text(
            'Highlight',
            style: TextStyle(color: Colors.yellow),
          ),
        ),
      ],
    );
  }
}
