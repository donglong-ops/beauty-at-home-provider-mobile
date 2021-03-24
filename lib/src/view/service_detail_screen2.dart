import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/apis/provider_api/simple_api.dart';
import 'package:flutter_app/src/models-new/service_model_new.dart';
import 'package:flutter_app/src/models-new/service_type_model.dart';
import 'package:flutter_app/src/providers/service_type_provider.dart';
import 'package:flutter_app/src/providers/user_profile.dart';
import 'package:flutter_app/src/view/provider_manager_service_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ServiceDetailScreen2 extends StatefulWidget {
  final ServiceModelNew service;

  const ServiceDetailScreen2({Key key, this.service}) : super(key: key);

  @override
  _ServiceDetailScreenState createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen2> {
  //List serviceType =['Gội đầu','Chăm sóc tóc','Massage','Makeup - Trang điểm','Chăm sóc da','Cắt tóc','Nails - Làm móng'];

  String serviceName ;
  String servicePrice;
  String serviceSumary;
  String serviceTypeId;
  // String serviceTypeName;
  String serviceDescription;
  String accountId;

  File _file;
  String url;
  List<ServiceTypeModel> listStyle;

  void pickImage() async {
    PickedFile pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      _file = File(pickedFile.path);
    });
  }
  int possition = 0;
  @override
  void initState() {
    serviceName = widget.service.serviceName;
    servicePrice= widget.service.price;
    serviceSumary= widget.service.summary;
    // serviceTypeName= widget.service.serviceType.name;
    serviceTypeId= widget.service.serviceType.id;
    serviceDescription = widget.service.description;
    super.initState();
    accountId = context.read<UserProfile>().profile.uid.toString();
    context.read<ServiceTypeProvider>().initAllServiceType("https://beautyathome2.azurewebsites.net/api/v1.0/service-types");
    var serviceType = context.read<ServiceTypeProvider>();
    listStyle = serviceType.serviceTypes;

    for(int i = 0; i < listStyle.length; i++){
      if(listStyle[i].id.contains(serviceTypeId.toString())){
        setState(() {
          possition = i;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String servTypeId = listStyle[possition].id;

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
                    padding: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(border: Border.all(width: 0.5)),
                    child: Container(
                      child: _file == null
                          ? GestureDetector(
                        onTap: pickImage,
                        child: Container(
                          // margin: EdgeInsets.only(top: 50),
                          width: 50,
                          child: Image.network(
                            widget.service.gallery.images[0].imageUrl,
                            width: 50,
                            fit: BoxFit.cover,
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
                            color: Colors.white,
                          ),
                          iconSize: 30.0,
                          color: Colors.black,
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.0, vertical: 20.0),
                    child: Container(
                      height: 150.0,
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
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: TextFormField(
                                initialValue: serviceName,
                                decoration: InputDecoration(
                                  labelText: "Tên dịch vụ",
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (value){
                                  setState(() {
                                    serviceName = value;
                                  });
                                },
                              )),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: TextFormField(
                                initialValue: servicePrice,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  labelText: "Giá (VND)",
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (value){
                                  setState(() {
                                    servicePrice = value;
                                  });
                                },
                              )),
                        ],
                      ),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(4.0),
                        child: TextFormField(
                          initialValue: serviceSumary,
                          decoration: InputDecoration(
                            labelText: "Miêu tả dịch vụ",
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value){
                            setState(() {
                              serviceSumary = value;
                            });
                          },
                        )),
                  ],
                ),
              ),
              Row(
                children: [
                  Container(
                      margin: EdgeInsets.only(right: 5,left: 7),
                      child: Text("Chọn loại dịch vụ* : ",
                        style: TextStyle(fontSize: 16, color: Colors.black.withOpacity(0.6)),)),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: DropdownButton<ServiceTypeModel>(
                        icon: Icon(Icons.arrow_drop_down,size: 25,),
                        value: listStyle[possition],
                        onChanged: (newValue){
                          for(int i = 0; i < listStyle.length; i++){
                            if(listStyle[i].name.contains(newValue.name)){
                              setState(() {
                                possition = i;
                              });
                            }
                          }
                        },
                        items: listStyle.map((index){
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
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text(
                        'CÁC BƯỚC LÀM DỊCH VỤ',
                        style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Container(
                        color: Colors.white,
                        height: MediaQuery.of(context).size.height * 0.35,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            color: Colors.white,
                            child: TextFormField(
                              initialValue: serviceDescription,
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              maxLines: 8,
                              onChanged: (value){
                                setState(() {
                                  serviceDescription = value;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    )
                  ]),
              GestureDetector(
                onTap: () {
                  if(serviceName.isNotEmpty && servicePrice.isNotEmpty && serviceSumary.isNotEmpty
                      && serviceDescription.isNotEmpty){

                    SimpleAPI.putServiceModel('services',id: widget.service.serviceID,
                        serviceName: serviceName, summary: serviceSumary ,
                        price: servicePrice,estimateTime: '30',
                        status: 'Active', description: serviceDescription,
                        galleryId: widget.service.gallery.id.toString(),
                        accountId: accountId,serviceTypeId: servTypeId,
                        path: _file == null ? null : _file.path
                    );
                  }

                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ProviderManagerScreen(),
                  ));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: FloatingActionButton.extended(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(1.0),
                      ),
                    ),
                    backgroundColor: Colors.blue[400],
                    label: Text(
                      'Lưu thay đổi',
                      style: TextStyle(color: Colors.white, letterSpacing: 4),
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
