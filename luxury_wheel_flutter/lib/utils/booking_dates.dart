class BookingDates {
  static const maxRentalDays = 30;

  static DateTime dateOnly(DateTime date) =>
      DateTime(date.year, date.month, date.day);

  static DateTime earliestReturnDate(
    DateTime pickupDate, {
    DateTime? today,
  }) {
    return _effectivePickupDate(pickupDate, today: today).add(
      const Duration(days: 1),
    );
  }

  static DateTime latestReturnDate(
    DateTime pickupDate, {
    DateTime? today,
  }) => _effectivePickupDate(
    pickupDate,
    today: today,
  ).add(const Duration(days: maxRentalDays));

  static DateTime clampDate(
    DateTime date,
    DateTime firstDate,
    DateTime lastDate,
  ) {
    final day = dateOnly(date);
    final firstDay = dateOnly(firstDate);
    final lastDay = dateOnly(lastDate);
    if (day.isBefore(firstDay)) return firstDay;
    if (day.isAfter(lastDay)) return lastDay;
    return day;
  }

  static DateTime adjustReturnDate(
    DateTime returnDate,
    DateTime pickupDate, {
    DateTime? today,
  }) {
    final firstDate = earliestReturnDate(pickupDate, today: today);
    final lastDate = latestReturnDate(pickupDate, today: today);
    return clampDate(returnDate, firstDate, lastDate);
  }

  static int daysBetween(DateTime start, DateTime end) {
    final startDate = dateOnly(start);
    final endDate = dateOnly(end);
    return DateTime.utc(
          endDate.year,
          endDate.month,
          endDate.day,
        )
        .difference(
          DateTime.utc(startDate.year, startDate.month, startDate.day),
        )
        .inDays;
  }

  static DateTime _effectivePickupDate(
    DateTime pickupDate, {
    DateTime? today,
  }) {
    final firstPickupDate = dateOnly(pickupDate);
    final todayDate = dateOnly(today ?? DateTime.now());
    return firstPickupDate.isBefore(todayDate) ? todayDate : firstPickupDate;
  }
}
