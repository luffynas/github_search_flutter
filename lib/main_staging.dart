// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:github_search/app/app.dart';
import 'package:github_search/bootstrap.dart';

import 'api/github_client.dart';
import 'modules/github/repositories/github_cache.dart';
import 'modules/github/repositories/github_repository.dart';

void main() {
  // ignore: omit_local_variable_types
  final GithubRepository githubRepository = GithubRepository(
    GithubCache(),
    GithubClient(),
  );

  bootstrap(() => App(githubRepository: githubRepository));
}
