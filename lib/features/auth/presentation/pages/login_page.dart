import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/features/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:flutter_clean_architecture/features/auth/presentation/pages/signup_page.dart';
import 'package:flutter_clean_architecture/features/auth/presentation/widgets/text_formfield.dart';
import 'package:flutter_clean_architecture/features/home/presentation/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Sign In.",
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      controller: emailController,
                      hintText: "Enter your email",
                      validator: (p0) =>
                          p0!.isEmpty ? "Please, enter your email" : null,
                    ),
                    SizedBox(height: 20),
                    CustomTextFormField(
                      controller: passwordController,
                      hintText: "Enter your password",
                      validator: (p0) =>
                          p0!.isEmpty ? "Please, enter your passwrord" : null,
                    ),
                    SizedBox(height: 20),
                    BlocConsumer<AuthBloc, AuthState>(
                      listener: (context, state) {
                        if (state is AuthFailure) {
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              SnackBar(content: Text(state.messgae.toString())),
                            );
                        }
                        if (state is AuthSuccess) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (builder) => HomePage()),
                          );
                        }
                      },

                      
                      builder: (context, state) {
                        if (state is AuthLoading) {
                          return Center(child: CircularProgressIndicator());
                        }

                        return SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                context.read<AuthBloc>().add(
                                  AuthSignIn(
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim(),
                                  ),
                                );
                              }
                            },
                            child: Text("Sign In"),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (builder) => SignupPage()),
                        );
                      },
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(text: "Don't have an account?"),
                            TextSpan(
                              text: "SignUp",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
