import 'package:flutter/material.dart';

class TextItem extends StatelessWidget {
  const TextItem(this.prefix, this.prefixStyle,
      [this.text = '',
      // ignore: avoid_init_to_null
      this.bodyStyle = null]);

  /// Prefix of the text.
  final String prefix;

  /// Style of the prefix text.
  final TextStyle prefixStyle;

  /// Body of the text.
  final String text;

  /// Style of the body text.
  final TextStyle bodyStyle;

  /// View Constants.
  static const double _textItemSpacing = 8.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: _textItemSpacing),
        child: Row(
          children: <Widget>[
            Flexible(
                child: RichText(
                    text: TextSpan(
                        text: prefix,
                        style: prefixStyle,
                        children: <TextSpan>[
                  TextSpan(
                      text: text,
                      style:
                          bodyStyle ?? prefixStyle.apply(color: Colors.black))
                ])))
          ],
        ));
  }
}
