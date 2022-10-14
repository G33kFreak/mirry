abstract class BrushingState {
  const BrushingState();
}

class IdleState extends BrushingState {
  const IdleState();
}

class PausedState extends BrushingState {
  const PausedState();
}

class InProgressState extends BrushingState {
  const InProgressState();
}

class FinishedState extends BrushingState {
  const FinishedState();
}
