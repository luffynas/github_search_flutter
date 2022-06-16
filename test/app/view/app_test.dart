// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/api/github_client.dart';
import 'package:github_search/app/app.dart';
import 'package:github_search/modules/counter/counter.dart';
import 'package:github_search/modules/github/repositories/github_cache.dart';
import 'package:github_search/modules/github/repositories/github_repository.dart';

void main() {
  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
      // ignore: omit_local_variable_types
      final GithubRepository githubRepository = GithubRepository(
        GithubCache(),
        GithubClient(),
      );

      await tester.pumpWidget(App(githubRepository: githubRepository));
      expect(find.byType(CounterPage), findsOneWidget);
    });
  });
}
