import 'package:flutter/material.dart';
import 'package:news/Ui/home/category_details/sourse_tap_name.dart';
import 'package:news/models/SourceResponse.dart';
import 'package:news/Ui/home/news/news_widget.dart';

class SourceTapWidget extends StatefulWidget {
  final List<Sources> sourcesList;
  final bool isSearchVisible;

  SourceTapWidget({required this.sourcesList, required this.isSearchVisible});

  @override
  State<SourceTapWidget> createState() => _SourceTapWidgetState();
}

class _SourceTapWidgetState extends State<SourceTapWidget> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.sourcesList.length,
      initialIndex: selectedIndex,
      child: Column(
        children: [
          TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
            tabs:
                widget.sourcesList.asMap().entries.map((entry) {
                  int idx = entry.key;
                  Sources source = entry.value;
                  return Tab(
                    child: SourseTapName(
                      source: source,
                      isSelected: idx == selectedIndex,
                    ),
                  );
                }).toList(),
          ),
          Expanded(
            child: TabBarView(
              children:
                  widget.sourcesList.map((source) {
                    return NewsWidget(
                      source: source,
                      isSearchVisible: widget.isSearchVisible,
                    );
                  }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
