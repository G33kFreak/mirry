part of 'teeth_brushing_module_bloc.dart';

@autoequalMixin
class TeethBrushingModuleState extends Equatable
    with _$TeethBrushingModuleStateAutoequalMixin {
  final int progress;
  final BrushingState brushingState;

  const TeethBrushingModuleState({
    this.progress = 0,
    this.brushingState = const IdleState(),
  });

  TeethBrushingModuleState copyWith({
    int? progress,
    BrushingState? brushingState,
  }) =>
      TeethBrushingModuleState(
        progress: progress ?? this.progress,
        brushingState: brushingState ?? this.brushingState,
      );
}
