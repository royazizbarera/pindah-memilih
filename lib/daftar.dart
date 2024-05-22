import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pindah_memilih/components/header_state.dart';
import 'package:pindah_memilih/controller/auth.dart';
import 'package:pindah_memilih/footer.dart';
import 'package:provider/provider.dart';

class Daftar extends StatefulWidget {
  const Daftar({super.key});

  @override
  State<Daftar> createState() => _DaftarState();
}

class _DaftarState extends State<Daftar> {
  bool _isLoading = false;
  bool obscureText1 = true;
  bool obscureText2 = true;
  IconData eye1 = Icons.visibility_off_outlined;
  IconData eye2 = Icons.visibility_off_outlined;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController1 = TextEditingController();
  TextEditingController passwordController2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        daftar(),
        const Footer(),
      ],
    );
  }

  Widget daftar() {
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
                'Daftar',
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
                  controller: passwordController1,
                  obscureText: obscureText1,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(eye1),
                      onPressed: () {
                        setState(() {
                          obscureText1 = !obscureText1;
                          eye1 = !obscureText1
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
                height: 56,
                child: TextFormField(
                  controller: passwordController2,
                  obscureText: obscureText2,
                  decoration: InputDecoration(
                    labelText: 'Masukan kembali password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(eye2),
                      onPressed: () {
                        setState(() {
                          obscureText2 = !obscureText2;
                          eye2 = !obscureText2
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
                        onPressed: () async {
                          if (emailController.text.isEmpty ||
                              passwordController1.text.isEmpty ||
                              passwordController2.text.isEmpty) {
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
                            return;
                          }
                          if (passwordController1.text !=
                              passwordController2.text) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text('Password tidak sama'),
                                  backgroundColor:
                                      Theme.of(context).colorScheme.error,
                                ),
                              );
                            }
                            return;
                          }
                          setState(() {
                            _isLoading = true;
                          });
                          try {
                            await AuthController.signUp(
                              emailController.text,
                              passwordController1.text,
                            );
                            setState(() {
                              if (context.mounted) {
                                Provider.of<HeaderState>(context, listen: false)
                                    .loginAccont();
                                Provider.of<HeaderState>(context, listen: false)
                                    .setIndex(0);
                                    Provider.of<HeaderState>(context, listen: false).setUsername = FirebaseAuth.instance.currentUser!.email!;
                              }
                            });
                          } catch (e) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(e.toString()),
                                  backgroundColor:
                                      Theme.of(context).colorScheme.error,
                                ),
                              );
                            }
                          } finally {
                            setState(() {
                              _isLoading = false;
                            });
                          }
                        },
                        child: const Text('Daftar'),
                      ),

                // FilledButton(
                //   onPressed: () {
                //     if (emailController.text.isEmpty ||
                //         passwordController1.text.isEmpty ||
                //         passwordController2.text.isEmpty) {
                //       ScaffoldMessenger.of(context).showSnackBar(
                //         SnackBar(
                //           content: const Text(
                //               'Email dan password tidak boleh kosong'),
                //           backgroundColor: Theme.of(context).colorScheme.error,
                //         ),
                //       );
                //       return;
                //     }
                //     if (passwordController1.text != passwordController2.text) {
                //       ScaffoldMessenger.of(context).showSnackBar(
                //         SnackBar(
                //           content: const Text('Password tidak sama'),
                //           backgroundColor: Theme.of(context).colorScheme.error,
                //         ),
                //       );
                //       return;
                //     }
                //     setState(() {
                //       Provider.of<HeaderState>(context, listen: false)
                //           .loginAccont();
                //       Provider.of<HeaderState>(context, listen: false)
                //           .setIndex(0);
                //     });
                //   },
                //   child: const Text('Daftar'),
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
