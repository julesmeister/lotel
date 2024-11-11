import 'package:collection/collection.dart';

enum Hotels {
  Serenity,
  MyLifestyle,
}

enum DateRange {
  Start,
  End,
}

extension FFEnumExtensions<T extends Enum> on T {
  String serialize() => name;
}

extension FFEnumListExtensions<T extends Enum> on Iterable<T> {
  T? deserialize(String? value) =>
      firstWhereOrNull((e) => e.serialize() == value);
}

T? deserializeEnum<T>(String? value) {
  switch (T) {
    case (Hotels):
      return Hotels.values.deserialize(value) as T?;
    case (DateRange):
      return DateRange.values.deserialize(value) as T?;
    default:
      return null;
  }
}
