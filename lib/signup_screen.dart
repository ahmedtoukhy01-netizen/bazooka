
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_task/passowrd_state.dart';
import 'package:second_task/password_cubit.dart';
import 'package:second_task/user_model.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController ageController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return BlocProvider(
      create: (context) => PassworedCubit(),
      child: Scaffold(
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
                      backgroundColor: const Color.fromARGB(255, 255, 0, 0),
                    ),
                  );
                } else if (state is PassoredSuccess) {
                  Navigator.of(context).pushNamed('/login');
                }
              },
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/bg.jpg', height: 200),
                    TextField(
                      controller: nameController,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                      decoration: const InputDecoration(
                        fillColor: Colors.white,
                        hintText: 'name',
                        hintStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: ageController,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                      decoration: const InputDecoration(
                        fillColor: Colors.white,
                        hintText: 'age',
                        hintStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 16),
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
                        onTap: () {
                          UserModel userModel = UserModel(
                            name: nameController.text,
                            age: int.parse(ageController.text),
                            email: emailController.text,
                            uid: "",
                          );
                          context.read<PassworedCubit>().signUp(
                            user: userModel,
                            password: passwordController.text,
                          );
                        },
                        child: Container(
                          alignment: Alignment.center,
                          child: const Text(
                            "sign up",
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 247, 0),
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed('/login');
                      },
                      child: const Text(
                        'login',
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 251, 0),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
