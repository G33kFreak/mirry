part of 'user_recognition_bloc.dart';

abstract class UserRecognitionEvent extends Equatable {
  const UserRecognitionEvent();

  @override
  List<Object?> get props => [];
}

@autoequalMixin
class UserChanged extends UserRecognitionEvent
    with _$UserChangedAutoequalMixin {
  final User? newUser;
  const UserChanged(this.newUser);
}
