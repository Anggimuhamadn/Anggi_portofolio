import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// Background particle field yang drift pelan-pelan, dan "ke-tolak" pas
/// pointer (mouse hover di web/desktop, atau drag di touch) mendekat.
class InteractiveParticleField extends StatefulWidget {
  const InteractiveParticleField({
    super.key,
    this.particleCount = 34,
    this.color = const Color(0xff00D2FF),
  });

  final int particleCount;
  final Color color;

  @override
  State<InteractiveParticleField> createState() =>
      _InteractiveParticleFieldState();
}

class _InteractiveParticleFieldState extends State<InteractiveParticleField>
    with SingleTickerProviderStateMixin {
  late final _ParticleFieldController _controller;

  @override
  void initState() {
    super.initState();
    _controller = _ParticleFieldController(
      particleCount: widget.particleCount,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Guard: kalau constraint dari parent ternyata unbounded/infinite
        // (misal karena posisi widget ini di tree lagi gak dikasih ukuran
        // pasti), jangan lanjut render CustomPaint — itu yang bikin crash
        // "RenderBox was not laid out". Mending gak nampilin apa-apa
        // daripada nge-crash seluruh halaman.
        final Size rawSize = constraints.biggest;
        if (!rawSize.width.isFinite || !rawSize.height.isFinite) {
          return const SizedBox.shrink();
        }
        final Size size = rawSize;
        _controller.attach(vsync: this, size: size);

        return MouseRegion(
          opaque: false,
          onHover: (event) => _controller.updatePointer(event.localPosition),
          onExit: (_) => _controller.updatePointer(null),
          child: Listener(
            onPointerMove: (event) =>
                _controller.updatePointer(event.localPosition),
            onPointerUp: (_) => _controller.updatePointer(null),
            behavior: HitTestBehavior.translucent,
            child: RepaintBoundary(
              child: CustomPaint(
                size: size,
                painter: _ParticleFieldPainter(
                  controller: _controller,
                  color: widget.color,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _Particle {
  _Particle({
    required this.position,
    required this.velocity,
    required this.radius,
    required this.opacity,
  });

  Offset position;
  final Offset velocity;
  final double radius;
  final double opacity;
}

class _ParticleFieldController extends ChangeNotifier {
  _ParticleFieldController({required this.particleCount});

  final int particleCount;
  final List<_Particle> particles = [];
  final Random _random = Random();

  Offset? _pointerPosition;
  Size _size = Size.zero;
  Ticker? _ticker;
  Duration _lastElapsed = Duration.zero;

  static const double _pointerRadius = 130.0;
  static const double _repelStrength = 2400.0;

  void attach({required TickerProvider vsync, required Size size}) {
    _size = size;
    if (particles.isEmpty && size.width > 0 && size.height > 0) {
      _seedParticles();
    }
    _ticker ??= vsync.createTicker(_onTick)..start();
  }

  void updatePointer(Offset? position) {
    _pointerPosition = position;
  }

  void _seedParticles() {
    for (int i = 0; i < particleCount; i++) {
      particles.add(
        _Particle(
          position: Offset(
            _random.nextDouble() * _size.width,
            _random.nextDouble() * _size.height,
          ),
          velocity: Offset(
            (_random.nextDouble() - 0.5) * 14,
            (_random.nextDouble() - 0.5) * 14,
          ),
          radius: 1.0 + _random.nextDouble() * 1.8,
          opacity: 0.12 + _random.nextDouble() * 0.30,
        ),
      );
    }
  }

  void _onTick(Duration elapsed) {
    if (_size == Size.zero || particles.isEmpty) return;

    final double dt =
    ((elapsed - _lastElapsed).inMicroseconds / 1e6).clamp(0.0, 0.05);
    _lastElapsed = elapsed;

    for (final particle in particles) {
      Offset next = particle.position + particle.velocity * dt;

      final Offset? pointer = _pointerPosition;
      if (pointer != null) {
        final Offset diff = next - pointer;
        final double dist = diff.distance;
        if (dist < _pointerRadius && dist > 0.1) {
          final double force = (_pointerRadius - dist) / _pointerRadius;
          next += (diff / dist) * force * _repelStrength * dt;
        }
      }

      double x = next.dx;
      double y = next.dy;
      if (x < -10) x = _size.width + 10;
      if (x > _size.width + 10) x = -10;
      if (y < -10) y = _size.height + 10;
      if (y > _size.height + 10) y = -10;

      particle.position = Offset(x, y);
    }

    notifyListeners();
  }

  @override
  void dispose() {
    _ticker?.stop();
    _ticker?.dispose();
    super.dispose();
  }
}

class _ParticleFieldPainter extends CustomPainter {
  _ParticleFieldPainter({required this.controller, required this.color})
      : super(repaint: controller);

  final _ParticleFieldController controller;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..style = PaintingStyle.fill;
    for (final particle in controller.particles) {
      paint.color = color.withOpacity(particle.opacity);
      canvas.drawCircle(particle.position, particle.radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _ParticleFieldPainter oldDelegate) => false;
}