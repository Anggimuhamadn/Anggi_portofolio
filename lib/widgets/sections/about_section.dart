import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

// === WIDGET KUSTOM TYPEWRITER TEXT (CEPETAN NGETIK & BISA DI-TRIGGER) ===
class TypewriterText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final Duration speed;
  final bool startTrigger;

  const TypewriterText({
    super.key,
    required this.text,
    required this.style,
    this.speed = const Duration(milliseconds: 20),
    required this.startTrigger,
  });

  @override
  State<TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText> {
  String _displayedText = "";
  int _currentIndex = 0;
  Timer? _timer;
  bool _hasStarted = false;

  @override
  void didUpdateWidget(TypewriterText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.startTrigger && !_hasStarted) {
      _hasStarted = true;
      _startTyping();
    }
  }

  void _startTyping() {
    _timer = Timer.periodic(widget.speed, (timer) {
      if (_currentIndex < widget.text.length) {
        if (mounted) {
          setState(() {
            _displayedText += widget.text[_currentIndex];
            _currentIndex++;
          });
        }
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 120),
      child: Text(
        _displayedText.isEmpty ? " " : _displayedText,
        style: widget.style,
      ),
    );
  }
}

// === WIDGET UTAMA: ABOUT SECTION (INTERACTIVE VISIBILITY REVEAL) ===
class AboutSection extends StatefulWidget {
  const AboutSection({super.key});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> with SingleTickerProviderStateMixin {
  bool _isPhotoHovered = false;
  bool _isVisible = false;

  late AnimationController _fadeController;
  late Animation<double> _photoFadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );
    _photoFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOutQuint),
    );
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isDesktop = screenWidth > 950;

    return VisibilityDetector(
      key: const Key('about-section-detector'),
      onVisibilityChanged: (visibilityInfo) {
        if (visibilityInfo.visibleFraction > 0.20 && !_isVisible) {
          setState(() {
            _isVisible = true;
          });
          _fadeController.forward();
        }
      },
      child: Container(
        width: double.infinity,
        color: const Color(0xff090D16),
        padding: EdgeInsets.symmetric(
          horizontal: isDesktop ? 60 : 24,
          vertical: 120,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: isDesktop
                ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(flex: 45, child: _buildInteractivePhotoLeft()),
                const SizedBox(width: 80),
                Expanded(flex: 55, child: _buildAboutTextRight()),
              ],
            )
                : Column(
              children: [
                _buildInteractivePhotoLeft(),
                const SizedBox(height: 50),
                _buildAboutTextRight(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // SISI KANAN: KONTEN TEKS & BADGE EMERALD
  Widget _buildAboutTextRight() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xff00F5D4).withOpacity(0.06),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xff00F5D4).withOpacity(0.3),
              width: 1.2,
            ),
          ),
          child: const Text(
            "ABOUT ME",
            style: TextStyle(
              fontFamily: 'Inter',
              color: Color(0xff00F5D4),
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
            ),
          ),
        ),
        const SizedBox(height: 24),

        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [
              Color(0xffF8FAFC),
              Color(0xff00F5D4),
              Color(0xff00D2FF),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds),
          child: const Text(
            "Transforming Complex Problems into Clean, Scalable Mobile Solutions..",
            style: TextStyle(
              fontFamily: 'Inter',
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w900,
              height: 1.3,
              letterSpacing: -0.8,
            ),
          ),
        ),
        const SizedBox(height: 24),

        TypewriterText(
          startTrigger: _isVisible,
          text: "Halo! Gua seorang Software Developer yang berfokus ngebantu startup, bisnis, "
              "dan enterprise buat nge-scale produk digital mereka. Gak cuma sekadar sistem "
              "yang jalan lancar, tapi juga didesain dengan UI/UX yang intuitif dan bikin user betah.\n\n"
              "Lu fokus ke visinya, gua yang beresin baris kodenya. Berawal dari rasa penasaran "
    "gimana cara kerja teknologi di balik layar, sekarang gua fokus membangun arsitektur "
    "clean-code yang scalable, aman, dan siap untuk tahap production.",
          style: const TextStyle(
            fontFamily: 'Inter',
            color: Color(0xff94A3B8),
            fontSize: 16,
            height: 1.7,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 32),

        // WIDGET BORDER RGB ANIMATED ROTATION BADGE
        const CyberRGBBadge(text: "TECH STACK"),

        const SizedBox(height: 20),

        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: const [
            _ColorTechChip(label: "Flutter", iconData: Icons.bolt, brandColor: Color(0xff02569B)),
            _ColorTechChip(label: "Dart", iconData: Icons.code, brandColor: Color(0xff0175C2)),
            _ColorTechChip(label: "HTML5", iconData: Icons.html, brandColor: Color(0xffE34F26)),
            _ColorTechChip(label: "JavaScript", iconData: Icons.javascript, brandColor: Color(0xffF7DF1E)),
            _ColorTechChip(label: "Python", iconData: Icons.terminal, brandColor: Color(0xff3776AB)),
            _ColorTechChip(label: "MySQL", iconData: Icons.storage, brandColor: Color(0xff00758F)),
            _ColorTechChip(label: "Firebase", iconData: Icons.local_fire_department, brandColor: Color(0xffF59E0B)),
            _ColorTechChip(label: "Git / GitHub", iconData: Icons.hub, brandColor: Color(0xffEF4444)),
          ],
        ),
      ],
    );
  }

  // SISI KIRI: FOTO INTERAKTIF DENGAN DRIVEN FADE ANIMATION
  Widget _buildInteractivePhotoLeft() {
    return AnimatedBuilder(
      animation: _photoFadeAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: _photoFadeAnimation.value,
          child: Transform.translate(
            offset: Offset(0, 50 * (1.0 - _photoFadeAnimation.value)),
            child: child,
          ),
        );
      },
      child: MouseRegion(
        onEnter: (_) => setState(() => _isPhotoHovered = true),
        onExit: (_) => setState(() => _isPhotoHovered = false),
        child: Center(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                bottom: -20,
                left: -20,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 380,
                  height: 440,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    border: Border.all(
                      color: _isPhotoHovered
                          ? const Color(0xff00F5D4).withOpacity(0.4)
                          : const Color(0xff00D2FF).withOpacity(0.1),
                      width: 1.5,
                    ),
                  ),
                ),
              ),

              AnimatedScale(
                scale: _isPhotoHovered ? 1.02 : 1.0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutCubic,
                child: Container(
                  width: 380,
                  height: 440,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    color: const Color(0xff111827).withOpacity(0.4),
                    border: Border.all(
                      color: _isPhotoHovered
                          ? const Color(0xff00F5D4).withOpacity(0.6)
                          : Colors.white.withOpacity(0.08),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xff00F5D4).withOpacity(_isPhotoHovered ? 0.18 : 0.02),
                        blurRadius: _isPhotoHovered ? 50 : 30,
                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.asset(
                            'assets/images/profile/f.png',
                            fit: BoxFit.cover,
                            color: const Color(0xff090D16).withOpacity(0.20),
                            colorBlendMode: BlendMode.colorBurn,
                          ),
                        ),
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  const Color(0xff090D16).withOpacity(0.1),
                                  const Color(0xff090D16).withOpacity(0.75),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// === COMPONENT WIDGET BADGE RGB ANIMATED ROTATION BORDER ===
class CyberRGBBadge extends StatefulWidget {
  final String text;
  const CyberRGBBadge({super.key, this.text = "CORE TECHNOLOGIES"});

  @override
  State<CyberRGBBadge> createState() => _CyberRGBBadgeState();
}

class _CyberRGBBadgeState extends State<CyberRGBBadge> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          padding: const EdgeInsets.all(1.5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: SweepGradient(
              transform: GradientRotation(_controller.value * 2 * 3.14159),
              colors: const [
                Color(0xff00D2FF),
                Color(0xff00F5D4),
                Color(0xffA855F7),
                Color(0xff00D2FF),
              ],
            ),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xff090D16),
              borderRadius: BorderRadius.circular(10.5),
            ),
            child: Text(
              widget.text,
              style: const TextStyle(
                fontFamily: 'monospace',
                color: Color(0xff00F5D4),
                fontWeight: FontWeight.bold,
                fontSize: 12,
                letterSpacing: 1.5,
              ),
            ),
          ),
        );
      },
    );
  }
}

// === COMPONENT WIDGET TECH CHIP INTERAKTIF ===
class _ColorTechChip extends StatefulWidget {
  final String label;
  final IconData iconData;
  final Color brandColor;

  const _ColorTechChip({
    required this.label,
    required this.iconData,
    required this.brandColor,
  });

  @override
  State<_ColorTechChip> createState() => _ColorTechChipState();
}

class _ColorTechChipState extends State<_ColorTechChip> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: _isHovered
              ? widget.brandColor.withOpacity(0.15)
              : const Color(0xff111827).withOpacity(0.4),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: _isHovered
                ? widget.brandColor
                : Colors.white.withOpacity(0.08),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              widget.iconData,
              color: _isHovered ? widget.brandColor : const Color(0xff94A3B8),
              size: 16,
            ),
            const SizedBox(width: 8),
            Text(
              widget.label,
              style: const TextStyle(
                fontFamily: 'Inter',
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}