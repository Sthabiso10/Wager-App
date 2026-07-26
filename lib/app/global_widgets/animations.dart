import 'package:flutter/material.dart';

/// ---------------------------------------------------------------------------
/// Tasteful, reusable motion primitives.
///
/// All of these honour the platform "reduce motion" accessibility setting —
/// when it's on, content appears instantly with no movement.
/// ---------------------------------------------------------------------------

bool _reduceMotion(BuildContext context) =>
    MediaQuery.maybeOf(context)?.disableAnimations ?? false;

/// Fades + slides its child in on first build, after an optional [delay].
/// Great for staggering a column of cards (increase delay per item).
class FadeSlideIn extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final Duration duration;
  final double offsetY;
  final Curve curve;

  const FadeSlideIn({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 460),
    this.offsetY = 18,
    this.curve = Curves.easeOutCubic,
  });

  /// Convenience for staggered lists: item [index] with a per-item [step].
  factory FadeSlideIn.staggered(
    int index, {
    required Widget child,
    Duration step = const Duration(milliseconds: 70),
    double offsetY = 18,
  }) {
    return FadeSlideIn(
      delay: step * index,
      offsetY: offsetY,
      child: child,
    );
  }

  @override
  State<FadeSlideIn> createState() => _FadeSlideInState();
}

class _FadeSlideInState extends State<FadeSlideIn>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: widget.duration);

  late final Animation<double> _fade =
      CurvedAnimation(parent: _controller, curve: widget.curve);
  late final Animation<Offset> _slide = Tween<Offset>(
    begin: Offset(0, widget.offsetY / 100),
    end: Offset.zero,
  ).animate(_fade);

  bool _started = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_started) return;
    _started = true;
    if (_reduceMotion(context)) {
      _controller.value = 1.0;
    } else {
      Future.delayed(widget.delay, () {
        if (mounted) _controller.forward();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(position: _slide, child: widget.child),
    );
  }
}

/// Counts an integer up from 0 to [value] on build, using [builder] to format
/// (e.g. add a currency prefix or a `%` suffix).
class AnimatedCount extends StatelessWidget {
  final num value;
  final Duration duration;
  final TextStyle? style;
  final String Function(num current)? builder;

  const AnimatedCount({
    super.key,
    required this.value,
    this.duration = const Duration(milliseconds: 900),
    this.style,
    this.builder,
  });

  @override
  Widget build(BuildContext context) {
    final instant = _reduceMotion(context);
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: value.toDouble()),
      duration: instant ? Duration.zero : duration,
      curve: Curves.easeOutCubic,
      builder: (context, current, _) {
        final text = builder != null
            ? builder!(current)
            : current.round().toString();
        return Text(text, style: style);
      },
    );
  }
}

/// A gentle, looping "breathing" scale — gives a resting element a little life
/// (used behind the profile avatar). Respects reduce-motion.
class Breathing extends StatefulWidget {
  final Widget child;
  final double min;
  final double max;
  final Duration duration;

  const Breathing({
    super.key,
    required this.child,
    this.min = 0.97,
    this.max = 1.03,
    this.duration = const Duration(milliseconds: 2600),
  });

  @override
  State<Breathing> createState() => _BreathingState();
}

class _BreathingState extends State<Breathing>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: widget.duration);
  late final Animation<double> _scale = Tween(begin: widget.min, end: widget.max)
      .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && !(_reduceMotion(context))) {
        _controller.repeat(reverse: true);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(scale: _scale, child: widget.child);
  }
}
