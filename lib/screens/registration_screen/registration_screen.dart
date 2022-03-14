import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:imigrata_web/project_utils/pj_utils.dart';
import 'package:imigrata_web/project_widgets/pj_button.dart';
import 'package:imigrata_web/project_widgets/pj_error.dart';
import 'package:imigrata_web/project_widgets/pj_forms.dart';
import 'package:imigrata_web/project_widgets/pj_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:imigrata_web/screens/payment_screen/payment_screen.dart';
import 'package:imigrata_web/screens/payment_screen/payment_screen_provider.dart';
import 'cubit/cb_registration_screen.dart';
import 'cubit/st_registration_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final FocusScopeNode _node = FocusScopeNode();
  bool isReg = true;
  bool isValid = true;
  bool isValidLength = true;
  bool isValidByReg = true;
  String errMessage = '';
  bool success = false;
  bool isClose = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // GetStorage().write('errMessage', null);
  }

//
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: kIsWeb ? AppBar(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
              title: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width < 900
                        ? 0
                        : 100,
                  ),
                  SizedBox(
                      width: 72,
                      height: 66,
                      child: Image.asset('assets/images/icon.png')),
                ],
              )
          ) : null,
          resizeToAvoidBottomInset: true,
          backgroundColor: PjColors.white,
          body: SingleChildScrollView(
            child: Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: kIsWeb ? 380 : null,
                child:
                    BlocConsumer<CbRegistrationScreen, StRegistrationScreen>(
                  listener: (context, state) {
                    if (state is StRegistrationScreenLoading) {
                      Get.dialog(Center(
                        child: CupertinoActivityIndicator(),
                      ));
                    }
                    if (state is StRegistrationScreenAuthed) {
                      Get.offAll(const PaymentScreenProvider());
                    }
                    if (state is StMailErrorMessage) {
                      Get.back();
                      log('${state.errMessage}',
                          name: 'ERROR11111111111111111111111');
                      setState(() {
                        switch (state.errMessage) {
                          case 'Email уже используется':
                            errMessage =
                                AppLocalizations.of(context)!.errMail;
                            break;
                          case 'Учетная запись не найдена':
                            errMessage =
                                AppLocalizations.of(context)!.notFound;
                            break;
                          case 'Учетная запись не подтверждена':
                            errMessage =
                                AppLocalizations.of(context)!.verified;
                            break;
                          case 'Введите корректную почту':
                            errMessage =
                                AppLocalizations.of(context)!.correctMail;
                            break;
                          default:
                            errMessage = state.errMessage ?? '';
                            break;
                        }
                        isValid = false;
                      });
                    }
                    if (state is StSuccessLogin) {
                      Get.back();
                      Get.dialog(Center(
                        child: Container(
                          width: kIsWeb ? 300 : 300.w,
                          height: kIsWeb ? 175 : 175.w,
                          decoration: BoxDecoration(
                              color: PjColors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              PjText(
                                text:
                                    AppLocalizations.of(context)!.confirmMail,
                                align: TextAlign.center,
                                fontSize: 18,
                              ),
                              SizedBox(
                                height: kIsWeb ? 30 : 30.w,
                              ),
                              PjButton(
                                text: 'Ок',
                                onTap: () async {
                                  setState(() {
                                    success = false;
                                    isReg = false;
                                  });
                                  await BlocProvider.of<CbRegistrationScreen>(context).login(emailController.text, passwordController.text);
                                  Get.back();
                                },
                                isSmall: true,
                              )
                            ],
                          ),
                        ),
                      ));
                    }
                  },
                  builder: (context, state) {
                    if (state is StRegistrationScreenError) {
                      Get.back();
                      return PjError(onTap: () {
                        BlocProvider.of<CbRegistrationScreen>(context)
                            .getLoaded();
                      });
                    }
                    if (state is StRegistrationScreenNoInternetError) {
                      Get.back();
                      return PjError(onTap: () {
                        BlocProvider.of<CbRegistrationScreen>(context)
                            .getLoaded();
                      });
                    }
                    return SafeArea(
                        child: Padding(
                            padding: kIsWeb
                                ? EdgeInsets.zero
                                : EdgeInsets.only(
                                    left: 20.w,
                                    top: 20.w,
                                    right: 20.w,
                                    bottom: 30.w),
                            child: FocusScope(
                                node: _node,
                                child: SingleChildScrollView(
                                  physics: ClampingScrollPhysics(),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        if (!kIsWeb) ...[
                                          SizedBox(
                                              width: 62.w,
                                              height: 56.w,
                                              child: Image.asset(
                                                  'assets/images/icon.png')),
                                          // Padding(
                                          //   padding:
                                          //       EdgeInsets.only(top: 20),
                                          //   child: SizedBox(
                                          //       width: 62,
                                          //       height: 5,
                                          //       child: Image.asset(
                                          //           'assets/images/icon.png')),
                                          // ),
                                        ],
                                        Center(
                                            child: Column(
                                                mainAxisSize:
                                                    MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                              SizedBox(
                                                height: kIsWeb ? 80 : 80.w,
                                              ),
                                              PjText(
                                                text: isReg
                                                    ? AppLocalizations.of(
                                                            context)!
                                                        .registration
                                                    : AppLocalizations.of(
                                                            context)!
                                                        .login,
                                                fontSize: 24,
                                                fontWeight: FontWeight.w900,
                                              ),
                                              SizedBox(
                                                height: kIsWeb ? 25 : 25.w,
                                              ),
                                              Flexible(
                                                  child: Padding(
                                                padding: kIsWeb
                                                    ? EdgeInsets.zero
                                                    : EdgeInsets.symmetric(
                                                        horizontal: 14.w),
                                                child: const PjText(
                                                  text:
                                                      'Какой-то шикарный текст который тут будет',
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  align: TextAlign.center,
                                                ),
                                              )),
                                              SizedBox(
                                                height: kIsWeb ? 40 : 40.w,
                                              ),
                                              PjForms(
                                                  width: kIsWeb ? 380 : 335,
                                                  height: 54,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  onEditingComplete: () {
                                                    _node.nextFocus();
                                                  },
                                                  controller: emailController,
                                                  tagTextType: 3,
                                                  placeHolder: 'Email'),
                                              SizedBox(
                                                height: kIsWeb ? 10 : 10.w,
                                              ),
                                              PjForms(
                                                  width: kIsWeb ? 380 : 335,
                                                  height: 54,
                                                  obscureText: true,
                                                  textInputAction:
                                                      TextInputAction.done,
                                                  onEditingComplete: () {
                                                    _node.unfocus();
                                                  },
                                                  controller:
                                                      passwordController,
                                                  tagTextType: 1,
                                                  placeHolder:
                                                      AppLocalizations.of(
                                                              context)!
                                                          .password),
                                              if (isValid == false ||
                                                  isValidLength == false ||
                                                  !isValidByReg) ...[
                                                SizedBox(
                                                  height:
                                                      kIsWeb ? 10 : 10.w,
                                                ),
                                                Container(
                                                  width:
                                                      kIsWeb ? 380 : 335.w,
                                                  height:
                                                      kIsWeb ? 36 : 36.w,
                                                  decoration: BoxDecoration(
                                                    color: PjColors.yellow,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: kIsWeb
                                                                    ? 17
                                                                    : 17.w),
                                                        child:
                                                            SvgPicture.asset(
                                                          'assets/icons/wrong.svg',
                                                          width: kIsWeb
                                                              ? 22
                                                              : 22.w,
                                                          height: kIsWeb
                                                              ? 19
                                                              : 19.w,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          fit: BoxFit.none,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: kIsWeb
                                                            ? 11
                                                            : 11.w,
                                                      ),
                                                      PjText(
                                                        text: errMessage
                                                                .isNotEmpty
                                                            ? errMessage
                                                            : !isValidLength
                                                                ? AppLocalizations.of(
                                                                        context)!
                                                                    .eightValid
                                                                : AppLocalizations.of(
                                                                        context)!
                                                                    .wrongPassword,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                              if (isReg == true) ...[
                                                SizedBox(
                                                  height:
                                                      kIsWeb ? 18 : 18.w,
                                                ),
                                                Flexible(
                                                    child: PjText(
                                                  align: TextAlign.center,
                                                  text: AppLocalizations.of(
                                                          context)!
                                                      .hintPassword,
                                                  fontSize: 10,
                                                  color: PjColors.grey166,
                                                  fontWeight: FontWeight.w400,
                                                )),
                                              ],
                                              SizedBox(
                                                height: kIsWeb ? 40 : 40.w,
                                              ),
                                              PjButton(
                                                  text: AppLocalizations.of(
                                                          context)!
                                                      .next,
                                                  onTap: () async {
                                                    if (passwordController
                                                            .text
                                                            .removeAllWhitespace
                                                            .length <
                                                        8 && isReg) {
                                                      setState(() {
                                                        errMessage =
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .eightValid;
                                                      });
                                                      isValidLength = false;
                                                    } else {
                                                      setState(() {
                                                        isValidLength = true;
                                                      });
                                                    }
                                                    if (passwordController.text.contains(RegExp(r'[a-z]')) &&
                                                        passwordController
                                                            .text
                                                            .contains(RegExp(
                                                                r'[A-Z]')) &&
                                                        passwordController
                                                            .text
                                                            .contains(RegExp(
                                                                r'[0-9]')) && isReg) {
                                                      isValidByReg = true;
                                                    } else {
                                                      if (isReg) {
                                                        setState(() {
                                                          errMessage =
                                                              AppLocalizations.of(
                                                                  context)!
                                                                  .typeCorrectPass;
                                                        });
                                                        isValidByReg = false;
                                                      }
                                                    }
                                                    if (emailController
                                                            .text.isEmpty ||
                                                        passwordController
                                                            .text.isEmpty) {
                                                      setState(() {
                                                        errMessage =
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .bothPoles;
                                                        isValid = false;
                                                      });
                                                    } else if (emailController
                                                            .text
                                                            .isNotEmpty &&
                                                        passwordController
                                                            .text
                                                            .isNotEmpty &&
                                                        isValidByReg &&
                                                        isValidLength) {
                                                      setState(() {
                                                        isValid = true;
                                                      });

                                                      isReg
                                                          ? await BlocProvider
                                                                  .of<CbRegistrationScreen>(
                                                                      context)
                                                              .register(
                                                                  emailController
                                                                      .text,
                                                                  emailController
                                                                      .text,
                                                                  '+79888009898',
                                                                  passwordController
                                                                      .text)
                                                          : await BlocProvider
                                                                  .of<CbRegistrationScreen>(
                                                                      context)
                                                              .login(
                                                                  emailController
                                                                      .text,
                                                                  passwordController
                                                                      .text);
                                                      if (isClose) {
                                                        await BlocProvider.of<CbRegistrationScreen>(context).login(emailController.text, passwordController.text);
                                                      }
                                                      // Get.back();
                                                      // !isReg
                                                      //     ? Get.to(
                                                      //         const PaymentScreenProvider())
                                                      //     : null;
                                                    }
                                                  }),
                                              SizedBox(
                                                height: kIsWeb ? 25 : 25.w,
                                              ),
                                              Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .center,
                                                  children: [
                                                    PjText(
                                                      text: isReg
                                                          ? AppLocalizations
                                                                  .of(
                                                                      context)!
                                                              .haveAcc
                                                          : AppLocalizations
                                                                  .of(context)!
                                                              .noAcc,
                                                      align: TextAlign.center,
                                                      fontSize: 16,
                                                    ),
                                                    GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            isReg = !isReg;
                                                            isValid = true;
                                                            emailController
                                                                .text = '';
                                                            passwordController
                                                                .text = '';
                                                          });
                                                        },
                                                        child: PjText(
                                                          text: isReg
                                                              ? AppLocalizations.of(
                                                                      context)!
                                                                  .comeIn
                                                              : AppLocalizations.of(
                                                                      context)!
                                                                  .register,
                                                          color:
                                                              PjColors.blue,
                                                          fontSize: 16,
                                                        ))
                                                  ])
                                            ]))
                                      ]),
                                ))));
                  },
                  // log('${errMessage}', name: 'ERROR');
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
