import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class LogoButton extends StatefulWidget {
  const LogoButton({super.key});

  @override
  State<LogoButton> createState() => _LogoButtonState();
}

class _LogoButtonState extends State<LogoButton> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => hover = true),
      onExit: (_) => setState(() => hover = false),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 200),
        scale: hover ? 1.05 : 1,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          width: hover ? 82 : 48,
          height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            gradient: const LinearGradient(
              colors: [Color(0xff2563EB), Color(0xff7C3AED)],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(hover ? .30 : .15),
                blurRadius: hover ? 28 : 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Center(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: ScaleTransition(scale: animation, child: child),
                );
              },
              child: Text(
                hover ? "<Anggiiii/>" : "</>",
                key: ValueKey(hover),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  letterSpacing: .2,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
