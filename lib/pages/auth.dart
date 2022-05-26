import 'package:flutter/cupertino.dart';
import 'package:maelstrom/widgets/auth/sign_up_business.dart';

import '../widgets/auth/login.dart';
import '../widgets/auth/sign_up.dart';

class AuthPage extends StatefulWidget {
  final authenticationService;
  AuthPage(this.authenticationService);
  @override
  _AuthPageState createState() => _AuthPageState(authenticationService);
}

class _AuthPageState extends State<AuthPage> {
  bool isBusiness = false;
  bool isLogin = true;
  bool isBusinessLogin = true;
  final authenticationService;

  _AuthPageState(this.authenticationService);

  @override
  Widget build(BuildContext context) => isBusiness
      ? isLogin
          ? LoginWidget(
              onClickedBusiness: toggleBusiness,
              onClickedSignUp: toggleLoginUser,
              isBusiness: isBusiness)
          : SignUpBusinessWidget(authenticationService,
              onClickedSignUp: toggleLoginUser)
      : isBusinessLogin
          ? LoginWidget(
              onClickedBusiness: toggleBusiness,
              onClickedSignUp: toggleLoginBusiness,
              isBusiness: isBusiness)
          : SignUpWidget(authenticationService,
              onClickedSignUp: toggleLoginBusiness);

  void toggleBusiness() => setState(() => isBusiness = !isBusiness);
  void toggleLoginUser() => setState(() => isLogin = !isLogin);
  void toggleLoginBusiness() =>
      setState(() => isBusinessLogin = !isBusinessLogin);
}
