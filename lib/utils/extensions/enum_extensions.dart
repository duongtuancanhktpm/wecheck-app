extension EnumExtensions on Enum {
  String get text => toString().split('.').last;
}
