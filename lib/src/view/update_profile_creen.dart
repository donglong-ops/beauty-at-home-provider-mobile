import 'package:flutter/material.dart';
import 'package:flutter_app/src/providers/user_profile.dart';
import 'package:flutter_app/src/providers/user_provider.dart';
import 'package:flutter_app/src/view/provider_confirm_screen.dart';
import 'package:flutter_app/src/widgets/shared_widget/style.dart';
import 'package:provider/provider.dart';

class ProfileAddScreen extends StatefulWidget {
  @override
  ProfileEditScreenState createState() => ProfileEditScreenState();
}

class ProfileEditScreenState extends State<ProfileAddScreen> {
  bool showPassword = false;
  String accountId;
  UserProfile userFro;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    accountId = context.read<UserProfile>().profile.uid.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AccountProvider>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Text(
            'Cập nhật thông tin',
            style: CustomTextStyle.headerText(Colors.black87),
          ),
        ),
        body: Container(
          padding: EdgeInsets.only(left: 16, top: 25, right: 16),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: ListView(
              children: [
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 4,
                                color: Theme.of(context).scaffoldBackgroundColor),
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.1),
                                  offset: Offset(0, 10))
                            ],
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage('public/img/images.png'))),
                      ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 4,
                                color: Theme.of(context).scaffoldBackgroundColor,
                              ),
                              color: Colors.green,
                            ),
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                            ),
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                buildTextField("Name", " ", false),
                buildTextField("Địa chỉ Email", " ", false),
                buildTextField("Số điện thoại", "0918076861", false),
                buildTextField("Mật khẩu", "********", true),
                buildTextField("Địa chỉ (Không bắt buộc)", " ", false),
                SizedBox(
                  height: 35,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ProviderScreen()));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 63,
                        vertical: 13,
                      ),
                      child: SizedBox(
                        width: 167,
                        height: 19,
                        child: Text(
                          "Lưu thông tin",
                          textAlign: TextAlign.center,
                          style: CustomTextStyle.titleText(Colors.white),
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Color(0xff2AD4D3),
                        borderRadius: BorderRadius.circular(4)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: TextField(
          obscureText: isPasswordTextField ? showPassword : false,
          decoration: InputDecoration(
              suffixIcon: isPasswordTextField
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                      icon: Icon(
                        Icons.remove_red_eye,
                        color: Colors.grey,
                      ),
                    )
                  : null,
              contentPadding: EdgeInsets.only(bottom: 3),
              labelText: labelText,
              labelStyle: TextStyle(
                fontSize: 18,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintText: placeholder,
              hintStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              )),
        ),
      ),
    );
  }
}
