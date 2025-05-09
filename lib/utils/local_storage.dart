import 'package:ecom_demo/models/cart_model.dart';
import 'package:ecom_demo/models/product_list_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class LocalStorage {
  static late Box<dynamic> box;
  static const String cartBoxName = 'cartItems';
  static late Box<CartData> cartBox;

  static Future<void> initialiseLocalStorage() async {
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(appDocumentDirectory.path);
    registerAdapters();
    box = await Hive.openBox('appLocalPreference');
    cartBox = await Hive.openBox<CartData>(cartBoxName);
  }

  static void registerAdapters() {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(CartDataAdapter());
    }
  }

  // Cart Operations
  static Future<bool> addToCart(ProductListModel product) async {
    try {
      final String productId = product.id.toString();
      
      // Check if the product is already in the cart
      final existingItem = cartBox.get(productId);
      
      if (existingItem != null) {
        // Update quantity if the product is already in the cart
        existingItem.quantity += 1;
        await existingItem.save();
      } else {
        // Add new product to cart
        final CartData cartItem = CartData(
          id: productId,
          name: product.title,
          price: product.price.toDouble(),
          imageUrl: product.images,
          quantity: 1,
        );
        
        await cartBox.put(productId, cartItem);
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  static List<CartData> getCartItems() {
    return cartBox.values.toList();
  }

  static Future<bool> removeFromCart(String productId) async {
    try {
      await cartBox.delete(productId);
      return true;
    } catch (e) {
      return false;
    }
  }

  static int getCartItemCount() {
    int count = 0;
    final items = cartBox.values;
    for (var item in items) {
      count += item.quantity;
    }
    return count;
  }

  static double getCartTotal() {
    double total = 0;
    final items = cartBox.values;
    for (var item in items) {
      total += (item.price * item.quantity);
    }
    return total;
  }
  
  
}