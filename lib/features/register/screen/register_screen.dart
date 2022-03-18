import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_practicing/core/shared/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layouts/home/screens/home_screen.dart';
import '../../login/screens/login_screen.dart';
import '../Widgets/register_cubit/register_cubit.dart';
import '../Widgets/register_cubit/register_state.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  late GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();

  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is CreateUserSuccessState) {
            navigateAndFinish(context, const HomeScreen());
          }
          // if (state is CreateUserSuccessState) {
          //   navigateAndFinish(
          //       context,
          //       VerifyPhoneScreen(
          //         phoneNumber: phoneController.text,
          //       ));
          // }
        },
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Register',
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                ?.copyWith(
                                    fontSize: 45, fontWeight: FontWeight.w900)),
                        const SizedBox(height: 15),
                        defaultFormField(
                            controller: nameController,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'Name must not be empty';
                              }
                              return null;
                            },
                            label: 'Name',
                            prefix: Icons.person),
                        const SizedBox(height: 15),
                        defaultFormField(
                            controller: phoneController,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter Your phone';
                              } else if (value.length < 11) {
                                return 'Too short for phone number';
                              }
                              return null;
                            },
                            label: 'Phone',
                            prefix: Icons.phone),
                        const SizedBox(height: 15),
                        defaultFormField(
                            controller: emailController,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter Your Email Address';
                              }
                              return null;
                            },
                            label: 'Email Address',
                            prefix: Icons.email_outlined),
                        const SizedBox(height: 15),
                        defaultFormField(
                          controller: passwordController,
                          validate: (value) {
                            if (value!.isEmpty ||
                                value != confirmPasswordController.text) {
                              return 'Password does not match';
                            }
                            return null;
                          },
                          label: 'Password',
                          obscureText: RegisterCubit.get(context).obscureText,
                          prefix: Icons.lock_outlined,
                          suffix: RegisterCubit.get(context).suffix,
                          suffixPressed: () {
                            RegisterCubit.get(context)
                                .changePasswordVisibility();
                          },
                          onSubmit: (value) {
                            if (formKey.currentState!.validate() == true) {
                              RegisterCubit.get(context).userRegister(
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  email: emailController.text,
                                  password: passwordController.text);
                              // RegisterCubit.get(context).submitPhoneNumber(
                              //     phoneNumber: phoneController.text);
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                          controller: confirmPasswordController,
                          validate: (value) {
                            if (value!.isEmpty ||
                                value != passwordController.text) {
                              return 'Password does not match';
                            }
                            return null;
                          },
                          label: 'Confirm Password',
                          obscureText: RegisterCubit.get(context).obscureText,
                          prefix: Icons.lock_outlined,
                          suffix: RegisterCubit.get(context).suffix,
                          suffixPressed: () {
                            RegisterCubit.get(context)
                                .changePasswordVisibility();
                          },
                          onSubmit: (value) {
                            if (formKey.currentState!.validate() == true) {
                              RegisterCubit.get(context).userRegister(
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  email: emailController.text,
                                  password: passwordController.text);
                              // RegisterCubit.get(context).submitPhoneNumber(
                              //     phoneNumber: phoneController.text);
                            }
                          },
                        ),
                        const SizedBox(height: 15),
                        ConditionalBuilder(
                          condition: state is! RegisterLoadingState,
                          fallback: (context) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          builder: (context) {
                            return defaultButton(
                              text: 'Register',
                              function: () {
                                if (formKey.currentState!.validate() == true) {
                                  RegisterCubit.get(context).userRegister(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      email: emailController.text,
                                      password: passwordController.text);
                                  // RegisterCubit.get(context).submitPhoneNumber(
                                  //     phoneNumber: phoneController.text);
                                }
                              },
                            );
                          },
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Center(
                          child: TextButton(
                            child: const Text(
                              "Have account ? Login instead",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            onPressed: () {
                              navigateAndFinish(context, const LoginScreen());
                            },
                          ),
                        ),
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
