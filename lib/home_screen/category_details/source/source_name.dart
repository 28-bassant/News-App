import 'package:flutter/material.dart';
import 'package:news_app/api/models/SourceResponse.dart';

class SourceName extends StatelessWidget {
  Source sources;
  bool isSelected;
  SourceName({required this.sources, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return isSelected?
      Text(sources.name?? ' ',style: Theme.of(context).textTheme.labelLarge,):
      Text(sources.name?? ' ',style: Theme.of(context).textTheme.labelMedium,)

    ;
  }
}
