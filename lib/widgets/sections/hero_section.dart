import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_size.dart';
import '../../data/app_data.dart';
import '../hero/hero_stats.dart';
import '../hero/interactive_particle_field.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  double _rotateX = 0.0;
  double _rotateY = 0.0;
  bool _isHovered = false;

  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.05, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: Container(color: const Color(0xff090D16))),

        Positioned.fill(child: CustomPaint(painter: HeroGridPainter())),
        const Positioned.fill(child: InteractiveParticleField()),

        Positioned(
          top: -150,
          left: -100,
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 55, sigmaY: 55),
            child: Container(
              width: 550,
              height: 550,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xff00D2FF).withOpacity(.25),
                    const Color(0xff0066FF).withOpacity(.08),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        ),

        Positioned(
          right: -150,
          bottom: -150,
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 55, sigmaY: 55),
            child: Container(
              width: 650,
              height: 650,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xff6366F1).withOpacity(.18),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        ),

        LayoutBuilder(
          builder: (context, constraints) {
            double screenWidth = MediaQuery.of(context).size.width;
            bool isDesktop = screenWidth > 950;

            return Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: isDesktop ? 80 : 40),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: AppSize.maxWidth),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isDesktop ? 40 : 20,
                    ),
                    child: isDesktop
                        ? Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 5,
                          child: _buildLeftContent(isDesktop),
                        ),
                        const SizedBox(width: 30),
                        Expanded(
                          flex: 5,
                          child: _buildRightPhoto(screenWidth),
                        ),
                      ],
                    )
                        : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildLeftContent(isDesktop),
                        const SizedBox(height: 32),
                        _buildRightPhoto(screenWidth),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildLeftContent(bool isDesktop) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 18),

        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xffF8FAFC), Color(0xff00D2FF), Color(0xff6366F1)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds),
          child: Text(
            "Anggi Muhamad Nawawi",
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: isDesktop ? 52 : 38,
              fontWeight: FontWeight.w900,
              letterSpacing: -1.2,
              height: 1.1,
              shadows: [
                Shadow(
                  color: const Color(0xff00D2FF).withOpacity(0.4),
                  blurRadius: 20,
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 12),

        Text(
          AppData.role,
          style: GoogleFonts.inter(
            fontSize: isDesktop ? 18 : 16,
            fontWeight: FontWeight.bold,
            color: const Color(0xff94A3B8),
          ),
        ),

        const SizedBox(height: 16),

        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 540),
          child: Text(
            AppData.subtitle,
            style: GoogleFonts.inter(
              fontSize: 15,
              height: 1.6,
              color: const Color(0xff94A3B8),
              fontWeight: FontWeight.w400,
            ),
          ),
        ),

        const SizedBox(height: 24),

        Row(
          children: const [
            _SocialIcon(
              imagePath: 'assets/images/icon/github.png',
              url: 'https://github.com/Anggimuhamadn?tab=repositories',
              tooltip: 'GitHub',
            ),
            SizedBox(width: 14),
            _SocialIcon(
              imagePath: 'assets/images/icon/i.png',
              url: 'https://www.instagram.com/dvlrspctg/?hl=en', // FIX: Tambah //
              tooltip: 'Instagram',
            ),
            SizedBox(width: 14),
            _SocialIcon(
              imagePath: 'assets/images/icon/w.png',
              url: 'https://wa.me/6283127152809?text=Halo%20Anggi,%20saya%20tertarik%20untuk%20discuss%20project%20atau%20bekerja%20sama!', // FIX: Tambah //
              tooltip: 'WhatsApp',
            ),
            SizedBox(width: 14),
            _SocialIcon(
              imagePath: 'assets/images/icon/l.png',
              url: 'https://www.linkedin.com/in/anggi-muhamad-nawawi/', // FIX: Tambah //
              tooltip: 'Linkedin',
            ),
          ],
        ),

        const SizedBox(height: 28),

        const HeroStats(),
      ],
    );
  }

  Widget _buildRightPhoto(double screenWidth) {
    double photoSize = screenWidth > 1200
        ? 420
        : (screenWidth > 950 ? 360 : 320);

    return Center(
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onHover: (details) {
          final x = details.localPosition.dx - (photoSize / 2);
          final y = details.localPosition.dy - (photoSize / 2);

          setState(() {
            _isHovered = true;
            _rotateX = (y / (photoSize / 2)) * -0.10;
            _rotateY = (x / (photoSize / 2)) * 0.10;
          });
        },
        onExit: (_) {
          setState(() {
            _isHovered = false;
            _rotateX = 0.0;
            _rotateY = 0.0;
          });
        },
        child: Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.0015)
            ..rotateX(_rotateX)
            ..rotateY(_rotateY),
          alignment: FractionalOffset.center,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: photoSize,
            height: photoSize,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(40)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(38.5),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: AnimatedScale(
                        scale: _isHovered ? 1.04 : 1.0,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOutCubic,
                        child: ShaderMask(
                          shaderCallback: (bounds) => const LinearGradient(
                            colors: [
                              Color(0xff090D16),
                              Color(0xff00D2FF),
                              Colors.transparent,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: [0.0, 0.4, 0.7],
                          ).createShader(bounds),
                          blendMode: BlendMode.softLight,
                          child: Image.asset(
                            'assets/images/profile/ff.png',
                            fit: BoxFit.cover,
                            alignment: const Alignment(0.0, 1),
                            color: const Color(0xff090D16).withOpacity(0.05),
                            colorBlendMode: BlendMode.darken,
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              const Color(0xff090D16).withOpacity(0.70),
                              Colors.transparent,
                              const Color(0xff090D16).withOpacity(0.20),
                              const Color(0xff090D16).withOpacity(0.98),
                            ],
                            stops: const [0.0, 0.30, 0.60, 1.0],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: -30,
                      right: -30,
                      child: Container(
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xff00D2FF).withOpacity(.10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SocialIcon extends StatefulWidget {
  final String imagePath;
  final String url;
  final String tooltip;

  const _SocialIcon({
    required this.imagePath,
    required this.url,
    required this.tooltip,
  });

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool _isHovered = false;

  void _openUrl(String url) async {
    final Uri uri = Uri.parse(url);
    try {
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        debugPrint('Could not launch $url');
      }
    } catch (e) {
      debugPrint('Error launching url: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltip,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          transform: Matrix4.identity()..translate(0, _isHovered ? -5 : 0, 0),
          width: 46,
          height: 46,
          child: Material(
            color: Colors.transparent,
            shape: const CircleBorder(),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () => _openUrl(widget.url),
              onHover: (hovering) {
                setState(() => _isHovered = hovering);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // Background lebih dark & elegan pas diam, glow cyan pas di-hover
                  color: _isHovered
                      ? const Color(0xff00D2FF).withOpacity(0.18)
                      : const Color(0xff111827).withOpacity(0.60),
                  border: Border.all(
                    color: _isHovered
                        ? const Color(0xff00D2FF)
                        : Colors.white.withOpacity(0.12),
                    width: _isHovered ? 1.5 : 1.0,
                  ),
                  boxShadow: [
                    if (_isHovered)
                      BoxShadow(
                        color: const Color(0xff00D2FF).withOpacity(0.40),
                        blurRadius: 16,
                        spreadRadius: 1,
                      ),
                  ],
                ),
                child: Center(
                  child: AnimatedScale(
                    duration: const Duration(milliseconds: 200),
                    scale: _isHovered ? 1.10 : 1.0,
                    child: SizedBox(
                      width: 22,
                      height: 22,
                      // ColorFilter bikin gambar icon PNG item lu dipaksa jadi PUTIH / CYAN NEON!
                      child: ColorFiltered(
                        colorFilter: ColorFilter.mode(
                          _isHovered
                              ? const Color(0xff00D2FF)
                              : Colors.white.withOpacity(0.85),
                          BlendMode.srcIn,
                        ),
                        child: Image.asset(
                          widget.imagePath,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HeroGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..strokeWidth = 1.0;
    const gap = 56.0;

    final Rect rect = Offset.zero & size;
    final RadialGradient gradient = RadialGradient(
      colors: [
        Colors.white.withOpacity(.035),
        Colors.white.withOpacity(.008),
        Colors.transparent,
      ],
      stops: const [0.0, 0.7, 1.0],
    );

    paint.shader = gradient.createShader(rect);

    for (double x = 0; x <= size.width; x += gap) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    for (double y = 0; y <= size.height; y += gap) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}