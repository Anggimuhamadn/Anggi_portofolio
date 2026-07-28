import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';

class HeroStats extends StatelessWidget {
  const HeroStats({super.key});

  Widget item(String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 28,
            fontWeight: FontWeight.w900,
            color: const Color(0xff94A3B8),
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 6),

        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: const Color(0xff94A3B8),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        item("3+", "Projects"),
        const SizedBox(width: 40),
        item("10+", "Technologies"),
        const SizedBox(width: 40),
        item("100%", "Passion"),
      ],
    );
  }
}
