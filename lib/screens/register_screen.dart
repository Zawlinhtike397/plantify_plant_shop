import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plantshop_app/screens/login_screen.dart';
import 'package:plantshop_app/services/firebase_auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isPasswordVisible = true;
  bool _isConfirmPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 300,
                    height: MediaQuery.sizeOf(context).width * 0.60,
                    child: const Image(
                      image: AssetImage("assets/image/plantify_logo.png"),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    'Register your account',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 28,
                        ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 15.0),
                    child: TextFormField(
                      controller: _userNameController,
                      decoration: InputDecoration(
                        hintText: 'UserName',
                        hintStyle:
                            Theme.of(context).textTheme.bodySmall!.copyWith(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                        ),
                      ),
                      validator: (value) {
                        //can I also make separate function for validator?
                        if (value == null || value.isEmpty) {
                          return 'Please enter username';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 15.0),
                    child: TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(
                              color: Colors.grey,
                              fontSize: 16,
                            ), //can I refractor here? use variable and store that widget.
                        border: const OutlineInputBorder(
                          //can I refractor here? use variable and store that widget.
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter email';
                        }

                        String pattern =
                            r'^[a-zA-Z0-9._%+$-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{3,}$';
                        RegExp regex = RegExp(pattern);

                        if (!regex.hasMatch(value)) {
                          return 'Enter a valid email address';
                        }

                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 15.0),
                    child: TextFormField(
                      obscureText: _isPasswordVisible,
                      controller: _passwordController,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                          icon: _isPasswordVisible == true
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off),
                          color: Colors.grey,
                        ),
                        hintText: 'Password',
                        hintStyle:
                            Theme.of(context).textTheme.bodySmall!.copyWith(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        }

                        String pattern =
                            r'^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!!@#$%^&*(),.?\":{}|<>]).{8,}$';
                        RegExp regex = RegExp(pattern);

                        if (!regex.hasMatch(value)) {
                          return 'require one letter, one number, one special character and 8 character password length';
                        }

                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 30.0),
                    child: TextFormField(
                      obscureText: _isConfirmPasswordVisible,
                      controller: _confirmPasswordController,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isConfirmPasswordVisible =
                                  !_isConfirmPasswordVisible;
                            });
                          },
                          icon: _isConfirmPasswordVisible == true
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off),
                          color: Colors.grey,
                        ),
                        hintText: 'Confirm password',
                        hintStyle:
                            Theme.of(context).textTheme.bodySmall!.copyWith(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm password';
                        }

                        if (_passwordController.text.trim() !=
                            _confirmPasswordController.text.trim()) {
                          return 'Passwords do not match';
                        }

                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: SizedBox(
                      width: MediaQuery.sizeOf(context).width,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                          ),
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                        ),
                        child: Text(
                          'Register',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            try {
                              await FirebaseAuthService().signup(
                                _emailController.text.trim(),
                                _passwordController.text.trim(),
                              );

                              if (!mounted) {
                                return;
                                
                              }
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Registeration Success'),
                                ),
                              );

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                              );
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'email-already-in-use') {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'The account already exists for that email.'),
                                  ),
                                );
                              } else if (e.code == 'invalid-email') {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text('The email address is invalid.'),
                                  ),
                                );
                              }
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('$e'),
                                ),
                              );
                            }
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Already have an account?",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontSize: 15,
                                ),
                          ),
                          TextSpan(
                            text: " Login Now",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
