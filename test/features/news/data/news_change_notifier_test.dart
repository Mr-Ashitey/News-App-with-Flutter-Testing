import 'package:flutter_testing/src/features/news/data/news_change_notifier.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../reusable_mocks.dart';

void main() {
  late NewsChangeNotifier sut; //sut = System Under Test
  late MockNewsService mockNewsService;

  setUp(() {
    mockNewsService = MockNewsService();
    sut = NewsChangeNotifier(mockNewsService);
  });

  test("test initial variables are correct", () async {
    expect(sut.articles, isEmpty);
    expect(sut.isLoading, isFalse);
  });

  group("getArticles", () {
    test(
        "checking that getArticles method has been called once from NewsService",
        () async {
      ReusableMocks.arrangeNewsServiceReturns3Articles(mockNewsService);
      await sut.getArticles();
      verify(() => mockNewsService.getArticles()).called(1);
    });

    test(
      """indicates loading of data, 
    set articles to the ones from the service,
    indicates that data is not being loaded anymore""",
      () async {
        ReusableMocks.arrangeNewsServiceReturns3Articles(mockNewsService);
        //?---------------------------------------?//
        /* 
            instead of doing the below with await:
              **await sut.getArticles();**
            we are rather doing this:
              **final future = sut.getArticles();**

            this is because, isLoading is only true, once the future is called.
            It becomes false after the future is completed. But we want to test and ensure that
            isLoading is true before the future is completed and false after the future is completed.
          */
        final future = sut
            .getArticles(); //without await we can check isLoading before the future is completed
        expect(sut.isLoading, isTrue);
        //?--------------------------------------?//

        await future; // we await the future to complete and then check isLoading as well as the list of articles
        expect(sut.isLoading, isFalse);
        expect(sut.articles, ReusableMocks.fakeArticlesList);
      },
    );
  });
}
