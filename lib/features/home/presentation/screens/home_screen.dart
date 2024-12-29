import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manasa_dashboard/core/constants.dart';
import 'package:manasa_dashboard/core/extensions/mediaQuery_extensions.dart';
import 'package:manasa_dashboard/core/utils/app_router.dart';
import 'package:manasa_dashboard/core/utils/widgets/custom_button_small.dart';
import 'package:manasa_dashboard/core/utils/widgets/custom_form_field.dart';
import 'package:manasa_dashboard/core/utils/widgets/custom_go_navigator.dart';
import 'package:manasa_dashboard/features/home/managers/cubit/home_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController? _scrollController;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    // HomeCubit.get(context)!
    //     .getAllUsers(pageNumber: pageNum); // Fetch initial data
    pageNum = 1;
    print('bavlyyyyyyyyyyyyyyyyyyy $pageNum');

    HomeCubit.get(context)!.getSearchedUsers(1);
    _scrollController!.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }

  void _scrollListener() async {
    if (_scrollController!.position.pixels >=
            0.7 * _scrollController!.position.maxScrollExtent &&
        !isLoading) {
      if (HomeCubit.get(context)!.count! !=
          HomeCubit.get(context)!.users.length) {
        isLoading = true;
        if (kDebugMode) {
          print("bavlyyyyyyyyyyyyyy${++pageNum}");
        }
        await HomeCubit.get(context)!.getSearchedUsers(++pageNum - 1);
        isLoading = false;
      } else {
        null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = HomeCubit.get(context)!;
        return Scaffold(
            body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: context.widthMediaQuery,
              ),
              SizedBox(
                height: context.hightMediaQuery * 0.04,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomFormField(
                      controller: cubit.searchController,
                      hintText: 'البحث',
                      onChanged: (value) {
                        HomeCubit.get(context)!.getSearchedUsers(1);
                        pageNum = 1;
                      },
                      textInputType: TextInputType.text),
                  CustomButtonSmall(
                    color: kDarktBlue,
                    //width: 30,
                    function: () {
                      HomeCubit.get(context)!.getSearchedUsers(1);

                      pageNum = 1;
                    },
                    text: 'بحث',
                    borderColor: Colors.black,
                  )
                ],
              ),
              SizedBox(
                height: context.hightMediaQuery * 0.04,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ]),
                height: context.hightMediaQuery * 0.8,
                child: Column(
                  children: [
                    // Fixed Header
                    Container(
                      color: kMoreLightBlue,
                      padding: const EdgeInsets.all(8.0),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                              child: Text('الرقم التعريفي',
                                  textAlign: TextAlign.center)),
                          Expanded(
                              child:
                                  Text('الاسم', textAlign: TextAlign.center)),
                          Expanded(
                              child:
                                  Text('الايميل', textAlign: TextAlign.center)),
                          Expanded(
                              child: Text('رقم الموبيل',
                                  textAlign: TextAlign.center)),
                          Expanded(
                              child:
                                  Text('الدرجة', textAlign: TextAlign.center)),
                          Expanded(
                              child:
                                  Text('الحالة', textAlign: TextAlign.center)),
                        ],
                      ),
                    ),
                    // Scrollable Data
                    Expanded(
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        child: state is GetSearchedUsersLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                color: kDarktBlue,
                              ))
                            : Column(
                                children: List.generate(
                                    HomeCubit.get(context)!.users.length,
                                    (index) {
                                  return InkWell(
                                    onTap: () {
                                      customJustGoNavigate(
                                          context: context,
                                          path: AppRouter.kProfileScreen);
                                      cubit.getUserData(
                                          userId: HomeCubit.get(context)!
                                              .users[index]
                                              .userId);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey.shade300),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Expanded(
                                              child: Text(
                                                  '${HomeCubit.get(context)!.users[index].userId}',
                                                  textAlign: TextAlign.center)),
                                          Expanded(
                                              child: Text(
                                                  HomeCubit.get(context)!
                                                      .users[index]
                                                      .name,
                                                  textAlign: TextAlign.center)),
                                          Expanded(
                                              child: Text(
                                                  HomeCubit.get(context)!
                                                      .users[index]
                                                      .email,
                                                  textAlign: TextAlign.center)),
                                          Expanded(
                                              child: Text(
                                                  HomeCubit.get(context)!
                                                      .users[index]
                                                      .mobileNum,
                                                  textAlign: TextAlign.center)),
                                          Expanded(
                                              child: Text(
                                                  HomeCubit.get(context)!
                                                          .users[index]
                                                          .registrationGrade ??
                                                      '',
                                                  textAlign: TextAlign.center)),
                                          Expanded(
                                              child: Text(
                                                  HomeCubit.get(context)!
                                                      .users[index]
                                                      .status,
                                                  style: TextStyle(
                                                      color: HomeCubit.get(
                                                                      context)!
                                                                  .users[index]
                                                                  .status ==
                                                              'نشط'
                                                          ? Colors.green
                                                          : Colors.red),
                                                  textAlign: TextAlign.center)),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                              ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
      },
    );
  }
}
