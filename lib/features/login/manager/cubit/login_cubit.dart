import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manasa_dashboard/features/login/data/login_repo/login_repo.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.loginRepo) : super(LoginInitial());

  final LoginRepo loginRepo;
  IconData iconDataPassword = Icons.visibility_off;
  bool ifPasswordVisible = true;
  var formScreenLoginrKey = GlobalKey<FormState>();

  void isVisiblePasswordEye() {
    ifPasswordVisible = !ifPasswordVisible;
    iconDataPassword =
        ifPasswordVisible ? Icons.visibility_off : Icons.remove_red_eye;
    emit(LoginPasswordVisibleEye());
  }

  static LoginCubit? get(context) => BlocProvider.of(context);

  TextEditingController phoneController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  login() async {
    emit(LoginLoading());
    final response =
        await loginRepo.login(phoneController.text, passwordController.text);

    response.fold(
      (errMessage) => emit(LoginFailure(message: errMessage)),
      (login) {
        emit(LoginSuccess());
      },
    );
  }

  clearData() {
    phoneController.clear();
    passwordController.clear();
  }
}
