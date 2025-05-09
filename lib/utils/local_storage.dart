import 'package:ecom_demo/models/cart_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class LocalStorage {
  static late Box<dynamic> box;

  static Future<void> initialiseLocalStorage() async {
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(appDocumentDirectory.path);
    registerAdapters();
    box = await Hive.openBox('appLocalPreference');
  }

  static void registerAdapters() {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(CartDataAdapter());
    }
  }

  
  
}