import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:bizzy/home/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'amplifyconfiguration.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Bizzy());
}

class Bizzy extends StatefulWidget {
  const Bizzy({super.key});

  @override
  State<Bizzy> createState() => _BizzyState();
}

class _BizzyState extends State<Bizzy> {
  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  void _configureAmplify() async {
    try {
      await Amplify.addPlugin(AmplifyAuthCognito());
      await Amplify.configure(amplifyconfig);
      safePrint('Successfully configured');
    } on Exception catch (e) {
      safePrint('Error configuring Amplify: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Authenticator(
      initialStep: AuthenticatorStep.signIn,
      child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme:
              ThemeData(visualDensity: VisualDensity.adaptivePlatformDensity),
          builder: Authenticator.builder(),
          home: Home()),
    );
  }
}
