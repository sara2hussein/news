import 'package:flutter/material.dart';
import 'package:news/models/NewsResponse.dart';

class NewsDetailsBottomSheet extends StatefulWidget {
  final News news;

  const NewsDetailsBottomSheet({required this.news, super.key});

  @override
  State<NewsDetailsBottomSheet> createState() => _NewsDetailsBottomSheetState();
}

class _NewsDetailsBottomSheetState extends State<NewsDetailsBottomSheet> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    final description = widget.news.description ?? '';
    final maxPreviewLines = 2;
    final previewText =
        expanded ? description : _getPreviewText(description, maxPreviewLines);
    final remainingChars = description.length - previewText.length;

    final maxHeight = MediaQuery.of(context).size.height * 0.8;

    return Container(
      constraints: BoxConstraints(maxHeight: maxHeight),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).indicatorColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if ((widget.news.urlToImage ?? '').isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  widget.news.urlToImage!,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (context, error, stackTrace) => const Icon(
                        Icons.broken_image,
                        size: 100,
                        color: Colors.grey,
                      ),
                ),
              ),
            SizedBox(height: 16),
            Text(
              widget.news.title ?? '',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(height: 12),
            GestureDetector(
              onTap: () {
                if (remainingChars > 0) {
                  setState(() {
                    expanded = !expanded;
                  });
                }
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      previewText,
                      maxLines: expanded ? null : maxPreviewLines,
                      overflow:
                          expanded
                              ? TextOverflow.visible
                              : TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  if (!expanded && remainingChars > 0)
                    Container(
                      margin: EdgeInsets.only(left: 6, top: 4),
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '+${remainingChars}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).indicatorColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(height: 24),
            if (widget.news.url != null && widget.news.url!.isNotEmpty)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Open full article in browser
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    'View Full Article',
                    style: TextStyle(color: Theme.of(context).indicatorColor),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _getPreviewText(String text, int maxLines) {
    int maxChars = maxLines * 100;
    if (text.length <= maxChars) return text;
    return text.substring(0, maxChars);
  }
}
