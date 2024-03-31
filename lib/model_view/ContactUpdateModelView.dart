import 'package:contactlab/database/ContactService/ContactService.dart';
import 'package:contactlab/model_view/HomeModelView.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ContactUpdateModelView extends ChangeNotifier {

ContactUpdateModelView();

Map<String,dynamic> contact={};

void changeContact(Map<String,dynamic> cont){
  contact=cont;
  notifyListeners();
}



void updateContactAndNavigateToHomePage(int id,String Name,String Phone,BuildContext context) async{


  await GetIt.instance.get<ContactService>().updateContact(id, Name, Phone);

  await  GetIt.instance.get<HomeModelView>().getContacts();
  Navigator.pushNamed(context, "/");
  



}
  
}