enum MirrySocketActions {
  connection,
  faceRecognized,
  recognizedUserLeft,
  brushingTeethStarted,
}

extension GetKebabCase on MirrySocketActions {
  String get value {
    switch (this) {
      case MirrySocketActions.connection:
        return 'connection';
      case MirrySocketActions.faceRecognized:
        return 'face-recognized';
      case MirrySocketActions.recognizedUserLeft:
        return 'recognized-user-left';
      case MirrySocketActions.brushingTeethStarted:
        return 'brushing-teeth-started';
    }
  }
}
