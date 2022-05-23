import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_shared_preference_app/page/user_page.dart';
import 'package:flutter_shared_preference_app/utils/user_simple_preferences.dart';

Future main() async{


  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await UserSimplePreferences.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String title = 'Shared Preferences';




  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xff8c52ff),
          colorScheme: const ColorScheme.dark().copyWith(secondary: Colors.lightGreen.shade400),
        unselectedWidgetColor: Colors.deepPurple.shade200,
        switchTheme: SwitchThemeData(
          thumbColor: MaterialStateProperty.all(Colors.white),
        )
      ),
    home: const UserPage(),
    //  home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
