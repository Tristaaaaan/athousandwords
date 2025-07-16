import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../commons/widgets/buttons/loading_state_notifier.dart';
import '../../commons/widgets/buttons/regular_button.dart';
import '../../core/appimages/app_images.dart';
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
                Image.asset(AppImages.appLogo, height: 400, width: 600),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      Text.rich(
                        TextSpan(
                          text: "Welcome to ",
                          style: TextStyle(
                            fontSize: 22,
                            height: 1.5,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          children: [
                            TextSpan(
                              text: "A Thousand Words",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                color: Theme.of(
                                  context,
                                ).colorScheme.primary.withValues(alpha: 0.85),
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      Text(
                        "Share your heartfelt story—who knows, maybe someday, somehow, that message will help someone else.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(
                            context,
                          ).colorScheme.primary.withValues(alpha: 0.9),
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                RegularButton(
                  withBorder: true,

                  width: 350,
                  suffixIcon: false,
                  text: AppText.google,
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  textColor: Theme.of(context).colorScheme.inversePrimary,
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
