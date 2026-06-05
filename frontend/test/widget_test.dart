import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vertex_bit/main.dart';

void main() {
  testWidgets('home page renders key sections without desktop overflow', (
    WidgetTester tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(1280, 900));
    await tester.pumpWidget(const VertexBitApp());
    await tester.pumpAndSettle();

    expect(find.text('Vertex Bit'), findsWidgets);
    expect(find.text('Our Services'), findsWidgets);
    expect(find.text('Web Development'), findsWidgets);
    expect(tester.takeException(), isNull);
  });

  testWidgets('home page uses compact navigation on mobile', (
    WidgetTester tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    await tester.pumpWidget(const VertexBitApp());
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.menu), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('contact form validates required fields',
      (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(900, 900));
    await tester.pumpWidget(const VertexBitApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Get in Touch').first);
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Send Message'));
    await tester.tap(find.text('Send Message'));
    await tester.pumpAndSettle();

    expect(find.text('This field is required'), findsOneWidget);
    expect(find.text('Email is required'), findsOneWidget);
    expect(find.text('Phone is required'), findsOneWidget);
    expect(find.text('Message is required'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
