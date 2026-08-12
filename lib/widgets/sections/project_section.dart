import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectSection extends StatefulWidget {
  const ProjectSection({super.key});

  @override
  State<ProjectSection> createState() => _ProjectSectionState();
}

class _ProjectSectionState extends State<ProjectSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  bool _hasAnimated = false;

  final List<Map<String, dynamic>> projects = [
    {
      "title": "SPK Perbaikan Fasilitas (Weighted Product)",
      "desc":
      "Sistem Pendukung Keputusan berbasis web/mobile untuk menentukan prioritas perbaikan fasilitas menggunakan metode Weighted Product (WP).",
      "imageUrl": "assets/images/project/c.png",
      "tags": ["Mobile Dev", "Data Management", "Process Automation"],
      "githubUrl": "https://github.com/Anggimuhamadn?tab=repositories",
      "liveUrl": "https://github.com/Anggimuhamadn?tab=repositories",
    },
    {
      "title": "Security Logbook & Patrol management",
      "desc":
      "Aplikasi mobile digitalisasi operasional kemanan fisik, Mengintegrasikan pencatatan real-time, pelaporan insiden presisi, dan manajemen data akses terpusat.",
      "imageUrl": "assets/images/project/b.jpeg",
      "tags": ["Decision Support System", "Algorithm", "UI/UX"],
      "githubUrl": "https://github.com/Anggimuhamadn?tab=repositories",
      "liveUrl": "https://github.com/Anggimuhamadn?tab=repositories",
    },
    {
      "title": "Report",
      "desc":
      "Aplikasi laporan bulanan dengan dilengkapi share pdf dan word dengan format menyesuaikan kebutuhan.",
      "imageUrl": "assets/images/project/d.jpeg",
      "alignment": Alignment.center,
      "tags": ["Flutter", "Bloc", "Node.js"],
      "githubUrl": "https://github.com/Anggimuhamadn?tab=repositories",
      "liveUrl": "https://github.com/Anggimuhamadn?tab=repositories",
    },
    {
      "title": "Visitor & Parking Registration System",
      "desc":
      "Sistem manajemen registrasi pengunjung dan kendaraan area terbatas. Dilengkapi validasi plat nomor otomatis, cetak pass masuk digital, serta pemantauan kuota parkir real-time.",
      "imageUrl": "assets/images/project/e.png",
      "tags": ["Flutter", "Riverpod", "REST API"],
      "githubUrl": "https://github.com/Anggimuhamadn?tab=repositories",
      "liveUrl": "https://github.com/Anggimuhamadn?tab=repositories",
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isDesktop = screenWidth > 950;

    return VisibilityDetector(
      key: const Key('project-section-visibility-key'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.12 && !_hasAnimated) {
          _hasAnimated = true;
          _animController.forward();
        }
      },
      child: Container(
        width: double.infinity,
        color: const Color(0xff090D16),
        child: Stack(
          children: [
            Positioned(
              top: 100,
              right: -100,
              child: RepaintBoundary(
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 55, sigmaY: 55),
                  child: Container(
                    width: 450,
                    height: 450,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          const Color(0xff00D2FF).withOpacity(0.12),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop ? 80 : 20,
                vertical: isDesktop ? 120 : 60,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1150),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildAnimatedChild(
                        start: 0.0,
                        end: 0.3,
                        child: Container(
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
                                Icons.grid_view_rounded,
                                color: Color(0xff00D2FF),
                                size: 14,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "Proyek Pilihan",
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
                      ),
                      const SizedBox(height: 20),

                      isDesktop
                          ? Column(
                        children: [
                          _buildAnimatedChild(
                            start: 0.2,
                            end: 0.6,
                            child: _GlassBentoCard(
                              project: projects[0],
                              isFeatured: true,
                            ),
                          ),
                          const SizedBox(height: 24),

                          Row(
                            children: [
                              Expanded(
                                child: _buildAnimatedChild(
                                  start: 0.35,
                                  end: 0.75,
                                  child: _GlassBentoCard(
                                    project: projects[1],
                                    isFeatured: false,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 24),
                              Expanded(
                                child: _buildAnimatedChild(
                                  start: 0.50,
                                  end: 0.90,
                                  child: _GlassBentoCard(
                                    project: projects[2],
                                    isFeatured: false,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 24),
                              Expanded(
                                child: _buildAnimatedChild(
                                  start: 0.65,
                                  end: 1.0,
                                  child: _GlassBentoCard(
                                    project: projects[3],
                                    isFeatured: false,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                          : ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: projects.length,
                        separatorBuilder: (_, __) =>
                        const SizedBox(height: 24),
                        itemBuilder: (context, index) {
                          final double start = (0.2 + (index * 0.15))
                              .clamp(0.0, 0.7);
                          final double end = (start + 0.35).clamp(
                            0.0,
                            1.0,
                          );

                          return _buildAnimatedChild(
                            start: start,
                            end: end,
                            child: _GlassBentoCard(
                              project: projects[index],
                              isFeatured: false,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedChild({
    required double start,
    required double end,
    required Widget child,
  }) {
    final Animation<double> fadeAnim = CurvedAnimation(
      parent: _animController,
      curve: Interval(start, end, curve: Curves.easeOut),
    );

    final Animation<Offset> slideAnim =
    Tween<Offset>(begin: const Offset(0.0, 0.20), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _animController,
        curve: Interval(start, end, curve: Curves.easeOutCubic),
      ),
    );

    final Animation<double> scaleAnim = Tween<double>(begin: 0.92, end: 1.0)
        .animate(
      CurvedAnimation(
        parent: _animController,
        curve: Interval(start, end, curve: Curves.easeOutBack),
      ),
    );

    return AnimatedBuilder(
      animation: _animController,
      builder: (context, childWidget) {
        return FadeTransition(
          opacity: fadeAnim,
          child: SlideTransition(
            position: slideAnim,
            child: ScaleTransition(scale: scaleAnim, child: childWidget),
          ),
        );
      },
      child: child,
    );
  }
}

class _GlassBentoCard extends StatefulWidget {
  final Map<String, dynamic> project;
  final bool isFeatured;

  const _GlassBentoCard({required this.project, required this.isFeatured});

  @override
  State<_GlassBentoCard> createState() => _GlassBentoCardState();
}

class _GlassBentoCardState extends State<_GlassBentoCard> {
  bool _isHovered = false;

  void _openLink(String urlString) async {
    final Uri uri = Uri.parse(urlString);
    try {
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        debugPrint('Could not launch $urlString');
      }
    } catch (e) {
      debugPrint('Error launching url: $e');
    }
  }

  // HELPER UNTUK CEK & RENDER GAMBAR DENGAN SAFE GUARD
  Widget _buildSafeImage(String path, Alignment alignment) {
    return Image.asset(
      path,
      fit: BoxFit.cover,
      alignment: alignment,
      errorBuilder: (context, error, stackTrace) {
        // BILA ASSET EXTENSION SALAH ATAU BEDA KAPITAL, TAMPILKAN PLACEHOLDER RAPI
        return Container(
          color: const Color(0xff1E293B),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.image_not_supported_rounded, color: Color(0xff00D2FF), size: 36),
              SizedBox(height: 6),
              Text("Image Asset", style: TextStyle(color: Colors.white54, fontSize: 11)),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            padding: EdgeInsets.all(widget.isFeatured ? 28 : 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: const Color(
                0xff111827,
              ).withOpacity(_isHovered ? 0.45 : 0.20),
              border: Border.all(
                color: _isHovered
                    ? const Color(0xff00D2FF).withOpacity(0.5)
                    : Colors.white.withOpacity(0.05),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(
                    0xff00D2FF,
                  ).withOpacity(_isHovered ? 0.08 : 0.0),
                  blurRadius: 30,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: widget.isFeatured
                ? _buildFeaturedContent()
                : _buildStandardContent(),
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturedContent() {
    final Alignment imgAlignment =
        widget.project["alignment"] ?? Alignment.center;

    return Row(
      children: [
        Expanded(
          flex: 6,
          child: AspectRatio(
            aspectRatio: 1.7,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: AnimatedScale(
                      scale: _isHovered ? 1.05 : 1.0,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeOutCubic,
                      child: _buildSafeImage(widget.project["imageUrl"], imgAlignment),
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
                            const Color(0xff090D16).withOpacity(0.5),
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
        const SizedBox(width: 32),

        Expanded(
          flex: 6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: (widget.project["tags"] as List<String>)
                    .map((tag) => _buildGlassTag(tag))
                    .toList(),
              ),
              const SizedBox(height: 18),
              Text(
                widget.project["title"],
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                widget.project["desc"],
                style: GoogleFonts.inter(
                  color: const Color(0xff94A3B8),
                  fontSize: 15,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  _buildGlassActionButton(
                    icon: Icons.code_rounded,
                    label: "Code",
                    onTap: () => _openLink(widget.project["githubUrl"]),
                  ),
                  const SizedBox(width: 12),
                  _buildGlassActionButton(
                    icon: Icons.arrow_outward_rounded,
                    label: "Demo",
                    onTap: () => _openLink(widget.project["liveUrl"]),
                    isPrimary: true,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStandardContent() {
    final Alignment imgAlignment =
        widget.project["alignment"] ?? const Alignment(0.0, -0.10);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 1.6,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Stack(
              children: [
                Positioned.fill(
                  child: AnimatedScale(
                    scale: _isHovered ? 1.05 : 1.0,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeOutCubic,
                    child: _buildSafeImage(widget.project["imageUrl"], imgAlignment),
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
                          const Color(0xff090D16).withOpacity(0.6),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 18),

        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: (widget.project["tags"] as List<String>)
              .map((tag) => _buildGlassTag(tag))
              .toList(),
        ),
        const SizedBox(height: 14),

        Text(
          widget.project["title"],
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 8),

        Text(
          widget.project["desc"],
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.inter(
            color: const Color(0xff94A3B8),
            fontSize: 13,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 20),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildGlassIconButton(
              icon: Icons.code_rounded,
              tooltip: "Source Code",
              onTap: () => _openLink(widget.project["githubUrl"]),
            ),
            _buildGlassIconButton(
              icon: Icons.arrow_outward_rounded,
              tooltip: "Live Demo",
              onTap: () => _openLink(widget.project["liveUrl"]),
              isPrimary: true,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGlassTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xff00D2FF).withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xff00D2FF).withOpacity(0.25)),
      ),
      child: Text(
        text,
        style: GoogleFonts.inter(
          color: const Color(0xff00D2FF),
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildGlassActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isPrimary = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isPrimary
              ? const Color(0xff00D2FF).withOpacity(0.15)
              : const Color(0xff1E293B).withOpacity(0.4),
          border: Border.all(
            color: isPrimary
                ? const Color(0xff00D2FF)
                : Colors.white.withOpacity(0.08),
            width: 1.2,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 17,
              color: isPrimary ? const Color(0xff00D2FF) : Colors.white,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isPrimary ? const Color(0xff00D2FF) : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGlassIconButton({
    required IconData icon,
    required String tooltip,
    required VoidCallback onTap,
    bool isPrimary = false,
  }) {
    return Tooltip(
      message: tooltip,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isPrimary
                ? const Color(0xff00D2FF).withOpacity(0.15)
                : const Color(0xff1E293B).withOpacity(0.4),
            border: Border.all(
              color: isPrimary
                  ? const Color(0xff00D2FF)
                  : Colors.white.withOpacity(0.08),
              width: 1.2,
            ),
          ),
          child: Center(
            child: Icon(
              icon,
              size: 19,
              color: isPrimary ? const Color(0xff00D2FF) : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}