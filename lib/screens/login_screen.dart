import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:google_sign_in/google_sign_in.dart";
import "package:plantshop_app/screens/forgot_password_screen.dart";
import "package:plantshop_app/screens/home_screen.dart";
import "package:plantshop_app/screens/register_screen.dart";
import "package:plantshop_app/services/firebase_auth_service.dart";

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = true;

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
                    'Login to your account',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 28,
                        ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 15.0),
                    child: TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: 'Enter your email',
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
                          return 'Please enter email';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                        hintText: 'Enter your password',
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
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 20.0, 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ForgotPasswordScreen(),
                              ),
                            );
                          },
                          child: Text(
                            "Forgot Password?",
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontSize: 14.0,
                                      color: const Color(0xff6A707C),
                                    ),
                          ),
                        ),
                      ],
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
                          'Login',
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
                              await FirebaseAuthService().login(
                                _emailController.text.trim(),
                                _passwordController.text.trim(),
                              );

                              if (FirebaseAuth.instance.currentUser != null) {
                                if (!mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Login Success'),
                                  ),
                                );

                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const HomeScreen(),
                                  ),
                                );
                              }
                            } on FirebaseAuthException catch (e) {
                              print('FirebaseAuthException code: ${e.code}');
                              String errorMessage;
                              if (e.code == 'invalid-credential') {
                                errorMessage = 'invalid username or password';
                              } else if (e.code == 'invalid-email') {
                                errorMessage =
                                    'The email address is not valid.';
                              } else {
                                errorMessage =
                                    'Login failed. Please try again.';
                              }

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(errorMessage),
                                ),
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('An unknown error occurred'),
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
                          builder: (context) => const RegisterScreen(),
                        ),
                      );
                    },
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Don't have an account?",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontSize: 15,
                                ),
                          ),
                          TextSpan(
                            text: " Register Now",
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      children: [
                        Container(
                          height: 1,
                          width: MediaQuery.sizeOf(context).width * 0.3,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.28,
                          child: Text(
                            textAlign: TextAlign.center,
                            'Or Login with',
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: const Color(0xff6A707C),
                                    ),
                          ),
                        ),
                        Container(
                          height: 1,
                          width: MediaQuery.sizeOf(context).width * 0.31,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () async {
                          await FirebaseAuthService().loginWithGoogle();

                          if (FirebaseAuth.instance.currentUser != null) {
                            if (!mounted) {
                              await GoogleSignIn().disconnect();
                              return;
                            }

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'Hello!, ${FirebaseAuth.instance.currentUser!.email}'),
                              ),
                            );

                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomeScreen()));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Google Login Failed'),
                              ),
                            );
                          }
                        },
                        child: Container(
                          width: 90,
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[400]!),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: const Image(
                            image: AssetImage('assets/image/google_icon.png'),
                          ),
                        ),
                      ),
                    ],
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
