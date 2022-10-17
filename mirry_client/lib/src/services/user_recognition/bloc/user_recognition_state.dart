part of 'user_recognition_bloc.dart';

@autoequalMixin
class UserRecognitionState extends Equatable
    with _$UserRecognitionStateAutoequalMixin {
  final User? currentUser;

  const UserRecognitionState({this.currentUser});

  UserRecognitionState copyWyth({
    User? currentUserId,
  }) =>
      UserRecognitionState(
        currentUser: currentUserId,
      );
}
