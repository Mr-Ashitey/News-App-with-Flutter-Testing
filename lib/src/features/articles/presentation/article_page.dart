import 'package:flutter/material.dart';

import '../../news/domain/article.dart';

class ArticlePage extends StatelessWidget {
  final Article article;
  const ArticlePage({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
            top: mediaQuery.padding.top,
            bottom: mediaQuery.padding.bottom,
            left: 8.0,
            right: 8.0),
        child: Column(
          children: [
            Text(
              article.title!,
              style: Theme.of(context).textTheme.headline5,
            ),
            const SizedBox(height: 8.0),
            Text(article.content!),
          ],
        ),
      ),
    );
  }
}
