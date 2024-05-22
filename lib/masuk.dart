import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pindah_memilih/components/header_state.dart';
import 'package:pindah_memilih/controller/auth.dart';
import 'package:pindah_memilih/footer.dart';
import 'package:provider/provider.dart';

class Masuk extends StatefulWidget {
  const Masuk({super.key});

  @override
  State<Masuk> createState() => _MasukState();
}

class _MasukState extends State<Masuk> {
  bool _isLoading = false;
  bool obscureText = true;
  IconData eye = Icons.visibility_off_outlined;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    emailController.text = 'royazizbarera@gmail.com';
    passwordController.text = 'aziz1234';
    return Column(
      children: [
        masuk(),
        const Footer(),
      ],
    );
  }

  Widget masuk() {
    Widget gap = const SizedBox(height: 25.0);
    return Padding(
      padding: const EdgeInsets.all(48.0),
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 500,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: Theme.of(context).colorScheme.outline,
            width: 1.0,
          ),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 1),
              blurRadius: 2,
              spreadRadius: 0,
              color: Colors.black.withOpacity(0.30),
            ),
            BoxShadow(
              offset: const Offset(0, 1),
              blurRadius: 3,
              spreadRadius: 1,
              color: Colors.black.withOpacity(0.15),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(48.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/logo-pindah-memilih.png'),
                ],
              ),
              gap,
              Text(
                'Masuk',
                style: TextStyle(
                  fontSize: 24,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              gap,
              SizedBox(
                width: 400,
                height: 56,
                child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                ),
              ),
              // Password
              gap,
              SizedBox(
                width: 400,
                height: 56,
                child: TextFormField(
                  controller: passwordController,
                  obscureText: obscureText,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(eye),
                      onPressed: () {
                        setState(() {
                          obscureText = !obscureText;
                          eye = !obscureText
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined;
                        });
                      },
                    ),
                  ),
                ),
              ),
              gap,
              SizedBox(
                width: 400,
                height: 40,
                child: _isLoading
                    ? const SizedBox(
                        width: 40, child: CircularProgressIndicator())
                    : FilledButton(
                        child: const Text('Masuk'),
                        onPressed: () async {
                          var user = await AuthController.signIn(
                            emailController.text,
                            passwordController.text,
                          );

                          setState(() {
                            _isLoading = true;
                          });

                          if (context.mounted) {
                            if (user != null) {
                              Provider.of<HeaderState>(context, listen: false)
                                  .loginAccont();
                              Provider.of<HeaderState>(context, listen: false)
                                  .setIndex(0);
                              Provider.of<HeaderState>(context, listen: false)
                                      .setUsername =
                                  FirebaseAuth.instance.currentUser!.email!;
                            }
                          }
                          if (emailController.text.isEmpty ||
                              passwordController.text.isEmpty) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text(
                                      'Email dan password tidak boleh kosong'),
                                  backgroundColor:
                                      Theme.of(context).colorScheme.error,
                                ),
                              );
                            }
                            setState(() {
                              _isLoading = false;
                            });
                            return;
                          }
                          setState(() {
                            _isLoading = false;
                          });
                        },
                      ),
                // FilledButton(
                //   onPressed: () async {
                //     print('klik');
                //     if (emailController.text.isEmpty ||
                //         passwordController.text.isEmpty) {
                //       if (context.mounted) {
                //         ScaffoldMessenger.of(context).showSnackBar(
                //           SnackBar(
                //             content: const Text(
                //                 'Email dan password tidak boleh kosong'),
                //             backgroundColor:
                //                 Theme.of(context).colorScheme.error,
                //           ),
                //         );
                //       }
                //       return;
                //     }
                //     print('masuk');
                //     await AuthController.signIn(
                //       emailController.text,
                //       passwordController.text,
                //     );
                //     // setState(() {
                //     //   Provider.of<HeaderState>(context, listen: false)
                //     //       .loginAccont();
                //     //   Provider.of<HeaderState>(context, listen: false)
                //     //       .setIndex(0);
                //     // });
                //   },
                //   child: const Text('Masuk'),
                // ),
              ),
              gap,
              // Divider
              SizedBox(
                width: 400.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Divider(
                        color: Theme.of(context).colorScheme.outlineVariant,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'atau',
                      style: TextStyle(
                        fontSize: 14,
                        letterSpacing: 0.25,
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Divider(
                        color: Theme.of(context).colorScheme.outlineVariant,
                      ),
                    ),
                  ],
                ),
              ),
              gap,
              // Google signin button
              SizedBox(
                width: 400,
                height: 40,
                child: OutlinedButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/google-logo.png',
                        width: 16,
                        height: 16,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Lanjutkan dengan Google',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Lupa Password
              gap,
              SizedBox(
                height: 40,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 10.0),
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Lupa password',
                      style: TextStyle(
                        fontSize: 12.0,
                        letterSpacing: 0.01,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
