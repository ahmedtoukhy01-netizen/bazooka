import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_task/passowrd_state.dart';
import 'package:second_task/password_cubit.dart';

class PassworedScreen extends StatelessWidget {
  const PassworedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: BlocConsumer<PassworedCubit, PassoredState>(
            listener: (context, state) {
              if (state is PassoredError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.error),
                    backgroundColor: Colors.red,
                  ),
                );
              } else if (state is PassoredSuccess) {
                Navigator.pushReplacementNamed(context, "/home");
              }
            },
            builder: (context, state) {
              final isLoading = state is PassoredLoading;

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/bg.jpg', height: 200),
                  TextField(
                    controller: emailController,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                    decoration: const InputDecoration(
                      fillColor: Colors.white,
                      hintText: 'mail',
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                    decoration: const InputDecoration(
                      fillColor: Colors.white,
                      hintText: 'password',
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: GestureDetector(
                      onTap: isLoading
                          ? null
                          : () {
                              context.read<PassworedCubit>().login(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                              );
                            },
                      child: Container(
                        alignment: Alignment.center,
                        child: isLoading
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: Color.fromARGB(255, 255, 255, 0),
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text(
                                "login",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 242, 255, 0),
                                  fontSize: 16,
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
