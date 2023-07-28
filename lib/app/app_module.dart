import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/product/product_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory((i) => Dio()),
    AsyncBind<SharedPreferences>((i) => SharedPreferences.getInstance()),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute('/', module: ProductModule()),
  ];
}
