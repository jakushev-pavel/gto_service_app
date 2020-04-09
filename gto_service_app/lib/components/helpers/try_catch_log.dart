T tryCatchLog<T>(T Function() cb) {
  try {
    return cb();
  } catch (e, s) {
    print(e.toString());
    print(s.toString());
    rethrow;
  }
}
