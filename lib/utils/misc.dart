class Misc {
  static T stringToEnum<T>(String stringEnum, Iterable<T> values) => values
      .firstWhere((element) => element.toString().split('.')[1] == stringEnum);
}
