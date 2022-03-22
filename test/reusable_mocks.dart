import 'package:flutter_testing/model/article.dart';

class ReusableMocks {
  static final List<Article> fakeArticlesList = [
    Article(title: "Test 1", content: "Test 1 Content"),
    Article(title: "Test 2", content: "Test 2 Content"),
    Article(title: "Test 3", content: "Test 3 Content"),
  ];
}
