extension StringExtensions on String {
  int? toInt() {
    try {
      return int.parse(this);
    } catch (e) {
      return null;
    }
  }
}

extension StringNullX on String? {
  bool get isEmptyOrNull => this?.isEmpty ?? true;
}
