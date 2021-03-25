import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/apis/provider_api/simple_api.dart';
import 'package:flutter_app/src/models-new/service_type_model.dart';
import 'package:flutter_app/src/providers/service_type_provider.dart';
import 'package:flutter_app/src/providers/user_profile.dart';
import 'package:flutter_app/src/view/provider_manager_service_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddNewServiceScreen extends StatefulWidget {
  @override
  _AddNewServiceScreenState createState() => _AddNewServiceScreenState();
}

class _AddNewServiceScreenState extends State<AddNewServiceScreen> {
  String serviceName;
  String servicePrice;
  String serviceSumary;
  String serviceDescription;
  String accountId;

  File _file;
  List<ServiceTypeModel> listStyle;

  void pickImage() async {
    PickedFile pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      _file = File(pickedFile.path);
    });
  }
  @override
  void initState() {
    super.initState();
    accountId = context.read<UserProfile>().profile.uid.toString();
    var serviceType = context.read<ServiceTypeProvider>();
    listStyle = serviceType.serviceTypes;
  }
  int possition = 0;
  @override
  Widget build(BuildContext context) {
      String serviceTypeId = listStyle[possition].id;
      return Scaffold(
        backgroundColor: Colors.white,
        body: Consumer<ServiceTypeProvider>(
          builder: (context, value, child) =>
              Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Stack(
                        children: [
                          Container(
                            height: 200.0,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            margin: EdgeInsets.only(bottom: 1.0),
                            padding: EdgeInsets.only(bottom: 20),
                            decoration: BoxDecoration(border: Border.all(
                                width: 0.5)),
                            child: Container(
                              child: _file == null
                                  ? GestureDetector(
                                onTap: pickImage,
                                child: Container(
                                  margin: EdgeInsets.only(top: 50),
                                  width: 50,
                                  child: Image.asset(
                                    'public/img/Image.png', width: 50,
                                    fit: BoxFit.fitHeight,),
                                ),
                              )
                                  : ClipRRect(
                                  child: Image.file(_file, fit: BoxFit.cover)),
                            ),
                          ),
                          Padding(
                            padding:
                            EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 25.0),
                            child: Row(
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(
                                    Icons.cancel,
                                    color: Colors.black.withOpacity(0.6),
                                  ),
                                  iconSize: 30.0,
                                  color: Colors.black,
                                  onPressed: () => Navigator.pop(context),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                            EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 20.0),
                            child: Container(
                              height: 170.0,
                              alignment: Alignment.bottomRight,
                              child: Card(
                                color: Colors.grey.shade100,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30.0),
                                  ),
                                ),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.add,
                                    color: Colors.black.withOpacity(0.6),
                                  ),
                                  iconSize: 25.0,
                                  color: Colors.black,
                                  //onPressed: getImage,
                                  onPressed: pickImage,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.17,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 4, top: 4, right: 0, bottom: 4),
                                  child: Container(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width * 0.6,
                                    child: TextField(
                                      textInputAction: TextInputAction.done,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                            top: 3, left: 15),
                                        border: OutlineInputBorder(),
                                        labelText: 'Tên dịch vụ',
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          serviceName = value;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 0, top: 4, right: 4, bottom: 4),
                                  child: Container(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width * 0.35,
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        contentPadding:
                                        EdgeInsets.only(top: 3, left: 15),
                                        border: OutlineInputBorder(),
                                        labelText: 'Giá (VND)',
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          servicePrice = value;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                color: Colors.white,
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.07,
                                child: TextField(
                                  textInputAction: TextInputAction.done,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                        top: 3, left: 15),
                                    labelText: 'Mô tả dịch vụ (Yêu cầu)*',
                                    border: OutlineInputBorder(),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      serviceSumary = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: [
                              Container(
                                  margin: EdgeInsets.only(right: 5, left: 7),
                                  child: Text("Chọn loại dịch vụ* : ",
                                    style: TextStyle(fontSize: 18,
                                        color: Colors.black.withOpacity(0.6)),)
                              ),
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: DropdownButton<ServiceTypeModel>(
                                    icon: Icon(
                                      Icons.arrow_drop_down, size: 25,),
                                    value: listStyle[possition],
                                    onChanged: (newValue) {
                                      for (int i = 0; i <
                                          listStyle.length; i++) {
                                        if (listStyle[i].name.contains(
                                            newValue.name)) {
                                          setState(() {
                                            possition = i;
                                          });
                                        }
                                      }
                                    },
                                    items: listStyle.map((index) {
                                      return DropdownMenuItem<ServiceTypeModel>(
                                        value: index,
                                        child: Text(index.name),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            color: Colors.white,
                            padding: EdgeInsets.only(left: 10.0, bottom: 4),
                            child: Text(
                              'Các bước làm dịch vụ*',
                              style: TextStyle(
                                  fontSize: 16.0),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              color: Colors.white,
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.35,
                              child: TextField(
                                textInputAction: TextInputAction.done,
                                decoration: InputDecoration(
                                  labelText: 'Các bước làm dịch vụ (Yêu cầu)*',
                                  border: OutlineInputBorder(),
                                ),
                                maxLines: 9,
                                onChanged: (value) {
                                  serviceDescription = value;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          if (serviceName.isNotEmpty &&
                              servicePrice.isNotEmpty &&
                              serviceSumary.isNotEmpty
                              && serviceDescription.isNotEmpty &&
                              serviceTypeId.isNotEmpty) {
                            SimpleAPI.postFile(
                                'services', description: serviceDescription,
                                price: servicePrice,
                                summary: serviceSumary,
                                estimateTime: "30",
                                serviceName: serviceName,
                                serviceTypeId: serviceTypeId,
                                accountId: accountId,
                                path: _file.path
                            );
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ProviderManagerScreen(),
                            ));
                          }
                        },
                        child: Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.9,
                          height: 38,
                          child: FloatingActionButton.extended(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(1.0),
                              ),
                            ),
                            backgroundColor: Colors.blue[400],
                            label: Text(
                              'Lưu mới',
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.white,
                                  letterSpacing: 4),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        ),
      );
  }
}
