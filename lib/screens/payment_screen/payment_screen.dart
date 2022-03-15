import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

// import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get_storage/get_storage.dart';
import 'package:imigrata_web/project_utils/pj_utils.dart';
import 'package:imigrata_web/project_widgets/pj_button.dart';
import 'package:imigrata_web/project_widgets/pj_error.dart';
import 'package:imigrata_web/project_widgets/pj_forms.dart';
import 'package:imigrata_web/project_widgets/pj_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:imigrata_web/screens/successful_payment_screen/successful_payment_screen.dart';
import 'package:imigrata_web/screens/survey_screen/widgets/validate_error.dart';
import 'package:stripe/stripe.dart' as stripe;
import 'package:stripe_payment/stripe_payment.dart';
import 'package:web_browser_detect/web_browser_detect.dart';
import 'cubit/cb_payment_screen.dart';
import 'cubit/st_payment_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:js' as js;

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {

  final FocusScopeNode _node = FocusScopeNode();
  TextEditingController numberController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController cvcController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController indexController = TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  bool isValid = true;
  bool isValidDate = true;
  CreditCard testCard = CreditCard(
      number: '4000 0027 6000 3184',
      expYear: 23,
      expMonth: 09,
      cvc: '993',
      name: 'testUser',
      addressLine1: 'address1',
      addressLine2: 'address2',
      addressCity: 'addressCity',
      addressState: 'CA',
      addressZip: '1337');
  Token? _paymentToken;
  Source? _source;
  bool isCancel = false;
  String errMessage = '';
  PaymentMethod? _paymentMethod;
  PaymentIntentResult? _paymentIntent;

  @override
  void initState() {
    super.initState();
    GetStorage().write('isDelete', false);
  }

  void setError(dynamic error) {
    Get.back();
    setState(() {
      isCancel = true;
    });
    Get.dialog(Center(
      child: Container(
        width: kIsWeb ? 300 : 300.w,
        height: kIsWeb ? 175 : 175.w,
        decoration: BoxDecoration(
            color: PjColors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PjText(
              text: AppLocalizations.of(context)!.paymentError,
              align: TextAlign.center,
              fontSize: 18,
            ),
            SizedBox(
              height: kIsWeb ? 30 : 30.w,
            ),
            PjButton(
              text: 'Ок',
              onTap: () async {
                Get.back();
              },
              isSmall: true,
            )
          ],
        ),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    log(Browser().browser.toString(), name: "browser");
    log(kIsWeb.toString(), name: "isWeb");
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: kIsWeb
              ? AppBar(
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
          backgroundColor: PjColors.white,
          resizeToAvoidBottomInset: true,
          body: SingleChildScrollView(
            child: Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: kIsWeb ? 380 : null,
                child: BlocBuilder<CbPaymentScreen, StPaymentScreen>(
                  builder: (context, state) {
                    if (state is StPaymentScreenError) {
                      Get.back();
                      return PjError(onTap: () {
                        BlocProvider.of<CbPaymentScreen>(context).getLoaded();
                      });
                    }
                    if (state is StPaymentScreenLoading) {
                      return const Center(
                        child: CupertinoActivityIndicator(),
                      );
                    }
                    if (state is StPaymentScreenLoaded) {
                      return SafeArea(
                        child: Padding(
                          padding: kIsWeb
                              ? EdgeInsets.zero
                              : EdgeInsets.only(
                                  left: 20.w, top: 20.w, right: 20.w),
                          child: FocusScope(
                            node: _node,
                            child: SingleChildScrollView(
                              physics: const ClampingScrollPhysics(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (!kIsWeb) ...[
                                    SizedBox(
                                        width: 62.w,
                                        height: 56.w,
                                        child: Image.asset(
                                            'assets/images/icon.png')),
                                  ],
                                  Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          height: kIsWeb ? 66 : 66.w,
                                        ),
                                        PjText(
                                          text: AppLocalizations.of(context)!
                                              .payment,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w900,
                                          align: TextAlign.center,
                                        ),
                                        SizedBox(
                                          height: kIsWeb ? 20 : 20.w,
                                        ),
                                        Flexible(
                                          child: Padding(
                                            padding: kIsWeb
                                                ? EdgeInsets.zero
                                                : EdgeInsets.symmetric(
                                                    horizontal: 14.w),
                                            child: const PjText(
                                              fontWeight: FontWeight.w500,
                                              text:
                                                  'Какой-то шикарный текст который тут будет',
                                              align: TextAlign.center,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: kIsWeb ? 45 : 45.w,
                                        ),
                                        PjForms(
                                          isCardNumber: true,
                                          maxLength: 19,
                                          width: kIsWeb ? 380 : 335,
                                          height: 54,
                                          tagTextType: 2,
                                          placeHolder:
                                              AppLocalizations.of(context)!
                                                  .cardNumber,
                                          controller: numberController,
                                        ),
                                        SizedBox(
                                          height: kIsWeb ? 10 : 10.w,
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            PjForms(
                                              isCardNumber: true,
                                              isDate: true,
                                              maxLength: 5,
                                              tagTextType: 2,
                                              placeHolder:
                                                  AppLocalizations.of(
                                                          context)!
                                                      .cardDate,
                                              width: kIsWeb ? 238 : 173,
                                              height: 54,
                                              controller: dateController,
                                            ),
                                            SizedBox(
                                              width: kIsWeb ? 13 : 13.w,
                                            ),
                                            PjForms(
                                              maxLength: 3,
                                              tagTextType: 2,
                                              placeHolder: 'CVC',
                                              width: kIsWeb ? 129 : 149,
                                              height: 54,
                                              controller: cvcController,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: kIsWeb ? 10 : 10.w,
                                        ),
                                        PjForms(
                                          width: kIsWeb ? 380 : 335,
                                          height: 54,
                                          tagTextType: 1,
                                          placeHolder:
                                              AppLocalizations.of(context)!
                                                  .country,
                                          controller: countryController,
                                        ),
                                        SizedBox(
                                          height: kIsWeb ? 10 : 10.w,
                                        ),
                                        PjForms(
                                          width: kIsWeb ? 380 : 335,
                                          height: 54,
                                          tagTextType: 1,
                                          placeHolder:
                                              AppLocalizations.of(context)!
                                                  .index,
                                          controller: indexController,
                                        ),
                                        SizedBox(
                                          height: kIsWeb ? 5 : 5.w,
                                        ),
                                        !isValid || !isValidDate
                                            ? ValidateError(
                                                text: errMessage.isNotEmpty
                                                    ? errMessage
                                                    : '')
                                            // Container(
                                            //   width: kIsWeb ? 400.h :  335.w,
                                            //   height: 36,
                                            //   decoration: BoxDecoration(
                                            //     color: PjColors.yellow,
                                            //     borderRadius:
                                            //     BorderRadius.circular(8),
                                            //   ),
                                            //   child: Row(
                                            //     children: [
                                            //       Padding(
                                            //         padding: kIsWeb ? EdgeInsets.zero :  EdgeInsets.only(
                                            //             left: 17.w),
                                            //         child: SvgPicture.asset(
                                            //           'assets/icons/wrong.svg',
                                            //           width: 22.w,
                                            //           height: 19.w,
                                            //           alignment: Alignment
                                            //               .centerLeft,
                                            //           fit: BoxFit.none,
                                            //         ),
                                            //       ),
                                            //       SizedBox(
                                            //         width: 11.w,
                                            //       ),
                                            //       Flexible(
                                            //         child: PjText(
                                            //           text: errMessage
                                            //               .isNotEmpty
                                            //               ? errMessage
                                            //               : '',
                                            //           fontSize: 12,
                                            //           fontWeight:
                                            //           FontWeight.w500,
                                            //         ),
                                            //       ),
                                            //     ],
                                            //   ),
                                            // )
                                            : Container(),
                                        SizedBox(
                                          height: kIsWeb ? 15 : 15.w,
                                        ),
                                        PjButton(
                                            text:
                                                AppLocalizations.of(context)!
                                                    .pay,
                                            onTap: !kIsWeb
                                                ? () async {
                                                    Get.dialog(
                                                        Center(
                                                          child:
                                                              CupertinoActivityIndicator(),
                                                        ),
                                                        barrierDismissible:
                                                            false);
                                                    if (numberController
                                                            .text.isEmpty ||
                                                        cvcController
                                                            .text.isEmpty ||
                                                        dateController
                                                            .text.isEmpty) {
                                                      setState(() {
                                                        isValid = false;
                                                        errMessage =
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .validCardPoles;
                                                      });
                                                    } else if (numberController
                                                            .text
                                                            .isNotEmpty &&
                                                        cvcController.text
                                                            .isNotEmpty &&
                                                        dateController.text
                                                            .isNotEmpty) {
                                                      setState(() {
                                                        isValid = true;
                                                        errMessage = '';
                                                      });
                                                    }
                                                    if (int.parse(
                                                            dateController
                                                                .text
                                                                .split('/')
                                                                .first) >
                                                        12) {
                                                      isValidDate = false;
                                                      setState(() {
                                                        errMessage =
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .correctDate;
                                                      });
                                                    } else {
                                                      isValidDate = true;
                                                    }
                                                    if (isValid &&
                                                        isValidDate) {
                                                      setState(() {
                                                        isCancel = false;
                                                      });
                                                      await BlocProvider.of<
                                                                  CbPaymentScreen>(
                                                              context)
                                                          .pay();
                                                      String clientSecret =
                                                          GetStorage().read(
                                                              'clientSecret');
                                                      StripePayment.setOptions(
                                                          StripeOptions(
                                                              publishableKey:
                                                                  GetStorage()
                                                                      .read(
                                                                          'pubKey'),
                                                              merchantId:
                                                                  'test',
                                                              androidPayMode:
                                                                  'test'));
                                                      !isCancel
                                                          ? await StripePayment.createSourceWithParams(SourceParams(
                                                                  returnURL:
                                                                      'example://stripe-redirect',
                                                                  type:
                                                                      'ideal',
                                                                  currency:
                                                                      'eur',
                                                                  amount: 1))
                                                              .then((source) {
                                                              log('Received ${source.sourceId}');
                                                              setState(() {
                                                                _source =
                                                                    source;
                                                              });
                                                            }).catchError(
                                                                  setError)
                                                          : null;
                                                      !isCancel
                                                          ? await StripePayment
                                                                  .createTokenWithCard(
                                                                      testCard)
                                                              .then((token) {
                                                              log('Received ${token.tokenId}');
                                                              setState(() {
                                                                _paymentToken =
                                                                    token;
                                                              });
                                                            }).catchError(
                                                                  setError)
                                                          : null;
                                                      !isCancel
                                                          ? await StripePayment
                                                                  .createPaymentMethod(
                                                                      PaymentMethodRequest(
                                                                          card:
                                                                              testCard))
                                                              .then(
                                                                  (paymentMethod) {
                                                              log('Received ${paymentMethod.id}');
                                                              setState(() {
                                                                _paymentMethod =
                                                                    paymentMethod;
                                                              });
                                                            }).catchError(
                                                                  setError)
                                                          : null;
                                                      !isCancel
                                                          ? await StripePayment.confirmPaymentIntent(PaymentIntent(
                                                                  clientSecret:
                                                                      clientSecret,
                                                                  paymentMethodId:
                                                                      _paymentMethod!
                                                                          .id))
                                                              .then(
                                                                  (paymentIntent) {
                                                              log('Received ${paymentIntent.paymentIntentId}');
                                                              setState(() {
                                                                _paymentIntent =
                                                                    paymentIntent;
                                                              });
                                                            }).catchError(
                                                                  setError)
                                                          : null;
                                                      Get.back();
                                                      GetStorage().write(
                                                          'isPay', true);
                                                      !isCancel
                                                          ? Get.offAll(
                                                              const SuccessfulPaymentScreen())
                                                          : null;
                                                    }
                                                  }
                                                : () async {
                                                    await BlocProvider.of<
                                                                CbPaymentScreen>(
                                                            context)
                                                        .pay();
                                                    final stripeKey =
                                                        stripe.Stripe(
                                                            GetStorage().read(
                                                                'pubKey'));
                                                    stripe.CreateCheckoutSessionRequest(
                                                        successUrl: '',
                                                        cancelUrl: '',
                                                        paymentMethodTypes: [
                                                          stripe
                                                              .PaymentMethodType
                                                              .card
                                                        ]);
                                                  }),
                                        if (!kIsWeb) ...[
                                          SizedBox(
                                            height: 10.w,
                                          ),
                                          PjText(
                                            text:
                                                AppLocalizations.of(context)!
                                                    .or,
                                            fontSize: 15.w,
                                          ),
                                          SizedBox(
                                            height: 10.w,
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              if (kIsWeb) {
                                                // await js.context.callMethod(
                                                //     'onGooglePaymentButtonClicked');
                                                // await js.context.callMethod('onApplePayButtonClicked');
                                              } else {
                                                await StripePayment
                                                    .paymentRequestWithNativePay(
                                                        androidPayOptions:
                                                            AndroidPayPaymentRequest(
                                                                currencyCode:
                                                                    'EUR',
                                                                totalPrice:
                                                                    '1'),
                                                        applePayOptions:
                                                            ApplePayPaymentOptions(
                                                                currencyCode:
                                                                    'EUR',
                                                                countryCode:
                                                                    'DE',
                                                                items: [
                                                              ApplePayItem(
                                                                  label:
                                                                      'test',
                                                                  amount: '1')
                                                            ]));
                                                await StripePayment
                                                    .completeNativePayRequest();
                                                Get.offAll(
                                                    const SuccessfulPaymentScreen());
                                              }
                                            },
                                            child: Container(
                                                width: 335.w,
                                                height: 45.w,
                                                decoration: BoxDecoration(
                                                  color: PjColors.black,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                  if (Platform.isIOS || kIsWeb) ...[
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        PjText(
                                                          text: AppLocalizations
                                                                  .of(context)!
                                                              .buyWith,
                                                          color: PjColors
                                                              .white,
                                                          fontSize: 25.w,
                                                        ),
                                                        SizedBox(
                                                          width: 7.w,
                                                        ),
                                                        SvgPicture.asset(
                                                          'assets/icons/applePay.svg',
                                                          width: 51.w,
                                                          height: 22.w,
                                                          fit: BoxFit.none,
                                                        )
                                                      ],
                                                    )
                                                  ] else if (Platform.isAndroid || kIsWeb || Platform.isMacOS) ...[
                                                    Row(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .center,
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .center,
                                                      children: [
                                                        PjText(
                                                          text: AppLocalizations.of(
                                                              context)!
                                                              .buyWith,
                                                          color: PjColors
                                                              .white,
                                                          fontSize: 25,
                                                        ),
                                                        SizedBox(
                                                          width: 7.w,
                                                        ),
                                                        SvgPicture.asset(
                                                          'assets/icons/googlePay.svg',
                                                          width: 63.w,
                                                          height: 27.w,
                                                          fit:
                                                          BoxFit.none,
                                                        )
                                                      ],
                                                    )
                                                  ]
                                                ])),
                                          ),
                                        ] else if (kIsWeb) ...[
                                          if (Browser().browser == 'Safari') ...[
                                            SizedBox(
                                              height: 10,
                                            ),
                                            PjText(
                                              text:
                                              AppLocalizations.of(context)!
                                                  .or,
                                              fontSize: 15,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            GestureDetector(
                                              onTap: () async {
                                                print(123);
                                                await js.context.callMethod('onApplePayButtonClicked');
                                              },
                                              child: Container(
                                                  width: 335,
                                                  height: 45,
                                                  decoration: BoxDecoration(
                                                    color: PjColors.black,
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        5),
                                                  ),
                                                  child: Center(
                                                    child: Row(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .center,
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .center,
                                                      children: [
                                                        PjText(
                                                          text: AppLocalizations.of(
                                                              context)!
                                                              .buyWith,
                                                          color: PjColors
                                                              .white,
                                                          fontSize: 25,
                                                        ),
                                                        SizedBox(
                                                          width: 7.h,
                                                        ),
                                                        SvgPicture.asset(
                                                          'assets/icons/applePay.svg',
                                                          width: 63,
                                                          height: 27,
                                                          fit:
                                                          BoxFit.none,
                                                        )
                                                      ],
                                                    ),
                                                  )),
                                            ),
                                          ],
                                          SizedBox(
                                            height: 10,
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                                await js.context.callMethod(
                                                    'onGooglePaymentButtonClicked');
                                            },
                                            child: Container(
                                                width: 335,
                                                height: 45,
                                                decoration: BoxDecoration(
                                                  color: PjColors.black,
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      5),
                                                ),
                                                child: Center(
                                                  child: Row(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .center,
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .center,
                                                    children: [
                                                      PjText(
                                                        text: AppLocalizations.of(
                                                            context)!
                                                            .buyWith,
                                                        color: PjColors
                                                            .white,
                                                        fontSize: 25,
                                                      ),
                                                      SizedBox(
                                                        width: 7.h,
                                                      ),
                                                      SvgPicture.asset(
                                                        'assets/icons/googlePay.svg',
                                                        width: 63,
                                                        height: 27,
                                                        fit:
                                                        BoxFit.none,
                                                      )
                                                    ],
                                                  ),
                                                )),
                                          ),
                                          SizedBox(height: 10,),
                                        ],
                                        SizedBox(
                                          height: 30.w,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                    if (state is StPaymentScreenError) {
                      return Container(color: Colors.red);
                    }
                    return Container(color: Colors.grey);
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
