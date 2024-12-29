import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manasa_dashboard/features/home/data/home_repo/home_repo.dart';
import 'package:manasa_dashboard/features/home/data/models/user_data_model.dart';
import 'package:manasa_dashboard/features/home/data/models/user_specific_data_model.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeRepo) : super(HomeInitial());

  final HomeRepo homeRepo;

  static HomeCubit? get(context) => BlocProvider.of(context);

  TextEditingController searchController = TextEditingController();

  List<User> users = [];
  int? count;
  getAllUsers(int pageNumber) async {
    if (pageNumber == 1) {
      users.clear();
    }

    if (pageNumber == 1) {
      emit(GetAllUsersLoading());
    } else {
      emit(GetMoreUsersLoading());
    }
    final response = await homeRepo.getAllUsers(pageNumber: pageNumber);
    response.fold((errMessage) => emit(GetAllUsersFailure(message: errMessage)),
        (getAllUsers) {
      if (pageNumber == 1) {
        count = getAllUsers.responseData.count;
      }
      if (kDebugMode) {
        print(getAllUsers.responseData.items.length);
      }
      users.addAll(getAllUsers.responseData.items);
      emit(GetAllUsersSuccess());
    });
  }

  getSearchedUsers(int pageNumber) async {
    if (pageNumber == 1) {
      users.clear();
    }

    if (pageNumber == 1) {
      emit(GetSearchedUsersLoading());
    } else {
      emit(GetMoreUsersLoading());
    }
    final response = await homeRepo.getASearchedUsers(
      pageNumber: pageNumber,
      lawyerName: searchController.text,
    );
    response.fold(
        (errMessage) => emit(GetSearchedUsersFailure(message: errMessage)),
        (getAllUsers) {
      if (pageNumber == 1) {
        count = getAllUsers.responseData.count;
      }
      if (kDebugMode) {
        print(getAllUsers.responseData.items.length);
      }
      users.addAll(getAllUsers.responseData.items);
      if (pageNumber == 1) {
        emit(GetSearchedUsersSuccess());
      } else {
        emit(GetMoreSearchedUsersSuccess());
      }
    });
  }

  UserData? user;

  getUserData({required int userId}) async {
    emit(GetUserDataLoading());
    final response = await homeRepo.getUserData(userId: userId);

    response.fold((errMessage) => emit(GetUserDataFailure(message: errMessage)),
        (getUserData) {
      user = getUserData;
      emit(GetUserDataSuccess(userData: getUserData));
    });
  }

  bool isLoading = false;

  deleteAccount({required int userID}) async {
    emit(DeleteAccountLoading());
    isLoading = true;

    final response = await homeRepo.deleteAccount(userID: userID);

    response.fold(
      (errMessage) {
        isLoading = false;
        emit(DeleteAccountFaluir(errMessage));
      },
      (message) async {
        isLoading = false;

        emit(DeleteAccountSuccess(message));
      },
    );
  }

  updateProfileSetting({required int userID, required int status}) async {
    emit(UpdateProfileLoading());

    final response =
        await homeRepo.updateProfileSetting(userID: userID, status: status);

    response.fold(
      (errMessage) {
        emit(UpdateProfileFaluir(errMessage));
      },
      (message) async {
        emit(UpdateProfileSuccess(message));
        getUserData(userId: userID);
      },
    );
  }
}
