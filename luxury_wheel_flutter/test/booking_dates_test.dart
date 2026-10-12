import 'package:flutter_test/flutter_test.dart';
import 'package:luxury_wheel_flutter/utils/booking_dates.dart';

void main() {
  group('BookingDates', () {
    final today = DateTime(2026, 10, 12);

    test(
      'return picker starts the day after pick-up and ends after 30 days',
      () {
        final pickup = DateTime(2026, 10, 20, 18, 30);

        expect(
          BookingDates.earliestReturnDate(pickup, today: today),
          DateTime(2026, 10, 21),
        );
        expect(
          BookingDates.latestReturnDate(pickup, today: today),
          DateTime(2026, 11, 19),
        );
      },
    );

    test('adjusts return date into the valid range after pick-up changes', () {
      final pickup = DateTime(2026, 10, 20);

      expect(
        BookingDates.adjustReturnDate(
          DateTime(2026, 10, 15),
          pickup,
          today: today,
        ),
        DateTime(2026, 10, 21),
      );
      expect(
        BookingDates.adjustReturnDate(
          DateTime(2026, 12, 1),
          pickup,
          today: today,
        ),
        DateTime(2026, 11, 19),
      );
    });

    test('uses today when an existing pick-up date is in the past', () {
      expect(
        BookingDates.earliestReturnDate(
          DateTime(2026, 10, 1),
          today: today,
        ),
        DateTime(2026, 10, 13),
      );
      expect(
        BookingDates.latestReturnDate(
          DateTime(2026, 10, 1),
          today: today,
        ),
        DateTime(2026, 11, 11),
      );
    });

    test('counts calendar days independent of time of day', () {
      expect(
        BookingDates.daysBetween(
          DateTime(2026, 10, 20, 23, 59),
          DateTime(2026, 10, 21, 0, 1),
        ),
        1,
      );
    });
  });
}
