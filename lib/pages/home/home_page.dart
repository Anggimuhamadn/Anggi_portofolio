import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../widgets/layout/navbar.dart';
import '../../widgets/sections/hero_section.dart';
import '../../widgets/sections/about_section.dart';
import '../../widgets/sections/project_section.dart';
import '../../widgets/sections/experience_section.dart';
import '../../widgets/sections/certification_section.dart';
import '../../widgets/sections/contact_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _certificationKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  // ValueNotifier dipakai supaya tiap tick scroll cuma widget yang
  // "dengerin" lewat ValueListenableBuilder yang rebuild, bukan
  // seluruh HomePage (Hero, About, Project, dst).
  final ValueNotifier<double> _scrollOffsetNotifier = ValueNotifier(0.0);
  final ValueNotifier<bool> _isScrolledNotifier = ValueNotifier(false);
  final ValueNotifier<int> _activeIndexNotifier = ValueNotifier(-1);

  // Throttle: cek section aktif cuma kalau offset udah geser cukup jauh,
  // gak perlu itung ulang tiap 1px scroll.
  double _lastCheckedOffset = 0.0;
  static const double _checkThreshold = 24.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _scrollOffsetNotifier.dispose();
    _isScrolledNotifier.dispose();
    _activeIndexNotifier.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!mounted) return;

    final double offset = _scrollController.offset;
    _scrollOffsetNotifier.value = offset;
    _isScrolledNotifier.value = offset > 20;

    if ((offset - _lastCheckedOffset).abs() >= _checkThreshold) {
      _lastCheckedOffset = offset;
      _checkActiveSection();
    }
  }

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _checkActiveSection() {
    double scrollOffset = _scrollController.offset;

    final double? aboutTop = _getSectionOffset(_aboutKey);
    final double? experienceTop = _getSectionOffset(_experienceKey);
    final double? projectsTop = _getSectionOffset(_projectsKey);
    final double? certTop = _getSectionOffset(_certificationKey);
    final double? contactTop = _getSectionOffset(_contactKey);

    int newIndex = -1;

    if (contactTop != null && scrollOffset >= (contactTop - 250)) {
      newIndex = 4;
    } else if (certTop != null && scrollOffset >= (certTop - 250)) {
      newIndex = 3;
    } else if (projectsTop != null && scrollOffset >= (projectsTop - 250)) {
      newIndex = 2;
    } else if (experienceTop != null && scrollOffset >= (experienceTop - 250)) {
      newIndex = 1;
    } else if (aboutTop != null && scrollOffset >= (aboutTop - 250)) {
      newIndex = 0;
    }

    if (_activeIndexNotifier.value != newIndex) {
      _activeIndexNotifier.value = newIndex;
    }
  }

  double? _getSectionOffset(GlobalKey key) {
    final RenderBox? renderBox =
        key.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      return renderBox.localToGlobal(Offset.zero).dy + _scrollController.offset;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xff090D16),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            child: Stack(
              children: [
                // Cuma bagian ini yang rebuild tiap scroll (lewat
                // ValueListenableBuilder). RepaintBoundary di dalamnya
                // bikin Transform cuma re-composite layer yang udah
                // di-cache, bukan repaint ulang seluruh isi Hero
                // (termasuk blur beratnya) tiap frame.
                ValueListenableBuilder<double>(
                  valueListenable: _scrollOffsetNotifier,
                  builder: (context, scrollOffset, child) {
                    double heroProgress =
                        (scrollOffset / (screenHeight * 0.7)).clamp(0.0, 1.0);
                    double heroScale = 1.0 - (heroProgress * 0.08);
                    double heroOpacity =
                        (1.0 - (heroProgress * 1.2)).clamp(0.0, 1.0);
                    double heroTranslateY = scrollOffset * 0.40;

                    return Transform.translate(
                      offset: Offset(0, heroTranslateY),
                      child: Opacity(
                        opacity: heroOpacity,
                        child: Transform.scale(
                          scale: heroScale,
                          child: child,
                        ),
                      ),
                    );
                  },
                  child: RepaintBoundary(
                    child: SizedBox(
                      height: screenHeight,
                      child: HeroSection(key: _heroKey),
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.99),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xff090D16),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                      border: Border(
                        top: BorderSide(
                          color: const Color(0xff00D2FF).withOpacity(0.35),
                          width: 1.5,
                        ),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.9),
                          blurRadius: 50,
                          spreadRadius: 10,
                          offset: const Offset(0, -20),
                        ),
                      ],
                    ),
                    // RepaintBoundary: bagian ini statis terhadap scroll,
                    // jadi diisolasi supaya gak ikut re-paint gara-gara
                    // parent Stack-nya rebuild.
                    child: RepaintBoundary(
                      child: Column(
                        children: [
                          const SizedBox(height: 18),

                          Center(
                            child: Container(
                              width: 48,
                              height: 5,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          AboutSection(key: _aboutKey),
                          ExperienceSection(key: _experienceKey),
                          ProjectSection(key: _projectsKey),
                          CertificationSection(key: _certificationKey),
                          ContactChatSection(key: _contactKey),

                          const SizedBox(height: 80),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ValueListenableBuilder<bool>(
              valueListenable: _isScrolledNotifier,
              builder: (context, isScrolled, _) {
                return ValueListenableBuilder<int>(
                  valueListenable: _activeIndexNotifier,
                  builder: (context, activeIndex, __) {
                    return Navbar(
                      isScrolled: isScrolled,
                      activeIndex: activeIndex,
                      onNavClick: (index) {
                        if (index == -1) {
                          _scrollController.animateTo(
                            0,
                            duration: const Duration(milliseconds: 800),
                            curve: Curves.easeInOutCubic,
                          );
                        } else if (index == 0) {
                          _scrollToSection(_aboutKey);
                        } else if (index == 1) {
                          _scrollToSection(_experienceKey);
                        } else if (index == 2) {
                          _scrollToSection(_projectsKey);
                        } else if (index == 3) {
                          _scrollToSection(_certificationKey);
                        } else if (index == 4) {
                          _scrollToSection(_contactKey);
                        }
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
