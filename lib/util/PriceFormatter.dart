import 'package:intl/intl.dart';

String formatPrice(dynamic price) {
  // Eğer price zaten int ise direkt formatla
  if (price is int) {
    return _formatIntPrice(price);
  }

  // Eğer price String olarak geliyorsa, int'e çevir
  if (price is String) {
    int? parsedPrice = int.tryParse(price.replaceAll(RegExp(r'[^0-9]'), ''));
    if (parsedPrice != null) {
      return _formatIntPrice(parsedPrice);
    }
  }

  // Eğer price null veya dönüştürülemezse varsayılan değer döndür
  return "₺0,00";
}

// Asıl formatlayan yardımcı metod
String _formatIntPrice(int price) {
  final NumberFormat currencyFormatter = NumberFormat.currency(
    locale: 'tr_TR', // Türkçe format
    symbol: '₺',     // TL sembolü
    decimalDigits: 2, // Kuruş olarak 2 hane
  );

  return currencyFormatter.format(price);
}
