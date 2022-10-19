enum MirrySocketActions {
  connection,
  faceRecognized,
  recognizedUserLeft,
  brushingTeethStarted,
  brushingTeethStoped,
  todoItemChanged,
  todoItemAdded,
  todoItemDeleted,
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
      case MirrySocketActions.brushingTeethStoped:
        return 'brushing-teeth-stoped';
      case MirrySocketActions.todoItemChanged:
        return 'todo-item-changed';
      case MirrySocketActions.todoItemAdded:
        return 'todo-item-added';
      case MirrySocketActions.todoItemDeleted:
        return 'todo-item-deleted';
    }
  }
}
