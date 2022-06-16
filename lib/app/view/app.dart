// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:github_search/l10n/l10n.dart';
import 'package:github_search/modules/github/view/search_form.dart';

import '../../bloc/theme/theme_cubit.dart';
import '../../modules/github/bloc/github_search_bloc.dart';
import '../../modules/github/repositories/github_repository.dart';
import '../../theme/theme_app.dart';

class App extends StatelessWidget {
  const App({super.key, required this.githubRepository});

  final GithubRepository githubRepository;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()..changeTheme()),
        BlocProvider(
          create: (_) => GithubSearchBloc(githubRepository: githubRepository),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            // theme: ThemeData(
            //   appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
            //   colorScheme: ColorScheme.fromSwatch(
            //     accentColor: const Color(0xFF13B9FF),
            //   ),
            // ),
            useInheritedMediaQuery: true,
            locale: DevicePreview.locale(context),
            builder: DevicePreview.appBuilder,
            theme: state is ThemeLight ? themeLight() : themeDark(),
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            // home: const CounterPage(),
            home: SearchForm(),
          );
        },
      ),
    );
  }
}
