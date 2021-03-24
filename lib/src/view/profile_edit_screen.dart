import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/src/apis/provider_api/simple_api.dart';
import 'package:flutter_app/src/models-new/account_model2.dart';
import 'package:flutter_app/src/models/provider_detail_model/user_profile_model.dart';
import 'package:flutter_app/src/providers/user_profile.dart';
import 'package:flutter_app/src/providers/user_provider.dart';
import 'package:flutter_app/src/view/profile_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileEditScreen extends StatefulWidget {
  @override
  ProfileEditScreenState createState() => ProfileEditScreenState();
}

class ProfileEditScreenState extends  State<ProfileEditScreen> {
  bool showPassword = false;
  File _file;
  String userName ;
  String userEmail;
  String userPhone ='0931182303';

  void pickImage() async {
    PickedFile pickedFile = await ImagePicker().getImage(
        source: ImageSource.gallery);
    setState(() {
      _file = File(pickedFile.path);
    });
  }
  String  accountId;
  UserProfile userFo;
  @override
  void initState() {
    accountId = context.read<UserProfile>().profile.uid.toString();
    userFo = context.read<UserProfile>();

    userName = userFo.profile.displayName;
    if(userPhone != null){
      userPhone = userFo.profile.phone;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AccountProvider>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.white,
          title: Text(
            'Chỉnh sửa thông tin', style: TextStyle(color: Colors.black),),
          actions: [
            GestureDetector(
              onTap: () {
                if(userName != null && userPhone != null) {
                  SimpleAPI.putAccountModel('accounts',id: value.account.id,
                      displayName: userName,
                      phone: userPhone,
                      status: 'Active',
                      path: _file == null ? null : _file.path);

                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ProfileScreen(),
                  ));
                }
              },
              child: Container(
                  margin: EdgeInsets.only(right: 15, top: 15),
                  child: Text('Lưu', style: TextStyle(color: Colors.blueAccent,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,))),
            ),
          ],
        ),
        body: Consumer <AccountProvider>(
          builder: (context, value, child) =>
              Container(
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
                                  image:
                                  DecorationImage(
                                      fit: BoxFit.cover,
                                      image: _file == null ? NetworkImage(userFo.profile.gallery.images[0].imageUrl)
                                    : new FileImage(new File(_file.path))
                                  )
                              ),
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
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.camera_alt, color: Colors.white,),
                                      iconSize: 20.0,
                                      color: Colors.white,
                                      onPressed: pickImage,
                                    )
                                )),
                          ],
                        ),
                      ),
                      SizedBox(height: 35),
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: TextFormField(
                            initialValue: userName,
                            obscureText: false,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(bottom: 3),
                                labelText: "Name",
                                labelStyle: TextStyle(
                                  fontSize: 18,
                                ),
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                hintStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                )),
                            onChanged: (value){
                              setState(() {
                                userName = value;
                              });
                            },
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: TextFormField(
                            keyboardType: TextInputType.phone,
                            initialValue: userPhone,
                            obscureText: false,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(bottom: 3),
                                labelText: "Số điện thoại",
                                labelStyle: TextStyle(
                                  fontSize: 18,
                                ),
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                hintStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                )),
                            onChanged: (value){
                              setState(() {
                                userPhone = value;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 35,),
                    ],
                  ),
                ),
              ),
        ),
      ),
    );
  }

}