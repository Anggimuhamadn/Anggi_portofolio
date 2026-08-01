import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Navbar extends StatefulWidget {
  final ValueChanged<int> onNavClick;
  final bool isScrolled;
  final int activeIndex;

  const Navbar({
    super.key,
    required this.onNavClick,
    required this.isScrolled,
    required this.activeIndex,
  });

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  bool _isLogoHovered = false;
  bool _isResumeHovered = false;

  void _downloadResume() async {
    const String resumeUrl = "assets/CV.AnggiMNfixnew.pdf";
    final Uri uri = Uri.parse(resumeUrl);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $resumeUrl');
    }
  }

  void _openMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xff090D16),
      barrierColor: Colors.black.withOpacity(0.7),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          decoration: BoxDecoration(
            color: const Color(0xff090D16),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
            border: Border.all(color: const Color(0xff00D2FF).withOpacity(0.2)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 24),

              _buildMobileNavItem("About", 0),
              _buildMobileNavItem("Experience", 1),
              _buildMobileNavItem("Projects", 2),
              _buildMobileNavItem("Certifications", 3),
              _buildMobileNavItem("Contact", 4),

              const SizedBox(height: 20),
              SizedBox(width: double.infinity, child: _buildResumeButton()),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMobileNavItem(String title, int index) {
    bool isActive = widget.activeIndex == index;
    return ListTile(
      onTap: () {
        Navigator.pop(context);
        widget.onNavClick(index);
      },
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'Inter',
          color: isActive ? const Color(0xff00D2FF) : const Color(0xff94A3B8),
          fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
          fontSize: 16,
        ),
      ),
      trailing: isActive
          ? const Icon(
        Icons.arrow_forward_ios_rounded,
        color: Color(0xff00D2FF),
        size: 14,
      )
          : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 800;

    return SafeArea(
      child: AnimatedPadding(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOutCubic,
        padding: EdgeInsets.only(
          left: isMobile ? 16 : (widget.isScrolled ? 80 : 60),
          right: isMobile ? 16 : (widget.isScrolled ? 80 : 60),
          top: isMobile ? 10 : 20,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: widget.isScrolled ? 0.0 : 14.0,
              sigmaY: widget.isScrolled ? 0.0 : 14.0,
            ),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeInOutCubic,
              height: isMobile ? 60 : 72,
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: widget.isScrolled
                    ? Colors.transparent
                    : const Color(0xff111827).withOpacity(0.45),
                border: Border.all(
                  color: widget.isScrolled
                      ? Colors.transparent
                      : const Color(0xff00D2FF).withOpacity(0.1),
                  width: widget.isScrolled ? 0.0 : 1.2,
                ),
                boxShadow: widget.isScrolled
                    ? []
                    : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Row(
                children: [
                  MouseRegion(
                    onEnter: (_) => setState(() => _isLogoHovered = true),
                    onExit: (_) => setState(() => _isLogoHovered = false),
                    child: GestureDetector(
                      onTap: () => widget.onNavClick(-1),
                      child: AnimatedRotation(
                        turns: _isLogoHovered ? 0.05 : 0.0,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOutBack,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: isMobile ? 38 : 44,
                          height: isMobile ? 38 : 44,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: _isLogoHovered
                                  ? [
                                const Color(0xff00D2FF),
                                const Color(0xff6366F1),
                              ]
                                  : [
                                const Color(0xff6366F1),
                                const Color(0xff00D2FF),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(
                                  0xff00D2FF,
                                ).withOpacity(_isLogoHovered ? 0.6 : 0.3),
                                blurRadius: _isLogoHovered ? 16 : 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Text(
                              "< />",
                              style: TextStyle(
                                fontFamily: 'Inter',
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                letterSpacing: .5,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const Spacer(),

                  if (!isMobile) ...[
                    _HoverNavItem(
                      title: "About",
                      isActive: widget.activeIndex == 0,
                      onTap: () => widget.onNavClick(0),
                    ),
                    const SizedBox(width: 24),
                    _HoverNavItem(
                      title: "Experience",
                      isActive: widget.activeIndex == 1,
                      onTap: () => widget.onNavClick(1),
                    ),
                    const SizedBox(width: 24),
                    _HoverNavItem(
                      title: "Projects",
                      isActive: widget.activeIndex == 2,
                      onTap: () => widget.onNavClick(2),
                    ),
                    const SizedBox(width: 24),
                    _HoverNavItem(
                      title: "Certifications",
                      isActive: widget.activeIndex == 3,
                      onTap: () => widget.onNavClick(3),
                    ),
                    const SizedBox(width: 24),
                    _HoverNavItem(
                      title: "Contact",
                      isActive: widget.activeIndex == 4,
                      onTap: () => widget.onNavClick(4),
                    ),
                    const Spacer(),
                    _buildResumeButton(),
                  ] else ...[
                    // TAMPILAN HEADER MOBILE: TOMBOL RESUME RINGKAS + IKON MENU
                    _buildMobileResumeButton(),
                    const SizedBox(width: 10),
                    IconButton(
                      onPressed: () => _openMobileMenu(context),
                      icon: const Icon(
                        Icons.menu_rounded,
                        color: Color(0xff00D2FF),
                        size: 28,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // WIDGET TOMBOL RESUME RINGKAS KHUSUS MOBILE HEADER
  Widget _buildMobileResumeButton() {
    return GestureDetector(
      onTap: _downloadResume,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xff0088FF), Color(0xff4F46E5)],
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xff00D2FF).withOpacity(0.25),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(
              "CV",
              style: TextStyle(
                fontFamily: 'Inter',
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
                letterSpacing: 0.5,
              ),
            ),
            SizedBox(width: 4),
            Icon(
              Icons.north_east_rounded,
              color: Colors.white,
              size: 13,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResumeButton() {
    return StatefulBuilder(
      builder: (context, buttonSetState) {
        bool isPressed = false;

        return MouseRegion(
          onEnter: (_) => setState(() => _isResumeHovered = true),
          onExit: (_) => setState(() => _isResumeHovered = false),
          child: GestureDetector(
            onTapDown: (_) => buttonSetState(() => isPressed = true),
            onTapUp: (_) => buttonSetState(() => isPressed = false),
            onTapCancel: () => buttonSetState(() => isPressed = false),
            onTap: _downloadResume,
            child: AnimatedScale(
              scale: isPressed ? 0.95 : (_isResumeHovered ? 1.04 : 1.0),
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeOut,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOutCubic,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: _isResumeHovered
                        ? [
                      const Color(0xff00D2FF),
                      const Color(0xff6366F1),
                      const Color(0xffEC4899),
                    ]
                        : [const Color(0xff0088FF), const Color(0xff4F46E5)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(
                        0xff00D2FF,
                      ).withOpacity(_isResumeHovered ? 0.5 : 0.15),
                      blurRadius: _isResumeHovered ? 24 : 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: null,
                  style: ElevatedButton.styleFrom(
                    disabledBackgroundColor: Colors.transparent,
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Resume",
                        style: TextStyle(
                          fontFamily: 'Inter',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          letterSpacing: 0.8,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(
                        Icons.north_east_rounded,
                        color: Colors.white,
                        size: 15,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _HoverNavItem extends StatefulWidget {
  final String title;
  final VoidCallback onTap;
  final bool isActive;

  const _HoverNavItem({
    required this.title,
    required this.onTap,
    required this.isActive,
  });

  @override
  State<_HoverNavItem> createState() => _HoverNavItemState();
}

class _HoverNavItemState extends State<_HoverNavItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    Color defaultTextColor = const Color(0xff94A3B8);
    Color hoverTextColor = Colors.white;

    bool shouldHighlight = _isHovered || widget.isActive;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(
                  fontFamily: 'Inter',
                  color: shouldHighlight ? hoverTextColor : defaultTextColor,
                  fontSize: 14,
                  fontWeight: shouldHighlight
                      ? FontWeight.w600
                      : FontWeight.w500,
                  letterSpacing: 0.5,
                ),
                child: Text(widget.title),
              ),
              const SizedBox(height: 6),
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                height: 2,
                width: shouldHighlight ? 24 : 0,
                decoration: BoxDecoration(
                  color: const Color(0xff00D2FF),
                  borderRadius: BorderRadius.circular(2),
                  boxShadow: [
                    if (shouldHighlight)
                      BoxShadow(
                        color: const Color(0xff00D2FF).withOpacity(0.8),
                        blurRadius: 6,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}