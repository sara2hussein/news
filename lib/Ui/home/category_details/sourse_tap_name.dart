import 'package:flutter/material.dart';
import 'package:news/models/SourceResponse.dart';

class SourseTapName extends StatelessWidget {
  Sources source;
  bool isSelected;
  SourseTapName({required this.source, required this.isSelected});
  @override
  Widget build(BuildContext context) {
    return Text(
      source.name??'',
      style: isSelected?
      Theme.of(context).textTheme.labelLarge:
      Theme.of(context).textTheme.labelMedium
      ,
    );
  }
}
