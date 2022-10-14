part of 'teeth_brushing_module_bloc.dart';

abstract class TeethBrushingModuleEvent extends Equatable {
  const TeethBrushingModuleEvent();

  @override
  List<Object?> get props => [];
}

@autoequalMixin
class ProgressChanged extends TeethBrushingModuleEvent
    with _$ProgressChangedAutoequalMixin {
  final int newValue;
  const ProgressChanged(this.newValue);
}

@autoequalMixin
class BrushingStateChanged extends TeethBrushingModuleEvent
    with _$BrushingStateChangedAutoequalMixin {
  final BrushingState newValue;

  const BrushingStateChanged(this.newValue);
}
