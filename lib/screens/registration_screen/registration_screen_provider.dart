import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'registration_screen.dart';
import 'cubit/cb_registration_screen.dart';
import 'cubit/st_registration_screen.dart';

class RegistrationScreenProvider extends StatelessWidget {
  const RegistrationScreenProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CbRegistrationScreen>(
      create: (context) => CbRegistrationScreen(),
      child: const RegistrationScreen(),
    );
  }
}    
    