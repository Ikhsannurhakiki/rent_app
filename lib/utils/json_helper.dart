int asInt(dynamic value) {
  if (value == null) return 0;
  if (value is int) return value;
  if (value is String) return int.tryParse(value) ?? 0;
  return 0;
}

double asDouble(dynamic value) {
  if (value == null) return 0.0;
  if (value is double) return value;
  if (value is int) return value.toDouble();
  if (value is String) return double.tryParse(value) ?? 0.0;
  return 0.0;
}

DateTime asDateTime(dynamic value) {
  if (value == null) return DateTime(2000);
  if (value is DateTime) return value;
  if (value is String) return DateTime.tryParse(value) ?? DateTime(2000);
  return DateTime(2000);
}
