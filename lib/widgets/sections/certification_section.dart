import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visibility_detector/visibility_detector.dart';

class CertificationSection extends StatefulWidget {
  const CertificationSection({super.key});

  @override
  State<CertificationSection> createState() => _CertificationSectionState();
}

class _CertificationSectionState extends State<CertificationSection>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late AnimationController _animController;
  bool _hasAnimated = false;

  final List<Map<String, String>> _certs = [
    {
      "title": "Introducton to Cybersecurity",
      "issuer": "Cisco",
      "date": "2025",
      "image": "assets/images/sertifikat/cisco.jpeg",
    },
    {
      "title": "Javascript Intermediate",
      "issuer": "Sololearn",
      "date": "2024",
      "image": "assets/images/sertifikat/sololearnn.jpeg",
    },
    {
      "title": "Belajar dasar pemrograman Javascript",
      "issuer": "Dicoding",
      "date": "2024",
      "image": "assets/images/sertifikat/dicoding.jpeg",
    },
    {
      "title": "Mastering SOLID Principles",
      "issuer": "Dicoding",
      "date": "2023",
      "image": "assets/images/sertifikat/dicodinggg.jpeg",
    },
    {
      "title": "Intro to Data Analytics",
      "issuer": "RevoU",
      "date": "2025",
      "image": "assets/images/sertifikat/revou.jpeg",
    },
    {
      "title": "Seminar ABCD",
      "issuer": "Unindra",
      "date": "2024",
      "image": "assets/images/sertifikat/unidra.jpeg",
    },
    {
      "title": "SQL Intermediate",
      "issuer": "Sololearn",
      "date": "2025",
      "image": "assets/images/sertifikat/sololearn.jpeg",
    },
    {
      "title": "Digitalisasi pendidikan pandi",
      "issuer": "ID Cloud",
      "date": "2024",
      "image": "assets/images/sertifikat/Idcloud.jpeg",
    },
    {
      "title": "Intro to Data Analytics",
      "issuer": "RevoU",
      "date": "2025",
      "image": "assets/images/sertifikat/revou.jpeg",
    },
  ];

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scroll(double offset) {
    _scrollController.animateTo(
      _scrollController.offset + offset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
    );
  }

  void _showImageLightbox(BuildContext context, String title, String imgUrl) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(20),
          child: Stack(
            alignment: Alignment.center,
            children: [
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(color: Colors.black.withOpacity(0.6)),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      constraints: const BoxConstraints(
                        maxWidth: 800,
                        maxHeight: 500,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xff00D2FF).withOpacity(0.4),
                        ),
                      ),
                      child: Image.asset(
                        imgUrl,
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.broken_image_rounded,
                          color: Colors.white24,
                          size: 50,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 10,
                right: 10,
                child: IconButton(
                  icon: const Icon(
                    Icons.close_rounded,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isDesktop = screenWidth > 950;

    return VisibilityDetector(
      key: const Key('certification-section-vis-key'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.15 && !_hasAnimated) {
          _hasAnimated = true;
          _animController.forward();
        }
      },
      child: Container(
        width: double.infinity,
        color: const Color(0xff090D16),
        padding: EdgeInsets.symmetric(
          horizontal: isDesktop ? 80 : 24,
          vertical: 100,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1150),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xff00D2FF).withOpacity(0.06),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: const Color(0xff00D2FF).withOpacity(0.2),
                              width: 1.2,
                            ),
                          ),
                          child: Text(
                            "📜 CREDENTIALS & CERTIFICATIONS",
                            style: GoogleFonts.inter(
                              color: const Color(0xff00D2FF),
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2.0,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),


                      ],
                    ),

                    if (isDesktop)
                      Row(
                        children: [
                          _buildNavArrow(
                            icon: Icons.arrow_back_rounded,
                            onTap: () => _scroll(-320),
                          ),
                          const SizedBox(width: 12),
                          _buildNavArrow(
                            icon: Icons.arrow_forward_rounded,
                            onTap: () => _scroll(320),
                          ),
                        ],
                      ),
                  ],
                ),
                const SizedBox(height: 36),

                SizedBox(
                  height: 520,
                  child: GridView.builder(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          childAspectRatio: 0.92,
                        ),
                    itemCount: _certs.length,
                    itemBuilder: (context, index) {
                      final item = _certs[index];

                      final double start = (index * 0.08).clamp(0.0, 0.65);
                      final double end = (start + 0.35).clamp(0.0, 1.0);

                      final Animation<double> fadeAnim = CurvedAnimation(
                        parent: _animController,
                        curve: Interval(start, end, curve: Curves.easeOut),
                      );

                      final Animation<Offset> slideAnim =
                          Tween<Offset>(
                            begin: const Offset(0.0, 0.15),
                            end: Offset.zero,
                          ).animate(
                            CurvedAnimation(
                              parent: _animController,
                              curve: Interval(
                                start,
                                end,
                                curve: Curves.easeOutCubic,
                              ),
                            ),
                          );

                      final Animation<double> scaleAnim =
                          Tween<double>(begin: 0.88, end: 1.0).animate(
                            CurvedAnimation(
                              parent: _animController,
                              curve: Interval(
                                start,
                                end,
                                curve: Curves.easeOutBack,
                              ),
                            ),
                          );

                      return AnimatedBuilder(
                        animation: _animController,
                        builder: (context, child) {
                          return FadeTransition(
                            opacity: fadeAnim,
                            child: SlideTransition(
                              position: slideAnim,
                              child: ScaleTransition(
                                scale: scaleAnim,
                                child: child,
                              ),
                            ),
                          );
                        },
                        child: _CertGlassCard(
                          title: item["title"]!,
                          issuer: item["issuer"]!,
                          date: item["date"]!,
                          imageUrl: item["image"]!,
                          onTap: () => _showImageLightbox(
                            context,
                            item["title"]!,
                            item["image"]!,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavArrow({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xff111827).withOpacity(0.5),
          border: Border.all(color: Colors.white.withOpacity(0.08)),
        ),
        child: Icon(icon, color: const Color(0xff00D2FF), size: 20),
      ),
    );
  }
}

class _CertGlassCard extends StatefulWidget {
  final String title;
  final String issuer;
  final String date;
  final String imageUrl;
  final VoidCallback onTap;

  const _CertGlassCard({
    required this.title,
    required this.issuer,
    required this.date,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  State<_CertGlassCard> createState() => _CertGlassCardState();
}

class _CertGlassCardState extends State<_CertGlassCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color(
              0xff111827,
            ).withOpacity(_isHovered ? 0.45 : 0.20),
            border: Border.all(
              color: _isHovered
                  ? const Color(0xff00D2FF).withOpacity(0.5)
                  : Colors.white.withOpacity(0.04),
              width: 1.2,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.asset(
                          widget.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: const Color(0xff1E293B),
                              child: const Center(
                                child: Icon(
                                  Icons.broken_image_rounded,
                                  color: Colors.white24,
                                  size: 28,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Positioned.fill(
                        child: Container(
                          color: Colors.black.withOpacity(
                            _isHovered ? 0.0 : 0.2,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 8,
                        bottom: 8,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xff090D16).withOpacity(0.8),
                          ),
                          child: const Icon(
                            Icons.fullscreen_rounded,
                            color: Color(0xff00D2FF),
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                widget.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.issuer,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        color: const Color(0xff00D2FF),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    widget.date,
                    style: GoogleFonts.inter(
                      color: const Color(0xff64748B),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
