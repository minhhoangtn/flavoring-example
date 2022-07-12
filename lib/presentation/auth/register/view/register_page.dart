import 'package:flavoring/configuration/style/style_barrel.dart';
import 'package:flavoring/presentation/auth/register/bloc/register_cubit.dart';
import 'package:flavoring/core/utils/keyboard_utils.dart';
import 'package:flavoring/core/utils/validator_utils.dart';

import 'package:flavoring/presentation/common/common_barrel.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
          children: [
            _buildHeader(),
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
                    const SizedBox(height: 20),
                    WidgetTextField(
                      hintText: 'Tên hiển thị',
                      controller: nameController,
                      validator: (value) {
                        if (ValidatorUtils.validateEmpty(value)) {
                          return "Nhập vào tên của bạn";
                        }
                        if (!ValidatorUtils.validateFullName(value!)) {
                          return "Tên chỉ gồm chữ và số";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 40),
                    BlocConsumer<RegisterCubit, RegisterState>(
                      listener: (context, state) {
                        if (state is RegisterSuccess) {
                          Navigator.of(context).pop(true);
                        } else if (state is RegisterFailure) {
                          WidgetSnackBar.showError(message: state.errorMessage);
                        }
                      },
                      builder: (context, state) {
                        return WidgetButton(
                          width: double.infinity,
                          color: AppColor.orangeFF,
                          isLoading: state is RegisterLoading,
                          title: 'Đăng ký',
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              KeyboardUtils.dismiss();
                              context.read<RegisterCubit>().performRegister(
                                  emailController.text,
                                  passwordController.text,
                                  nameController.text);
                            }
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 30),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: 'Đã có tài khoản? ',
                          style: AppTextStyle.grey(14)),
                      TextSpan(
                          text: 'Đăng nhập',
                          style: AppTextStyle.orange(14),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Navigator.of(context).pop())
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

  _buildHeader() {
    return Container(
      height: 250,
      decoration: BoxDecoration(
          color: AppColor.orangeFF,
          borderRadius:
              const BorderRadius.only(bottomLeft: Radius.circular(100))),
      width: double.infinity,
      alignment: Alignment.bottomRight,
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Icon(
            Icons.emoji_nature_outlined,
            color: Colors.white,
            size: 80,
          ),
          const SizedBox(height: 10),
          Text(
            'ĐĂNG KÝ',
            style: AppTextStyle.white(20, weight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
