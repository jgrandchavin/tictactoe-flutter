import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tictactoe_flutter/core/router/routes.dart';
import 'package:tictactoe_flutter/core/ui/animations/appear_animation.dart';
import 'package:tictactoe_flutter/core/ui/app_colors.dart';
import 'package:tictactoe_flutter/core/ui/widgets/app_loader.dart';
import 'package:tictactoe_flutter/core/ui/widgets/app_logo.dart';
import 'package:tictactoe_flutter/core/ui/widgets/app_scaffold.dart';
import 'package:tictactoe_flutter/core/ui/widgets/app_text.dart';
import 'package:tictactoe_flutter/features/splash/presentation/controllers/splash_view_controller.dart';

class SplashView extends ConsumerWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(splashViewControllerProvider);

    ref.listen(splashViewControllerProvider, (previous, next) {
      // When loading completes, navigate to the menu.
      if (previous?.isLoading == true && next.isLoading == false) {
        if (context.mounted) {
          if (next.initializationSavedGameInfoExists) {
            context.pushReplacement(Routes.game);
          } else {
            context.pushReplacement(Routes.menu);
          }
        }
      }
    });

    return AppScaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: AppearAnimation(child: AppLogo()),
            ),
          ),
          Expanded(
            child: Center(
              child: AppearAnimation(
                delay: const Duration(milliseconds: 1000),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppLoader(size: 40, strokeWidth: 4, color: AppColors.white),
                    const SizedBox(height: 16),
                    AppText.body(text: 'Loading...'.toUpperCase()),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
