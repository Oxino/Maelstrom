import 'package:flutter/cupertino.dart';

import '../widgets/auth/login.dart';
import '../widgets/auth/signup.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) => isLogin
      ? LoginWidget(onClickedSignUp: toggle)
      : SignUpWidget(onClickedSignUp: toggle);

  void toggle() => setState(() => isLogin = !isLogin);
}
