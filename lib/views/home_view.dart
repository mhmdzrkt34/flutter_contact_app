import 'package:contactlab/model_view/HomeModelView.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return MultiProvider(providers: [
      ChangeNotifierProvider.value(value: GetIt.instance.get<HomeModelView>())
    ],
    child: Scaffold(
      appBar: AppBar(title: Text("Contacts"),),
      body: ContactsSelector(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
        onPressed: (){
          GetIt.instance.get<HomeModelView>().addOnPress(context);

      }),


    ),
    );


  }

  Selector<HomeModelView,List<Map<String,dynamic>>> ContactsSelector(){


    return Selector<HomeModelView,List<Map<String,dynamic>>>(selector: (context,provider)=>provider.contacts,
    shouldRebuild: (previous, next) => !identical(previous,next),

    builder: (context,value,child){

      return Contacts(value);


    },
    
    );
  }


  Widget Contacts(List<Map<String,dynamic>> contacts){

    if(contacts.length==0){

      return Center(child: Text("You Have Zero Contacts"),);
    }

    return ListView.builder(itemCount: contacts.length,  itemBuilder: (BuildContext context,int index){

      return ListTile(
        title: Text(contacts[index]['name']), 
        subtitle: Text(contacts[index]['phone']), 
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(onTap: (){
              GetIt.instance.get<HomeModelView>().navigatToUpdateContactPage(context, contacts[index]);

            },child:Icon(Icons.update) ,),
            
        
          
          GestureDetector(
            onTap: (){
              GetIt.instance.get<HomeModelView>().removeContact(contacts[index]['id']);
            },
            child:Icon(Icons.remove) ,)
          ],),
      );




    });
  }
}