import 'package:intl/intl.dart';

String formatPrice(dynamic price) {
  if (price is int || price is double) {
    return _formatDoublePrice(price.toDouble());
  }

  if (price is String) {
    double? parsedPrice = double.tryParse(price.replaceAll(RegExp(r'[^0-9.]'), ''));
    if (parsedPrice != null) {
      return _formatDoublePrice(parsedPrice);
    }
  }
  return "₺0,00";
}

String _formatDoublePrice(double price) {
  final NumberFormat currencyFormatter = NumberFormat.currency(
    locale: 'tr_TR',
    symbol: '₺',
    decimalDigits: 2,
  );

  return currencyFormatter.format(price);
}
