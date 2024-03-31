import 'package:contactlab/model_view/ContactUpdateModelView.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class ContactUpdateView extends StatelessWidget {

  final GlobalKey<FormState> _key=GlobalKey<FormState>();
  String Phone="";
  String Name="";
  late int id;


@override
  Widget build(BuildContext context) {

    return MultiProvider(providers: 
    [ChangeNotifierProvider.value(value: GetIt.instance.get<ContactUpdateModelView>())

    ],
    child: Scaffold(
      appBar: AppBar(title: Text("Update Contact Info")),
      body: Column(children: [FormSelector(),UpdateContactButton(context)]),
    ),);


  }

  Selector<ContactUpdateModelView,Map<String,dynamic>> FormSelector(){

    return Selector<ContactUpdateModelView,Map<String,dynamic>>(selector: (context,provider)=>provider.contact,
    shouldRebuild: (previous, next) => !identical(previous, next),
    builder: (context,value,child){
      id=value['id'];
      return Form(
        key: _key,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
          TextFormField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              
              hintText: "Name"),
              initialValue: value['name'],

              onSaved: (value){
                Name=value!;
              },
              validator: (value){

                bool result=value!.length==0? false:true;

                return result? null:"*required field";
              },
          ),
          TextFormField(
            initialValue: value['phone'],
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


      );

      


    },
    );
  }

  Widget UpdateContactButton(BuildContext context){
    return MaterialButton(
      
      child: Text("Update Contact"),
      onPressed: (){
        if(_key.currentState!.validate()){
          _key.currentState!.save();
          GetIt.instance.get<ContactUpdateModelView>().updateContactAndNavigateToHomePage(id, Name, Phone, context);
        }

    });
  }


}