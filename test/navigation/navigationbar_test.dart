


import 'package:buecherteam_2023_desktop/Resources/text.dart';
import 'package:buecherteam_2023_desktop/Theme/color_scheme.dart';
import 'package:buecherteam_2023_desktop/Theme/text_theme.dart';
import 'package:buecherteam_2023_desktop/UI/navigation/navigation_button.dart';
import 'package:buecherteam_2023_desktop/UI/navigation/navigationbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main () {

  Widget createWidgetUnderTest () {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: lightColorScheme,
        useMaterial3: true,
        fontFamily: 'Helvetica Neue',
        textTheme: textTheme,
      ),
      home: const LfgNavigationBar()
    );
  }

  testWidgets("test if rendered correctly and initial states", (tester) async{
   await tester.pumpWidget(createWidgetUnderTest());
   await tester.pumpAndSettle(const Duration(milliseconds: 260));
   final studentButton = find.byKey(const Key(TextRes.student));
   final bookButton = find.byKey(const Key(TextRes.book));
   expect(studentButton, findsOneWidget);
   expect(bookButton, findsOneWidget);

   final NavigationButton studentNavButton = tester.widget(studentButton);
   final NavigationButton bookNavButton = tester.widget(bookButton);
   expect(studentNavButton.isClicked, true);
   expect(bookNavButton.isClicked, false);

  });

  testWidgets("test if switching buttons works", (tester) async{
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle(const Duration(milliseconds: 260));
    final studentButton = find.byKey(const Key(TextRes.student));
    final bookButton = find.byKey(const Key(TextRes.book));
    await tester.tap(bookButton);
    await tester.pumpAndSettle();
    final NavigationButton studentNavButton = tester.widget(studentButton);
    final NavigationButton bookNavButton = tester.widget(bookButton);
    expect(studentNavButton.isClicked, false);
    expect(bookNavButton.isClicked, true);

  });

  testWidgets("test if tapping the same buttons changes something", (tester) async{
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle(const Duration(milliseconds: 260));
    final studentButton = find.byKey(const Key(TextRes.student));
    final bookButton = find.byKey(const Key(TextRes.book));
    await tester.tap(studentButton);
    await tester.pumpAndSettle();
    final NavigationButton studentNavButton = tester.widget(studentButton);
    final NavigationButton bookNavButton = tester.widget(bookButton);
    expect(studentNavButton.isClicked, true);
    expect(bookNavButton.isClicked, false);

  });

  testWidgets("test if some switches in a row work", (tester) async{
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle(const Duration(milliseconds: 260));

    final studentButton = find.byKey(const Key(TextRes.student));
    final bookButton = find.byKey(const Key(TextRes.book));

    NavigationButton studentNavButton = tester.widget(studentButton);
    NavigationButton bookNavButton = tester.widget(bookButton);

    await tester.tap(bookButton);
    await tester.pumpAndSettle(const Duration(milliseconds: 260));
    studentNavButton = tester.widget(studentButton);
    bookNavButton = tester.widget(bookButton);
    expect(studentNavButton.isClicked, false);
    expect(bookNavButton.isClicked, true);

    await tester.tap(studentButton);
    await tester.pumpAndSettle(const Duration(milliseconds: 260));
    studentNavButton = tester.widget(studentButton);
    bookNavButton = tester.widget(bookButton);
    expect(studentNavButton.isClicked, true);
    expect(bookNavButton.isClicked, false);

    await tester.tap(bookButton);
    await tester.pumpAndSettle(const Duration(milliseconds: 260));
    studentNavButton = tester.widget(studentButton);
    bookNavButton = tester.widget(bookButton);
    expect(studentNavButton.isClicked, false);
    expect(bookNavButton.isClicked, true);

    await tester.tap(studentButton);
    await tester.pumpAndSettle(const Duration(milliseconds: 260));
    studentNavButton = tester.widget(studentButton);
    bookNavButton = tester.widget(bookButton);
    expect(studentNavButton.isClicked, true);
    expect(bookNavButton.isClicked, false);

    await tester.tap(studentButton);
    await tester.pumpAndSettle(const Duration(milliseconds: 260));
    studentNavButton = tester.widget(studentButton);
    bookNavButton = tester.widget(bookButton);
    expect(studentNavButton.isClicked, true);
    expect(bookNavButton.isClicked, false);

  });





}