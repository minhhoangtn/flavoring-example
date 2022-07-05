import 'package:flavoring/configuration/routing/app_router.dart';
import 'package:flavoring/configuration/style/style_barrel.dart';
import 'package:flavoring/presentation/auth/bloc/auth_bloc.dart';
import 'package:flavoring/core/utils/keyboard_utils.dart';
import 'package:flavoring/core/utils/validator_utils.dart';

import 'package:flavoring/presentation/common/common_barrel.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/login_cubit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
          children: [
            Container(
              height: 250,
              decoration: BoxDecoration(
                  color: AppColor.orangeFF,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(100))),
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 60),
                    WidgetTextField(
                      hintText: 'Email',
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (ValidatorUtils.validateEmpty(value)) {
                          return "Nhập vào email";
                        }
                        if (!ValidatorUtils.validateEmail(value!)) {
                          return "Email chưa đúng định dạng";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    WidgetTextField(
                      hintText: 'Mật khẩu',
                      controller: passwordController,
                      obscureText: true,
                      validator: (value) {
                        if (ValidatorUtils.validateEmpty(value)) {
                          return "Nhập vào mật khẩu";
                        }
                        if (value!.length < 6) {
                          return "Mật khẩu phải có 6 kí tự";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 40),
                    BlocConsumer<LoginCubit, LoginState>(
                      listener: (context, state) {
                        if (state is LoginSuccess) {
                          context
                              .read<AuthBloc>()
                              .add(LoggedIn(userInfo: state.userInfo));
                        } else if (state is LoginFailure) {
                          print(state.errorMessage);
                        }
                      },
                      builder: (context, state) {
                        return WidgetButton(
                          width: double.infinity,
                          color: AppColor.orangeFF,
                          isLoading: state is LoginLoading,
                          title: 'Đăng nhập',
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              KeyboardUtils.dismiss();
                              context.read<LoginCubit>().performLogin(
                                  emailController.text,
                                  passwordController.text);
                            }
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 30),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: 'Hiện chưa có tài khoản? ',
                          style: AppTextStyle.grey(14)),
                      TextSpan(
                          text: 'Đăng ký ngay',
                          style: AppTextStyle.orange(14),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Navigator.of(context)
                                .pushNamed(RouteDefine.register))
                    ])),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
