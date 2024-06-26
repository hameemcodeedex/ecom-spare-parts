import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spareproject/Constents/colors.dart';
import 'package:spareproject/Constents/flush_custom.dart';
import 'package:spareproject/Features/Cart/Model/view_cart_response_model.dart';
import 'package:spareproject/Features/Cart/Repository/repository.dart';

class CartViewModel extends ChangeNotifier {
  CartRepository cartRepo = CartRepository();
  CartResponseModel? cartItems;
  dynamic? price;

  getAllcarts() async {
    await cartRepo.viewcart().then((value) {
      if (value?.message != null) {
        cartItems = value;
        price = cartItems?.totalCartPrice;
      }
    });
    notifyListeners();
  }

  updatecart(int quantity, int cartId) async {
    await cartRepo.updatecart(quantity, cartId);
    getAllcarts();
    notifyListeners();
  }

  deletecart(int cartId, BuildContext context) async {
    await cartRepo.deletecart(cartId).then((value) {
      if (value?.status == true) {
        showFlushBarCustom(
            context: context,
            color: buttonColor,
            message: "Cart Deleted Success");
        getAllcarts();
      } else {
        showFlushBarCustom(
            context: context,
            color: Colors.red,
            message: "Something Went Wrong");
        getAllcarts();
      }
    });
    notifyListeners();
  }

  checkTokenandId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    int? id = pref.getInt('userId');
    String? token = pref.getString('token');
    notifyListeners();
  }
}
