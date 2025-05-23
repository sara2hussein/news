import 'package:flutter/material.dart';
import 'package:news/Ui/home/news/news_item.dart';
import 'package:news/api/api_manager.dart';
import 'package:news/models/NewsResponse.dart';
import 'package:news/models/SourceResponse.dart';
import 'package:news/utils/app_colors.dart';
import 'package:news/Ui/home/news/news_details_bottom_sheet.dart';

class NewsWidget extends StatefulWidget {
  final Sources source;
  final bool isSearchVisible;

  NewsWidget({required this.source, required this.isSearchVisible});

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  List<News> newsList = [];
  int currentPage = 1;
  bool isLoading = false;
  bool hasMore = true;
  String searchQuery = '';
  TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchNews();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent &&
          !isLoading &&
          hasMore) {
        fetchNews();
      }
    });
  }

  Future<void> fetchNews({bool isNewSearch = false}) async {
    if (isNewSearch) {
      newsList.clear();
      currentPage = 1;
      hasMore = true;
    }

    if (!hasMore || isLoading) return;

    setState(() => isLoading = true);
    try {
      var response = await ApiManager.getNewsBySourceId(
        widget.source.id ?? '',
        page: currentPage,
        pageSize: 20,
        query: searchQuery,
      );
      if (response != null && response.status == 'ok') {
        setState(() {
          currentPage++;
          newsList.addAll(response.articlesList ?? []);
          if ((response.articlesList?.length ?? 0) < 20) hasMore = false;
        });
      } else {
        hasMore = false;
      }
    } catch (e) {
      hasMore = false;
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    searchController.dispose();
    super.dispose();
  }

  void showNewsDetails(BuildContext context, News news) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => NewsDetailsBottomSheet(news: news),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.isSearchVisible)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              style: TextStyle(
                color:
                    Theme.of(
                      context,
                    ).indicatorColor, 
              ),
              decoration: InputDecoration(
                hintText: 'Search...',
                
                filled: true,
                fillColor: Theme.of(context).primaryColor,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color:
                        Theme.of(
                          context,
                        ).indicatorColor, 
                    width: 2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color:
                        Theme.of(
                          context,
                        ).indicatorColor, 
                    width: 2,
                  ),
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Theme.of(context).indicatorColor,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: Theme.of(context).indicatorColor,
                  ),
                  onPressed: () {
                    searchController.clear();
                    searchQuery = '';
                    fetchNews(isNewSearch: true);
                  },
                ),
              ),
              onSubmitted: (value) {
                searchQuery = value;
                fetchNews(isNewSearch: true);
              },
            ),
          ),
        Expanded(
          child:
              newsList.isEmpty && isLoading
                  ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.greyColor,
                    ),
                  )
                  : ListView.builder(
                    controller: scrollController,
                    itemCount: newsList.length + (hasMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index < newsList.length) {
                        return NewsItem(
                          news: newsList[index],
                          onTap:
                              () => showNewsDetails(context, newsList[index]),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppColors.greyColor,
                            ),
                          ),
                        );
                      }
                    },
                  ),
        ),
      ],
    );
  }
}
