import 'dart:ui';
import 'package:flutter/material.dart';
import '../../widgets/sections/hero_section.dart';
import '../../widgets/sections/project_section.dart';
import '../../widgets/sections/experience_section.dart';
import '../../widgets/sections/certification_section.dart';
import '../../widgets/sections/contact_section.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key});

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  final ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        _scrollOffset = _scrollController.offset;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    double heroProgress = (_scrollOffset / (screenHeight * 0.7)).clamp(
      0.0,
      1.0,
    );
    double heroScale = 1.0 - (heroProgress * 0.08);
    double heroOpacity = (1.0 - (heroProgress * 1.2)).clamp(0.0, 1.0);
    double heroTranslateY = _scrollOffset * 0.35;

    return Scaffold(
      backgroundColor: const Color(0xff090D16),
      body: Stack(
        children: [
          Positioned(
            top: -heroTranslateY,
            left: 0,
            right: 0,
            height: screenHeight,
            child: Opacity(
              opacity: heroOpacity,
              child: Transform.scale(
                scale: heroScale,
                child: const HeroSection(),
              ),
            ),
          ),

          SingleChildScrollView(
            controller: _scrollController,
            physics: const ClampingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.85),

                Container(
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
                      const SizedBox(height: 30),
                      const ExperienceSection(),
                      const ProjectSection(),
                      const ContactChatSection(),

                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
