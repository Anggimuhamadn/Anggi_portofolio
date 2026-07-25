import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// === DATA MODEL EXPERIENCE ===
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

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  static const List<ExperienceData> _listExperience = [
    ExperienceData(

        role: "Mobile Developer — Security Data Management",
        company: "Internal Operational System Project",
        period: "2024 - 2025",
        description:
        "Merancang dan mendesain aplikasi mobile untuk digitalisasi manajemen data operasional security. Mengubah pencatatan logbook manual menjadi sistem digital terstruktur, mempercepat pelaporan insiden, dan meningkatkan akurasi rekap data lapangan.",
        tags: ["Mobile Development", "Data Management", "Process Automation", "UI/UX"],
      ),
    ExperienceData(
      role: "Operational Security Officer",
      company: "Professional Security Service",
      period: "2023 - Sekarang",
      description:
      "Bertanggung jawab atas pengawasan keamanan fisik, analisis risiko area, serta penerapan SOP operasional secara ketat. Mengasah komunikasi interpersonal, manajemen krisis, disiplin tinggi, serta ketelitian detail dalam pencatatan log book dan situasi harian.",
      tags: ["Risk Analysis", "Access Control", "Crisis Management", "SOP Compliance"],
    ),
    ExperienceData(
      role: "Riset Software & Proyek Akhir Kuliah",
      company: "Universitas Indraprasta PGRI",
      period: "2021 - 2025",
      description:
      "Mengembangkan Sistem Pendukung Keputusan (SPK) perbaikan fasilitas menggunakan metode Weighted Product (WP). Berfokus pada perancangan arsitektur aplikasi yang bersih, analisis data terstruktur, dan antarmuka pengguna yang intuitif.",
      tags: ["Informatics Engineering", "Decision Support System", "Clean Architecture", "UI/UX"],
    ),

  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isDesktop = screenWidth > 950;

    return Container(
      width: double.infinity,
      color: const Color(0xff090D16),
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 60 : 20,
        vertical: 100,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // INTRO BADGE NEON CYAN
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
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
                    const Icon(Icons.work_history_rounded,
                        color: Color(0xff00D2FF), size: 14),
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

              const SizedBox(height:20),

              // TIMELINE LIST
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _listExperience.length,
                itemBuilder: (context, index) {
                  return _FuturisticTimelineTile(
                    data: _listExperience[index],
                    isFirst: index == 0,
                    isLast: index == _listExperience.length - 1,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// === COMPONENT WIDGET: CYBER GLASS TIMELINE CARD ===
class _FuturisticTimelineTile extends StatefulWidget {
  final ExperienceData data;
  final bool isFirst;
  final bool isLast;

  const _FuturisticTimelineTile({
    required this.data,
    required this.isFirst,
    required this.isLast,
  });

  @override
  State<_FuturisticTimelineTile> createState() =>
      _FuturisticTimelineTileState();
}

class _FuturisticTimelineTileState extends State<_FuturisticTimelineTile> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // =========================================================================
            // 1. STRUKTUR CYBER NODE & GLOWING LINE
            // =========================================================================
            SizedBox(
              width: 32,
              child: Column(
                children: [
                  Container(
                    width: 2,
                    height: 22,
                    color: widget.isFirst
                        ? Colors.transparent
                        : const Color(0xff1E293B),
                  ),

                  // CYBER GLOWING NODE
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    width: _isHovered ? 18 : 14,
                    height: _isHovered ? 18 : 14,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _isHovered
                          ? const Color(0xff00D2FF)
                          : const Color(0xff090D16),
                      border: Border.all(
                        color: _isHovered
                            ? const Color(0xff00D2FF)
                            : const Color(0xff334155),
                        width: _isHovered ? 3.5 : 2,
                      ),
                      boxShadow: [
                        if (_isHovered)
                          BoxShadow(
                            color: const Color(0xff00D2FF).withOpacity(0.9),
                            blurRadius: 18,
                            spreadRadius: 4,
                          )
                      ],
                    ),
                  ),

                  // GARIS VERTIKAL DENGAN NEON GRADIENT PAS HOVER
                  Expanded(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: _isHovered ? 2.5 : 2,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: widget.isLast
                              ? [Colors.transparent, Colors.transparent]
                              : (_isHovered
                              ? [
                            const Color(0xff00D2FF),
                            const Color(0xff1E293B)
                          ]
                              : [
                            const Color(0xff1E293B),
                            const Color(0xff1E293B)
                          ]),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 24),

            // =========================================================================
            // 2. KARTU FUTURISTIK DENGAN SPOTLIGHT GLOW & HOVER SLIDE
            // =========================================================================
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 28),
                child: AnimatedSlide(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOutCubic,
                  offset: _isHovered ? const Offset(0.012, 0) : Offset.zero,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeOutCubic,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
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
                            blurRadius: 30,
                            offset: const Offset(0, 10),
                          ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        // SPOTLIGHT RADIAL GLOW DI CORNER PAS HOVER
                        if (_isHovered)
                          Positioned(
                            top: -40,
                            right: -40,
                            child: Container(
                              width: 130,
                              height: 130,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: RadialGradient(
                                  colors: [
                                    const Color(0xff00D2FF).withOpacity(0.15),
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                            ),
                          ),

                        // KONTEN UTAMA KARTU
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // CYBER BADGE ICON
                                Container(
                                  width: 44,
                                  height: 44,
                                  margin: const EdgeInsets.only(right: 16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: const Color(0xff00D2FF)
                                        .withOpacity(_isHovered ? 0.12 : 0.05),
                                    border: Border.all(
                                      color: const Color(0xff00D2FF)
                                          .withOpacity(_isHovered ? 0.35 : 0.15),
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.developer_board_rounded,
                                    color: _isHovered
                                        ? const Color(0xff00D2FF)
                                        : const Color(0xff64748B),
                                    size: 20,
                                  ),
                                ),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.data.role,
                                        style: GoogleFonts.inter(
                                          color: Colors.white,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: -0.3,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
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
                                const SizedBox(width: 12),

                                // BADGE PERIODE
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: const Color(0xff1E293B)
                                        .withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.06),
                                    ),
                                  ),
                                  child: Text(
                                    widget.data.period,
                                    style: GoogleFonts.inter(
                                      color: const Color(0xff94A3B8),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),

                            // URAIAN DESKRIPSI
                            Text(
                              widget.data.description,
                              style: GoogleFonts.inter(
                                color: const Color(0xff94A3B8),
                                fontSize: 14,
                                height: 1.6,
                              ),
                            ),
                            const SizedBox(height: 18),

                            // TAG CHIPS CYBER
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: widget.data.tags.map((tag) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: _isHovered
                                        ? const Color(0xff00D2FF).withOpacity(0.08)
                                        : const Color(0xff1E293B).withOpacity(0.25),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: _isHovered
                                          ? const Color(0xff00D2FF).withOpacity(0.3)
                                          : Colors.white.withOpacity(0.04),
                                      width: 1,
                                    ),
                                  ),
                                  child: Text(
                                    tag,
                                    style: GoogleFonts.inter(
                                      color: _isHovered
                                          ? const Color(0xff00D2FF)
                                          : const Color(0xffCBD5E1),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}