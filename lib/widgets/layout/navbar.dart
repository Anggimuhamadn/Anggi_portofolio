import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:html' as html;

class Navbar extends StatefulWidget {
  final ValueChanged<int> onNavClick;
  final bool isScrolled;
  final int activeIndex; // <--- TAMBAHIN BARIS INI BLAY!

  const Navbar({
    super.key,
    required this.onNavClick,
    required this.isScrolled,
    required this.activeIndex, // <--- WAJIB DIINJECT DI SINI BRAY
  });

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  bool _isLogoHovered = false;
  bool _isResumeHovered = false;

  void _downloadResume() {
    html.AnchorElement anchorElement = html.AnchorElement(href: "assets/CV.AnggiMNn.pdf");
    anchorElement.target = "_blank";
    anchorElement.download = "CV_Anggi_M_N.pdf";
    anchorElement.click();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnimatedPadding(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOutCubic,
        padding: EdgeInsets.only(
          left: widget.isScrolled ? 80 : 60,
          right: widget.isScrolled ? 80 : 60,
          top: 20,
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
              height: 72,
              padding: const EdgeInsets.symmetric(horizontal: 24),
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
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: _isLogoHovered
                                    ? [const Color(0xff00D2FF), const Color(0xff6366F1)]
                                    : [const Color(0xff6366F1), const Color(0xff00D2FF)],
                              ),
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xff00D2FF).withOpacity(_isLogoHovered ? 0.6 : 0.3),
                                  blurRadius: _isLogoHovered ? 16 : 10,
                                  offset: const Offset(0, 4),
                                )
                              ]),
                          child: const Center(
                            child: Text(
                              "< />",
                              style: TextStyle(
                                fontFamily: 'Inter',
                                color: Colors.white,
                                fontSize: 14,
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

                  // SINKRONISASI COCOK-NYALA BERDASARKAN ACTIVEINDEX BRE!
                  _HoverNavItem(
                    title: "About",
                    isActive: widget.activeIndex == 0, // <--- Menyala pas index 0 aktif
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
                ],
              ),
            ),
          ),
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
                        : [
                      const Color(0xff0088FF),
                      const Color(0xff4F46E5),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xff00D2FF).withOpacity(_isResumeHovered ? 0.5 : 0.15),
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
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
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
                      Icon(Icons.north_east_rounded, color: Colors.white, size: 15),
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

// COMPONENT HOVERNAVITEM DIUBAH PAKE PARAMETER ISACTIVE DINAMIS
class _HoverNavItem extends StatefulWidget {
  final String title;
  final VoidCallback onTap;
  final bool isActive; // <--- Menggantikan isScrolled bawaan yang ga kepake di item bre

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

    // Kondisi menyala: pas kursor nge-hover ATAU pas section-nya emang lagi aktif discroll blay
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
                  fontWeight: shouldHighlight ? FontWeight.w600 : FontWeight.w500,
                  letterSpacing: 0.5,
                ),
                child: Text(widget.title),
              ),
              const SizedBox(height: 6),
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                height: 2,
                // Garis cyan auto-lebar 24px kalau section-nya lagi aktif bre!
                width: shouldHighlight ? 24 : 0,
                decoration: BoxDecoration(
                    color: const Color(0xff00D2FF),
                    borderRadius: BorderRadius.circular(2),
                    boxShadow: [
                      if (shouldHighlight)
                        BoxShadow(
                          color: const Color(0xff00D2FF).withOpacity(0.8),
                          blurRadius: 6,
                        )
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}