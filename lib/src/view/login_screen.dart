import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/providers/user_profile.dart';
import 'package:flutter_app/src/utils/routes_name.dart';
import 'package:flutter_app/src/widgets/shared_widget/style.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'login_phone_screen.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0DB5B4),
      body: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 30),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 90,
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        width: 290,
                        height: 200,
                        child:
                        Image(image: AssetImage('public/img/logoBr.png')),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          'Làm đẹp ngay tại ngôi nhà của bạn',
                          style: CustomTextStyle.titleText(Colors.white),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 70),
                  _loginWithGoogle(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _loginWithGoogle(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final userProfile = context.read<UserProfile>();
        await userProfile.login();
        if (userProfile.isSignIn) {
          Navigator.of(context).pushNamed(Routes.home);
        }
      },
      child: GestureDetector(
        child: Container(
          height: 45,
          padding: EdgeInsets.symmetric(
            horizontal: 15,
          ),
          color: Colors.white,
          child: Row(
            children: <Widget>[
              Icon(
                FontAwesomeIcons.google,
                size: 10.0 * 2.5,
                color: Colors.red.withOpacity(0.6),
              ),
              SizedBox(width: 30),
              Text(
                'Đăng nhập với Google',
                style: CustomTextStyle.titleText(Colors.black87),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loginWithPhone(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPhoneScreen()));
      },
      child: Container(
        height: 45,
        padding: EdgeInsets.symmetric(
          horizontal: 15,
        ),
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Icon(Icons.phone, size: 10.0 * 2.5, color: Color(0xff28BEBA)),
            SizedBox(width: 30),
            Text(
              'Đăng nhập với điện thoại',
              style: CustomTextStyle.titleText(Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
