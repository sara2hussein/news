import 'package:flutter/material.dart';
import 'package:news/Ui/home/category_details/sourse_tap_name.dart';
import 'package:news/models/SourceResponse.dart';
import 'package:news/utils/app_colors.dart';
import 'package:news/utils/app_theme.dart';

class SourceTapWidget extends StatefulWidget {
  List<Sources> sourcesList;

  SourceTapWidget({required this.sourcesList});

  @override
  State<SourceTapWidget> createState() => _SourceTapWidgetState();
}

class _SourceTapWidgetState extends State<SourceTapWidget> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.sourcesList.length,
      child: Column(
        children: [
          TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            indicatorColor: Theme.of(context).indicatorColor,
            dividerColor: AppColors.transparentColor,
            onTap: (index) {
              selectedIndex = index;
              setState(() {});
            },
            tabs:
                widget.sourcesList.map((source) {
                  return SourseTapName(
                    source: source,
                    isSelected:
                        selectedIndex == widget.sourcesList.indexOf(source),
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }
}
