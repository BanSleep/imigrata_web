import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'payment_screen.dart';
import 'cubit/cb_payment_screen.dart';
import 'cubit/st_payment_screen.dart';

class PaymentScreenProvider extends StatelessWidget {
  const PaymentScreenProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CbPaymentScreen>(
      create: (context) => CbPaymentScreen(),
      child: const PaymentScreen(),
    );
  }
}    
    