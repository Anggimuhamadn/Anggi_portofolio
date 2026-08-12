import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ExperienceData {
  final String role;
  final String company;
  final String period;
  final String description;
  final List<String> tags;

  const ExperienceData({
    required this.role,
    required this.company,
    required this.period,
    required this.description,
    required this.tags,
  });
}

class ExperienceSection extends StatefulWidget {
  const ExperienceSection({super.key});

  static const List<ExperienceData> _listExperience = [
    ExperienceData(
      role: "Mobile Developer — Security Data Management",
      company: "Internal Operational System Project",
      period: "2024 - 2025",
      description:
      "Merancang dan mendesain aplikasi mobile untuk digitalisasi manajemen data operasional security. Mengubah pencatatan logbook manual menjadi sistem digital terstruktur, mempercepat pelaporan insiden, dan meningkatkan akurasi rekap data lapangan.",
      tags: [
        "Mobile Development",
        "Data Management",
        "Process Automation",
        "UI/UX",
      ],
    ),
    ExperienceData(
      role: "Operational Security Officer",
      company: "Professional Security Service",
      period: "2023 - Sekarang",
      description:
      "Bertanggung jawab atas pengawasan keamanan fisik, analisis risiko area, serta penerapan SOP operasional secara ketat. Mengasah komunikasi interpersonal, manajemen krisis, disiplin tinggi, serta ketelitian detail dalam pencatatan log book dan situasi harian.",
      tags: [
        "Risk Analysis",
        "Access Control",
        "Crisis Management",
        "SOP Compliance",
      ],
    ),
    ExperienceData(
      role: "Riset Software & Proyek Akhir Kuliah",
      company: "Universitas Indraprasta PGRI",
      period: "2021 - 2025",
      description:
      "Mengembangkan Sistem Pendukung Keputusan (SPK) perbaikan fasilitas menggunakan metode Weighted Product (WP). Berfokus pada perancangan arsitektur aplikasi yang bersih, analisis data terstruktur, dan antarmuka pengguna yang intuitif.",
      tags: [
        "Informatics Engineering",
        "Decision Support System",
        "Clean Architecture",
        "UI/UX",
      ],
    ),
  ];

  @override
  State<ExperienceSection> createState() => _ExperienceSectionState();
}

class _ExperienceSectionState extends State<ExperienceSection>
    with SingleTickerProviderStateMixin {
  bool _isVisible = false;
  late final AnimationController _revealController;

  @override
  void initState() {
    super.initState();
    _revealController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds:
        600 + (ExperienceSection._listExperience.length * 220),
      ),
    );
  }

  @override
  void dispose() {
    _revealController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isDesktop = screenWidth > 950;

    return VisibilityDetector(
      key: const Key('experience-section-detector'),
      onVisibilityChanged: (visibilityInfo) {
        if (visibilityInfo.visibleFraction > 0.15 && !_isVisible) {
          setState(() => _isVisible = true);
          _revealController.forward();
        }
      },
      child: Container(
        width: double.infinity,
        color: const Color(0xff090D16),
        padding: EdgeInsets.symmetric(
          horizontal: isDesktop ? 60 : 20,
          vertical: 80,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: Column(
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
                      color: const Color(0xff00D2FF).withOpacity(0.25),
                      width: 1.2,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.work_history_rounded,
                        color: Color(0xff00D2FF),
                        size: 14,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "CAREER PATH",
                        style: GoogleFonts.inter(
                          color: const Color(0xff00D2FF),
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                Column(
                  children: List.generate(
                    ExperienceSection._listExperience.length,
                        (index) {
                      final int count =
                          ExperienceSection._listExperience.length;
                      // Stagger: tiap tile mulai reveal sedikit lebih telat
                      // dari tile sebelumnya, biar keliatan "satu-satu"
                      // bukan muncul bareng semua.
                      final double start = (index / count) * 0.7;
                      final double end =
                      (start + (1 / count) * 1.3).clamp(0.0, 1.0);
                      final Animation<double> revealAnimation =
                      CurvedAnimation(
                        parent: _revealController,
                        curve: Interval(
                          start,
                          end,
                          curve: Curves.easeOutCubic,
                        ),
                      );

                      return _FuturisticTimelineTile(
                        data: ExperienceSection._listExperience[index],
                        isFirst: index == 0,
                        isLast: index == count - 1,
                        revealAnimation: revealAnimation,
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
}



class _FuturisticTimelineTile extends StatefulWidget {
  final ExperienceData data;
  final bool isFirst;
  final bool isLast;
  final Animation<double> revealAnimation;

  const _FuturisticTimelineTile({
    required this.data,
    required this.isFirst,
    required this.isLast,
    required this.revealAnimation,
  });

  @override
  State<_FuturisticTimelineTile> createState() =>
      _FuturisticTimelineTileState();
}

class _FuturisticTimelineTileState extends State<_FuturisticTimelineTile>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late final AnimationController _pulseController;

  static const double _railWidth = 28.0;
  static const double _dotTopOffset = 24.0;

  @override
  void initState() {
    super.initState();
    // Ring "sinyal aktif" yang breathing terus-menerus di tiap dot —
    // ini yang ngasih kesan futuristik/HUD, jalan independen dari hover.
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedBuilder(
        animation: widget.revealAnimation,
        builder: (context, child) {
          final double t = widget.revealAnimation.value.clamp(0.0, 1.0);
          return Opacity(
            opacity: t,
            child: Transform.translate(
              offset: Offset(0, (1 - t) * 28),
              child: child,
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: Stack(
            children: [
              // Garis penghubung — Stack otomatis ambil tinggi dari
              // konten card di bawah, jadi gak butuh IntrinsicHeight
              // sama sekali (itu yang kemarin bikin crash).
              if (!widget.isLast)
                Positioned(
                  left: (_railWidth - 2) / 2,
                  top: widget.isFirst ? _dotTopOffset : 0,
                  bottom: 0,
                  child: Container(
                    width: 2,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          const Color(0xff00D2FF).withOpacity(
                            widget.isFirst ? 0.0 : 0.35,
                          ),
                          const Color(0xff00D2FF).withOpacity(0.05),
                        ],
                      ),
                    ),
                  ),
                )
              else if (!widget.isFirst)
              // Entry terakhir: garis cuma nyambung dari atas ke dot,
              // gak lanjut ke bawah.
                Positioned(
                  left: (_railWidth - 2) / 2,
                  top: 0,
                  child: Container(
                    width: 2,
                    height: _dotTopOffset,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          const Color(0xff00D2FF).withOpacity(0.0),
                          const Color(0xff00D2FF).withOpacity(0.35),
                        ],
                      ),
                    ),
                  ),
                ),

              // Dot + pulsing ring
              Positioned(
                left: 0,
                top: _dotTopOffset - 14,
                child: AnimatedBuilder(
                  animation: _pulseController,
                  builder: (context, _) {
                    final double pulse = _pulseController.value;
                    return SizedBox(
                      width: _railWidth,
                      height: 28,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          if (!_isHovered)
                            Container(
                              width: 12 + (pulse * 10),
                              height: 12 + (pulse * 10),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: const Color(0xff00D2FF)
                                      .withOpacity((1 - pulse) * 0.35),
                                  width: 1.2,
                                ),
                              ),
                            ),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            width: _isHovered ? 16 : 12,
                            height: _isHovered ? 16 : 12,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _isHovered
                                  ? const Color(0xff00D2FF)
                                  : const Color(0xff090D16),
                              border: Border.all(
                                color: _isHovered
                                    ? const Color(0xff00D2FF)
                                    : const Color(0xff334155),
                                width: _isHovered ? 3 : 2,
                              ),
                              boxShadow: [
                                if (_isHovered)
                                  BoxShadow(
                                    color: const Color(0xff00D2FF)
                                        .withOpacity(0.8),
                                    blurRadius: 12,
                                    spreadRadius: 2,
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // Card — ini yang menentukan tinggi Stack secara keseluruhan
              // (non-positioned child = default sizing source buat Stack).
              Padding(
                padding: EdgeInsets.only(left: _railWidth + 16),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOutCubic,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: _isHovered
                        ? const Color(0xff111827).withOpacity(0.55)
                        : const Color(0xff111827).withOpacity(0.18),
                    border: Border.all(
                      color: _isHovered
                          ? const Color(0xff00D2FF).withOpacity(0.45)
                          : Colors.white.withOpacity(0.04),
                      width: 1.2,
                    ),
                    boxShadow: [
                      if (_isHovered)
                        BoxShadow(
                          color: const Color(0xff00D2FF).withOpacity(0.08),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LayoutBuilder(
                        builder: (context, constraints) {
                          bool isMobile = constraints.maxWidth < 480;

                          if (isMobile) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 36,
                                      height: 36,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(10),
                                        color: const Color(0xff00D2FF)
                                            .withOpacity(0.10),
                                      ),
                                      child: const Icon(
                                        Icons.developer_board_rounded,
                                        color: Color(0xff00D2FF),
                                        size: 18,
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xff1E293B)
                                            .withOpacity(0.5),
                                        borderRadius:
                                        BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        widget.data.period,
                                        style: GoogleFonts.inter(
                                          color: const Color(0xff94A3B8),
                                          fontSize: 11,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  widget.data.role,
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  widget.data.company,
                                  style: GoogleFonts.inter(
                                    color: const Color(0xff00D2FF),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            );
                          }

                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                margin: const EdgeInsets.only(right: 14),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: const Color(0xff00D2FF)
                                      .withOpacity(0.10),
                                ),
                                child: const Icon(
                                  Icons.developer_board_rounded,
                                  color: Color(0xff00D2FF),
                                  size: 20,
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.data.role,
                                      style: GoogleFonts.inter(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      widget.data.company,
                                      style: GoogleFonts.inter(
                                        color: const Color(0xff00D2FF),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xff1E293B)
                                      .withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  widget.data.period,
                                  style: GoogleFonts.inter(
                                    color: const Color(0xff94A3B8),
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),

                      const SizedBox(height: 14),

                      Text(
                        widget.data.description,
                        style: GoogleFonts.inter(
                          color: const Color(0xff94A3B8),
                          fontSize: 13.5,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 14),

                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: widget.data.tags.map((tag) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xff1E293B).withOpacity(0.3),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.05),
                              ),
                            ),
                            child: Text(
                              tag,
                              style: GoogleFonts.inter(
                                color: const Color(0xffCBD5E1),
                                fontSize: 11,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
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