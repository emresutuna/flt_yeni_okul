import 'package:intl/intl.dart';

String formatPrice(dynamic price) {
  // Eğer price zaten double veya int ise formatla
  if (price is int || price is double) {
    return _formatDoublePrice(price.toDouble());
  }

  // Eğer price String olarak geliyorsa, double'a çevir
  if (price is String) {
    double? parsedPrice = double.tryParse(price.replaceAll(RegExp(r'[^0-9.]'), ''));
    if (parsedPrice != null) {
      return _formatDoublePrice(parsedPrice);
    }
  }

  // Eğer price null veya dönüştürülemezse varsayılan değer döndür
  return "₺0,00";
}

// Asıl formatlayan yardımcı metod
String _formatDoublePrice(double price) {
  final NumberFormat currencyFormatter = NumberFormat.currency(
    locale: 'tr_TR', // Türkçe format
    symbol: '₺',     // TL sembolü
    decimalDigits: 2, // Kuruş olarak 2 hane
  );

  return currencyFormatter.format(price);
}
