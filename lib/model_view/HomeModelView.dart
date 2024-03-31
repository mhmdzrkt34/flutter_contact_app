import 'package:contactlab/database/ContactService/ContactService.dart';
import 'package:contactlab/model_view/ContactUpdateModelView.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HomeModelView extends ChangeNotifier {
  List<Map<String, dynamic>> contacts=[];

  HomeModelView(){
    getContacts();
  }


 Future<void> getContacts() async{

  List<Map<String,dynamic>> result= await GetIt.instance.get<ContactService>().getContacts();

  contacts=List.from(result);
  notifyListeners();
 }



 void addOnPress(BuildContext context){


  showDialog(context: context, builder: (BuildContext _context){

    GlobalKey<FormState> _key=GlobalKey<FormState>();

    String Phone="";
    String Name="";


    return AlertDialog(

      title: Text("Add Contact"),
      content: 
      
      Column(
        mainAxisSize: MainAxisSize.min,
        children: 
      [Form(
        key: _key,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
          TextFormField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              
              hintText: "Name"),

              onSaved: (value){
                Name=value!;
              },
              validator: (value){

                bool result=value!.length==0? false:true;

                return result? null:"*required field";
              },
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: "Phone No"),
            onSaved: (value){
              Phone=value!;
            },
                          validator: (value){

                bool result=value!.length==0? false:true;

                return result? null:"*required field";
              },

          ),



        ],),


      ),
      MaterialButton(onPressed: (
        

      ){

        if(_key.currentState!.validate()){
          _key.currentState!.save();
          addContact(Name, Phone);
          Navigator.pop(_context);
        }
      },child: Text("Add Contact"),)
      ]),


    );

  });
 }

 Future<void> addContact(String name, String phone) async {

  await GetIt.instance.get<ContactService>().insertContact(name, phone);
    List<Map<String,dynamic>> result= await GetIt.instance.get<ContactService>().getContacts();

  contacts=List.from(result);
  notifyListeners();




  



 }
 Future<void> removeContact(int id) async{
  await GetIt.instance.get<ContactService>().deleteContact(id);
      List<Map<String,dynamic>> result= await GetIt.instance.get<ContactService>().getContacts();

  contacts=List.from(result);
  notifyListeners();


  
 }

 void navigatToUpdateContactPage(BuildContext context,Map<String,dynamic> contact){
  GetIt.instance.get<ContactUpdateModelView>().changeContact(contact);
  Navigator.pushNamed(context, "/Contact/Update");


 }


  
}