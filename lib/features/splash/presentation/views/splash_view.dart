import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictactoe_flutter/core/app_router.dart';
import 'package:tictactoe_flutter/core/design/app_colors.dart';
import 'package:tictactoe_flutter/core/design/widgets/app_loader.dart';
import 'package:tictactoe_flutter/core/design/widgets/app_logo.dart';
import 'package:tictactoe_flutter/core/design/widgets/app_scaffold.dart';
import 'package:tictactoe_flutter/core/design/widgets/app_text.dart';
import 'package:tictactoe_flutter/features/splash/presentation/controllers/splash_view_controller.dart';

class SplashView extends ConsumerWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(splashViewControllerProvider);

    ref.listen(splashViewControllerProvider, (previous, next) {
      // When loading completes, navigate to the menu.
      if (previous?.isLoading == true && next.isLoading == false) {
        Navigator.of(
          context,
        ).pushReplacementNamed(AppRouter.menuRoute, arguments: next.savedGame);
      }
    });

    return AppScaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppLogo(),
          const SizedBox(height: 32),
          AppLoader(size: 40, strokeWidth: 4, color: AppColors.white),
          const SizedBox(height: 16),
          AppText.body(text: 'Loading...'.toUpperCase()),
        ],
      ),
    );
  }
}
