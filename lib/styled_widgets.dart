import 'package:flutter/material.dart';

class StyledText extends StatelessWidget {
  const StyledText({
    super.key,
    required this.text,
    required this.fontSize,
  });

  final String text;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    var style = theme.textTheme.titleLarge!;

    return Text(text,
        style: TextStyle(
          color: style.color,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        )
      );
  }
}

class SettingsText extends StatelessWidget {
  const SettingsText({
    super.key,
    required this.text,
    required this.fontSize,
  });

  final String text;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
          color: Colors.blueGrey[900],
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ));
  }
}

class StyledTextButton extends StatelessWidget {
  const StyledTextButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  final void Function() onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        alignment: Alignment.center,
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        minimumSize: const Size(80, 20),
        enableFeedback: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      onPressed: onPressed,
      child: StyledText(text: text, fontSize: 16),
    );
  }
}

class StyledHomeButton extends StatelessWidget {
  const StyledHomeButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  final void Function() onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.blueGrey[900],
        foregroundColor: Colors.white,
        alignment: Alignment.center,
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        minimumSize: const Size(200, 50),
        enableFeedback: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      onPressed: onPressed,
      child: StyledText(text: text, fontSize: 16),
    );
  }
}
