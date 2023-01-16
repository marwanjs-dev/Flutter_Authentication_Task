import 'package:authentication_task/Screens/Register/register.dart';
import 'package:authentication_task/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../components/buttons.dart';
import 'package:flutter/material.dart';
import '../../../../constants.dart';
import '../../../services/auth_exceptions.dart';
import '../../../utilities/error_dialog.dart';
import '../../HomePage.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({Key? key}) : super(key: key);

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // TODO: Create Your Variables Here

  @override
  Widget build(BuildContext context) {
    bool emptyArea = false;

    return SafeArea(
        child: SingleChildScrollView(
      child: Column(
        children: [
///////////////////////////////////////////////////////////////////////////////////
          Padding(
            padding: const EdgeInsets.only(top: 120).r,
            child: SizedBox(
              width: 260.w,
              child: Column(
                children: [
                  Text(
                    "Login!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: mainFontSize.sp,
                      fontWeight: mainFontWeight,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    "Welcome back ! Login with your credentials",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: commonTextSize.sp,
                      color: lightGreyReceiptBG,
                    ),
                  ),
                ],
              ),
            ),
          ),
///////////////////////////////////////////////////////////////////////////////////

          SizedBox(width: double.infinity.w, height: 40.h),
          Form(
            key: _formKey,
            child: Column(
              children: [
///////////////////////////////////////////////////////////////////////////////////
                Padding(
                  padding: const EdgeInsets.only(right: 20.0).r,
                  child: SizedBox(
                    width: 220.w,
                    height: 90.h,
                    child: TextFormField(
                      controller: _emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          displaySnackBar("enter your email");
                          emptyArea = true;
                          return "empty";
                        }
                        return null;
                      },
                      cursorColor: textBlack,
                      style: TextStyle(fontSize: subFontSize.sp),
                      decoration: InputDecoration(
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: textBlack),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: textBlack),
                        ),
                        icon: const Icon(
                          Icons.email_outlined,
                          color: textBlack,
                        ),
                        labelText: "Email",
                        hintText: "abc@gmail.com",
                        labelStyle: TextStyle(
                            color: textBlack,
                            fontSize: mainFontSize.sp,
                            fontWeight: mainFontWeight),
                        hintStyle: TextStyle(
                            color: textBlack, fontSize: subFontSize.sp),
                      ),
                      onChanged: (text) {
                        // TODO: add your code to fetch the user email
                      },
                    ),
                  ),
                ),
///////////////////////////////////////////////////////////////////////////////////
                Padding(
                  padding: const EdgeInsets.only(right: 20.0).r,
                  child: SizedBox(
                    width: 220.w,
                    height: 90.h,
                    child: TextFormField(
                      controller: _passwordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          displaySnackBar("enter your email");
                          emptyArea = true;
                          return "empty";
                        }
                        return null;
                      },
                      cursorColor: textBlack,
                      style: TextStyle(fontSize: subFontSize.sp),
                      decoration: InputDecoration(
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: textBlack),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: textBlack),
                        ),
                        icon: const Icon(
                          Icons.password_outlined,
                          color: textBlack,
                        ),
                        labelText: "Password",
                        hintText: "******",
                        labelStyle: TextStyle(
                            color: textBlack,
                            fontSize: mainFontSize.sp,
                            fontWeight: mainFontWeight),
                        hintStyle: TextStyle(
                            color: textBlack, fontSize: subFontSize.sp),
                      ),
                      onChanged: (text) {
                        // TODO: add your code to fetch the user password
                      },
                    ),
                  ),
                ),
///////////////////////////////////////////////////////////////////////////////////
                SizedBox(height: 30.h, width: double.infinity.w),
                DefaultButton(
                    text: "Log in",
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        emptyArea = false;
                      }
                      if (emptyArea == false) {
                        await displaySnackBar("loading");
                        await AuthService.firebase().initialize();
                        try {
                          final UserCredentials =
                              await AuthService.firebase().login(
                            email: _emailController.text.trim(),
                            password: _passwordController.text,
                          );
                          Navigator.pushNamed(context, HomePage.routeName);
                        } on UserNotFoundAuthException {
                          // ignore: use_build_context_synchronously
                          await showErrorDialog(
                            context,
                            "User not found",
                          );
                        } on WrongPasswordAuthException {
                          // ignore: use_build_context_synchronously
                          await showErrorDialog(
                            context,
                            "invalid password",
                          );
                        } on GenericAuthException {
                          // ignore: use_build_context_synchronously
                          await showErrorDialog(
                            context,
                            "Authentication Error",
                          );
                        }
                      }
                    }),
///////////////////////////////////////////////////////////////////////////////////
                SizedBox(height: 20.h, width: double.infinity.w),
                Text(
                  "Do not have an account ?",
                  style: (TextStyle(
                      color: textBlack, fontSize: commonTextSize.sp)),
                ),
///////////////////////////////////////////////////////////////////////////////////
                InkWell(
                  child: Text(
                    'Register',
                    style: TextStyle(
                        color: textBlack,
                        fontSize: commonTextSize.sp,
                        fontWeight: commonTextWeight),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, Register.routeName);
                  },
                )
              ],
            ),
          )
        ],
      ),
    ));
  }

  // TODO: Create Your Functions Here

}
