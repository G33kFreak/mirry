part of 'user_recognition_bloc.dart';

@autoequalMixin
class UserRecognitionState extends Equatable
    with _$UserRecognitionStateAutoequalMixin {
  final String? currentUserId;

  const UserRecognitionState({this.currentUserId});

  UserRecognitionState copyWyth({
    String? currentUserId,
  }) =>
      UserRecognitionState(
        currentUserId: currentUserId,
      );
}
