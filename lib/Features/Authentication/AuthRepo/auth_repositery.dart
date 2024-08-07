import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:spareproject/Features/Authentication/AuthResponseModel/forgotemailModel.dart';
import 'package:spareproject/Features/Authentication/AuthResponseModel/loginResponseModel.dart';
import 'package:spareproject/Features/Authentication/AuthResponseModel/registerresponseModel.dart';

class Authrepo {
  Future<RegisterResponseModel?> signUp(
      {required String name,
      required String email,
      required String password,
      required String confirmpassword}) async {
    try {
      EasyLoading.show();
      var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
      var data = {
        'name': name,
        'email': email,
        'password': password,
        'confirm_password': confirmpassword,
      };
      var dio = Dio();
      var response = await dio.request(
        'https://prethewram.pythonanywhere.com/api/register/',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        return RegisterResponseModel.fromJson(response.data);
      } else {
        EasyLoading.dismiss();
        print(response.statusMessage);
      }
    } catch (e) {
      EasyLoading.dismiss();
      print('this is your error: <<<$e');
    }
  }

  Future<RegisterResponseModel?> verifyOtp(
      {required String email, required String otp}) async {
    EasyLoading.show();
    try {
      var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
      var data = {'email': email, 'otp': otp};
      var dio = Dio();
      var response = await dio.request(
        'https://prethewram.pythonanywhere.com/api/verify-otp/',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        print(json.encode(response.data));
        return RegisterResponseModel.fromJson(response.data);
      } else {
        EasyLoading.dismiss();
        print(response.statusMessage);
      }
    } catch (e) {
      EasyLoading.dismiss();
      print('This is your :$e');
    }
  }

  Future<LoginResponseModel?> logIn(
      {required String email, required String password}) async {
    EasyLoading.show();
    try {
      var data = {'email': email, 'password': password};
      var dio = Dio();
      var response = await dio.request(
        'https://prethewram.pythonanywhere.com/api/login/',
        options: Options(
          method: 'POST',
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        EasyLoading.showSuccess("Login Success");
        return LoginResponseModel.fromJson(response.data);
      } else {
        EasyLoading.dismiss();
        print(response.statusMessage);
      }
    } catch (e) {
      EasyLoading.dismiss();
      print('Thisis your error $e');
    }
  }

  Future<ForgotEmailModel?> passwordReset({required String email}) async {
    EasyLoading.show();
    try {
      var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
      var data = {'email': email};
      var dio = Dio();
      var response = await dio.request(
        'https://prethewram.pythonanywhere.com/api/password-reset/',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        EasyLoading.showSuccess('');
        print(json.encode(response.data));
        return ForgotEmailModel.fromJson(response.data);
      } else {
        EasyLoading.dismiss();
        print(response.statusMessage);
      }
    } catch (e) {
      EasyLoading.dismiss();
      print('This is your error$e');
    }
  }

  Future<ForgotEmailModel?> passwordOTP(
      {required String email, required String otp}) async {
    EasyLoading.show();
    try {
      var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
      var data = {'email': email, 'otp': otp};
      var dio = Dio();
      var response = await dio.request(
        'https://prethewram.pythonanywhere.com/api/password-otp/',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        EasyLoading.showSuccess('Otp Verified SuccesFully');
        print(json.encode(response.data));
        return ForgotEmailModel.fromJson(response.data);
      } else {
        EasyLoading.dismiss();
        print(response.statusMessage);
      }
    } catch (e) {
      EasyLoading.dismiss();

      print('This is your error $e');
    }
  }

  Future<ForgotEmailModel?> changePassword(
      {required String email,
      required String newPassword,
      required String confirm_new_password}) async {
    EasyLoading.show();
    try {
      var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
      var data = {
        'email': email,
        'new_password': newPassword,
        'confirm_new_password': confirm_new_password
      };
      var dio = Dio();
      var response = await dio.request(
        'https://prethewram.pythonanywhere.com/api/change-password/',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        EasyLoading.showSuccess('New password Set Succesfully');
        print(json.encode(response.data));
        return ForgotEmailModel.fromJson(response.data);
      } else {
        EasyLoading.dismiss();
        print(response.statusMessage);
      }
    } catch (e) {
      EasyLoading.dismiss();
      print('this is your error$e');
    }
  }
}
