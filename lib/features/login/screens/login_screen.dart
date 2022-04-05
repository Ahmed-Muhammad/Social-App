import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_practicing/core/shared/components.dart';
import 'package:firebase_practicing/layouts/home/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/cache/cache_helper.dart';
import '../../register/screen/register_screen.dart';
import '../Widgets/cubit/login_cubit.dart';
import '../Widgets/cubit/login_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  late GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginErrorState) {
            showToast(message: state.error, state: ToastStates.error);
          }
          if (state is LoginSuccessState) {
            CacheHelper.saveData(key: 'uid', value: state.uid)
                .then((value) {
              navigateAndFinish(context, const HomeScreen());
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              ?.copyWith(
                                fontSize: 45,
                                fontWeight: FontWeight.w900,
                              ),
                        ),
                        Text(
                          'login now to connect with your friends ',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(
                                color: Colors.grey,
                                fontSize: 18,
                              ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                          controller: emailController,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter Your Email Address';
                            }
                            return null;
                          },
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Password is too short';
                            }
                            return null;
                          },
                          //as
                          label: 'Password',
                          //using Login cubit
                          obscureText: LoginCubit.get(context).obscureText,
                          prefix: Icons.lock_outlined,
                          //using Login cubit
                          suffix: LoginCubit.get(context).suffix,
                          suffixPressed: () {
                            //using Login cubit
                            LoginCubit.get(context)
                                .changePasswordVisibility();
                          },
                          onSubmit: (value) {
                            if (formKey.currentState!.validate() == true) {
                              LoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ConditionalBuilder(
                          condition: state is! LoginLoadingState,
                          fallback: (context) => const Center(
                              child: CircularProgressIndicator()),
                          builder: (context) => defaultButton(
                            function: () {
                              if (formKey.currentState!.validate() ==
                                  true) {
                                LoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            text: 'Login',
                            isUpperCase: true,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Center(
                          child: TextButton(
                            child: const Text(
                              "Forget your password ?",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {},
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account ?",
                              style:
                                  TextStyle(fontWeight: FontWeight.bold),
                            ),
                            defaultTextButton(
                                text: 'Register now',
                                function: () {
                                  // ignore: prefer_const_constructors
                                  navigateAndFinish(
                                      context, RegisterScreen());
                                }),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
