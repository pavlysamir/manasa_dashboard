import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manasa_dashboard/core/Assets/assets.dart';
import 'package:manasa_dashboard/core/api/dio_consumer.dart';
import 'package:manasa_dashboard/core/api/end_ponits.dart';
import 'package:manasa_dashboard/core/constants.dart';
import 'package:manasa_dashboard/core/extensions/mediaQuery_extensions.dart';
import 'package:manasa_dashboard/core/utils/app_router.dart';
import 'package:manasa_dashboard/core/utils/service_locator.dart';
import 'package:manasa_dashboard/core/utils/styles.dart';
import 'package:manasa_dashboard/core/utils/widgets/custom_button_large.dart';
import 'package:manasa_dashboard/core/utils/widgets/custom_form_field.dart';
import 'package:manasa_dashboard/core/utils/widgets/custom_go_navigator.dart';
import 'package:manasa_dashboard/core/utils/widgets/validation_handling.dart';
import 'package:manasa_dashboard/features/login/data/login_repo/login_repo.dart';
import 'package:manasa_dashboard/features/login/manager/cubit/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(LoginRepo(getIt.get<DioConsumer>())),
      child: Scaffold(
        body: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              ApiKey.authenticated = true;

              customGoAndDeleteNavigate(
                  context: context, path: AppRouter.kHomeLayout);
              LoginCubit.get(context)!.clearData();

              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(builder: (context) => const HomeScreen()),
              // );
            }
            if (state is LoginFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  content: Text(state.message),
                ),
              );
              LoginCubit.get(context)!.clearData();
            }
          },
          builder: (context, state) {
            final cubit = LoginCubit.get(context)!;
            return SingleChildScrollView(
              child: Form(
                key: cubit.formScreenLoginrKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: context.widthMediaQuery,
                    ),
                    Image.asset(AssetsData.logo),
                    SizedBox(
                      height: context.hightMediaQuery * 0.1,
                    ),
                    Text(
                      'تسجيل الدخول',
                      style: Styles.textStyle32Black,
                    ),
                    SizedBox(
                      height: context.hightMediaQuery * 0.03,
                    ),
                    CustomFormField(
                      controller: cubit.phoneController,
                      hintText: 'رقم الهاتف',
                      textInputType: TextInputType.phone,
                      validationMassage: conditionOfValidationPhone,
                    ),
                    SizedBox(
                      height: context.hightMediaQuery * 0.03,
                    ),
                    CustomFormField(
                      isEyeTrue: cubit.ifPasswordVisible,
                      suffixIcon: IconButton(
                        onPressed: () {
                          LoginCubit.get(context)!.isVisiblePasswordEye();
                        },
                        icon: Icon(LoginCubit.get(context)!.iconDataPassword),
                      ),
                      controller: cubit.passwordController,
                      validationMassage: conditionOfValidationPassWord,
                      hintText: 'كلمة المرور',
                      textInputType: TextInputType.visiblePassword,
                    ),
                    SizedBox(
                      height: context.hightMediaQuery * 0.1,
                    ),
                    state is LoginLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                            color: kPrimaryKey,
                          ))
                        : CustomButtonLarge(
                            text: 'تسجيل الدخول',
                            textColor: Colors.white,
                            function: () async {
                              if (cubit.formScreenLoginrKey.currentState!
                                  .validate()) {
                                cubit.login();
                              }
                            }),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
