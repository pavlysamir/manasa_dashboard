part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class GetAllUsersLoading extends HomeState {}

final class GetMoreUsersLoading extends HomeState {}

final class GetAllUsersSuccess extends HomeState {}

final class GetAllUsersFailure extends HomeState {
  final String message;
  GetAllUsersFailure({required this.message});
}

final class GetSearchedUsersLoading extends HomeState {}

final class GetSearchedUsersSuccess extends HomeState {}

final class GetMoreSearchedUsersSuccess extends HomeState {}

final class GetSearchedUsersFailure extends HomeState {
  final String message;
  GetSearchedUsersFailure({required this.message});
}

final class GetUserDataLoading extends HomeState {}

final class GetUserDataSuccess extends HomeState {
  final UserData userData;
  GetUserDataSuccess({required this.userData});
}

final class GetUserDataFailure extends HomeState {
  final String message;
  GetUserDataFailure({required this.message});
}

final class DeleteAccountLoading extends HomeState {}

final class DeleteAccountFaluir extends HomeState {
  final String errorMessage;

  DeleteAccountFaluir(this.errorMessage);
}

final class DeleteAccountSuccess extends HomeState {
  final String message;

  DeleteAccountSuccess(this.message);
}

final class UpdateProfileLoading extends HomeState {}

final class UpdateProfileFaluir extends HomeState {
  final String errorMessage;

  UpdateProfileFaluir(this.errorMessage);
}

final class UpdateProfileSuccess extends HomeState {
  final String message;

  UpdateProfileSuccess(this.message);
}
