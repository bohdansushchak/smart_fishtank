// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Hasło`
  String get password {
    return Intl.message(
      'Hasło',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Załoguj`
  String get signIn {
    return Intl.message(
      'Załoguj',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  /// `{type, select, light{Oświetlenie} uv{Lampa UV} co2{CO₂} airPump{Napowietrzacz} other{{type}}}`
  String socketTypeSelect(Object type) {
    return Intl.select(
      type,
      {
        'light': 'Oświetlenie',
        'uv': 'Lampa UV',
        'co2': 'CO₂',
        'airPump': 'Napowietrzacz',
        'other': '$type',
      },
      name: 'socketTypeSelect',
      desc: '',
      args: [type],
    );
  }

  /// `Zapisz`
  String get save {
    return Intl.message(
      'Zapisz',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Wyłącz`
  String get disable {
    return Intl.message(
      'Wyłącz',
      name: 'disable',
      desc: '',
      args: [],
    );
  }

  /// `g`
  String get hour {
    return Intl.message(
      'g',
      name: 'hour',
      desc: '',
      args: [],
    );
  }

  /// `min.`
  String get minutes {
    return Intl.message(
      'min.',
      name: 'minutes',
      desc: '',
      args: [],
    );
  }

  /// `Od {timeFrom} do {timeTo}`
  String timeFromTo(Object timeFrom, Object timeTo) {
    return Intl.message(
      'Od $timeFrom do $timeTo',
      name: 'timeFromTo',
      desc: '',
      args: [timeFrom, timeTo],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'pl'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
