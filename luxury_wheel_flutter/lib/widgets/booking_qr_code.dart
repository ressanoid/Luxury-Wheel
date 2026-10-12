import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class BookingQrCode extends StatelessWidget {
  const BookingQrCode({
    required this.bookingReference,
    super.key,
  });

  final String bookingReference;

  @override
  Widget build(BuildContext context) {
    final payload = jsonEncode({
      'type': 'luxury-wheel-booking',
      'reference': bookingReference,
    });

    return Semantics(
      label: 'Booking QR code for $bookingReference',
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: QrImageView(
          data: payload,
          size: 220,
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}

class BookingQrDialog extends StatelessWidget {
  const BookingQrDialog({
    required this.title,
    required this.bookingReference,
    this.details = const [],
    super.key,
  });

  final String title;
  final String bookingReference;
  final List<Widget> details;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final dialogWidth = (screenSize.width - 48).clamp(0.0, 400.0);
    final dialogHeight = screenSize.height * 0.85;

    return Dialog(
      backgroundColor: const Color(0xFFF7F6F1),
      child: SizedBox(
        width: dialogWidth,
        height: dialogHeight,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 12, 8),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  IconButton(
                    tooltip: 'Close',
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Booking $bookingReference',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 8),
                    ...details,
                    const SizedBox(height: 12),
                    BookingQrCode(bookingReference: bookingReference),
                    const SizedBox(height: 12),
                    const Text(
                      'Booking QR only — not a tax invoice or ZATCA e-invoice QR.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11,
                        color: Color(0xFF77786F),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
