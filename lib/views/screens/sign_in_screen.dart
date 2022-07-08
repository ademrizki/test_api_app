import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_api_app/provider/sign_in_provider.dart';
import 'package:test_api_app/utils/state/finite_state.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    final provider = Provider.of<SignInProvider>(context, listen: false);
    provider.addListener(
      () {
        if (provider.myState == MyState.failed) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'User doesn\'t exist!',
              ),
            ),
          );
        } else if (provider.myState == MyState.loaded) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Logged In',
              ),
            ),
          );
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SignInProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sign In',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: TextFormField(
                  controller: emailController,
                  validator: (String? value) {
                    const String expression = "[a-zA-Z0-9+._%-+]{1,256}"
                        "\\@"
                        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}"
                        "("
                        "\\."
                        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}"
                        ")+";
                    final RegExp regExp = RegExp(expression);
                    return !regExp.hasMatch(value!)
                        ? "Please, input valid email!"
                        : null;
                  },
                  decoration: const InputDecoration(
                    label: Text('Email'),
                    filled: true,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Please, fill password field!';
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                    label: Text('Password'),
                    filled: true,
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 46),
                ),
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();

                    await provider.signIn(
                      email: emailController.text,
                      password: passwordController.text,
                    );
                  }
                },
                child: Consumer<SignInProvider>(
                  builder: (context, provider, _) {
                    if (provider.myState == MyState.loading) {
                      return const CircularProgressIndicator();
                    } else {
                      return const Text('SIGN IN');
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
