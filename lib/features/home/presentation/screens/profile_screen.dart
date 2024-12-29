import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manasa_dashboard/core/constants.dart';
import 'package:manasa_dashboard/core/extensions/mediaQuery_extensions.dart';
import 'package:manasa_dashboard/core/utils/app_router.dart';
import 'package:manasa_dashboard/core/utils/widgets/custom_button_small.dart';
import 'package:manasa_dashboard/core/utils/widgets/custom_go_navigator.dart';
import 'package:manasa_dashboard/core/utils/widgets/custom_text_rich.dart';
import 'package:manasa_dashboard/features/home/data/models/user_specific_data_model.dart';
import 'package:manasa_dashboard/features/home/managers/cubit/home_cubit.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? image;

  List<String>? images;

  String? primary;

  List<String>? anotherSpacifications;

  List<String>? availabletowork;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is GetUserDataSuccess) {
          for (var element in state.userData.data?.pictures ?? []) {
            if (element.fileTypetId == 1) {
              image = element.url;
            } else {
              image = null;
            }
          }

          images = state.userData.data?.pictures
                  ?.where((element) => element.fileTypetId == 3)
                  .map((e) => e.url ?? 'غير متوفر')
                  .toList() ??
              [];

          availabletowork = state.userData.data?.availableWorks
                  ?.map((e) => e.name ?? 'غير متوفر')
                  .toList() ??
              [];

          // Find the primary specialization
          final primarySpecialization = state
              .userData.data?.specializationFields
              ?.firstWhere((element) => element.isPrimary == true,
                  orElse: () => SpecializationFields(
                        name: 'غير متوفر', // Default name
                        isPrimary: false, // Default isPrimary value
                      ));
          primary = primarySpecialization?.name;

          // Collect other specializations
          anotherSpacifications = state.userData.data?.specializationFields
                  ?.where((element) => element.isPrimary == false)
                  .map((e) => e.name ?? 'غير متوفر')
                  .toList() ??
              [];
        }
        if (state is DeleteAccountSuccess) {
          customGoAndDeleteNavigate(
              context: context, path: AppRouter.kHomeLayout);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green,
              content: Text(state.message),
            ),
          );
        } else if (state is DeleteAccountFaluir) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(state.errorMessage),
            ),
          );
        }
        if (state is UpdateProfileSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green,
              content: Text(state.message),
            ),
          );
        } else if (state is UpdateProfileFaluir) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(state.errorMessage),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
            body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: state is GetUserDataLoading || state is UpdateProfileLoading
                ? const Center(child: CircularProgressIndicator())
                : state is GetUserDataFailure
                    ? const Text(
                        "Failed to load user data. Please try again later.")
                    : state is GetUserDataSuccess
                        ? Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Container(
                                          height: context.hightMediaQuery * 0.4,
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black,
                                                  offset: Offset(0, 1),
                                                  blurRadius: 2,
                                                  spreadRadius: 0.1)
                                            ],
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: CachedNetworkImage(
                                                fit: BoxFit.cover,
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                                placeholder: (context, url) =>
                                                    const Center(
                                                        child:
                                                            CircularProgressIndicator()),
                                                imageUrl: image ?? ''),
                                          ))),
                                  const SizedBox(
                                    width: 24,
                                  ),
                                  Expanded(
                                      flex: 3,
                                      child: IntrinsicHeight(
                                        child: Container(
                                            padding: const EdgeInsets.all(12),
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black,
                                                    offset: Offset(0, 1),
                                                    blurRadius: 2,
                                                    spreadRadius: 0.1)
                                              ],
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          CustomTextRich(
                                                            firstText:
                                                                ':عنوان المكتب ',
                                                            secondText:
                                                                '${state.userData.data?.address}, ${state.userData.data?.governorate}, ${state.userData.data?.district}' ??
                                                                    'غير متوفر',
                                                          ),
                                                          CustomTextRich(
                                                            firstText:
                                                                'الحالة :',
                                                            secondText:
                                                                availabletowork
                                                                        ?.join(
                                                                            ', ') ??
                                                                    'غير متوفر',
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          CustomTextRich(
                                                            firstText:
                                                                'التخصصات الاخري : ',
                                                            secondText: anotherSpacifications ==
                                                                    []
                                                                ? 'غير متوفر'
                                                                : anotherSpacifications
                                                                        ?.join(
                                                                            ', ') ??
                                                                    'غير متوفر',
                                                          ),
                                                          CustomTextRich(
                                                            firstText:
                                                                ': النقابة التابع لها ',
                                                            secondText: state
                                                                    .userData
                                                                    .data
                                                                    ?.barAssociation ??
                                                                'غير متوفر',
                                                          ),
                                                          CustomTextRich(
                                                            firstText:
                                                                ': ليسانس حقوق عام ',
                                                            secondText: state
                                                                    .userData
                                                                    .data
                                                                    ?.generalLawBachelor ??
                                                                'غير متوفر',
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          CustomTextRich(
                                                            firstText:
                                                                ': درجة القيد',
                                                            secondText: state
                                                                    .userData
                                                                    .data
                                                                    ?.registrationGrade ??
                                                                'غير متوفر',
                                                          ),
                                                          CustomTextRich(
                                                            firstText:
                                                                ': رقم القيد',
                                                            secondText: state
                                                                    .userData
                                                                    .data
                                                                    ?.registrationNumber ??
                                                                'غير متوفر',
                                                          ),
                                                          CustomTextRich(
                                                            firstText:
                                                                ': التتخصص الأساسي',
                                                            secondText:
                                                                primary ??
                                                                    'غير متوفر',
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          CustomTextRich(
                                                            firstText:
                                                                ': الاسم',
                                                            secondText: state
                                                                    .userData
                                                                    .data
                                                                    ?.name ??
                                                                'غير متوفر',
                                                          ),
                                                          CustomTextRich(
                                                            firstText:
                                                                ' :رقم الموبيل',
                                                            secondText: state
                                                                    .userData
                                                                    .data
                                                                    ?.mobileNo ??
                                                                'غير متوفر',
                                                          ),
                                                          CustomTextRich(
                                                            firstText:
                                                                ' :الايميل',
                                                            secondText: state
                                                                    .userData
                                                                    .data
                                                                    ?.email ??
                                                                'غير متوفر',
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Expanded(
                                                  child: CustomTextRich(
                                                    firstText:
                                                        ': الرؤية الشخصية',
                                                    secondText: state
                                                            .userData
                                                            .data
                                                            ?.description ??
                                                        'غير متوفر',
                                                  ),
                                                ),
                                              ],
                                            )),
                                      )),
                                ],
                              ),
                              const SizedBox(height: 50),
                              state.userData.data?.pictures != null &&
                                      images!.length >= 2
                                  ? IntrinsicWidth(
                                      child: Container(
                                          height: context.hightMediaQuery * 0.3,
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black,
                                                  offset: Offset(0, 1),
                                                  blurRadius: 2,
                                                  spreadRadius: 0.1)
                                            ],
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Flexible(
                                                  child: IntrinsicHeight(
                                                    child: CachedNetworkImage(
                                                        fit: BoxFit.cover,
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            const Icon(
                                                                Icons.error),
                                                        placeholder: (context,
                                                                url) =>
                                                            const Center(
                                                                child:
                                                                    CircularProgressIndicator()),
                                                        imageUrl:
                                                            images?[0] ?? ''),
                                                  ),
                                                ),
                                                const SizedBox(width: 50),
                                                Flexible(
                                                  child: IntrinsicHeight(
                                                    child: CachedNetworkImage(
                                                        fit: BoxFit.cover,
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            const Icon(
                                                                Icons.error),
                                                        placeholder: (context,
                                                                url) =>
                                                            const Center(
                                                                child:
                                                                    CircularProgressIndicator()),
                                                        imageUrl:
                                                            images?[1] ?? ''),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )),
                                    )
                                  : const SizedBox(),
                              const SizedBox(height: 50),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomButtonSmall(
                                    function: () {
                                      HomeCubit.get(context)?.deleteAccount(
                                          userID:
                                              state.userData.data?.userId ?? 0);
                                    },
                                    text: "حذف",
                                    borderColor: Colors.red,
                                    color: Colors.red,
                                  ),
                                  state.userData.data?.status == 'موقوف '
                                      ? CustomButtonSmall(
                                          function: () {
                                            HomeCubit.get(context)
                                                ?.updateProfileSetting(
                                              userID:
                                                  state.userData.data?.userId ??
                                                      0,
                                              status: 1,
                                            );
                                          },
                                          text: "ايقاف الوقف",
                                          borderColor: kPrimaryKey,
                                          color: kPrimaryKey,
                                        )
                                      : CustomButtonSmall(
                                          function: () {
                                            HomeCubit.get(context)
                                                ?.updateProfileSetting(
                                              userID:
                                                  state.userData.data?.userId ??
                                                      0,
                                              status: 2,
                                            );
                                          },
                                          text: "وقف",
                                          borderColor: kPrimaryKey,
                                          color: kPrimaryKey,
                                        ),
                                ],
                              )
                            ],
                          )
                        : null,
          ),
        ));
      },
    );
  }
}
