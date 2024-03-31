import 'package:contactlab/database/ContactService/ContactService.dart';
import 'package:contactlab/database/helpers/DataBaseHelper.dart';
import 'package:contactlab/model_view/ContactUpdateModelView.dart';
import 'package:contactlab/model_view/HomeModelView.dart';
import 'package:contactlab/views/contact_update_view.dart';
import 'package:contactlab/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  GetIt.instance.registerSingleton<DatabaseHelper>(DatabaseHelper());

  GetIt.instance.registerSingleton<ContactService>(ContactService(GetIt.instance.get<DatabaseHelper>()));
  GetIt.instance.registerSingleton<HomeModelView>(HomeModelView());
  GetIt.instance.registerSingleton<ContactUpdateModelView>(ContactUpdateModelView());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}):super(key:key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: "ContactLab",
      initialRoute: "/",

      routes: {

        "/":(context)=>HomeView(),
        "/Contact/Update":(context)=>ContactUpdateView()
      },
    );


  }
  }