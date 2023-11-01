import 'package:flutter/material.dart';
import 'myapp.dart';
import 'package:provider/provider.dart';
import 'package:sensor_flutter_app/model_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     return ChangeNotifierProvider(
      create: (_) => ModelTheme(),
      child: Consumer<ModelTheme>(
          builder: (context, ModelTheme themeNotifier, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: themeNotifier.isDark
              ? ThemeData(
                  brightness: Brightness.dark,
                )
              : ThemeData(
                  brightness: Brightness.light,
                  primaryColor: Colors.blue[100],
                  //primarySwatch: Colors.lime
                ),
          debugShowCheckedModeBanner: false,
          home: LoginPage(),
        );
      }),
    );
  }
}