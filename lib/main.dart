
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hoteladmin/src/pages/admin/list/listhotel_page.dart';
import 'package:hoteladmin/src/pages/admin/products/create/restaurant_products_create_page.dart';
import 'package:hoteladmin/src/pages/client/products/detail/client_products_detail_page.dart';
import 'package:hoteladmin/src/pages/client/products/list/client_products_list_page.dart';
import 'package:hoteladmin/src/pages/inicio.dart';

import 'package:hoteladmin/src/pages/login/login_page.dart';
import 'package:hoteladmin/src/pages/register/register_page.dart';
import 'package:hoteladmin/src/pages/roles/roles_page.dart';
import 'package:hoteladmin/src/provider/push_notifications_provider.dart';
import 'package:hoteladmin/src/utils/my_colors.dart';




PushNotificationsProvider pushNotificationsProvider = PushNotificationsProvider();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
 
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');

}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  pushNotificationsProvider.initNotifications();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {


@override
  void initState() {
    // TODO: implement initState
    super.initState();

    pushNotificationsProvider.onMessageListener();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Hoteles La Maná",
      debugShowCheckedModeBanner: false,
      initialRoute: 'inicio',
      routes: {
        'inicio': (BuildContext context) =>  Inicio(),
        'login': (BuildContext context) => const LoginPage(),
        'register': (BuildContext context) => const RegisterPage(),
        'roles': (BuildContext context) => const RolesPage(),
        'client/products/list': (BuildContext context) => const ClientProductsListPage(),
        'client/detalle': (BuildContext context) =>  ClientsProductsDetailPage(),
        'hotel/lista': (BuildContext context) => const ListaHotelPage(),
        'crear/hotel': (BuildContext context) => const RestaurantProductsCreatePage(),
       
      },


      theme: ThemeData(
        //fontFamily: 'NimbusSans',
        colorScheme: const ColorScheme.light().copyWith(primary:  Color.fromARGB(
            255, 76, 175, 80)),
        appBarTheme: const AppBarTheme(elevation: 0)
      ),
    );
  }
}
