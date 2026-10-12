import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:luxury_wheel_flutter/screens/luxury_home_screen.dart';
import 'package:luxury_wheel_flutter/widgets/booking_qr_code.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:luxury_wheel_flutter/client.dart';

void main() {
  testWidgets('shows the rental home and primary navigation', (tester) async {
    await initializeClient();
    await tester.pumpWidget(const MaterialApp(home: LuxuryHomeScreen()));
    await tester.pump();

    expect(find.text('LUXURY WHEEL'), findsOneWidget);
    expect(find.text('The art of\narriving.'), findsOneWidget);
    expect(find.text('Discover'), findsOneWidget);
    expect(find.text('My trips'), findsOneWidget);

    await tester.tap(find.text('Rewards'));
    await tester.pumpAndSettle();
    expect(find.text('The Wheel Circle'), findsOneWidget);
    expect(find.text('0'), findsOneWidget);
    expect(
      find.textContaining('Earn 1 point for every 10 SAR'),
      findsOneWidget,
    );
    expect(
      find.textContaining('Every 100 points gives you 10 SAR off'),
      findsOneWidget,
    );
  });

  testWidgets('car search starts with city then moves to category', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: LuxuryHomeScreen()));
    await tester.pump();

    await tester.tap(find.text('Riyadh').first);
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.text('Choose your city'), findsOneWidget);

    await tester.tap(find.text('Jeddah').last);
    await tester.tap(find.text('Continue'));
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.text('Choose a category'), findsOneWidget);
  });

  testWidgets('renders a booking QR containing its booking reference', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: BookingQrCode(bookingReference: 'LW-12345')),
      ),
    );

    expect(find.byType(QrImageView), findsOneWidget);
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Semantics &&
            widget.properties.label == 'Booking QR code for LW-12345',
      ),
      findsOneWidget,
    );
  });

  testWidgets('QR dialog opens and closes without a layout exception', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => TextButton(
              onPressed: () => showDialog<void>(
                context: context,
                builder: (_) => const BookingQrDialog(
                  title: 'Approved booking',
                  bookingReference: 'LW-12345',
                  details: [Text('Status: approved')],
                ),
              ),
              child: const Text('Open booking QR'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open booking QR'));
    await tester.pumpAndSettle();

    expect(find.byType(QrImageView), findsOneWidget);
    expect(find.text('Booking LW-12345'), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.tap(find.text('Close'));
    await tester.pumpAndSettle();

    expect(find.byType(BookingQrDialog), findsNothing);
    expect(tester.takeException(), isNull);
  });
}
