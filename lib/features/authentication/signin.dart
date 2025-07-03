import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../commons/widgets/buttons/loading_state_notifier.dart';
import '../../commons/widgets/buttons/regular_button.dart';
import '../../core/apptext/app_text.dart';
import 'auth_services.dart';

class SigninScreen extends ConsumerWidget {
  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: IntrinsicHeight(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    Text.rich(
                      TextSpan(
                        text: "Welcome to ",
                        style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        children: const [
                          TextSpan(
                            text: "A Thousand Words",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
                RegularButton(
                  width: double.infinity,
                  text: AppText.google,
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  textColor: Theme.of(context).colorScheme.primary,
                  buttonKey: "signinwithgoogle",
                  onTap: () async {
                    final signInNotifier = ref.read(
                      regularButtonLoadingProvider.notifier,
                    );

                    signInNotifier.setLoading("signinwithgoogle", true);
                    await ref
                        .read(authServicesProvider)
                        .signInWithGoogle(ref, context);

                    signInNotifier.setLoading("signinwithgoogle", false);
                  },
                ),
                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
