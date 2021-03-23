import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/apis/provider_api/simple_api.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/src/providers/serviceType_provider.dart';
import 'package:flutter_app/src/view/provider_manager_service_screen.dart';
import 'package:image_picker/image_picker.dart';

class AddNewServiceScreen extends StatefulWidget {
  final ServiceItem service;

  const AddNewServiceScreen({Key key, this.service}) : super(key: key);

  @override
  _AddNewServiceScreenState createState() => _AddNewServiceScreenState();
}

class _AddNewServiceScreenState extends State<AddNewServiceScreen> {
  List serviceType =['Gội đầu','Chăm sóc tóc','Massage','Makeup - Trang điểm','Chăm sóc da','Cắt tóc','Nails - Làm móng'];
  String serviceName;
  String servicePrice;
  String serviceSumary;
  String serviceTypeId;
  String serviceDescription;


  File _file;
  void pickImage() async {
    PickedFile pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      _file = File(pickedFile.path);
    });
    print("linkkkkkkkkkeeeee: " + _file.path);
  }
  @override
  void initState() {
    // context.read<ServiceTypeProvider>().initAllServiceType("https://beautyathome2.azurewebsites.net/api/v1.0/servicetypes");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                children: [
                  Container(
                    height: 200.0,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(bottom: 1.0),
                    padding: EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(border: Border.all(width: 0.5)),
                    child: Container(
                      child: _file == null
                          ? GestureDetector(
                              onTap: pickImage,
                              child: Container(
                                margin: EdgeInsets.only(top: 50),
                                width: 50,
                                child: Image.asset(
                                  'public/img/Image.png',
                                  width: 50,
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            )
                          : ClipRRect(child: Image.file(_file, fit: BoxFit.cover)),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.0, vertical: 25.0),
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
                        EdgeInsets.symmetric(horizontal: 5.0, vertical: 20.0),
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
                margin: EdgeInsets.only( top: 5),
                height: MediaQuery.of(context).size.height * 0.17,
                width: MediaQuery.of(context).size.width,
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
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: TextField(
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(top: 3, left: 15),
                                border: OutlineInputBorder(),
                                labelText: 'Tên dịch vụ',
                              ),
                              onChanged: (value){
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
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                contentPadding:
                                EdgeInsets.only(top: 3, left: 15),
                                border: OutlineInputBorder(),
                                labelText: 'Giá (VND)',
                              ),
                              onChanged: (value){
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
                        height: MediaQuery.of(context).size.height * 0.07,
                        child: TextField(
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(top: 3, left: 15),
                            labelText: 'Mô tả dịch vụ (Yêu cầu)*',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value){
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
                        margin: EdgeInsets.only(right: 5,left: 7),
                          child: Text("Chọn loại dịch vụ* : ",
                            style: TextStyle(fontSize: 18,
                            color: Colors.black.withOpacity(0.6)),)),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: DropdownButton(
                            icon: Icon(Icons.arrow_drop_down,size: 25,),
                            value: serviceTypeId,
                            onChanged: (newValue){
                              setState(() {
                                serviceTypeId = newValue;
                              });
                            },
                            items: serviceType.map((valueType){
                                return DropdownMenuItem(
                                  value: valueType,
                                  child: Text(valueType),
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
                      height: MediaQuery.of(context).size.height * 0.35,
                      child: TextField(
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          labelText: 'Các bước làm dịch vụ (Yêu cầu)*',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 9,
                        onChanged: (value){
                          serviceDescription = value;
                        },
                      ),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  if(serviceName.isNotEmpty && servicePrice.isNotEmpty && serviceSumary.isNotEmpty
                      && serviceDescription.isNotEmpty && serviceTypeId.isNotEmpty){

                    SimpleAPI.postFile('services', description: serviceDescription,
                                      price: servicePrice,summary: serviceSumary,
                                      estimateTime: "30",serviceName: serviceName,serviceTypeId: "3", accountId: "3", path: _file.path);
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ProviderManagerScreen(),
                    ));
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
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
                          fontSize: 17, color: Colors.white, letterSpacing: 4),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
