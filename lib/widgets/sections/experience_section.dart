import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isDesktop = screenWidth > 950;

    return Container(
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
                children: List.generate(_listExperience.length, (index) {
                  return _FuturisticTimelineTile(
                    data: _listExperience[index],
                    isFirst: index == 0,
                    isLast: index == _listExperience.length - 1,
                  );
                }),
              ),
            ],
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 24,
            child: Column(
              children: [
                const SizedBox(height: 24),
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
                          color: const Color(0xff00D2FF).withOpacity(0.8),
                          blurRadius: 12,
                          spreadRadius: 2,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24),
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
                                      borderRadius: BorderRadius.circular(10),
                                      color: const Color(
                                        0xff00D2FF,
                                      ).withOpacity(0.10),
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
                                      color: const Color(
                                        0xff1E293B,
                                      ).withOpacity(0.5),
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
                                color: const Color(
                                  0xff00D2FF,
                                ).withOpacity(0.10),
                              ),
                              child: const Icon(
                                Icons.developer_board_rounded,
                                color: Color(0xff00D2FF),
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
                                color: const Color(0xff1E293B).withOpacity(0.5),
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
          ),
        ],
      ),
    );
  }
}
