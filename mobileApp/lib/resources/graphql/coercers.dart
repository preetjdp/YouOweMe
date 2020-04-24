DateTime fromGraphQLDateTimeToDartDateTime(int timestamp) {
  return DateTime.fromMillisecondsSinceEpoch(timestamp);
}

int fromDartDateTimeToGraphQLTimestamp(DateTime timestamp) {
  return timestamp.millisecondsSinceEpoch;
}
