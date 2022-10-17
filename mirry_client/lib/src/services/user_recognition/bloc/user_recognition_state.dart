part of 'user_recognition_bloc.dart';

@autoequalMixin
class UserRecognitionState extends Equatable
    with _$UserRecognitionStateAutoequalMixin {
  final User? currentUserId;

  const UserRecognitionState({this.currentUserId});

  UserRecognitionState copyWyth({
    User? currentUserId,
  }) =>
      UserRecognitionState(
        currentUserId: currentUserId,
      );
}
