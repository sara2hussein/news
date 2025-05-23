import 'package:flutter/material.dart';
import 'package:news/models/SourceResponse.dart';

class SourseTapName extends StatelessWidget {
  final Sources source;
  final bool isSelected;

  const SourseTapName({
    required this.source,
    required this.isSelected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      source.name ?? '',
      style:
          isSelected
              ? Theme.of(context).textTheme.labelLarge
              : Theme.of(context).textTheme.labelMedium,
    );
  }
}
