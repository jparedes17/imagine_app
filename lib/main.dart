import 'package:flutter/material.dart';
import 'package:imagine_apps/providers/db_provider.dart';
import 'package:imagine_apps/screens/add_work.dart';
import 'package:imagine_apps/screens/edit_work.dart';
import 'package:imagine_apps/screens/home.dart';
import 'package:imagine_apps/screens/login.dart';
import 'package:imagine_apps/screens/register.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => dbProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        home: Scaffold(
          body: LoginForm(),
        ),
      ),
    );
  }
}
