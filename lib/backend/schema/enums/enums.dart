import 'package:collection/collection.dart';

enum WhereYouCoach {
  online,
  inPerson,
  hybrid,
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
    case (WhereYouCoach):
      return WhereYouCoach.values.deserialize(value) as T?;
    default:
      return null;
  }
}
