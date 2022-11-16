// import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// import 'package:faker/faker.dart';
import 'package:flutter_project/config/mongo.dart';
import 'package:flutter_project/config/service_locator.dart';
import 'package:flutter_project/layout/app/app.layout.dart';
import 'package:flutter_project/layout/auth/auth.layout.dart';
import 'package:flutter_project/modules/auth/auth.controller.dart';
import 'package:flutter_project/modules/auth/auth.service.dart';
import 'package:flutter_project/modules/auth/auth.state.dart';
import 'package:flutter_project/modules/loader/page.dart';
import 'package:flutter_project/router/auth.router.dart';
import 'package:get/get.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  final mongodb = DBConnection.getInstance();
  await mongodb.connect();

  setupDatabaseLocator(mongodb);
  initializer();

  runApp(const ProjectApp());
}

void initializer() {
  // inject authentication controller
  Get.lazyPut(() => AuthenticationController(Get.put(AuthenticationService())));
}

class ProjectApp extends GetWidget<AuthenticationController> {
  const ProjectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: authRoutes(),
      title: 'Flutter Obx Auth',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: Obx(() {
        if (controller.state is UnAuthenticated) {
          return const AuthLayout();
        }

        if (controller.state is Authenticated) {
          return AppLayout(
            user: (controller.state as Authenticated).user,
          );
        }
        return const SplashScreen();
      }),
    );
  }
}
















// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   final userForm = <UserCard>[];
//   final faker = Faker();
//   final date = <String>[
//     "10/20/1993",
//     "03/30/1991",
//     "12/23/1985",
//     "11/12/2006",
//     "04/18/200",
//     "07/19/1967"
//   ];

//   final pictures = [
//     "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1770&q=80",
//     "https://images.unsplash.com/photo-1547425260-76bcadfb4f2c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1770&q=80",
//     "https://images.unsplash.com/photo-1552058544-f2b08422138a?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=999&q=80",
//     "https://images.unsplash.com/photo-1554151228-14d9def656e4?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=986&q=80",
//     "https://images.unsplash.com/photo-1599566150163-29194dcaad36?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=987&q=80",
//     "https://images.unsplash.com/photo-1496302662116-35cc4f36df92?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1770&q=80",
//     "https://images.unsplash.com/photo-1555952517-2e8e729e0b44?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1064&q=80",
//   ];

//   void _incrementUserCard() {
//     setState(() {
//       userForm.add(UserCard(
//           icon: random.element(pictures),
//           name: faker.person.name(),
//           email: faker.internet.email(),
//           color: Color(Random().nextInt(0xffffffff)).withAlpha(0xff),
//           birthdate: random.element(date)));
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: GridView.count(
//         padding: const EdgeInsets.all(10),
//         childAspectRatio: 2 / 2,
//         crossAxisCount: 2,
//         crossAxisSpacing: 10,
//         mainAxisSpacing: 10,
//         children: List.generate(userForm.length, (index) {
//           return userForm[index];
//         }),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementUserCard,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
