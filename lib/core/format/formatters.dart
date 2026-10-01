import 'package:intl/intl.dart';

/// Formats a cost in the currency the model quoted, falling back to USD when
/// the model left it out. intl prints unknown codes as-is rather than failing.
String formatMoney(num amount, {String? currency, String? locale}) {
  final code = (currency == null || currency.trim().isEmpty)
      ? 'USD'
      : currency.trim().toUpperCase();
  return NumberFormat.simpleCurrency(
    name: code,
    locale: locale,
    decimalDigits: amount == amount.roundToDouble() ? 0 : 2,
  ).format(amount);
}

String formatMoneyRange(
  num low,
  num high, {
  String? currency,
  String? locale,
}) {
  if (low == high) return formatMoney(low, currency: currency, locale: locale);
  return '${formatMoney(low, currency: currency, locale: locale)}'
      ' to ${formatMoney(high, currency: currency, locale: locale)}';
}
