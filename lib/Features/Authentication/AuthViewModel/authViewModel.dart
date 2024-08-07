import 'package:flutter/material.dart';
import 'package:spareproject/Constents/colors.dart';
import 'package:spareproject/Constents/flush_custom.dart';
import 'package:spareproject/Features/Authentication/AuthRepo/auth_repositery.dart';
import 'package:spareproject/Features/Authentication/Authview/Otp/otpVerificationView.dart';
import 'package:spareproject/Features/Authentication/Authview/SignIn/Login.dart';
import 'package:spareproject/Features/Authentication/Authview/forgotPassword/changepassword.dart';
import 'package:spareproject/Features/Authentication/Authview/forgotPassword/paswordOTP.dart';
import 'package:spareproject/bottombar/custom_bottom_bar.dart';
import 'package:spareproject/sharedPrefrences/sharedPreferences.dart';

class Authviewmodel extends ChangeNotifier {
  TextEditingController forgotemailcontroller = TextEditingController();

  final emailcontroller = TextEditingController();
  Authrepo authrepo = Authrepo();
  Future signUp(
      {required String name,
      required String email,
      required String password,
      required String confirmpassword,
      required BuildContext context}) async {
    await authrepo
        .signUp(
      name: name,
      email: email,
      password: password,
      confirmpassword: confirmpassword,
    )
        .then(
      (value) {
        if (value?.status == true) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => OtpView()));
          showFlushBarCustom(
              context: context,
              color: Colors.green,
              message: "OTP Sent Success",
              icon: Icons.check_circle);
        } else {
          showFlushBarCustom(
              context: context,
              color: Colors.red,
              message: "User With This Email Already Exist",
              icon: Icons.close);
        }
      },
    );
    notifyListeners();
  }

  Future otpVerify(
      {required String email,
      required String otp,
      required BuildContext context}) async {
    await authrepo.verifyOtp(email: email, otp: otp).then(
      (value) {
        if (value?.status == true) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => LoginView()),
              (Route route) => false);
          showFlushBarCustom(
              context: context,
              color: Colors.green,
              message: "Verified",
              icon: Icons.check_circle);
        } else {
          showFlushBarCustom(
              context: context,
              color: Colors.red,
              message: "OTP Is Inncorrect",
              icon: Icons.close);
        }
      },
    );
    notifyListeners();
  }

  logIn(
      {required String email,
      required String password,
      required BuildContext context}) async {
    await authrepo.logIn(email: email, password: password).then(
      (value) {
        if (value?.status == true) {
          storeToken(value?.token ?? "");
          storeUserId(value?.id ?? 0);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => BottomNavBar()),
              (Route route) => false);
          showFlushBarCustom(
              context: context,
              color: buttonColor,
              message: 'Logined Succesfully');
        } else {
          showFlushBarCustom(
              context: context,
              color: Colors.red,
              message: "user not found",
              icon: Icons.close);
        }
      },
    );
    notifyListeners();
  }

  forgotemail({required String email, required BuildContext context}) async {
    await authrepo.passwordReset(email: email).then(
      (value) {
        if (value?.status == true) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ForgotOtpView(),
              ));
          showFlushBarCustom(
              context: context,
              color: buttonColor,
              message: 'OTP Send Succesfully');
        } else {
          showFlushBarCustom(
              context: context, color: Colors.red, message: 'Otp Send Failed');
        }
      },
    );
    notifyListeners();
  }

  forgototp(
      {required String otp,
      required String email,
      required BuildContext context}) async {
    await authrepo.passwordOTP(email: email, otp: otp).then(
      (value) {
        if (value?.status == true) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ChangePasswordView(),
              ));
          showFlushBarCustom(
              context: context,
              color: buttonColor,
              message: 'OTP Verified Succesfully');
        } else {
          showFlushBarCustom(
              context: context,
              color: Colors.red,
              message: 'Otp verification  Failed');
        }
      },
    );
    notifyListeners();
  }

  changePaswword(
      {required String email,
      required String newPassword,
      required String confirmNewPassword,
      required BuildContext context}) async {
    await authrepo
        .changePassword(
            email: email,
            newPassword: newPassword,
            confirm_new_password: confirmNewPassword)
        .then(
      (value) {
        if (value?.status == true) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => LoginView(),
              ),
              (Route route) => false);
          showFlushBarCustom(
              context: context,
              color: buttonColor,
              message: 'Password Changed Succesfully');
        } else {
          showFlushBarCustom(
              context: context,
              color: Colors.red,
              message: 'Cannot Change Password');
        }
      },
    );
    notifyListeners();
  }
}
