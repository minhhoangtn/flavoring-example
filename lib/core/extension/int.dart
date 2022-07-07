extension IntExtension on int {
  DateTime fromEpoch() => DateTime.fromMillisecondsSinceEpoch(this);
}
