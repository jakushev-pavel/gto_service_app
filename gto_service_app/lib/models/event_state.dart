enum EventState {
  Preparation,
  Ready,
  InProgress,
  Finished,
}

extension EventStateEx on EventState {
  static EventState fromStr(String str) {
    switch (str.toLowerCase()) {
      case "подготовка":
        return EventState.Preparation;
      case "готовность":
        return EventState.Ready;
      case "провеение":
        return EventState.InProgress;
      case "завершен":
        return EventState.Finished;
      default:
        throw Exception("Invalid event state");
    }
  }

  String toStr() {
    switch (this) {
      case EventState.Preparation:
        return "подготовка";
      case EventState.Ready:
        return "готовность";
      case EventState.InProgress:
        return "проведение";
      case EventState.Finished:
        return "завершен";
      default:
        throw Exception("Invalid event state");
    }
  }

  EventState next() {
    switch (this) {
      case EventState.Preparation:
        return EventState.Ready;
      case EventState.Ready:
        return EventState.InProgress;
      case EventState.InProgress:
        return EventState.Finished;
      case EventState.Finished:
        return EventState.Finished;
      default:
        throw Exception("Invalid event state");
    }
  }
}